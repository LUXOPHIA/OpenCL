# LUX.GPU.OpenCL
[English](../README.md) | [日本語](README.md)

GPU（または CPU）による並列計算のための、**Delphi** 用 [OpenCL](https://registry.khronos.org/OpenCL/) 3.1 ラッパーライブラリ。OpenCL C のカーネルを文字列として書き、パラメータに名前で Delphi の値を割り当てて、実行する — ハンドル管理も API の決まり文句も不要です。Khronos の C ヘッダーは完全に 1:1 で移植されており、直接呼び出すこともできます [1][3]。

----

## 利用ライブラリ

* [**LUX**](https://github.com/LUXOPHIA/LUX) ：ラッパー全体で用いる数学型・汎用リスト・色を提供する基盤ライブラリ。

## 1. 概要

本ライブラリは 2 層構成です。下層（`CL/`）は公式の Khronos OpenCL C ヘッダーを一対一で Pascal へ移植したもので、任意の OpenCL エントリポイントを直接呼び出せます。上層（`Core/`）はオブジェクト指向のラッパーで、OpenCL の全オブジェクトが仕様と同じ親子階層を持つ Delphi クラスとして提供され、寿命は自動管理され、エラーは例外として報告されます。

### 1.1 特徴

* **OpenCL 3.1 完全バインディング** — 公式の [Khronos OpenCL-Headers](https://github.com/KhronosGroup/OpenCL-Headers) [3] と一対一対応で移植。`cl_version.pas` の既定値は `CL_TARGET_OPENCL_VERSION = 310` です。
* **ランタイムの動的ロード** — OpenCL 共有ライブラリは実行時にロードされるため、OpenCL ドライバの無いマシンでもアプリは起動します。使えるかどうかは `TOpenCL.Available` で判定できます。
* **オブジェクト指向モデル** — プラットフォーム・デバイス・コンテキスト・キュー・プログラム・カーネル・バッファ・イメージ・サンプラー等、OpenCL の全オブジェクトが Delphi のクラスとして、仕様 [1] と同じ親子階層で提供されます。
* **ハンドルの遅延生成** — OpenCL のハンドルは、最初に読まれたときに作られ、その元になったプロパティが変わると解放されます。そこから作られていたものも一緒に解放され、必要になった時点で作り直されるので、プロパティはどの順に設定しても、いつ変えても構いません（§2.5）。
* **寿命の自動管理** — 親が子を所有するので、手で解放するものはありません。終了時にすべて自動で解放されます。途中でオブジェクトを解放することも、別の親へ移すこともできます。
* **例外ベースのエラー処理** — ハンドルを作れなかったときは、OpenCL のエラーコードと読めるメッセージを持つ `ECLError` を送出します。利用者が与える文字列（カーネルのソースと、パラメータの名前）で決まる結果は、`BuildOK`・`FindsOK`・`BindsOK` で、例外なしに尋ねることもできます（§4.2）。
* **型付きバッファとイメージ** — `TCLBuffer<T>` により GPU メモリを型安全な配列のように扱えます。1D/2D/3D イメージも複数のピクセル形式で提供。
* **ゼロコピー設計** — バッファとイメージはメモリフラグに `CL_MEM_ALLOC_HOST_PTR` を加えて確保され、Map/Unmap 経由でアクセスされるため、ホスト・デバイス間の無駄なコピーを避けます。
* **分離コンパイル&リンク** — `clCompileProgram` / `clLinkProgram` によるビルドで、カーネルソース内の `#include` はメモリ上のライブラリプログラム（`TCLLibrar`）を埋め込みヘッダーとして与えることで、ディスク不要で解決されます。

## 2. 技術的背景

### 2.1 プラットフォームモデル

OpenCL は計算機を厳格な包含階層として提示します。*プラットフォーム*（あるベンダーの実装）が 1 つ以上の*デバイス*を公開し、*コンテキスト*はプラットフォーム上に作られて相互作用しうるデバイス・メモリオブジェクト・プログラムをまとめ、*コマンドキュー*はコンテキストとちょうど 1 つのデバイスを結んで投入されたコマンドを直列化します [1]。

```
包含階層（外側から順に）

・プラットフォーム         ･･･ あるベンダーの実装
  ┗・デバイス             ･･･ プラットフォームが公開する
     ┗・コンテキスト      ･･･ デバイス/メモリ/プログラムをまとめる
        ┗・コマンドキュー ･･･ コンテキストとちょうど 1 つのデバイスを結ぶ
           ┗・コマンド    ･･･ キューへ投入された順に直列化される
```

ラッパーはこの包含関係をそのまま写しています。だからこそ `TCLContex` は `TCLPlatfo` から作られ、`TCLQueuer` はコンテキストとデバイスの両方を必要とします。

```pascal
C := TCLContex.Create( P );      // プラットフォーム P 上のコンテキスト
Q := TCLQueuer.Create( C, D );   // コンテキスト C・デバイス D 上のキュー
```

### 2.2 実行モデル — NDRange

カーネルの起動は、最大 3 次元のインデックス空間 *NDRange* を実体化します。その空間の各点が*ワークアイテム*であり、ワークアイテムはローカルメモリを共有して内部同期できる*ワークグループ*にまとめられます。グローバルサイズ $G_d$、ローカル（ワークグループ）サイズ $L_d$、グローバルオフセット $o_d$ のとき、ワークグループ ID が $w_d$、ローカル ID が $l_d$ のワークアイテムのグローバル ID は

$$g_d = w_d L_d + l_d + o_d , \qquad d = 0, \dots, D-1 \qquad \text{(1)}$$

であり、各次元のワークグループ数とワークアイテムの総数は

$$W_d = \frac{G_d}{L_d} , \qquad N = \prod_{d=0}^{D-1} G_d . \qquad \text{(2)}$$

`TCLKernel` は $o_d$ を `GloMinX/Y/Z`、$G_d$ を `GloSizX/Y/Z`、導出される上限 $o_d + G_d$ を `GloMaxX/Y/Z` として公開します。次元数 $D$ は手で設定するものでは*なく*、実際に使われた値から推論されます。

$$D = \begin{cases} 3 & (o_2 > 0) \lor (G_2 > 1) \\\\ 2 & (o_1 > 0) \lor (G_1 > 1) \\\\ 1 & \text{その他} \end{cases} \qquad \text{(3)}$$

`TCLKernel.Run` は $o_d$ と $G_d$ を `clEnqueueNDRangeKernel` に渡し、ローカルサイズは `nil` として $L_d$ の選択を実装に委ね、続けて `clFinish` を呼びます。したがって `Run` は同期実行です。カーネル側では同じインデックスを `get_global_id( d )`・`get_local_id( d )`・`get_group_id( d )` で読み出します [2]。

### 2.3 メモリモデル — マップされたゼロコピー確保

OpenCL はホストメモリと、グローバル・定数・ローカル・プライベートの各デバイスメモリを区別します [1]。本ライブラリは全メモリオブジェクトを `CL_MEM_ALLOC_HOST_PTR` で確保し、内容へは `clEnqueueMapBuffer` / `clEnqueueMapImage` を通じてアクセスします。そのため共有メモリのデバイスではホストとデバイスが*同一*ページを指し、明示的な read/write のコピーは発行されません。`Count` 要素の `TCLBuffer<T>` の確保サイズは

$$S = \texttt{Count} \cdot \operatorname{sizeof}(T) \qquad \text{(4)}$$

であり、`Data[ I ]` は最初のアクセス時に領域を Map し、`Data.Unmap` はそれを解放してデバイスが使えるようにします。3D の NDRange とフラットなバッファ添字との間の慣例的な行優先の線形化は

$$i = g_0 + G_0 \bigl( g_1 + G_1 g_2 \bigr) . \qquad \text{(5)}$$

イメージは要素型ではなくピクセル形式を持ちます。用意されている組み合わせは次のとおりです。

| クラス | `cl_channel_order` | `cl_channel_type` | Delphi の要素型 |
|:--|:--|:--|:--|
| `TCLImager{1,2,3}DxBGRAxUInt8` | `CL_BGRA` | `CL_UNSIGNED_INT8` | `TByteRGBA` |
| `TCLImager{1,2,3}DxBGRAxUFix8` | `CL_BGRA` | `CL_UNORM_INT8` | `TByteRGBA` |
| `TCLImager{1,2,3}DxRGBAxUInt32` | `CL_RGBA` | `CL_UNSIGNED_INT32` | `TUInt32xRGBA` |
| `TCLImager{1,2,3}DxRGBAxSFlo32` | `CL_RGBA` | `CL_FLOAT` | `TSingleRGBA` |

`Data` は読み取り専用のプロパティです。マップされたビューは、そのメモリオブジェクトが生きている間、ずっとそのオブジェクトのものです。`Count`（または `CountX/Y/Z`）を変えると確保が解放されるので、大きさを変えた後に中身は残りません。

### 2.4 プログラムのビルドモデル — 分離コンパイルとリンク

一体型の `clBuildProgram` ではなく、`TCLBuildr`（デバイスごとに 1 つ）が OpenCL 1.2 以降の 2 段ビルド、すなわち `clCompileProgram` に続く `clLinkProgram` を実行します。コンパイルは次のオプションで発行されます。

```
-cl-kernel-arg-info -cl-std=CL<version>
```

*名前によるバインド*を可能にしているのが `-cl-kernel-arg-info` です。コンパイル済みカーネルの引数名を `clGetKernelArgInfo` で問い合わせられるため、`K.Parames[ 'Xs' ] := B` は `'Xs'` を引数インデックスへ解決して `clSetKernelArg` を呼べます。コンテキストの各 `TCLLibrar` は、その `Name` を付けた*埋め込みヘッダー*として `clCompileProgram` に渡されるので、カーネルは `#include "MyHeader.cl"` と書けばメモリ上から解決されます。コンパイルは遅延実行で、カーネルが実際に必要になった時点で行われ、デバイスごとのログは `BuildLog` で取得できます。2 段とも成功したかどうかは `BuildOK` で分かり、リンクの失敗も同じログに書かれます。

### 2.5 ハンドルモデル — 遅延生成と解放

ラッパーの各オブジェクトが持つ OpenCL のハンドルは高々 1 つで、`nil` は*まだ作られていない*ことを表します。ハンドルは、`Handle` プロパティが最初に読まれたとき（直接読んだときのほか、カーネルの実行や `Data` へのアクセスで間接に読まれたとき）に作られ、作れなければ `ECLError` を送出します（§4.2）。プロパティのセッターは、値が同じなら何もしません。違うときは、先にハンドルを解放してから新しい値を入れるので、次に読まれたときに、新しい状態に合ったハンドルが作られます。

OpenCL のオブジェクトは互いを*元にして*作られるので、ハンドルを解放すると、それを元に作られたハンドルもすべて解放されます。

```
解放の伝わり方  （ あるノードを解放すると、その下のすべてが解放される ）

・TCLContex              ･･･ キューが加わる・外れる・デバイスを変える
  ┣・TCLQueuer
  ┣・TCLSamplr
  ┣・TCLMemory           ･･･ 大きさ・種類・キューが変わる
  ┃  ┗・TCLMemDat        ･･･ マップされたビュー（ Data ）
  ┗・TCLLibrar           ･･･ ソースが変わる
     ┗・TCLExecut        ･･･ ソースが変わる
        ┗・TCLBuildr     ･･･ デバイス・言語のバージョンが変わる
           ┗・TCLKernel  ･･･ 名前が変わる
```

カーネルの引数だけは例外です。`TCLMemory` や `TCLSamplr` を解放しても、それを割り当てたカーネルは解放されず、次の `Run` で引数を渡し直すだけです。親から外れるオブジェクト（解放されるもの・別の親へ移るもの）は、外れる前にハンドルを解放します。解放が例外を出すことはなく、解放を試みたハンドルは、その時点で忘れられます。

クイックスタート（§4.1）のオブジェクトを使うと、次のようになります。

```pascal
B.Count := 20;                                  // バッファが解放され …
K.Run;                                          // … ここで作り直され、割り当て直される

E.Source[ 3 ] := '     Xs[ i ] = Xs[ i ] + 2;';  // プログラムとそのカーネルが解放され …
K.Run;                                          // … ここでビルドし直される
```

## 3. アーキテクチャ

### 3.1 クラス階層

オブジェクトはツリーを構成し、親が子を生成・所有・解放するため、利用側が `Free` を呼ぶことはありません。複数形の名前（`TCLPlatfos`・`TCLDevices` …）が所有するリストクラス、単数形がその要素です。`LUX.GPU.OpenCL.pas` はジェネリックな実装クラスの非ジェネリックなエイリアスを公開します。

```
・TOpenCL                                    ･･･ クラス静的な窓口。DLL をロード
  ┗・TCLSystem                              ･･･ クラスコンストラクタが生成
     ┗・TCLPlatfos — TCLPlatfo             ･･･ clGetPlatformIDs
        ┣・TCLExtenss                       ･･･ 対応拡張名の TStringList
        ┣・TCLDevices — TCLDevice          ･･･ clGetDeviceIDs
        ┗・TCLContexs — TCLContex          ･･･ clCreateContext
           ┣・TCLQueuers — TCLQueuer       ･･･ clCreateCommandQueue
           ┣・TCLArgumes — TCLArgume       ･･･ カーネル引数の抽象基底
           ┃  ┣・TCLSamplr                 ･･･ clCreateSampler
           ┃  ┗・TCLMemory                 ･･･ clReleaseMemObject
           ┃     ┣・TCLBuffer<T>           ･･･ clCreateBuffer
           ┃     ┃  ┗・TCLBufDat<T>       ･･･ Map / Unmap, Values[ I ]
           ┃     ┗・TCLImager1D/2D/3D      ･･･ clCreateImage
           ┃        ┗・TCLImaDat1D/2D/3D
           ┣・TCLLibrars — TCLLibrar       ･･･ 埋め込みヘッダープログラム
           ┗・TCLExecuts — TCLExecut       ･･･ clCreateProgramWithSource
              ┣・TCLBuildrs — TCLBuildr    ･･･ デバイス別の Compile ＋ Link
              ┗・TCLKernels — TCLKernel    ･･･ clCreateKernel、NDRange、Run
                 ┗・TCLParames — TCLParame ･･･ 引数名→番号→clSetKernelArg
```

1 回の起動におけるデータの流れは次のとおりです。

```
1. 転送（ホスト → デバイス）

・ホスト配列
  ┗・Data[ I ] := …        ･･･ Map された領域を通じて書き込む
     ┗・TCLBufDat<T>
        ┗・Data.Unmap       ･･･ デバイスへページを引き渡す
           ┗・デバイスのグローバルメモリ

2. バインド（名前による引数割り当て）

・TCLParames[ 'Xs' ] := B    ･･･ バッファ B がカーネル引数 'Xs' になる

3. 起動（実行順）

・TCLKernel.Run
  ┣・clEnqueueNDRangeKernel ･･･ デバイスのグローバルメモリ上でカーネルを実行
  ┗・clFinish               ･･･ 完了を待つため、Run は同期実行

4. 読み戻し（デバイス → ホスト）

・デバイスのグローバルメモリ
  ┗・Map                    ･･･ 最初のアクセス時にホストへ再 Map される
     ┗・TCLBufDat<T>
        ┗・Data[ I ]        ･･･ ホスト配列へ読み戻す
           ┗・ホスト配列
```

### 3.2 ファイル構成

```
・LUX.GPU.OpenCL/
  ┣・CL/                                          ･･･ C ヘッダーの 1:1 移植
  ┃  ┣・cl_platform.pas                          ･･･ 基本スカラー型
  ┃  ┣・cl_version.pas                           ･･･ CL_TARGET_OPENCL_VERSION
  ┃  ┣・cl.pas                                   ･･･ 型・定数・関数型
  ┃  ┗・cl_functions.pas                         ･･･ ICD ローダー相当
  ┣・Core/                                        ･･･ オブジェクト指向ラッパー
  ┃  ┣・LUX.GPU.OpenCL.core.pas                  ･･･ ECLError / CheckCL ほか
  ┃  ┣・LUX.GPU.OpenCL.Platfo.pas                ･･･ TCLPlatfo, TCLExtenss
  ┃  ┣・LUX.GPU.OpenCL.Device.pas                ･･･ TCLDevice
  ┃  ┣・LUX.GPU.OpenCL.Contex.pas                ･･･ TCLContex
  ┃  ┣・LUX.GPU.OpenCL.Queuer.pas                ･･･ TCLQueuer
  ┃  ┣・LUX.GPU.OpenCL.Argume.pas                ･･･ TCLArgume — 引数の基底
  ┃  ┣・LUX.GPU.OpenCL.Argume.Samplr.pas         ･･･ TCLSamplr
  ┃  ┣・LUX.GPU.OpenCL.Argume.Memory.pas         ･･･ TCLMemory / TCLMemDat
  ┃  ┣・LUX.GPU.OpenCL.Argume.Memory.Buffer.pas  ･･･ TCLBuffer<T>/TCLBufDat<T>
  ┃  ┣・LUX.GPU.OpenCL.Argume.Memory.Imager*.pas ･･･ TCLImager1D/2D/3D
  ┃  ┣・LUX.GPU.OpenCL.Progra.pas                ･･･ プログラム関連クラス
  ┃  ┣・LUX.GPU.OpenCL.Kernel.pas                ･･･ TCLKernel / TCLParame
  ┃  ┗・LUX.GPU.OpenCL.Show.pas                  ･･･ 診断用ツリー出力
  ┣・Argume/                                      ･･･ 補助的な引数機能
  ┃  ┗・LUX.GPU.OpenCL.Argume.Seeder.*           ･･･ TCLSeeder — 乱数シード
  ┣・Stream/                                      ･･･ 補助的な入出力機能
  ┃  ┣・LUX.GPU.OpenCL.Stream.FMX.*              ･･･ FMX TBitmap↔イメージャ
  ┃  ┗・LUX.GPU.OpenCL.Stream.HDR.*              ･･･ Radiance HDR↔イメージャ
  ┣・LUX.GPU.OpenCL.pas                           ･･･ エントリポイント・別名
  ┗・：KhronosGroup/OpenCL-Headers/               ･･･ 同梱の C ヘッダー
```

## 4. 使い方

ライブラリのフォルダ（と `LUX` のフォルダ）をプロジェクトの検索パスに追加して:

### 4.1 クイックスタート

```pascal
uses LUX.GPU.OpenCL;

procedure RunAddOne;
var
   P :TCLPlatfo;
   D :TCLDevice;
   C :TCLContex;
   Q :TCLQueuer;
   E :TCLExecut;
   K :TCLKernel;
   B :TCLBuffer<Single>;
   I :Integer;
begin
     // 1. この環境で OpenCL は使えるか?
     if not TOpenCL.Available or ( TOpenCL.Platfos.Count = 0 ) then Exit;

     // 2. 先頭のプラットフォームと、その先頭のデバイスを選ぶ。
     P := TOpenCL.Platfos[ 0 ];
     D := P.Devices[ 0 ];

     // 3. プラットフォーム上にコンテキストを、デバイス上にコマンドキューを作る。
     C := TCLContex.Create( P );
     Q := TCLQueuer.Create( C, D );

     // 4. OpenCL C プログラム(カーネルソース)を書く。
     E := TCLExecut.Create( C );
     with E.Source do
     begin
          Add( 'kernel void AddOne( global float* Xs )' );
          Add( '{'                                      );
          Add( '     const int i = get_global_id( 0 );' );
          Add( '     Xs[ i ] = Xs[ i ] + 1;'            );
          Add( '}'                                      );
     end;

     // 5. 関数名を指定してカーネルを得る。
     K := TCLKernel.Create( E, 'AddOne', Q );

     // 6. 型付きバッファを作って値を詰める。Data[] へのアクセスでバッファがホスト側に Map される。
     B := TCLBuffer<Single>.Create( Q );  // コンテキストは、キューのものになる
     B.Count := 10;
     for I := 0 to B.Count-1 do B.Data[ I ] := I;
     B.Data.Unmap;  // デバイスへデータを引き渡す

     // 7. カーネルのパラメータに、名前でバッファを割り当てる。
     K.Parames[ 'Xs' ] := B;

     // 8. ワークアイテム10個で実行。Run は同期実行(完了を待つ)。
     K.GloSizX := B.Count;
     K.Run;

     // 9. 結果を読む。Data[] にアクセスすると再び Map される。
     for I := 0 to B.Count-1 do Writeln( B.Data[ I ] :0:1 );  // 1.0 2.0 ... 10.0

     // 10. Free は不要: すべてプラットフォームが所有し、終了時に解放される。
end;
```

プログラムのコンパイルは、カーネルが実際に必要になった時点で遅延実行されます（§2.4）。カーネルソースは `E.Source.LoadFromFile( 'MyKernel.cl' )` でファイルから読み込むこともできます。

### 4.2 エラー処理と診断

ハンドルを作れなかったときは、それが最初に必要になった時点で `ECLError` 例外を送出します。`Message` に OpenCL のエラー名が入り、`Code` プロパティで生のエラーコードを取得できます。

```pascal
uses LUX.GPU.OpenCL;

try
   K.Run;
except
   on X :ECLError do ShowMessage( X.Message );  // 例:【BUILD_PROGRAM_FAILURE】…
end;
```

次の 3 つは、利用者が与える文字列で結果が決まるので、例外なしに尋ねることもできます。読んだ時点でまだ行われていなければ、その場で行われます。

| プロパティ | True になるとき |
|:--|:--|
| `TCLBuildr.BuildOK` | プログラムが、そのデバイス向けにコンパイルとリンクまでできた |
| `TCLParames.FindsOK` | カーネルのすべての引数に、同じ名前のパラメータがある |
| `TCLParames.BindsOK` | すべての引数を、カーネルへ渡せた |

`FindsOK` と `BindsOK` は、ビルドされたカーネルを読むので、先に `BuildOK` を尋ねます。デバイスごとのコンパイラとリンカの出力は、`BuildLog` で取得できます。

```pascal
if not E.BuildTo( D ).BuildOK then ShowMessage( E.BuildTo( D ).BuildLog );
```

診断用に、プラットフォーム/デバイスのツリー全体を表示するには:

```pascal
TOpenCL.Show( Memo1.Lines );
```

### 4.3 イメージとストリーム

ストリームは、イメージャと、OpenCL の外の表現との間でコピーを行います。イメージャを指すだけで所有せず、インターフェースを通して参照カウントされるので、`Free` は不要です。

| ユニット | クラス | 外の表現 |
|:--|:--|:--|
| `LUX.GPU.OpenCL.Stream.FMX.D1/D2/D3` | `TCLStream{1,2,3}Dx…_FMX` | FMX の `TBitmap` と、それが読み書きする画像ファイル |

```pascal
uses LUX.GPU.OpenCL, LUX.GPU.OpenCL.Stream.FMX.D2;

var
   M :TCLImager2DxBGRAxUFix8;
   S :ICLStream2DxBGRAxUFix8_FMX;
begin
     M := TCLImager2DxBGRAxUFix8.Create( Q );
     S := TCLStream2DxBGRAxUFix8_FMX.Create( M );
     S.LoadFromFile( 'Input.png' );   // イメージャは、画像の大きさになる
     S.CopyTo( Image1.Bitmap );       // イメージャ → FMX のビットマップ
     S.SaveToFile( 'Output.png' );
end;
```

### 4.4 乱数の種

`TCLSeeder1D/2D/3D`（ユニット `LUX.GPU.OpenCL.Argume.Seeder`）は、すべての画素が xoshiro128 生成器 [6] の 128 ビットの状態を持つ、RGBA の `uint32` のイメージです。イメージが作られるとき、状態の 1 つを Delphi の `Random` から取り、残りは、生成器のジャンプ関数を使って、デバイスの上でそこから導きます。2D の種では、同じ行の隣の画素どうしは $2^{64}$ ステップ、隣の行どうしは $2^{96}$ ステップ離れているので、異なる画素の列は重なりません。実行のたびに違う列を得るには、先に `Randomize` を呼びます。

カーネルは、種を `read_write` のイメージとして受け取り（OpenCL 2.0 以降）、自分の画素の状態を読み、そこから乱数を引き、進めた状態を、次の実行のために書き戻します。

```c
uint rotl( const uint x, const int k )
{
  return ( x << k ) | ( x >> ( 32 - k ) );
}

float Rand( uint4* const S )  // xoshiro128++ : [ 0, 1 )
{
  const uint R = rotl( S->x + S->w, 7 ) + S->x;
  const uint T = S->y << 9;
  S->z ^= S->x;  S->w ^= S->y;  S->y ^= S->z;  S->x ^= S->w;
  S->z ^= T;
  S->w = rotl( S->w, 11 );
  return ( R >> 8 ) / 16777216.0f;
}

kernel void Noise( read_write image2d_t Seeder, write_only image2d_t Imager )
{
  const int2 P = { get_global_id( 0 ), get_global_id( 1 ) };
  uint4 Seed = read_imageui( Seeder, P );  // この画素の状態
  const float L = Rand( &Seed );
  write_imagef( Imager, P, (float4)( L, L, L, 1 ) );
  write_imageui( Seeder, P, Seed );        // 進めた状態を、次の実行のために残す
}
```

```pascal
uses LUX.GPU.OpenCL, LUX.GPU.OpenCL.Argume.Seeder;

M := TCLImager2DxRGBAxSFlo32.Create( Q );
M.CountX := 640;
M.CountY := 480;

S := TCLSeeder2D.Create( Q );
S.CountX := M.CountX;
S.CountY := M.CountY;

K := TCLKernel.Create( E, 'Noise', Q );
K.Parames[ 'Seeder' ] := S;
K.Parames[ 'Imager' ] := M;
K.GloSizX := M.CountX;
K.GloSizY := M.CountY;
K.Run;
```

## 5. 動作環境

* **Delphi** — Delphi 13（Win64）で開発・確認。ジェネリクスの使える近年のバージョンなら動作する見込みです。
* **OpenCL ランタイム** — GPU ドライバ（NVIDIA / AMD / Intel）が提供します。ライブラリは実行時に名前でロードします: Windows では `OpenCL.dll`、macOS では `/System/Library/Frameworks/OpenCL.framework/OpenCL`、Android では `libOpenCL.so`、その他では `libOpenCL.so.1`。OpenCL 2.0 以降を推奨、バインディングは 3.1 対応です。
* **[LUXOPHIA/LUX](https://github.com/LUXOPHIA/LUX)** — 基盤ライブラリ（数学型・汎用リスト・色）。本リポジトリには同梱されていません。

> **はじめての方へ**: サンプルリポジトリ [LUXOPHIA/OpenCL](https://github.com/LUXOPHIA/OpenCL) [5] から始めるのがお勧めです。本ライブラリと全依存ライブラリが同梱されており、対話型マンデルブロレンダラーをすぐにビルド・実行できます。

## 6. ロードマップ

* 非同期実行（`cl_event` ラッパー、`RunAsync`、プロファイリング）
* 半精度浮動小数点対応（`cl_half.h` の移植と `THalf` 型）
* サンプルの拡充

## 7. ライセンス

[Apache License 2.0](../LICENSE) — 同梱の Khronos OpenCL ヘッダーと同一ライセンスです。

## 8. 参考文献

1. Khronos OpenCL Working Group, [*The OpenCL Specification*](https://registry.khronos.org/OpenCL/specs/3.0-unified/html/OpenCL_API.html), Khronos Group, 2023.
2. Khronos OpenCL Working Group, [*The OpenCL C Specification*](https://registry.khronos.org/OpenCL/specs/3.0-unified/html/OpenCL_C.html), Khronos Group, 2023.
3. Khronos Group, [*OpenCL-Headers*](https://github.com/KhronosGroup/OpenCL-Headers), GitHub リポジトリ.
4. Khronos Group, [*Khronos OpenCL Registry*](https://registry.khronos.org/OpenCL/).
5. LUXOPHIA, [*OpenCL*](https://github.com/LUXOPHIA/OpenCL), GitHub リポジトリ — サンプルアプリ（マンデルブロレンダラー）.
6. S. Vigna, [*A PRNG Shootout*](https://prng.di.unimi.it/) — xoshiro / xoroshiro 生成器（D. Blackman との共同設計）.

## 💖 [Embarcadero](https://www.embarcadero.com/jp/) [**Delphi**](https://www.embarcadero.com/jp/products/delphi)
ネイティブなクロスプラットフォームアプリを開発するための統合開発環境（ＩＤＥ）。
### Free Download: [**Delphi** Community Edition](https://www.embarcadero.com/jp/products/delphi/starter)
