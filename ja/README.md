<!---
layout: page
title: "README (Japanese)"
permalink: /ja/
-->
[`［English］`](https://luxophia.github.io/LUX.GPU.OpenCL/)

# LUX.GPU.OpenCL

GPU(または CPU)による並列計算のための、[Delphi](https://www.embarcadero.com/jp/products/delphi) 用 [OpenCL](https://ja.wikipedia.org/wiki/OpenCL) 3.1 ラッパーライブラリ。

OpenCL C のカーネルを文字列として書き、パラメータに名前で Delphi の値を割り当てて、実行する — ハンドル管理も API の決まり文句も不要です。

----
## ■ 1. 特徴

* **OpenCL 3.1 完全バインディング** — 公式の [Khronos OpenCL-Headers](https://github.com/KhronosGroup/OpenCL-Headers) と一対一対応で移植。
* **ランタイムの動的ロード** — `OpenCL.dll` は実行時にロードされるため、OpenCL ドライバの無いマシンでもアプリは起動します。使えるかどうかは `TOpenCL.Available` で判定できます。
* **オブジェクト指向モデル** — プラットフォーム・デバイス・コンテキスト・キュー・プログラム・カーネル・バッファ等、OpenCL の全オブジェクトが Delphi のクラスとして、仕様と同じ親子階層で提供されます。
* **寿命の自動管理** — 親が子を所有します。ライブラリのオブジェクトに `Free` を書く必要はなく、終了時にすべて自動解放されます。
* **例外ベースのエラー処理** — 失敗した OpenCL 呼び出しは、エラーコードと読めるメッセージを持つ `ECLError` を送出します。エラーが黙殺されることはありません。
* **型付きバッファとイメージ** — `TCLBuffer<T>` により GPU メモリを型安全な配列のように扱えます。1D/2D/3D イメージも複数のピクセル形式で提供。
* **ゼロコピー設計** — バッファは `CL_MEM_ALLOC_HOST_PTR` + Map/Unmap 方式で、ホスト・デバイス間の無駄なコピーを避けます。
* **分離コンパイル&リンク** — `clCompileProgram` / `clLinkProgram` によるビルドで、カーネルソース内の `#include` はメモリ上のライブラリプログラム(`TCLLibrar`)からディスク不要で解決されます。

----
## ■ 2. 動作環境

* **Delphi** — Delphi 12.x(Win32 / Win64)で開発・確認。ジェネリクスの使える近年のバージョンなら動作する見込みです。
* **OpenCL ランタイム** — GPU ドライバ(NVIDIA / AMD / Intel)が提供します。OpenCL 2.0 以降を推奨。
* **[LUXOPHIA/LUX](https://github.com/LUXOPHIA/LUX)** — 基盤ライブラリ(数学型・汎用リスト・色)。本リポジトリには同梱されていません。

> **はじめての方へ**: サンプルリポジトリ [LUXOPHIA/OpenCL](https://github.com/LUXOPHIA/OpenCL) から始めるのがお勧めです。本ライブラリと全依存ライブラリが同梱されており、対話型マンデルブロレンダラーをすぐにビルド・実行できます。

----
## ■ 3. クイックスタート

ライブラリのフォルダ(と `LUX` のフォルダ)をプロジェクトの検索パスに追加して:

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
     for P in TOpenCL.Platfos do Break;
     for D in P.Devices       do Break;

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
     B := TCLBuffer<Single>.Create( C, Q );
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

プログラムのコンパイルは、カーネルが実際に必要になった時点で遅延実行されます。カーネルソースは `E.Source.LoadFromFile( 'MyKernel.cl' )` でファイルから読み込むこともできます。

----
## ■ 4. エラー処理

失敗した OpenCL 呼び出しは `ECLError` 例外を送出します。`Message` に OpenCL のエラー名が入り、`Code` プロパティで生のエラーコードを取得できます。

```pascal
try
   K.Run;
except
   on X :ECLError do ShowMessage( X.Message );  // 例:【INVALID_KERNEL_ARGS】…
end;
```

カーネルのビルドに失敗した場合は、デバイスごとのコンパイルログを確認できます:

```pascal
ShowMessage( E.BuildTo( D ).CompileLog );
```

診断用に、プラットフォーム/デバイスのツリー全体を表示するには:

```pascal
TOpenCL.Show( Memo1.Lines );
```

----
## ■ 5. クラス階層

オブジェクトはツリーを構成し、親が子を生成・所有・解放します。

```
TOpenCL :シングルトンの窓口
 └ TCLSystem :システム
    └ TCLPlatfos ─ TCLPlatfo :プラットフォーム
       ├ TCLDevices ─ TCLDevice :デバイス
       └ TCLContexs ─ TCLContex :コンテキスト
          ├ TCLQueuers ─ TCLQueuer :コマンドキュー
          ├ TCLArgumes ─ TCLBuffer<T> / TCLImager / TCLSamplr :カーネル引数
          ├ TCLLibrars ─ TCLLibrar :ライブラリプログラム(#include 用)
          └ TCLExecuts ─ TCLExecut :実行プログラム
             ├ TCLBuildrs ─ TCLBuildr :デバイス別ビルド
             └ TCLKernels ─ TCLKernel :カーネル
                └ TCLParames ─ TCLParame :カーネルパラメータ
```

----
## ■ 6. ユニット構成

| フォルダ / ユニット | 対応 |
|:--|:--|
| `CL/cl_platform.pas` | `cl_platform.h` — 基本スカラー型 |
| `CL/cl_version.pas` | `cl_version.h` — バージョンスイッチ(`CL_TARGET_OPENCL_VERSION`) |
| `CL/cl.pas` | `cl.h` — OpenCL API の型・定数・関数型 |
| `CL/cl_functions.pas` | ICD ローダー相当 — API 関数変数 + `LoadFunctions` |
| `Core/LUX.GPU.OpenCL.core.pas` | `ECLError` / `CheckCL` / `TCLVersion` |
| `Core/LUX.GPU.OpenCL.*.pas` | クラスラッパー(Platfo / Device / Contex / Queuer / Progra / Kernel / Argume …) |
| `LUX.GPU.OpenCL.pas` | エントリポイント: `TOpenCL` と全クラスの短縮エイリアス |
| `Argume/`, `Stream/` | 補助ユーティリティ(乱数シーダー、FMX 画像ストリーミング) |

----
## ■ 7. ロードマップ

* 非同期実行(`cl_event` ラッパー、`RunAsync`、プロファイリング)
* 半精度浮動小数点対応(`cl_half.h` の移植と `THalf` 型)
* サンプルの拡充

----
## ■ 8. ライセンス

[Apache License 2.0](../LICENSE) — 同梱の Khronos OpenCL ヘッダーと同一ライセンスです。

## ■ 9. 参考

* [Khronos OpenCL Registry](https://registry.khronos.org/OpenCL/)
* [KhronosGroup/OpenCL-Headers](https://github.com/KhronosGroup/OpenCL-Headers)
* [LUXOPHIA/OpenCL](https://github.com/LUXOPHIA/OpenCL) — サンプルアプリ(マンデルブロレンダラー)
