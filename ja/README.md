# OpenCL

[English](../README.md) | [日本語](README.md)

[OpenCL](https://registry.khronos.org/OpenCL/) を用いて GPU / CPU で並列計算を行う、対話的な**マンデルブロ集合**ビューアです。アプリケーションは [LUX.GPU.OpenCL](https://github.com/LUXOPHIA/LUX.GPU.OpenCL) ラッパーライブラリの上に構築されており、OpenCL のオブジェクトモデル全体を Object Pascal クラスの所有階層として表現します。

![](../--------/_SCREENSHOT/OpenCL.png)

## 利用ライブラリ

* [**LUX**](https://github.com/LUXOPHIA/LUX) ：Delphi のための基盤数学ライブラリ。
* [**LUX.GPU.OpenCL**](https://github.com/LUXOPHIA/LUX.GPU.OpenCL) ：Delphi のための OpenCL ラッパーライブラリ。

## 1. 概要

* **クラスベースの OpenCL ラッパー**：OpenCL の各オブジェクト（プラットフォーム・デバイス・コンテキスト・コマンドキュー・バッファー・イメージ・サンプラー・プログラム・カーネル）を専用の Delphi クラスで表現し、生存期間管理と親子登録を自動化。
* **デバイスの自動検出**：シングルトン `TOpenCL` が起動時にホスト上の全プラットフォームと全デバイスを列挙。
* **型付きデバイスメモリ**：ジェネリックバッファー（`TCLBuffer<T>`）は任意の Delphi レコード型に対応。型付きイメージクラスが 1D/2D/3D の各次元と複数のチャンネル順・ピクセル形式をカバー。
* **ソースレベルのカーネルワークフロー**：OpenCL C ソースを実行時に読み込み、デバイスごとにビルドしてビルドログを取得でき、カーネル引数は名前で接続。
* **FireMonkey 連携**：ストリームクラス（`TCLStream1DxBGRAxUFix8_FMX`・`TCLStream2DxBGRAxUFix8_FMX`）がデバイスイメージと `TBitmap` の間でデータをコピーし、カーネル出力を GUI に直接表示。
* **デモカーネル**：滑らかに着色されたマンデルブロ集合をタイマー毎にデバイス上で再計算し、アニメーションズームを実現。

## 2. 技術的背景

### 2.1. OpenCL の実行モデル

OpenCL [1][2] は異種混在の計算資源を厳密な階層構造として編成します。

* **プラットフォーム**は、１つのベンダー（NVIDIA・AMD・Intel など）が提供する実行環境です。
* **デバイス**は、プラットフォームに属する物理的なプロセッサ（GPU または CPU）です。
* **コンテキスト**は、同一プラットフォームのデバイス群と、それらが共有するメモリオブジェクトやプログラムをまとめます。
* **コマンドキュー**は、コンテキストと特定の１つのデバイスを接続します。すべてのデータ転送とカーネル起動は、キューへ投入されるコマンドです。キューは*同一*プラットフォームのコンテキストとデバイスの組でのみ生成できます。

### 2.2. NDRange・ワークグループ・ワークアイテム

カーネルは **NDRange**、すなわち最大３次元の**ワークアイテム**格子として実行され、各ワークアイテムは自分の座標に対して同じカーネル関数を実行します。格子は**ワークグループ**に分割されます。次元 $d \in \{0,1,2\}$ におけるグローバルサイズを $G_d$、ワークグループサイズを $L_d$、ワークグループ番号を $w_d$、ローカル番号を $l_d$ とすると、ワークアイテムのグローバル番号は

```math
g_d = w_d \cdot L_d + l_d , \qquad 0 \le g_d < G_d .
```

カーネル内では $g_d$ と $G_d$ を `get_global_id(d)` と `get_global_size(d)` で取得します。ラッパーはグローバルサイズを `TCLKernel` の `GloSizX`/`GloSizY`/`GloSizZ` プロパティとして公開しており、概念的には「全反復が並列に走る三重ループ」に相当します。本デモでは NDRange を出力画像の解像度 $G = (500, 500)$ に設定するため、各ワークアイテムがちょうど１ピクセルを計算します。

### 2.3. メモリモデル

ホストとデバイスは別々のメモリを持ちます。本ライブラリは OpenCL の３種類の実引数をラップします。

* **バッファー**（`TCLBuffer<T>`）：任意の単純型・レコード型の線形配列。ホストからのアクセスにはマップ／アンマップ方式を用い、`Data.Map` で領域をホストへ展開し、`Data.Unmap` でデバイスへ返却します。
* **イメージ**（`TCLImager*`）：ハードウェア支援アクセス（`read_imagef`/`write_imagef`）を備えた 1D～3D のピクセル配列。
* **サンプラー**（`TCLSamplr`）：イメージを実数座標で読み出す際のアドレッシングと補間方法を定義します。

### 2.4. デモカーネル：マンデルブロ集合の滑らかな描画

カーネル `Main`（[`_DATA/Execut.cl`](../_DATA/Execut.cl)、複素数演算ライブラリ [`_DATA/Librar.cl`](../_DATA/Librar.cl) を使用）はマンデルブロ集合を描画します。各ワークアイテムはまず、格子サイズ $s = (s_x, s_y)$ 内の自ピクセル座標 $p = (p_x, p_y)$ を、表示領域の中心 $C$ と半径サイズ $S$ を用いて複素平面上の点 $c$ へ写像します。

```math
c_R = C_R + S_R \left( \frac{2\,(p_x + 0.5)}{s_x} - 1 \right), \qquad
c_I = C_I - S_I \left( \frac{2\,(p_y + 0.5)}{s_y} - 1 \right).
```

次に２次写像

```math
z_{n+1} = z_n^2 + c , \qquad z_0 = 0
```

を、$\lvert z_n \rvert > 2$（発散）または反復上限 $N_{\max} = 1000$ に達するまで反復します。縞模様（バンディング）を避けるため、発散回数は連続値へ平滑化されます。

```math
\nu = n + 1 - \log \left( \log_2 \lvert z_n \rvert \right).
```

ピクセル色は、正規化座標

```math
t = \sqrt{ \nu / N_{\max} }
```

を用いて 1D グラデーションテクスチャ（`_DATA/Textur.png`）から `read_imagef( Textur, Samplr, t )` で取得され、`write_imagef` で出力イメージへ書き込まれます。

ホスト側では `Main.pas` が表示を動かします。タイマーが現在の中心／サイズを目標領域へ補間し（毎ティック $x \leftarrow x + 0.25\,(x_1 - x)$）、両者を２つの `TSingleC` 要素としてバッファーへ書き込み（マップ → 書き込み → アンマップ）、カーネルを実行し、得られた 2D イメージを FireMonkey の `TImage` へコピーします。マウスホイールはカーソル直下の複素座標を不動点として目標領域を拡縮し、カーソル中心の滑らかなズームを実現します。

## 3. アーキテクチャ

### 3.1. LUX.GPU.OpenCL のクラス階層

ラッパーライブラリは OpenCL のオブジェクトグラフを所有ツリーとしてモデル化します。各親クラスは子の型付きリストを所有し、子の生成（例：`TCLContex.Create( _Platfo )`）は自動的に親へ登録されます。

```
・TOpenCL                                  ･･･ TCLSystem のシングルトン
┃
・TCLSystem                                ･･･ ルート；全計算デバイスを検出
  ┗・TCLPlatfos                           ･･･ プラットフォームリスト
     ┗・TCLPlatfo                         ･･･ プラットフォーム（ベンダー環境）
        ┣・TCLExtenss                     ･･･ 拡張機能リスト
        ┣・TCLDevices                     ･･･ デバイスリスト
        ┃  ┗・TCLDevice                  ･･･ 物理的な GPU / CPU
        ┗・TCLContexs                     ･･･ コンテキストリスト
           ┗・TCLContex                   ･･･ コンテキスト（データ+プログラム）
              ┣・TCLQueuers               ･･･ コマンドキューリスト
              ┃  ┗・TCLQueuer            ･･･ キュー（コンテキスト×デバイス）
              ┣・TCLArgumes               ･･･ 実引数リスト
              ┃  ┣・TCLBuffer            ･･･ 汎用バッファー（TCLMemory）
              ┃  ┣・TCLImager            ･･･ 1D/2D/3D イメージ（TCLMemory）
              ┃  ┗・TCLSamplr            ･･･ サンプラー
              ┣・TCLLibrars               ･･･ ライブラリリスト
              ┃  ┗・TCLLibrar            ･･･ カーネルを含まないプログラム
              ┗・TCLExecuts               ･･･ 実行プログラムリスト
                 ┗・TCLExecut             ･･･ カーネルを含むプログラム
                    ┣・TCLBuildrs         ･･･ ビルドリスト
                    ┃  ┗・TCLBuildr      ･･･ デバイス毎のビルド（ログ・状態）
                    ┗・TCLKernels         ･･･ カーネルリスト
                       ┗・TCLKernel       ･･･ 実行可能なカーネル関数
                          ┗・TCLParames   ･･･ 仮引数リスト
                             ┗・TCLParame ･･･ カーネル仮引数
```

デモアプリケーションのデータフロー：

```
入力 — ホスト側の各ソースがカーネルの引数になる

・Textur.png
  ┗・TCLImager1DxBGRAxUFix8 ･･･ 1D カラーグラデーションテクスチャ
     ┗・TCLKernel

・マウスホイール
  ┗・TCLBuffer<TSingleC>    ･･･ 表示中心／半径
     ┗・TCLKernel

・Librar.cl / Execut.cl
  ┗・TCLExecut              ･･･ カーネルを供給するコンパイル済みプログラム
     ┗・TCLKernel           ･･･ （'Main'；タイマー毎に TCLQueuer 経由で実行）

出力 — カーネルの結果を GUI へ

・TCLKernel
  ┗・TCLImager2DxBGRAxUFix8 ･･･ 描画されたマンデルブロ画像
     ┗・TImage              ･･･ (GUI)
```

### 3.2. ファイル構成

```
・OpenCL/
  ┣・OpenCL.dpr             ･･･ プロジェクトソース（ユニット一覧）
  ┣・OpenCL.dproj           ･･･ RAD Studio プロジェクト（FMX・Win32/Win64）
  ┣・Main.pas / Main.fmx    ･･･ メインフォーム：CL グラフ構築とタイマー描画
  ┣・_DATA/
  ┃  ┣・Librar.cl          ･･･ ライブラリ：複素数型 TSingleC と演算子
  ┃  ┣・Execut.cl          ･･･ 実行ソース：マンデルブロカーネル 'Main'
  ┃  ┗・Textur.png         ･･･ 滑らかな着色用の 1D グラデーションテクスチャ
  ┣・_LIBRARY/
  ┃  ┗・LUXOPHIA/
  ┃     ┣・LUX/            ･･･ 基盤ユーティリティ（LUX.Complex・LUX.D1～D4）
  ┃     ┗・LUX.GPU.OpenCL/ ･･･ OpenCL ラッパー（Core/・CL/・Stream/）
  ┗・--------/_SCREENSHOT/  ･･･ スクリーンショット
```

## 4. 使用方法

### 4.1. デモアプリケーション

| 操作 | 動作 |
|---|---|
| 結果画像上で**マウスホイール** | ズームイン／アウト。カーソル直下の点が不動点（１ノッチあたり ×1.1） |
| **System** タブ | 検出された全プラットフォームと全デバイスの一覧 |
| **Program** タブ（Library / Execute / Build） | OpenCL C ソースとデバイスごとのビルドログ |
| **Result** タブ | 描画されたマンデルブロ画像（タイマー毎に更新） |

終了時に、デバイス情報を `System.txt` へ、最後に描画されたフレームを `Imager.png` へ保存します。OpenCL ランタイムが存在しない場合は `TOpenCL.Available` が `False` となり、メッセージを表示して安全に停止します。

### 4.2. ライブラリ API

`TOpenCL`クラスは、`TCLSystem`クラスのシングルトンです。`TCLSystem`クラスは、実行マシンにおけるすべての**計算用デバイス**を自動的に検出します。

#### 4.2.1. プラットフォーム

“**プラットフォーム**”オブジェクト (`TCLPlatfo`) は、各デバイスベンダーが定義する環境を表します。`TCLSystem`クラスは、すべての**プラットフォーム**を自動的に検出し、`Platfos[]`プロパティに列挙されます。

> `Object Pascal`
> ```Delphi
> TOpenCL.Platfos.Count :Integer    // 全プラットフォームの数
> TOpenCL.Platfos[*]    :TCLPlatfo  // 全プラットフォームの配列
> ```

特定の**プラットフォーム**に関する情報は、`TCLPlatfo`クラスのプロパティから取得できます。

> `Object Pascal`
> ```Delphi
> _Platfo := TOpenCL.Platfos[0];  // 特定プラットフォームの選択
>
> _Platfo.Handle        :T_cl_platform_id  // ポインタ
> _Platfo.Profile       :String            // プロファイル
> _Platfo.Version       :String            // バージョン
> _Platfo.Name          :String            // 名前
> _Platfo.Vendor        :String            // ベンダー名
> _Platfo.Extenss.Count :Integer           // 拡張機能の数
> _Platfo.Extenss[*]    :String            // 拡張機能の配列
> ```

#### 4.2.2. デバイス

“**デバイス**”オブジェクト (`TCLDevice`) は、物理的な GPU や CPU を表します。`TCLPlatfo`クラスは、特定の**プラットフォーム**内のすべての**デバイス**を自動的に検出し、`Devices[]`プロパティに列挙されます。

> `Object Pascal`
> ```Delphi
> _Platfo.Devices.Count :Integer    // デバイスの数
> _Platfo.Devices[*]    :TCLDevice  // デバイスの配列
> ```

特定の**デバイス**に関する情報は、`TCLDevice`クラスのプロパティから取得できます。

> `Object Pascal`
> ```Delphi
> _Device := _Platfo.Devices[0];  // 特定デバイスの選択
>
> _Device.Handle           :T_cl_device_id    // ポインタ
> _Device.DEVICE_TYPE      :T_cl_device_type  // タイプ
> _Device.DEVICE_VENDOR_ID :T_cl_uint         // ベンダーＩＤ
> _Device.DEVICE_NAME      :String            // 名前
> _Device.DEVICE_VENDOR    :String            // ベンダー
> _Device.DRIVER_VERSION   :String            // ドライバのバージョン
> _Device.DEVICE_PROFILE   :String            // プロファイル
> _Device.DEVICE_VERSION   :String            // バージョン
> ```

#### 4.2.3. コンテキスト

“**コンテキスト**”オブジェクト (`TCLContex`) は、関連するデータやプログラムを管理および保持します。`TCLContex`クラスは、`TCLPlatfo`クラスを引数として生成できます。

> `Object Pascal`
> ```Delphi
> _Contex := TCLContex.Create( _Platfo );
> ```

生成された`TCLContex`クラスは、`TCLPlatfo`クラスの`Contexs[]`プロパティへ登録されます。

> `Object Pascal`
> ```Delphi
> _Platfo.Contexs.Count :Integer    // コンテキストの数
> _Platfo.Contexs[*]    :TCLContex  // コンテキストの配列
> ```

#### 4.2.4. コマンドキュー

“**コマンドキュー**”オブジェクト (`TCLQueuer`) は、**デバイス**に送られる命令を管理します。つまり、**コンテキスト**と**デバイス**間での命令のやり取りを管理します。`TCLQueuer`クラスは、`TCLContex`クラスと`TCLDevice`クラスを引数として生成できます。

> `Object Pascal`
> ```Delphi
> _Queuer := TCLQueuer.Create( _Contex, _Device );
>   {or}
> _Queuer := _Contex.Queuers[ _Device ];
> ```

生成された`TCLQueuer`クラスは、`TCLContex`クラスの`Queuers[]`プロパティへ登録されます。

> `Object Pascal`
> ```Delphi
> _Contex.Queuers.Count :Integer    // コマンドキューの数
> _Contex.Queuers[*]    :TCLQueuer  // コマンドキューの配列
> ```

なお、異なる**プラットフォーム**の**コンテキスト**と**デバイス**を接続する**コマンドキュー**は生成できません。

> `Object Pascal`
> ```Delphi
> P0 := TOpenCL.Platfos[0];
> P1 := TOpenCL.Platfos[1];
> P2 := TOpenCL.Platfos[2];
>
> D00 := P0.Devices[0];  D01 := P0.Devices[1];  D02 := P0.Devices[2];
> D10 := P1.Devices[0];
> D20 := P2.Devices[0];
>
> C0 := TCLContex.Create( P0 );
> C1 := TCLContex.Create( P1 );
> C2 := TCLContex.Create( P2 );
>
> Q00 := TCLQueuer.Create( C0, D00 );  // ＯＫ
> Q01 := TCLQueuer.Create( C0, D01 );  // ＯＫ
> Q02 := TCLQueuer.Create( C0, D02 );  // ＯＫ
>
> Q10 := TCLQueuer.Create( C1, D00 );  // エラー
> Q11 := TCLQueuer.Create( C1, D01 );  // エラー
> Q12 := TCLQueuer.Create( C1, D02 );  // エラー
>
> Q20 := TCLQueuer.Create( C2, D00 );  // エラー
> Q21 := TCLQueuer.Create( C2, D10 );  // エラー
> Q22 := TCLQueuer.Create( C2, D20 );  // ＯＫ
> ```

#### 4.2.5. 実引数

実引数クラスは以下の継承ツリーを構成します。

```
・TCLArgume
  ┣・TCLMemory
  ┃  ┣・TCLBuffer
  ┃  ┗・TCLImager
  ┗・TCLSamplr
```

##### 4.2.5.1. メモリー

“**メモリー**”オブジェクト (`TCLMemory`) は、さまざまなデータを保存し、**デバイス**と共有します。`TCLMemory`クラスは、`TCLContex`クラスと`TCLQueuer`クラスを引数として生成できます。`TCLMemory`クラスは抽象クラスであり、`TCLBuffer`クラスと`TCLImager`クラスを派生させます。

**バッファー**：`TCLBuffer`クラスは、任意の“単純型”や“レコード型”の配列を格納します。

デバイスへ以下のような構造体型の配列を送りたい場合、

> `OpenCL C`
> ```C
> typedef struct {
>   int    A;
>   double B;
> } TItem;
>
> kernel void Main( global TItem* Buffer ) {
>   ･･･
> }
> ```

以下のように`TCLBuffer`クラスを生成します。

> `Object Pascal`
> ```Delphi
> TItem = record
>   A :Integer;
>   B :Double;
> end;
>
> _Buffer := TCLBuffer<TItem>.Create( _Queuer );
> ```

配列データは、`Data[]`プロパティを通して読み書きします。ホストとデバイスの同期のため、配列データを使用する前に“**マップ**”し、終了後に“**アンマップ**”する必要があります。

> `Object Pascal`
> ```Delphi
> _Buffer.Count := 3;                          // 要素数の設定
> _Buffer.Data.Map;                            // メモリ領域を展開
> _Buffer.Data[0] := TItem.Create( 1, 2.34 );  // 書き込み
> _Buffer.Data[1] := TItem.Create( 5, 6.78 );  // 書き込み
> _Buffer.Data[2] := TItem.Create( 9, 0.12 );  // 書き込み
> _Buffer.Data.Unmap;                          // メモリ領域を同期
> ```

**イメージ**：“**イメージ**”オブジェクト (`TCLImager`) は、1D～3D におけるピクセル配列を格納します。3D のボクセルデータも**イメージ**の一種と見なされます。`TCLImager`クラスは抽象クラスであり、カラーチャンネルのレイアウトやビット数に応じて、様々なクラスが派生します。

```
・TCLImager
  ┣・TCLImager1D
  ┃  ┣・TCLImager1DxBGRAxUInt8
  ┃  ┣・TCLImager1DxBGRAxUFix8
  ┃  ┣・TCLImager1DxRGBAxUInt32
  ┃  ┗・TCLImager1DxRGBAxSFlo32
  ┣・TCLImager2D
  ┃  ┣・TCLImager2DxBGRAxUInt8
  ┃  ┣・TCLImager2DxBGRAxUFix8
  ┃  ┣・TCLImager2DxRGBAxUInt32
  ┃  ┗・TCLImager2DxRGBAxSFlo32
  ┗・TCLImager3D
     ┣・TCLImager3DxBGRAxUInt8
     ┣・TCLImager3DxBGRAxUFix8
     ┣・TCLImager3DxRGBAxUInt32
     ┗・TCLImager3DxRGBAxSFlo32
```

クラス名の１番目の部分は、画像の次元を表しています。

> * TCLImager`1D`x`*`x`*` ：次元 `1D`
> * TCLImager`2D`x`*`x`*` ：次元 `2D`
> * TCLImager`3D`x`*`x`*` ：次元 `3D`

クラス名の２番目の部分は、カラーチャンネルの順番を表しています。

> * TCLImager`*`x`BGRA`x`*` ：カラーチャンネル順 `BGRA`
> * TCLImager`*`x`RGBA`x`*` ：カラーチャンネル順 `RGBA`

クラス名の３番目の部分は、色のデータ型を表しています。

> * TCLImager`*`x`*`x`UInt8` ：デバイス側 `uint8` @ OpenCL C ／ ホスト側 `UInt8 (Byte)` @ Delphi
> * TCLImager`*`x`*`x`UFix8` ：デバイス側 `float` @ OpenCL C ／ ホスト側 `UInt8 (Byte)` @ Delphi
> * TCLImager`*`x`*`x`UInt32` ：デバイス側 `uint` @ OpenCL C ／ ホスト側 `UInt32 (Cardinal)` @ Delphi
> * TCLImager`*`x`*`x`SFlo32` ：デバイス側 `float` @ OpenCL C ／ ホスト側 `Single` @ Delphi

X/Y/Z 方向のピクセル数は、`CountX`/`CountY`/`CountZ` プロパティで設定できます。

> `Object Pascal`
> ```Delphi
> _Imager := TCLImager3DxBGRAxUInt8.Create( _Queuer );
> _Imager.CountX := 100;  // Ｘ方向ピクセル数
> _Imager.CountY := 200;  // Ｙ方向ピクセル数
> _Imager.CountZ := 300;  // Ｚ方向ピクセル数
> ```

##### 4.2.5.2. サンプラー

サンプラーオブジェクト (`TCLSamplr`) は、ピクセル色を実数座標で得るための補間方法を定義します。`TCLSamplr`クラスは、`TCLContex`クラスを引数として生成できます。

> `Object Pascal`
> ```Delphi
> _Samplr := TCLSamplr.Create( _Contex );
> ```

#### 4.2.6. プログラム

“**プログラム**”オブジェクト (`TCLProgra`) は、ソースコードを読み込んで、実行可能なバイナリへビルドします。`TCLProgra`クラスは、`TCLContex`クラスを引数として生成できます。`TCLProgra`クラスは抽象クラスであり、ソースコードの種類に応じて、`TCLLibrar`クラスまたは`TCLExecut`クラスの基底クラスとして機能します。

**ライブラリ**：`TCLLibrar`クラスは、直接実行する関数を含まないプログラムです。

> `Object Pascal`
> ```Delphi
> _Librar := TCLLibrar.Create( _Contex );
>
> _Librar.Source.LoadFromFile( 'Librar.cl' );  // ソースコードのロード
> ```

**エグゼキュータブル**：`TCLExecut`クラスは、直接実行する関数（**カーネル**）を含んだプログラムです。

> `Object Pascal`
> ```Delphi
> _Execut := TCLExecut.Create( _Contex );
>
> _Execut.Source.LoadFromFile( 'Execut.cl' );  // ソースコードのロード
> ```

#### 4.2.7. ビルド

**ビルド** (`TCLBuildr`) は**プログラム**が行う“行為”ですが、このライブラリでは、ビルドはクラスとして明確に定義されています。`TCLBuildr`クラスは、`TCLExecut`クラスと`TCLDevice`クラスを引数として生成できます。

> `Object Pascal`
> ```Delphi
> _Buildr := TCLBuildr.Create( _Execut, _Device );
>   {or}
> _Buildr := _Execut.Buildrs[ _Device ];
>   {or}
> _Buildr := _Execut.BuildTo( _Device );
> ```

**カーネル**オブジェクト（4.2.8. 節参照）は、実行時に`TCLBuildr`クラスを自動的に生成します。しかし、カーネルの実行前に`TCLBuildr`クラスを作成することで、コンパイルとリンクのエラーを事前に確認することができます。

> `Object Pascal`
> ```Delphi
> _Buildr.Handle;  // ビルドの実行（ハンドルの生成）
>
> _Buildr.BuildOK  :Boolean  // コンパイルとリンクの両方が成功したか
> _Buildr.BuildLog :String   // コンパイルとリンクのログ
> ```

#### 4.2.8. カーネル

“**カーネル**”オブジェクト (`TCLKernel`) は、プログラム内の実行可能な関数を指します。

> `OpenCL C`
> ```C
> kernel void Main( ･･･ ) {
>   ･･･
> }
> ```

`TCLKernel`クラスは、`TCLExecut`クラスと`TCLQueuer`クラスを引数にして生成できます。

> `Object Pascal`
> ```Delphi
> _Kernel := TCLKernel.Create( _Execut, 'Main', _Queuer );
>   {or}
> _Kernel := _Execut.Kernels.Add( 'Main', _Queuer );
> ```

**仮引数**：**メモリ**オブジェクトは、`TCLKernel`クラスの`Parames[]`プロパティを介して、ソースコード内の引数に関連付けられます。

> `Object Pascal`
> ```Delphi
> _Kernel.Parames['Buffer'] := _Buffer;  // バッファーの接続
> _Kernel.Parames['Imager'] := _Imager;  // イメージ　の接続
> _Kernel.Parames['Samplr'] := _Samplr;  // サンプラーの接続
> ```

**反復回数**：OpenCL のプログラムは、３重のループ構文のように繰り返し実行されます。

> `Object Pascal`
> ```Delphi
> _Kernel.GloSizX := 100;  // Ｘ方向のループ回数
> _Kernel.GloSizY := 200;  // Ｙ方向のループ回数
> _Kernel.GloSizZ := 300;  // Ｚ方向のループ回数
> ```

ループの最小および最大インデックスを指定することも可能です。

> `Object Pascal`
> ```Delphi
> _Kernel.GloMinX := 0;      // Ｘ方向の開始インデックス
> _Kernel.GloMinY := 0;      // Ｙ方向の開始インデックス
> _Kernel.GloMinZ := 0;      // Ｚ方向の開始インデックス
>
> _Kernel.GloMaxX := 100-1;  // Ｘ方向の終了インデックス
> _Kernel.GloMaxY := 200-1;  // Ｙ方向の終了インデックス
> _Kernel.GloMaxZ := 300-1;  // Ｚ方向の終了インデックス
> ```

**実行**：

> `Object Pascal`
> ```Delphi
> _Kernel.Run;  // 実行
> ```

## 5. ビルド方法

* **IDE**：Embarcadero RAD Studio / Delphi（FireMonkey アプリケーション；プロジェクト形式バージョン 20.4）。
* **プロジェクト**：`OpenCL.dproj` を開いてビルドします。有効なターゲットプラットフォームは **Win32** と **Win64** です。
* **依存ライブラリ**：必要なライブラリ（`LUX`・`LUX.GPU.OpenCL`・Khronos `OpenCL-Headers` の翻訳 [4] を含む）は `_LIBRARY/` 以下に同梱され、`OpenCL.dpr` から直接参照されるため、追加のインストールは不要です。
* **ランタイム**：OpenCL ランタイム（`OpenCL.dll`）が必要です。通常は GPU ベンダーのドライバー（NVIDIA / AMD / Intel）と共にインストールされます。利用できない場合、アプリケーションは "OpenCL is not available." と表示します。
* **データファイル**：カーネルとグラデーションテクスチャは、実行ファイルからの相対パス（`..\..\_DATA\`）で `_DATA/` から読み込まれます。これは既定の出力ディレクトリ構成（例：`Win64\Debug\`）に対応します。

## 6. 参考文献

1. [Khronos OpenCL Registry](https://registry.khronos.org/OpenCL/).
2. [The OpenCL Specification, Version 3.0](https://registry.khronos.org/OpenCL/specs/3.0-unified/html/OpenCL_API.html), The Khronos Group Inc.
3. [The OpenCL C Specification, Version 3.0](https://registry.khronos.org/OpenCL/specs/3.0-unified/html/OpenCL_C.html), The Khronos Group Inc.
4. [KhronosGroup/OpenCL-Headers](https://github.com/KhronosGroup/OpenCL-Headers).

## 💖 [Embarcadero](https://www.embarcadero.com/jp/) [**Delphi**](https://www.embarcadero.com/jp/products/delphi)
ネイティブなクロスプラットフォームアプリを開発するための統合開発環境（ＩＤＥ）。
### Free Download: [**Delphi** Community Edition](https://www.embarcadero.com/jp/products/delphi/starter)
