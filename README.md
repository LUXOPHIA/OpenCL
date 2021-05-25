<!---
layout: page
title: "README (English)"
permalink: /
-->
[`［日本語］`](https://luxophia.github.io/OpenCL/ja/)

# [OpenCL](https://github.com/LUXOPHIA/OpenCL/)
Parallel computing with [OpenCL](https://en.wikipedia.org/wiki/OpenCL) on the GPU (or CPU).  

![](https://github.com/LUXOPHIA/OpenCL/raw/master/--------/_SCREENSHOT/OpenCL.png)

----
## ■ 1. [`LUX.GPU.OpenCL`](https://luxophia.github.io/LUX.GPU.OpenCL/) Library

> [`TOpenCL`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.pas#L82) ：Singleton of TCLSystem  
> 　┃  
> [`TCLSystem`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.pas#L67) ：System  
> 　┗[`TCLPlatfos`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Platfo.pas#L88) ：Platform list  
> 　　　┗[`TCLPlatfo`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Platfo.pas#L33) ：Platform  
> 　　　　　┣[`TCLExtenss`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Platfo.pas#L25) ：Extension list  
> 　　　　　┣[`TCLDevices`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Device.pas#L293) ：Device list  
> 　　　　　┃　┗[`TCLDevice`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Device.pas#L21) ：Device  
> 　　　　　┗[`TCLContexs`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Contex.pas#L62) ：Context list  
> 　　　　　　　┗[`TCLContex`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Contex.pas#L25) ：Context  
> 　　　　　　　　　┣[`TCLQueuers`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Queuer.pas#L51) ：Command Queue list  
> 　　　　　　　　　┃　┗[`TCLQueuer`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Queuer.pas#L23) ：Command Queue  
> 　　　　　　　　　┣[`TCLArgumes`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.pas#L44) ：Argument list  
> 　　　　　　　　　┃　┣[`TCLBuffer`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Buffer.pas#L24) ：Buffer  
> 　　　　　　　　　┃　┣[`TCLImager`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.pas#L24) ：Image  
> 　　　　　　　　　┃　┗[`TCLSamplr`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Samplr.pas#L21) ：Sampler  
> 　　　　　　　　　┣[`TCLLibrars`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Progra.pas#L245) ：Library list  
> 　　　　　　　　　┃　┗[`TCLLibrar`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Progra.pas#L196) ：Library  
> 　　　　　　　　　┗[`TCLExecuts`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Progra.pas#L256) ：Executable program list  
> 　　　　　　　　　　　┗[`TCLExecut`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Progra.pas#L208) ：Executable program  
> 　　　　　　　　　　　　　┣[`TCLBuildrs`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Progra.pas#L80) ：Build list  
> 　　　　　　　　　　　　　┃　┗[`TCLBuildr`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Progra.pas#L33) ：Build  
> 　　　　　　　　　　　　　┗[`TCLKernels`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Kernel.pas#L214) ：Kernel list  
> 　　　　　　　　　　　　　　　┗[`TCLKernel`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Kernel.pas#L106) ：Kernel  
> 　　　　　　　　　　　　　　　　　┗[`TCLParames`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Kernel.pas#L65) ：Parameter list  
> 　　　　　　　　　　　　　　　　　　　┗[`TCLParame`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Kernel.pas#L33) ：Parameter

----
## ■ 2. Usage
The `TOpenCL` class is a singleton of the `TCLSystem` class.
The `TCLSystem` class automatically detects all **computing devices** on the execution machine.  

### ⬤ 2.1. Platform
The "**platform**" object (`TCLPlatfo`) represents the environment defined by each device vendor. 
The `TCLSystem` class automatically detects all **platform**s and enumerate them in the `Platfors` property. 

> `Object Pascal`
> ```Delphi
> TOpenCL.Platfors.Count :Integer    // Number of all platforms
> TOpenCL.Platfors[*]    :TCLPlatfo  // Array of all platforms
> ```

The `TCLPlatfo` class provides information about a specific **platform** as properties.  
> `Object Pascal`
> ```Delphi
> _Platfo := TOpenCL.Platfors[0];  // Selecting a specific platform
> 
> _Platfo.Handle        :T_cl_platform_id  // Pointer
> _Platfo.Profile       :String            // Profile
> _Platfo.Version       :String            // Version
> _Platfo.Name          :String            // Name
> _Platfo.Vendor        :String            // Vendor Name
> _Platfo.Extenss.Count :Integer           // Number of Extensions
> _Platfo.Extenss[*]    :String            // Array of Extensions
> ```

### ⬤ 2.2. Device
The "**device**" object (`TCLDevice`) represents a physical GPU or CPU.
The `TCLPlatfo` class automatically detects all **device** objects in a specific **platform** object and enumerate them in the `Devices` property.  
> `Object Pascal`
> ```Delphi
> _Platfo.Devices.Count :Integer    // Number of devices
> _Platfo.Devices[*]    :TCLDevice  // Array of devices
> ```

The `TCLDevice` class provides information about a specific **device** as properties.  
> `Object Pascal`
> ```Delphi
> _Device := _Platfo.Devices[0];  // Selecting a specific device
> 
> _Device.Handle           :T_cl_device_id    // Pointer
> _Device.DEVICE_TYPE      :T_cl_device_type  // Type
> _Device.DEVICE_VENDOR_ID :T_cl_uint         // Vendor ID
> _Device.DEVICE_NAME      :String            // Name
> _Device.DEVICE_VENDOR    :String            // Vendor
> _Device.DRIVER_VERSION   :String            // Driver Version
> _Device.DEVICE_PROFILE   :String            // Profile
> _Device.DEVICE_VERSION   :String            // Version
> ```

### ⬤ 2.3. Context
The "**context**" object (`TCLContex`) manages a bundle of related data and programs.
The `TCLContex` class is created from the `TCLPlatfo` class.  
> `Object Pascal`
> ```Delphi
> _Contex := TCLContex.Create( _Platfo );
> ```

The generated `TCLContex` class is registered into the `Contexs[]` property of the `TCLPlatfo` class.
> `Object Pascal`  
> ```Delphi
> _Platfo.Contexs.Count :Integer    // Number of contexts
> _Platfo.Contexs[*]    :TCLQueuer  // Array  of contexts
> ``

### ⬤ 2.4. Command Queue
The "**command queue**" object (`TCLQueuer`) manages the commands sent to the device.
In other words, it is an object that connects **context** and **device**.
The `TCLQueuer` class is created with the `TCLContex` and the `TCLDevice` classes as arguments.
> `Object Pascal`
> ```Delphi
> _Queuer := TCLQueuer.Create( _Contex, _Device );
>   {or}
> _Queuer := _Contex.Queuers[ _Device ];
> ```

The `TCLContex` class registers the `TCLQueuer` class in the `Queuers` property.  
> `Object Pascal`  
> ```Delphi
> _Contex.Queuers.Count :Integer    // Number of command queue
> _Contex.Queuers[*]    :TCLQueuer  // Array  of command queue
> ```

Note that **context** and **device** on the different **platforms** cannot generate a **command queue**.  
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
> Q00 := TCLQueuer.Create( C0, D00 );  // OK
> Q01 := TCLQueuer.Create( C0, D01 );  // OK
> Q02 := TCLQueuer.Create( C0, D02 );  // OK
> 
> Q10 := TCLQueuer.Create( C1, D00 );  // Error
> Q11 := TCLQueuer.Create( C1, D01 );  // Error
> Q12 := TCLQueuer.Create( C1, D02 );  // Error
> 
> Q20 := TCLQueuer.Create( C2, D00 );  // Error
> Q21 := TCLQueuer.Create( C2, D10 );  // Error
> Q22 := TCLQueuer.Create( C2, D20 );  // OK
> ```

### ⬤ 2.5. Argument

> [`TCLArgume`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.pas#L21)  
> 　┣[`TCLMemory`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.pas#L24)  
> 　┃　┣[`TCLBuffer`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Buffer.pas#L24)  
> 　┃　┗[`TCLImager`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.pas#L24)  
> 　┗[`TCLSamplr`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Samplr.pas#L21)  

#### ▼ 2.5.1. Memory
The "**Memory**" object (`TCLMemory`) stores various data and shares it with the **device**.
The `TCLMemory` class is created from the `TCLContex` and the `TCLQueuer` classes.
The `TCLMemory` class is abstract and derives the `TCLBuffer` and `TCLImager` classes.  

#### ▽ 2.5.1.1. Buffer
The `TCLBuffer` class stores an array of any "simple type" or "record type."  

If you want to send an array of the following structure type to the device,  
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

generate the `TCLBuffer` class as follows.  
> `Object Pascal`
> ```Delphi
> TItem = record
>   A :Integer;
>   B :Double;
> end;
> 
> _Buffer := TCLBuffer<TItem>.Create( _Contex, _Queuer );
> ```

Read and write array data through the `Data` property.
The array data must be "**map**ped" to synchronize with the host before reading or writing, and "**unmap**ped" to synchronize with the device after use.  
> `Object Pascal`
> ```Delphi
> _Buffer.Count := 3;                          // Setting the number of elements
> _Buffer.Data.Map;                            // Synchronize data with host
> _Buffer.Data[0] := TItem.Create( 1, 2.34 );  // Writing
> _Buffer.Data[1] := TItem.Create( 5, 6.78 );  // Writing
> _Buffer.Data[2] := TItem.Create( 9, 0.12 );  // Writing
> _Buffer.Data.Unmap;                          // Synchronize data with Device
> ```

#### ▽ 2.5.1.2. Image
The "**image**" object (`TCLImager`) stores the pixel array in 1D to 3D.
3D voxel data is also considered a type of 3D **image**.
The `TCLImager` class is abstract and derives various classes depending on the layout and bits of the color channel.   

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

The first part of the class name represents the dimension of a image. 
> * TCLImager`1D`x`*`x`*`  
>   * Dimension：`1D`
> * TCLImager`2D`x`*`x`*`  
>   * Dimension：`2D`
> * TCLImager`3D`x`*`x`*`  
>   * Dimension：`3D`

The second part of the class name represents the color channel order of a image.  
> * TCLImager`*`x`BGRA`x`*`  
>   * Color channel order：`ＢＧＲＡ`
> * TCLImager`*`x`RGBA`x`*`  
>   * Color channel order：`ＲＧＢＡ`

The third part of the class name represents the color data type of a image.  
> * TCLImager`*`x`*`x`UInt8`  
>   * Device-side data type：`uint8` @ OpenCL C
>   * Host-side data type：`UInt8 (Byte)` @ Delphi
> * TCLImager`*`x`*`x`UFix8`  
>   * Device-side data type：`float` @ OpenCL C
>   * Host-side data type：`UInt8 (Byte)` @ Delphi
> * TCLImager`*`x`*`x`UInt32`  
>   * Device-side data type：`uint` @ OpenCL C
>   * Host-side data type：`UInt32 (Cardinal)` @ Delphi
> * TCLImager`*`x`*`x`SFlo32`  
>   * Device-side data type：`float` @ OpenCL C
>   * Host-side data type：`Single` @ Delphi

The 'CountX'/'Y'/'Z' property sets the number of pixels in the X/Y/Z direction.
> `Object Pascal`
> ```Delphi
> _Imager := TCLDevIma3DxBGRAxUInt8.Create( _Contex, _Queuer );
> _Imager.CountX := 100;  // Number of pixels in the X direction
> _Imager.CountY := 200;  // Number of pixels in the Y direction
> _Imager.CountZ := 300;  // Number of pixels in the Z direction
> ```

#### ▼ 2.5.2. Sampler
The sampler object (`TCLSamplr`) defines the interpolation method to get the pixel color in real-number coordinates.  
The `TCLSamplr` class is generated with the 'TCLContex' class as an argument.
> `Object Pascal`
> ```Delphi
> _Samplr := TCLSamplr.Create( _Contex );
> ```

### ⬤ 2.6. Program
The "**program**" object (`TCLProgra`) reads the source code and builds it into an executable binary.
The `TCLProgra` class is generated with the 'TCLContex' class as an argument.
The `TCLProgra` class is abstract and derives the `TCLLibrar` and `TCLExecut` classes, depending on the type of source code. 

#### ▼ 2.6.1. Library
The `TCLLibrar` class is a program that does not include functions to execute directly is called a library type.  
> `Object Pascal`
> ```Delphi
> _Librar := TCLLibrar.Create( _Contex );
> 
> _Librar.Source.LoadFromFile( 'Librar.cl' );  // load Sourcecode
> ```

#### ▼ 2.6.2. Executable
The `TCLExecut` class is a program that includes functions (**Kernel**s) to execute directly.  
> `Object Pascal`
> ```Delphi
> _Execut := TCLExecut.Create( _Contex );
> 
> _Execut.Source.LoadFromFile( 'Execut.cl' );  // load Sourcecode
> ```

### ⬤ 2.7. Build
A "**build**" (`TCLBuildr`) is an "action" performed by a **program**, but it is explicitly represented as a class in our library.  
> `Object Pascal`
> ```Delphi
> _Buildr := TCLBuildr.Create( _Execut, _Device );
>   {or}
> _Buildr := _Execut.Buildrs[ _Device ];
>   {or}
> _Buildr := _Execut.BuildTo( _Device );
> ```

The **kernel** object (see chapter 2.8.) automatically creates the `TCLBuildr` class at runtime.
However, you can check for compiling and linking errors by creating a `TCLBuildr` class before running the kernel.  
> `Object Pascal`
> ```Delphi
> _Buildr.Handle;  // Run build
> 
> _Buildr.CompileStatus :T_cl_build_status  // Compile status
> _Buildr.CompileLog    :String             // Compile log
> _Buildr.LinkStatus    :T_cl_build_status  // Link status
> _Buildr.LinkLog       :String             // Link log
> ```

### ⬤ 2.8. Kernel
The "**kernel**" object (`TCLKernel`) represents an executable function in a program.  
> `OpenCL C`
> ```C
> kernel void Main( ･･･ ) {
>   ･･･
> }
> ```

The `TCLKernel` class is created from the `TCLExecut` and `TCLQueuer` classes. 
> `Object Pascal`
> ```Delphi
> _Kernel := TCLKernel.Create( _Execut, 'Main', _Queuer );
>   {or}
> _Kernel := _Execut.Kernels.Add( 'Main', _Queuer );
> ```


#### ▼ 2.8.1. Parameter
The **memory** object connects to the parameter in the source code through the "Parames" property of the `TCLKernel` class.  
> `Object Pascal`
> ```Delphi
> _Kernel.Parames['Buffer'] := _Buffer;  // Connect to buffer
> _Kernel.Parames['Imager'] := _Imager;  // Connect to image
> _Kernel.Parames['Samplr'] := _Samplr;  // Connect to sampler
> ```

#### ▼ 2.8.2. Loop Count
The OpenCL program repeatedly runs like a triple loop-statement.  
> `Object Pascal`
> ```Delphi
> _Kernel.GloSizX := 100;  // Number of loops in X direction
> _Kernel.GloSizY := 200;  // Number of loops in Y direction
> _Kernel.GloSizZ := 300;  // Number of loops in Z direction
> ```

You can also specify the minimum and maximum loop indices.  
> `Object Pascal`
> ```Delphi
> _Kernel.GloMinX := 0;      // Start index in X direction
> _Kernel.GloMinY := 0;      // Start index in Y direction
> _Kernel.GloMinZ := 0;      // Start index in Z direction
> 
> _Kernel.GloMaxX := 100-1;  // End index in X direction
> _Kernel.GloMaxY := 200-1;  // End index in Y direction
> _Kernel.GloMaxZ := 300-1;  // End index in Z direction
> ```

#### ▼ 2.8.3. Run
> `Object Pascal`
> ```Delphi
> _Kernel.Run;  // Run
> ```

----
## ■ 3. Reference

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
