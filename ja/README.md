<!---
layout: page
title: "README (Japanese)"
permalink: /ja/
-->
[`［English］`](https://luxophia.github.io/OpenCL/)

# [OpenCL](https://github.com/LUXOPHIA/OpenCL/tree/master/ja)
[OpenCL](https://ja.wikipedia.org/wiki/OpenCL) を用いたＧＰＵ（やＣＰＵ）での並列計算。  

![](https://github.com/LUXOPHIA/OpenCL/raw/master/--------/_SCREENSHOT/OpenCL.png)

----
## ■ 1. [`LUX.GPU.OpenCL`](https://luxophia.github.io/LUX.GPU.OpenCL/ja/) ライブラリ

> [`TOpenCL`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.pas#L82) ：TCLSystem のシングルトン  
> 　┃  
> [`TCLSystem`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.pas#L67) ：システム  
> 　┗[`TCLPlatfos`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Platfo.pas#L88) ：プラットフォームリスト  
> 　　　┗[`TCLPlatfo`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Platfo.pas#L33) ：プラットフォーム  
> 　　　　　┣[`TCLExtenss`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Platfo.pas#L25) ：拡張機能リスト  
> 　　　　　┣[`TCLDevices`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Device.pas#L293) ：デバイスリスト  
> 　　　　　┃　┗[`TCLDevice`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Device.pas#L21) ：デバイス  
> 　　　　　┗[`TCLContexs`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Contex.pas#L62) ：コンテキストリスト  
> 　　　　　　　┗[`TCLContex`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Contex.pas#L25) ：コンテキスト  
> 　　　　　　　　　┣[`TCLQueuers`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Queuer.pas#L51) ：コマンドキューリスト  
> 　　　　　　　　　┃　┗[`TCLQueuer`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Queuer.pas#L23) ：コマンドキュー  
> 　　　　　　　　　┣[`TCLArgumes`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.pas#L44) ：実引数リスト  
> 　　　　　　　　　┃　┣[`TCLBuffer`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Buffer.pas#L24) ：バッファー  
> 　　　　　　　　　┃　┣[`TCLImager`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.pas#L24) ：イメージ  
> 　　　　　　　　　┃　┗[`TCLSamplr`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Samplr.pas#L21) ：サンプラー  
> 　　　　　　　　　┣[`TCLLibrars`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Progra.pas#L245) ：ライブラリリスト  
> 　　　　　　　　　┃　┗[`TCLLibrar`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Progra.pas#L196) ：ライブラリ  
> 　　　　　　　　　┗[`TCLExecuts`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Progra.pas#L256) ：実行プログラムリスト  
> 　　　　　　　　　　　┗[`TCLExecut`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Progra.pas#L208) ：実行プログラム  
> 　　　　　　　　　　　　　┣[`TCLBuildrs`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Progra.pas#L80) ：ビルドリスト  
> 　　　　　　　　　　　　　┃　┗[`TCLBuildr`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Progra.pas#L33) ：ビルド  
> 　　　　　　　　　　　　　┗[`TCLKernels`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Kernel.pas#L214) ：カーネルリスト  
> 　　　　　　　　　　　　　　　┗[`TCLKernel`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Kernel.pas#L106) ：カーネル  
> 　　　　　　　　　　　　　　　　　┗[`TCLParames`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Kernel.pas#L65) ：仮引数リスト  
> 　　　　　　　　　　　　　　　　　　　┗[`TCLParame`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Kernel.pas#L33) ：仮引数

----
## ■ 2. ライブラリの利用方法
`TOpenCL`クラスは、`TCLSystem`クラスのシングルトンです。
`TCLSystem`クラスは、実行マシンにおけるすべての**計算用デバイス**を自動的に検出します。

### ⬤ 2.1. プラットフォーム
“**プラットフォーム**”オブジェクト (`TCLPlatfo`) は、各デバイスベンダーが定義する環境を表します。
`TCLSystem`クラスは、すべての**プラットフォーム**を自動的に検出し、`Platfors[]`プロパティに列挙します。 

> `Object Pascal`
> ```Delphi
> TOpenCL.Platfors.Count :Integer    // 全プラットフォームの数
> TOpenCL.Platfors[*]    :TCLPlatfo  // 全プラットフォームの配列
> ```

特定の**プラットフォーム**に関する情報は、`TCLPlatfo`クラスのプロパティから取得できます。  
> `Object Pascal`
> ```Delphi
> _Platfo := TOpenCL.Platfors[0];  // 特定プラットフォームの選択
> 
> _Platfo.Handle        :T_cl_platform_id  // ポインタ
> _Platfo.Profile       :String            // プロファイル
> _Platfo.Version       :String            // バージョン
> _Platfo.Name          :String            // 名前
> _Platfo.Vendor        :String            // ベンダー名
> _Platfo.Extenss.Count :Integer           // 拡張機能の数
> _Platfo.Extenss[*]    :String            // 拡張機能の配列
> ```

### ⬤ 2.2. デバイス
**デバイス**オブジェクト (`TCLDevice`) は、物理的なＧＰＵやＣＰＵを表します。
`TCLPlatfo`クラスは、特定の**プラットフォーム**内のすべての**デバイス**を自動的に検出し、`Devices[]`プロパティに列挙します。  
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

### ⬤ 2.3. コンテキスト
“**コンテキスト**” (`TCLContex`) は、関連するデータやプログラムを束ねて管理します。
`TCLContex`クラスは、`TCLPlatfo`クラスを引数として生成できます。  
> `Object Pascal`
> ```Delphi
> _Contex := TCLContex.Create( _Platfo );
> ```

生成された`TCLContex`クラスは、`TCLPlatfo`クラスの`Contexs[]`プロパティへ登録されます。
> `Object Pascal`  
> ```Delphi
> _Platfo.Contexs.Count :Integer    // コンテキストの数
> _Platfo.Contexs[*]    :TCLQueuer  // コンテキストの配列
> ``

### ⬤ 2.4. コマンドキュー
“**コマンドキュー**”オブジェクト (`TCLQueuer`) は、**デバイス**に送られる命令を管理します。
つまり、**コンテキスト**と**デバイス**を繋ぐオブジェクトです。
`TCLQueuer`クラスは、`TCLContex`クラスと`TCLDevice`クラスを引数として生成できます。  
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

なお、**プラットフォーム**の異なる**コンテキスト**と**デバイス**を繋ぐ**コマンドキュー**は生成できません。
> `Object Pascal`  
> ```Delphi
> P0 := TOpenCL.Platfors[0];
> P1 := TOpenCL.Platfors[1];
> P2 := TOpenCL.Platfors[2];
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

### ⬤ 2.5. 実引数

> [`TCLArgume`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.pas#L21)  
> 　┣[`TCLMemory`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.pas#L24)  
> 　┃　┣[`TCLBuffer`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Buffer.pas#L24)  
> 　┃　┗[`TCLImager`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.pas#L24)  
> 　┗[`TCLSamplr`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Samplr.pas#L21)  

#### ▼ 2.5.1. メモリー
“**メモリー**”オブジェクト (`TCLMemory`) は、様々なデータを格納し**デバイス**と共有します。
`TCLMemory`クラスは、`TCLContex`クラスと`TCLQueuer`クラスを引数として生成できます。
`TCLMemory`クラスは抽象クラスであり、`TCLBuffer`クラスと`TCLImager`クラスを派生させます。  

#### ▽ 2.5.1.1. バッファー 
`TCLBuffer`クラスは、任意の“単純型”や“レコード型”の配列を格納します。

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
> _Buffer := TCLBuffer<TItem>.Create( _Contex, _Queuer );
> ```

配列データは、`Data[]`プロパティを通して読み書きします。
ホストとデバイスを同期させるために、配列データを読み書きする前に“**マップ**”し、使用後に“**アンマップ**”する必要があります。
> `Object Pascal`
> ```Delphi
> _Buffer.Count := 3;                          // 要素数の設定
> _Buffer.Data.Map;                            // メモリ領域を展開
> _Buffer.Data[0] := TItem.Create( 1, 2.34 );  // 書き込み
> _Buffer.Data[1] := TItem.Create( 5, 6.78 );  // 書き込み
> _Buffer.Data[2] := TItem.Create( 9, 0.12 );  // 書き込み
> _Buffer.Data.Unmap;                          // メモリ領域を同期
> ```

#### ▽ 2.5.1.2. イメージ
“**イメージ**”オブジェクト (`TCLImager`) は、１Ｄ～３Ｄにおけるピクセル配列を格納します。
３Ｄのボクセルデータも**イメージ**の一種と見なされます。
`TCLImager`クラスは抽象クラスであり、カラーチャンネルのレイアウトやビット数に応じて、様々なクラスが派生します。  

> [`TCLImager`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.pas#L24)  
　┣[`TCLImager1D`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D1.pas#L24)  
　┃　┗[`TCLImager1DFMX`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D1.FMX.pas#L25)  
　┃　　　┣[`TCLImager1DxBGRAxUInt8`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D1.FMX.pas#L38)  
　┃　　　┣[`TCLImager1DxBGRAxUFix8`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D1.FMX.pas#L52)  
　┃　　　┗[`TCLImager1DxRGBAxSFlo32`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D1.FMX.pas#L66)  
　┣[`TCLImager2D`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D2.pas#L25)  
　┃　┗[`TCLImager2DFMX`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D2.FMX.pas#L26)  
　┃　　　┣[`TCLImager2DxBGRAxUInt8`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D2.FMX.pas#L39)  
　┃　　　┣[`TCLImager2DxBGRAxUFix8`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D2.FMX.pas#L53)  
　┃　　　┣[`TCLImager2DxRGBAxUInt32`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D2.FMX.pas#L67)  
　┃　　　┗[`TCLImager2DxRGBAxSFlo32`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D2.FMX.pas#L81)  
　┗[`TCLImager3D`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D3.pas#L24)  
　　　┗[`TCLImager3DFMX`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D3.FMX.pas#L25)  
　　　　　┣[`TCLImager3DxBGRAxUInt8`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D3.FMX.pas#L38)  
　　　　　┣[`TCLImager3DxBGRAxUFix8`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D3.FMX.pas#L52)  
　　　　　┗[`TCLImager3DxRGBAxSFlo32`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D3.FMX.pas#L66)  

クラス名の１番目の部分は、画像の次元を表しています。  
> * TCLImager`1D`x`*`x`*`  
>   * 次元：`１Ｄ`
> * TCLImager`2D`x`*`x`*`  
>   * 次元：`２Ｄ`
> * TCLImager`3D`x`*`x`*`  
>   * 次元：`３Ｄ`

クラス名の２番目の部分は、カラーチャンネルの順番を表しています。  
> * TCLImager`*`x`BGRA`x`*`  
>   * カラーチャンネル順：`ＢＧＲＡ`
> * TCLImager`*`x`RGBA`x`*`  
>   * カラーチャンネル順：`ＲＧＢＡ`

クラス名の３番目の部分は、色のデータ型を表しています。  
> * TCLImager`*`x`*`x`UInt8`  
>   * デバイス側データ型：`uint8` @ OpenCL C
>   * ホスト側データ型：`UInt8 (Byte)` @ Delphi
> * TCLImager`*`x`*`x`UFix8`  
>   * デバイス側データ型：`float` @ OpenCL C
>   * ホスト側データ型：`UInt8 (Byte)` @ Delphi
> * TCLImager`*`x`*`x`UInt32`  
>   * デバイス側データ型：`uint` @ OpenCL C
>   * ホスト側データ型：`UInt32 (Cardinal)` @ Delphi
> * TCLImager`*`x`*`x`SFlo32`  
>   * デバイス側データ型：`float` @ OpenCL C
>   * ホスト側データ型：`Single` @ Delphi

Ｘ/Ｙ/Ｚ方向のピクセル数は、'CountX'/'Y'/'Z' プロパティで設定できます。
> `Object Pascal`
> ```Delphi
> _Imager := TCLDevIma3DxBGRAxUInt8.Create( _Contex, _Queuer );
> _Imager.CountX := 100;  // Ｘ方向ピクセル数
> _Imager.CountY := 200;  // Ｙ方向ピクセル数
> _Imager.CountZ := 300;  // Ｚ方向ピクセル数
> ```

#### ▼ 2.5.2. サンプラー
サンプラーオブジェクト (`TCLSamplr`) は、ピクセル色を実数座標で得るための補間方法を定義します。  
`TCLSamplr` クラスは、'TCLContex'クラスを引数として生成できます。
> `Object Pascal`
> ```Delphi
> _Samplr := TCLSamplr.Create( _Contex );
> ```

### ⬤ 2.6. プログラム 
“**プログラム**”オブジェクト (`TCLProgra`) は、ソースコードを読み込んで、実行可能なバイナリへビルドします。
`TCLProgra`クラスは、'TCLContex'クラスを引数として生成できます。
`TCLProgra`クラスは抽象クラスであり、ソースコードの種類に応じて、`TCLLibrar`クラスと`TCLExecut`クラスへ派生します。  

#### ▼ 2.6.1. ライブラリ
`TCLLibrar`クラスは、直接実行する関数を含まないプログラムです。  
> `Object Pascal`
> ```Delphi
> _Librar := TCLLibrar.Create( _Contex );
> 
> _Librar.Source.LoadFromFile( 'Librar.cl' );  // ソースコードのロード
> ```

#### ▼ 2.6.2. エグゼキュータブル 
`TCLExecut`クラスは、直接実行する関数（**カーネル**）を含んだプログラムです。  
> `Object Pascal`
> ```Delphi
> _Execut := TCLExecut.Create( _Contex );
> 
> _Execut.Source.LoadFromFile( 'Execut.cl' );  // ソースコードのロード
> ```

### ⬤ 2.7. ビルド
**ビルド** (`TCLBuildr`) は**プログラム**が行う“行為”ですが、我々のライブラリではクラスとして明示的に表現されます。  
`TCLBuildr` クラスは、'TCLExecut'クラスと'TCLDevice'クラスを引数として生成できます。
> `Object Pascal`
> ```Delphi
> _Buildr := TCLBuildr.Create( _Execut, _Device );
>   {or}
> _Buildr := _Execut.Buildrs[ _Device ];
>   {or}
> _Buildr := _Execut.BuildTo( _Device );
> ```

**カーネル**オブジェクト（2.8.章参照）は、実行時に`TCLBuildr`クラスを自動生成します。
しかし、カーネルの実行前に`TCLBuildr`クラスを作成することで、コンパイルとリンクのエラーを事前に確認することができます。 
> `Object Pascal`
> ```Delphi
> _Buildr.Handle;  // ビルドの実行（ハンドルの生成）
> 
> _Buildr.CompileStatus :T_cl_build_status  // コンパイルのスタータス
> _Buildr.CompileLog    :String             // コンパイルのログ
> _Buildr.LinkStatus    :T_cl_build_status  // リンクのスタータス
> _Buildr.LinkLog       :String             // リンクのログ
> ```

### ⬤ 2.8. カーネル 
**カーネル**”オブジェクト (`TCLKernel`) は、プログラムの中の実行可能な関数を表します。  
> `OpenCL C`
> ```C
> kernel void Main( ･･･ ) {
>   ･･･
> }
> ```

`TCLKernel`クラスは、`TCLExecut`クラスと`TCLQueuer`クラスを引数として生成できます。  
> `Object Pascal`
> ```Delphi
> _Kernel := TCLKernel.Create( _Execut, 'Main', _Queuer );
>   {or}
> _Kernel := _Execut.Kernels.Add( 'Main', _Queuer );
> ```

#### ▼ 2.8.1. 仮引数
**メモリ**オブジェクトは、`TCLKernel`クラスの`Parames[]`プロパティを介して、ソースコードの引数へ接続します。  
> `Object Pascal`
> ```Delphi
> _Kernel.Parames['Buffer'] := _Buffer;  // バッファーの接続
> _Kernel.Parames['Imager'] := _Imager;  // イメージ　の接続
> _Kernel.Parames['Samplr'] := _Samplr;  // サンプラーの接続
> ```

#### ▼ 2.8.2. 反復回数 
OpenCL のプログラムは、３重のループ構文のように繰り返し実行されます。  
> `Object Pascal`
> ```Delphi
> _Kernel.GloSizX := 100;  // Ｘ方向のループ回数
> _Kernel.GloSizY := 200;  // Ｙ方向のループ回数
> _Kernel.GloSizZ := 300;  // Ｚ方向のループ回数
> ```

ループのインデックスの最小値と最大値を指定することもできます。  
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

#### ▼ 2.8.3. 実行
> `Object Pascal`
> ```Delphi
> _Kernel.Run;  // 実行
> ```

----
## ■ 3. 参考文献

### ⬤ 3.1. [The Khronos Group Inc](https://www.khronos.org/)
* [Khronos OpenCL Registry - The Khronos Group Inc](https://www.khronos.org/registry/OpenCL/)
  * [3.0](https://www.khronos.org/registry/OpenCL/specs/3.0-unified/)
    * [The OpenCL Specification](https://www.khronos.org/registry/OpenCL/specs/3.0-unified/html/OpenCL_API.html)
    * [The OpenCL Specification](https://www.khronos.org/registry/OpenCL/specs/3.0-unified/pdf/OpenCL_API.pdf) .pdf
    * [The OpenCL C Specification](https://www.khronos.org/registry/OpenCL/specs/3.0-unified/html/OpenCL_C.html)
    * [The OpenCL C Specification](https://www.khronos.org/registry/OpenCL/specs/3.0-unified/pdf/OpenCL_C.pdf) .pdf

### ⬤ 3.2. [GitHub](https://github.com)
* [The Khronos Group](https://github.com/KhronosGroup)
  * [OpenCL-Headers](https://github.com/KhronosGroup/OpenCL-Headers)

----
* **Delphi IDE** @ Embarcadero  
https://www.embarcadero.com/jp/products/delphi/starter
