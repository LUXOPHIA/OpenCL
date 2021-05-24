<!---
layout: page
title: "README (Japanese)"
permalink: /ja/
-->
[`［English］`](https://luxophia.github.io/LUX.GPU.OpenCL/)

# [LUX.GPU.OpenCL](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/ja/README.md)
ＧＰＵ（やＣＰＵ）による並列計算のための [OpenCL](https://en.wikipedia.org/wiki/OpenCL) ライブラリ。

----
## ■ 1. クラス

### ⬤ 1.1. 依存関係
> [`TOpenCL`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.pas#L82) ：TCLSystem のシングルトン  
　┃  
[`TCLSystem`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.pas#L67) ：システム  
　┗[`TCLPlatfos`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Platfo.pas#L88) ：プラットフォームリスト  
　　　┗[`TCLPlatfo`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Platfo.pas#L33) ：プラットフォーム  
　　　　　┣[`TCLExtenss`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Platfo.pas#L25) ：拡張機能リスト  
　　　　　┣[`TCLDevices`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Device.pas#L293) ：デバイスリスト  
　　　　　┃　┗[`TCLDevice`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Device.pas#L21) ：デバイス  
　　　　　┗[`TCLContexs`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Contex.pas#L62) ：コンテキストリスト  
　　　　　　　┗[`TCLContex`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Contex.pas#L25) ：コンテキスト  
　　　　　　　　　┣[`TCLQueuers`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Queuer.pas#L51) ：コマンドキューリスト  
　　　　　　　　　┃　┗[`TCLQueuer`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Queuer.pas#L23) ：コマンドキュー  
　　　　　　　　　┣[`TCLArgumes`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.pas#L44) ：実引数リスト  
　　　　　　　　　┃　┣[`TCLBuffer`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Buffer.pas#L24) ：バッファー  
　　　　　　　　　┃　┣[`TCLImager`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.pas#L24) ：画像  
　　　　　　　　　┃　┗[`TCLSamplr`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Samplr.pas#L21) ：サンプラー  
　　　　　　　　　┣[`TCLLibrars`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Progra.pas#L245) ：ライブラリプログラムリスト  
　　　　　　　　　┃　┗[`TCLLibrar`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Progra.pas#L196) ：ライブラリプログラム  
　　　　　　　　　┗[`TCLExecuts`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Progra.pas#L256) ：実行可能プログラムリスト  
　　　　　　　　　　　┗[`TCLExecut`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Progra.pas#L208) ：実行可能プログラム  
　　　　　　　　　　　　　┣[`TCLBuildrs`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Progra.pas#L80) ：ビルドリスト  
　　　　　　　　　　　　　┃　┗[`TCLBuildr`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Progra.pas#L33) ：ビルド  
　　　　　　　　　　　　　┗[`TCLKernels`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Kernel.pas#L214) ：カーネルリスト  
　　　　　　　　　　　　　　　┗[`TCLKernel`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Kernel.pas#L106) ：カーネル  
　　　　　　　　　　　　　　　　　┗[`TCLParames`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Kernel.pas#L65) ：仮引数リスト  
　　　　　　　　　　　　　　　　　　　┗[`TCLParame`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Kernel.pas#L33) ：仮引数

### ⬤ 1.2. 継承関係

----
## ■ 2. ユニット

### ⬤ 2.1. 依存関係

> [`LUX.GPU.OpenCL`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.pas) ：システム  
>　┣[`LUX.GPU.OpenCL.core`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.core.pas) ：共通ルーチン  
>　┣[`LUX.GPU.OpenCL.Show`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Show.pas) ：システム情報表示  
>　┃　┗ LUX.GPU.OpenCL.core  
>　┣[`LUX.GPU.OpenCL.Platfo`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Platfo.pas) ：ブラットフォーム  
>　┃　┣ LUX.GPU.OpenCL.core  
>　┃　┣[`LUX.GPU.OpenCL.Device`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Device.pas) ：デバイス  
>　┃　┃　┗ LUX.GPU.OpenCL.core  
>　┃　┗[`LUX.GPU.OpenCL.Contex`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Contex.pas) ：コンテキスト  
>　┃　　　┣[`LUX.GPU.OpenCL.Queuer`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Queuer.pas) ：コマンドキュー  
>　┃　　　┃　┣ LUX.GPU.OpenCL.core  
>　┃　　　┃　┗ LUX.GPU.OpenCL.Device  
>　┃　　　┣[`LUX.GPU.OpenCL.Argume`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.pas) ：実引数  
>　┃　　　┃　┗ LUX.GPU.OpenCL.core  
>　┃　　　┗[`LUX.GPU.OpenCL.Progra`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Progra.pas) ：プログラム  
>　┃　　　　　┃　┣ LUX.GPU.OpenCL.core  
>　┃　　　　　┃　┗ LUX.GPU.OpenCL.Device  
>　┃　　　　　┗[`LUX.GPU.OpenCL.Kernel`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Kernel.pas) ：カーネル  
>　┃　　　　　　　┣ LUX.GPU.OpenCL.core  
>　┃　　　　　　　┣ LUX.GPU.OpenCL.Device  
>　┃　　　　　　　┣ LUX.GPU.OpenCL.Queuer  
>　┃　　　　　　　┗ LUX.GPU.OpenCL.Argume  
>　┣[`LUX.GPU.OpenCL.Argume.Samplr`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Samplr.pas) ：サンプラー  
>　┃　┣ LUX.GPU.OpenCL.core  
>　┃　┗ LUX.GPU.OpenCL.Argume  
>　┣[`LUX.GPU.OpenCL.Argume.Memory`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.pas) ：メモリー  
>　┃　┣ LUX.GPU.OpenCL.core  
>　┃　┣ LUX.GPU.OpenCL.Queuer  
>　┃　┗ LUX.GPU.OpenCL.Argume  
>　┣[`LUX.GPU.OpenCL.Argume.Memory.Buffer`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Buffer.pas) ：バッファー  
>　┃　┣ LUX.GPU.OpenCL.core  
>　┃　┣ LUX.GPU.OpenCL.Queuer  
>　┃　┗ LUX.GPU.OpenCL.Argume.Memory  
>　┗[`LUX.GPU.OpenCL.Argume.Memory.Imager`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.pas) ：画像  
>　　　┣ LUX.GPU.OpenCL.core  
>　　　┣ LUX.GPU.OpenCL.Queuer  
>　　　┗ LUX.GPU.OpenCL.Argume.Memory  

#### ▼ 2.1.1. FireMonkey 用

> [`LUX.GPU.OpenCL.FMX`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.FMX.pas) ：ＦＭＸ用システム  
> 　┣ LUX.GPU.OpenCL  
> 　┣[`LUX.GPU.OpenCL.Argume.Memory.Imager.D1.FMX`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D1.FMX.pas) ：ＦＭＸ用１Ｄ画像   
> 　┃　┗[`LUX.GPU.OpenCL.Argume.Memory.Imager.D1`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D1.pas) ：１Ｄ画像   
> 　┃　　　┣ LUX.GPU.OpenCL.core  
> 　┃　　　┗ LUX.GPU.OpenCL.Argume.Memory.Imager  
> 　┣[`LUX.GPU.OpenCL.Argume.Memory.Imager.D2.FMX`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D2.FMX.pas) ：ＦＭＸ用２Ｄ画像   
> 　┃　┗[`LUX.GPU.OpenCL.Argume.Memory.Imager.D2`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D2.pas) ：２Ｄ画像   
> 　┃　　　┣ LUX.GPU.OpenCL.core  
> 　┃　　　┗ LUX.GPU.OpenCL.Argume.Memory.Imager  
> 　┗[`LUX.GPU.OpenCL.Argume.Memory.Imager.D3.FMX`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D3.FMX.pas) ：ＦＭＸ用３Ｄ画像  
> 　　　┗[`LUX.GPU.OpenCL.Argume.Memory.Imager.D3`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D3.pas) ：３Ｄ画像  
> 　　　　　┣ LUX.GPU.OpenCL.core  
> 　　　　　┗ LUX.GPU.OpenCL.Argume.Memory.Imager  

### ⬤ 2.2. 継承関係

> [`LUX.GPU.OpenCL.Argume`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.pas) ：実引数  
　　┣[`LUX.GPU.OpenCL.Argume.Samplr`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Samplr.pas) ：サンプラー  
　　┗[`LUX.GPU.OpenCL.Argume.Memory`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.pas) ：メモリー  
　　　　┣[`LUX.GPU.OpenCL.Argume.Memory.Buffer`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Buffer.pas) ：バッファー  
　　　　┗[`LUX.GPU.OpenCL.Argume.Memory.Imager`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.pas) ：画像  
　　　　　　┗[`LUX.GPU.OpenCL.Argume.Memory.Imager.D1`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D1.pas) ：１Ｄ  
　　　　　　┃　┗[`LUX.GPU.OpenCL.Argume.Memory.Imager.D1.FMX`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D1.FMX.pas) ：ＦＭＸ用  
　　　　　　┗[`LUX.GPU.OpenCL.Argume.Memory.Imager.D2`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D2.pas) ：２Ｄ  
　　　　　　┃　┗[`LUX.GPU.OpenCL.Argume.Memory.Imager.D2.FMX`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D2.FMX.pas) ：ＦＭＸ用  
　　　　　　┗[`LUX.GPU.OpenCL.Argume.Memory.Imager.D3`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D3.pas) ：３Ｄ  
　　　　　　　　┗[`LUX.GPU.OpenCL.Argume.Memory.Imager.D3.FMX`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D3.FMX.pas) ：ＦＭＸ用  

----
## ■ 3. 参考文献

### ⬤ 3.1. [The Khronos Group Inc](https://www.khronos.org/)
* [Khronos OpenCL Registry - The Khronos Group Inc](https://www.khronos.org/registry/OpenCL/)
  * [3.0](https://www.khronos.org/registry/OpenCL/specs/3.0-unified/)
    * [The OpenCL Specification](https://www.khronos.org/registry/OpenCL/specs/3.0-unified/html/OpenCL_API.html)
    * [The OpenCL Specification](https://www.khronos.org/registry/OpenCL/specs/3.0-unified/pdf/OpenCL_API.pdf).pdf
    * [The OpenCL C Specification](https://www.khronos.org/registry/OpenCL/specs/3.0-unified/html/OpenCL_C.html)
    * [The OpenCL C Specification](https://www.khronos.org/registry/OpenCL/specs/3.0-unified/pdf/OpenCL_C.pdf).pdf

### ⬤ 3.2. [GitHub](https://github.com)
* [The Khronos Group](https://github.com/KhronosGroup)
  * [OpenCL-Headers](https://github.com/KhronosGroup/OpenCL-Headers)

----
* [**Delphi IDE**](https://www.embarcadero.com/jp/products/delphi/starter) @ [Embarcadero](https://www.embarcadero.com)
