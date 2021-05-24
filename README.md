<!---
layout: page
title: "README (English)"
permalink: /
-->
[`［日本語］`](https://luxophia.github.io/LUX.GPU.OpenCL/ja/)

# [LUX.GPU.OpenCL](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/README.md)
[OpenCL](https://en.wikipedia.org/wiki/OpenCL) Library for parallel computing on the GPU (or CPU).  

----
## ■ 1. Classes

### ⬤ 1.1. Dependence Relationships
> [`TOpenCL`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.pas#L82) ：singleton of TCLSystem  
　┃  
[`TCLSystem`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.pas#L67) ：System  
　┗[`TCLPlatfos`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Platfo.pas#L88) ：Platform list  
　　　┗[`TCLPlatfo`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Platfo.pas#L33) ：Platform  
　　　　　┣[`TCLExtenss`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Platfo.pas#L25) ：Extension list  
　　　　　┣[`TCLDevices`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Device.pas#L293) ：Device list  
　　　　　┃　┗[`TCLDevice`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Device.pas#L21) ：Device  
　　　　　┗[`TCLContexs`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Contex.pas#L62) ：Context list  
　　　　　　　┗[`TCLContex`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Contex.pas#L25) ：Context  
　　　　　　　　　┣[`TCLQueuers`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Queuer.pas#L51) ：Command Queue list  
　　　　　　　　　┃　┗[`TCLQueuer`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Queuer.pas#L23) ：Command Queue  
　　　　　　　　　┣[`TCLArgumes`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.pas#L44) ：Argument list  
　　　　　　　　　┃　┣[`TCLBuffer`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Buffer.pas#L24) ：Buffer  
　　　　　　　　　┃　┣[`TCLImager`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.pas#L24) ：Image  
　　　　　　　　　┃　┗[`TCLSamplr`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Samplr.pas#L21) ：Sampler  
　　　　　　　　　┣[`TCLLibrars`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Progra.pas#L245) ：Library program list  
　　　　　　　　　┃　┗[`TCLLibrar`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Progra.pas#L196) ：Library program  
　　　　　　　　　┗[`TCLExecuts`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Progra.pas#L256) ：Executable program list  
　　　　　　　　　　　┗[`TCLExecut`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Progra.pas#L208) ：Executable program  
　　　　　　　　　　　　　┣[`TCLBuildrs`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Progra.pas#L80) ：Build list  
　　　　　　　　　　　　　┃　┗[`TCLBuildr`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Progra.pas#L33) ：Build  
　　　　　　　　　　　　　┗[`TCLKernels`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Kernel.pas#L214) ：Kernel list  
　　　　　　　　　　　　　　　┗[`TCLKernel`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Kernel.pas#L106) ：Kernel  
　　　　　　　　　　　　　　　　　┗[`TCLParames`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Kernel.pas#L65) ：Parameter list  
　　　　　　　　　　　　　　　　　　　┗[`TCLParame`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Kernel.pas#L33) ：Parameter

### ⬤ 1.2. Inheritance Relationships

----
## ■ 2. Uints

### ⬤ 2.1. Dependence Relationships

> [`LUX.GPU.OpenCL`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.pas) ：System  
>　┣[`LUX.GPU.OpenCL.core`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.core.pas) ：Common Routine  
>　┣[`LUX.GPU.OpenCL.Show`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Show.pas) ：Show System Infomation  
>　┃　┗ LUX.GPU.OpenCL.core  
>　┣[`LUX.GPU.OpenCL.Platfo`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Platfo.pas) ：Platform  
>　┃　┣ LUX.GPU.OpenCL.core  
>　┃　┣[`LUX.GPU.OpenCL.Device`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Device.pas) ：Device  
>　┃　┃　┗ LUX.GPU.OpenCL.core  
>　┃　┗[`LUX.GPU.OpenCL.Contex`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Contex.pas) ：Context  
>　┃　　　┣[`LUX.GPU.OpenCL.Queuer`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Queuer.pas) ：Command Queue  
>　┃　　　┃　┣ LUX.GPU.OpenCL.core  
>　┃　　　┃　┗ LUX.GPU.OpenCL.Device  
>　┃　　　┣[`LUX.GPU.OpenCL.Argume`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.pas) ：Argument  
>　┃　　　┃　┗ LUX.GPU.OpenCL.core  
>　┃　　　┗[`LUX.GPU.OpenCL.Progra`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Progra.pas) ：Program  
>　┃　　　　　┃　┣ LUX.GPU.OpenCL.core  
>　┃　　　　　┃　┗ LUX.GPU.OpenCL.Device  
>　┃　　　　　┗[`LUX.GPU.OpenCL.Kernel`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Kernel.pas) ：Kernel  
>　┃　　　　　　　┣ LUX.GPU.OpenCL.core  
>　┃　　　　　　　┣ LUX.GPU.OpenCL.Device  
>　┃　　　　　　　┣ LUX.GPU.OpenCL.Queuer  
>　┃　　　　　　　┗ LUX.GPU.OpenCL.Argume  
>　┣[`LUX.GPU.OpenCL.Argume.Samplr`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Samplr.pas) ：Sampler  
>　┃　┣ LUX.GPU.OpenCL.core  
>　┃　┗ LUX.GPU.OpenCL.Argume  
>　┣[`LUX.GPU.OpenCL.Argume.Memory`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.pas) ：Memory  
>　┃　┣ LUX.GPU.OpenCL.core  
>　┃　┣ LUX.GPU.OpenCL.Queuer  
>　┃　┗ LUX.GPU.OpenCL.Argume  
>　┣[`LUX.GPU.OpenCL.Argume.Memory.Buffer`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Buffer.pas) ：Buffer  
>　┃　┣ LUX.GPU.OpenCL.core  
>　┃　┣ LUX.GPU.OpenCL.Queuer  
>　┃　┗ LUX.GPU.OpenCL.Argume.Memory  
>　┗[`LUX.GPU.OpenCL.Argume.Memory.Imager`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.pas) ：Image  
>　　　┣ LUX.GPU.OpenCL.core  
>　　　┣ LUX.GPU.OpenCL.Queuer  
>　　　┗ LUX.GPU.OpenCL.Argume.Memory  

#### ▼ 2.1.1. for FireMonkey

> [`LUX.GPU.OpenCL.FMX`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.FMX.pas) ：  
> 　┣ LUX.GPU.OpenCL  
> 　┣[`LUX.GPU.OpenCL.Argume.Memory.Imager.D1.FMX`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D1.FMX.pas) ：1D Image for FMX  
> 　┃　┗[`LUX.GPU.OpenCL.Argume.Memory.Imager.D1`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D1.pas) ：1D Image  
> 　┃　　　┣ LUX.GPU.OpenCL.core  
> 　┃　　　┗ LUX.GPU.OpenCL.Argume.Memory.Imager  
> 　┣[`LUX.GPU.OpenCL.Argume.Memory.Imager.D2.FMX`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D2.FMX.pas) ：2D Image for FMX  
> 　┃　┗[`LUX.GPU.OpenCL.Argume.Memory.Imager.D2`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D2.pas) ：2D Image  
> 　┃　　　┣ LUX.GPU.OpenCL.core  
> 　┃　　　┗ LUX.GPU.OpenCL.Argume.Memory.Imager  
> 　┗[`LUX.GPU.OpenCL.Argume.Memory.Imager.D3.FMX`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D3.FMX.pas) ：3D Image for FMX  
> 　　　┗[`LUX.GPU.OpenCL.Argume.Memory.Imager.D3`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D3.pas) ：3D Image  
> 　　　　　┣ LUX.GPU.OpenCL.core  
> 　　　　　┗ LUX.GPU.OpenCL.Argume.Memory.Imager  

### ⬤ 2.2. Inheritance Relationships

> [`LUX.GPU.OpenCL.Argume`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.pas) ：Argument  
　　┣[`LUX.GPU.OpenCL.Argume.Samplr`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Samplr.pas) ：Sampler  
　　┗[`LUX.GPU.OpenCL.Argume.Memory`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.pas) ：Memory  
　　　　┣[`LUX.GPU.OpenCL.Argume.Memory.Buffer`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Buffer.pas) ：Buffer  
　　　　┗[`LUX.GPU.OpenCL.Argume.Memory.Imager`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.pas) ：Image  
　　　　　　┗[`LUX.GPU.OpenCL.Argume.Memory.Imager.D1`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D1.pas) ：1D  
　　　　　　┃　┗[`LUX.GPU.OpenCL.Argume.Memory.Imager.D1.FMX`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D1.FMX.pas) ：for FMX  
　　　　　　┗[`LUX.GPU.OpenCL.Argume.Memory.Imager.D2`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D2.pas) ：2D  
　　　　　　┃　┗[`LUX.GPU.OpenCL.Argume.Memory.Imager.D2.FMX`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D2.FMX.pas) ：for FMX  
　　　　　　┗[`LUX.GPU.OpenCL.Argume.Memory.Imager.D3`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D3.pas) ：3D  
　　　　　　　　┗[`LUX.GPU.OpenCL.Argume.Memory.Imager.D3.FMX`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D3.FMX.pas) ：for FMX  

----
## ■ 3. Reference

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
