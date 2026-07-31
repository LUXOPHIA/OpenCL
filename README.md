# OpenCL

[English](README.md) | [日本語](ja/README.md)

An interactive **Mandelbrot set** explorer that demonstrates parallel computing on GPUs and CPUs with [OpenCL](https://registry.khronos.org/OpenCL/) from Delphi. The application is built on the [LUX.GPU.OpenCL](https://github.com/LUXOPHIA/LUX.GPU.OpenCL) wrapper library, which maps the entire OpenCL object model onto an ownership hierarchy of Object Pascal classes.

![](--------/_SCREENSHOT/OpenCL.png)

## 利用ライブラリ

* [**LUX**](https://github.com/LUXOPHIA/LUX) ：Base mathematical utility library for Delphi.
* [**LUX.GPU.OpenCL**](https://github.com/LUXOPHIA/LUX.GPU.OpenCL) ：OpenCL wrapper library for Delphi.

## 1. Overview

* **Class-based OpenCL wrapper**: every OpenCL object (platform, device, context, command queue, buffer, image, sampler, program, kernel) is represented by a dedicated Delphi class with automatic lifetime management and parent/child registration.
* **Automatic device discovery**: the `TOpenCL` singleton enumerates all platforms and devices present on the host at startup.
* **Typed device memory**: generic buffers (`TCLBuffer<T>`) accept any Delphi record type; typed image classes cover 1D/2D/3D layouts with several channel orders and pixel formats.
* **Source-level kernel workflow**: OpenCL C sources are loaded at runtime, built per device with full access to the build log, and kernel parameters are bound by name.
* **FireMonkey interoperation**: stream classes (`TCLStream1DxBGRAxUFix8_FMX`, `TCLStream2DxBGRAxUFix8_FMX`) copy device images to and from `TBitmap`, so kernel output is displayed directly in the GUI.
* **Demo kernel**: a smoothly-colored, animated zoom into the Mandelbrot set, recomputed on the device every timer tick.

## 2. Technical Background

### 2.1. OpenCL Execution Model

OpenCL [1][2] organizes heterogeneous computing resources into a strict hierarchy:

* A **platform** is the runtime environment provided by one vendor (NVIDIA, AMD, Intel, ...).
* A **device** is a physical processor (GPU or CPU) belonging to a platform.
* A **context** groups devices of one platform together with the memory objects and programs they share.
* A **command queue** connects a context to one specific device; all data transfers and kernel launches are commands submitted to a queue. A queue can only join a context and a device of the *same* platform.

### 2.2. NDRange, Work-Groups and Work-Items

A kernel is executed as an **NDRange**: an up to 3-dimensional grid of **work-items**, each running the same kernel function on its own coordinates. The grid is partitioned into **work-groups**. With global size $G_d$, work-group size $L_d$, work-group index $w_d$ and local index $l_d$ in dimension $d \in \{0,1,2\}$, the global index of a work-item is

```math
g_d = w_d \cdot L_d + l_d , \qquad 0 \le g_d < G_d .
```

Inside the kernel, $g_d$ and $G_d$ are obtained via `get_global_id(d)` and `get_global_size(d)`. The wrapper exposes the global size as the properties `GloSizX`/`GloSizY`/`GloSizZ` of `TCLKernel` — conceptually a triple loop whose iterations all run in parallel. In this demo the NDRange is set to the output image resolution, $G = (500, 500)$, so each work-item computes exactly one pixel.

### 2.3. Memory Model

Host and device have separate memories. The library wraps the three OpenCL argument kinds:

* **Buffer** (`TCLBuffer<T>`): a linear array of any simple or record type. Host access uses map/unmap semantics — `Data.Map` makes the region visible to the host, `Data.Unmap` returns it to the device.
* **Image** (`TCLImager*`): 1D–3D pixel arrays with hardware-accelerated access (`read_imagef`/`write_imagef`).
* **Sampler** (`TCLSamplr`): defines addressing and interpolation when an image is read at real-valued coordinates.

### 2.4. The Demo Kernel: Smooth Mandelbrot Rendering

The kernel `Main` in [`_DATA/Execut.cl`](_DATA/Execut.cl) (using the complex-arithmetic library [`_DATA/Librar.cl`](_DATA/Librar.cl)) renders the Mandelbrot set. Each work-item first maps its pixel coordinate $p = (p_x, p_y)$ within the grid $s = (s_x, s_y)$ to a point $c$ of the complex plane, given the view center $C$ and half-size $S$:

```math
c_R = C_R + S_R \left( \frac{2\,(p_x + 0.5)}{s_x} - 1 \right), \qquad
c_I = C_I - S_I \left( \frac{2\,(p_y + 0.5)}{s_y} - 1 \right).
```

It then iterates the quadratic map

```math
z_{n+1} = z_n^2 + c , \qquad z_0 = 0
```

until $\lvert z_n \rvert > 2$ (escape) or the iteration limit $N_{\max} = 1000$ is reached. To avoid banding, the escape count is smoothed to a continuous value

```math
\nu = n + 1 - \log \left( \log_2 \lvert z_n \rvert \right),
```

and the pixel color is fetched from a 1D gradient texture (`_DATA/Textur.png`) at the normalized coordinate

```math
t = \sqrt{ \nu / N_{\max} }
```

via `read_imagef( Textur, Samplr, t )`, then written to the output image with `write_imagef`.

On the host side, `Main.pas` animates the view: a timer interpolates the current center/size toward a target region ($x \leftarrow x + 0.25\,(x_1 - x)$ per tick), writes both as two `TSingleC` elements into the buffer (map → write → unmap), runs the kernel, and copies the resulting 2D image into the FireMonkey `TImage`. The mouse wheel rescales the target region about the complex coordinate under the cursor, producing a cursor-centered smooth zoom.

## 3. Architecture

### 3.1. Class Hierarchy of LUX.GPU.OpenCL

The wrapper library models the OpenCL object graph as an ownership tree. Each parent class owns typed lists of its children; creating a child (e.g. `TCLContex.Create( _Platfo )`) automatically registers it with its parent.

```
・TOpenCL                                  ･･･ singleton of TCLSystem
┃
・TCLSystem                                ･･･ root; detects all compute devices
  ┗・TCLPlatfos                           ･･･ platform list
     ┗・TCLPlatfo                         ･･･ platform (one vendor runtime)
        ┣・TCLExtenss                     ･･･ extension list
        ┣・TCLDevices                     ･･･ device list
        ┃  ┗・TCLDevice                  ･･･ physical GPU / CPU
        ┗・TCLContexs                     ･･･ context list
           ┗・TCLContex                   ･･･ context (data + programs)
              ┣・TCLQueuers               ･･･ command-queue list
              ┃  ┗・TCLQueuer            ･･･ command queue (context × device)
              ┣・TCLArgumes               ･･･ argument list
              ┃  ┣・TCLBuffer            ･･･ generic buffer (TCLMemory)
              ┃  ┣・TCLImager            ･･･ 1D/2D/3D image (TCLMemory)
              ┃  ┗・TCLSamplr            ･･･ sampler
              ┣・TCLLibrars               ･･･ library list
              ┃  ┗・TCLLibrar            ･･･ program without kernels
              ┗・TCLExecuts               ･･･ executable-program list
                 ┗・TCLExecut             ･･･ program with kernels
                    ┣・TCLBuildrs         ･･･ build list
                    ┃  ┗・TCLBuildr      ･･･ per-device build (log, status)
                    ┗・TCLKernels         ･･･ kernel list
                       ┗・TCLKernel       ･･･ executable kernel function
                          ┗・TCLParames   ･･･ parameter list
                             ┗・TCLParame ･･･ kernel parameter
```

Data flow of the demo application:

```
Inputs — each host-side source becomes a kernel argument

・Textur.png
  ┗・TCLImager1DxBGRAxUFix8 ･･･ 1D color-gradient texture
     ┗・TCLKernel

・mouse wheel
  ┗・TCLBuffer<TSingleC>    ･･･ view center / half-size
     ┗・TCLKernel

・Librar.cl / Execut.cl
  ┗・TCLExecut              ･･･ compiled program supplying the kernel
     ┗・TCLKernel           ･･･ ('Main', run per timer tick via TCLQueuer)

Output — kernel result back to the GUI

・TCLKernel
  ┗・TCLImager2DxBGRAxUFix8 ･･･ rendered Mandelbrot image
     ┗・TImage              ･･･ (GUI)
```

### 3.2. File Structure

```
・OpenCL/
  ┣・OpenCL.dpr             ･･･ project source (unit list)
  ┣・OpenCL.dproj           ･･･ RAD Studio project (FMX, Win32/Win64)
  ┣・Main.pas / Main.fmx    ･･･ main form: CL object graph, timer rendering
  ┣・_DATA/
  ┃  ┣・Librar.cl          ･･･ library: complex type TSingleC and operators
  ┃  ┣・Execut.cl          ･･･ executable source: Mandelbrot kernel 'Main'
  ┃  ┗・Textur.png         ･･･ 1D color-gradient texture for smooth coloring
  ┣・_LIBRARY/
  ┃  ┗・LUXOPHIA/
  ┃     ┣・LUX/            ･･･ base utilities (LUX.Complex, LUX.D1–D4, ...)
  ┃     ┗・LUX.GPU.OpenCL/ ･･･ OpenCL wrapper (Core/, CL/, Stream/)
  ┗・--------/_SCREENSHOT/  ･･･ screenshots
```

## 4. Usage

### 4.1. Demo Application

| Control | Action |
|---|---|
| **Mouse wheel** over the result image | Zoom in/out; the point under the cursor stays fixed (×1.1 per notch) |
| **System** tab | Enumeration of all detected platforms and devices |
| **Program** tab (Library / Execute / Build) | OpenCL C sources and the per-device build log |
| **Result** tab | The rendered Mandelbrot image, updated per timer tick |

On exit the application saves the device report to `System.txt` and the last rendered frame to `Imager.png`. If no OpenCL runtime is present, `TOpenCL.Available` is `False` and the demo degrades gracefully with a message.

### 4.2. Library API

The `TOpenCL` class is a singleton of the `TCLSystem` class. The `TCLSystem` class automatically detects all **computing devices** present on the host machine.

#### 4.2.1. Platform

The "**platform**" object (`TCLPlatfo`) represents the environment provided by each device vendor. The `TCLSystem` class automatically detects all **platform**s and lists them in the `Platfos[]` property.

> `Object Pascal`
> ```Delphi
> TOpenCL.Platfos.Count :Integer    // Number of all platforms
> TOpenCL.Platfos[*]    :TCLPlatfo  // Array of all platforms
> ```

The `TCLPlatfo` class provides information about a specific **platform** as properties.

> `Object Pascal`
> ```Delphi
> _Platfo := TOpenCL.Platfos[0];  // Selecting a specific platform
>
> _Platfo.Handle        :T_cl_platform_id  // Pointer
> _Platfo.Profile       :String            // Profile
> _Platfo.Version       :String            // Version
> _Platfo.Name          :String            // Name
> _Platfo.Vendor        :String            // Vendor Name
> _Platfo.Extenss.Count :Integer           // Number of Extensions
> _Platfo.Extenss[*]    :String            // Array of Extensions
> ```

#### 4.2.2. Device

The "**device**" object (`TCLDevice`) represents a physical GPU or CPU. The `TCLPlatfo` class automatically detects all **device** objects in a specific **platform** object and enumerates them in the `Devices[]` property.

> `Object Pascal`
> ```Delphi
> _Platfo.Devices.Count :Integer    // Number of devices
> _Platfo.Devices[*]    :TCLDevice  // Array of devices
> ```

The `TCLDevice` class provides detailed information about each specific **device** through its properties.

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

#### 4.2.3. Context

The "**context**" object (`TCLContex`) manages a collection of related data and programs. The `TCLContex` class is instantiated from the `TCLPlatfo` class.

> `Object Pascal`
> ```Delphi
> _Contex := TCLContex.Create( _Platfo );
> ```

The generated `TCLContex` class is registered in the `Contexs[]` property of the `TCLPlatfo` class.

> `Object Pascal`
> ```Delphi
> _Platfo.Contexs.Count :Integer    // Number of contexts
> _Platfo.Contexs[*]    :TCLContex  // Array  of contexts
> ```

#### 4.2.4. Command Queue

The "**command queue**" object (`TCLQueuer`) manages the commands sent to the device. In other words, it serves as a bridge between a **context** and a **device**. The `TCLQueuer` class is created with the `TCLContex` and `TCLDevice` classes as arguments.

> `Object Pascal`
> ```Delphi
> _Queuer := TCLQueuer.Create( _Contex, _Device );
>   {or}
> _Queuer := _Contex.Queuers[ _Device ];
> ```

The `TCLContex` class registers the `TCLQueuer` object in the `Queuers[]` property.

> `Object Pascal`
> ```Delphi
> _Contex.Queuers.Count :Integer    // Number of command queue
> _Contex.Queuers[*]    :TCLQueuer  // Array  of command queue
> ```

Note that **context** and **device** on the different **platforms** cannot generate a **command queue**.

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

#### 4.2.5. Argument

The argument classes form the following inheritance tree:

```
・TCLArgume
  ┣・TCLMemory
  ┃  ┣・TCLBuffer
  ┃  ┗・TCLImager
  ┗・TCLSamplr
```

##### 4.2.5.1. Memory

The "**memory**" object (`TCLMemory`) stores various data and shares it with the **device**. The `TCLMemory` class is created from the `TCLContex` and the `TCLQueuer` classes. The `TCLMemory` class is abstract and derives the `TCLBuffer` and `TCLImager` classes.

**Buffer**: The `TCLBuffer` class stores an array of any "simple type" or "record type."

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
> _Buffer := TCLBuffer<TItem>.Create( _Queuer );
> ```

Read and write array data through the `Data` property. The array data must be "**map**ped" to synchronize with the host before reading or writing, and "**unmap**ped" to synchronize with the device after use.

> `Object Pascal`
> ```Delphi
> _Buffer.Count := 3;                          // Setting the number of elements
> _Buffer.Data.Map;                            // Synchronize data with host
> _Buffer.Data[0] := TItem.Create( 1, 2.34 );  // Writing
> _Buffer.Data[1] := TItem.Create( 5, 6.78 );  // Writing
> _Buffer.Data[2] := TItem.Create( 9, 0.12 );  // Writing
> _Buffer.Data.Unmap;                          // Synchronize data with Device
> ```

**Image**: The "**image**" object (`TCLImager`) stores the pixel array in 1D to 3D. 3D voxel data is also considered a type of 3D **image**. The `TCLImager` class is abstract and derives various classes depending on the layout and bits of the color channel.

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

The first part of the class name represents the dimension of a image.

> * TCLImager`1D`x`*`x`*` : Dimension `1D`
> * TCLImager`2D`x`*`x`*` : Dimension `2D`
> * TCLImager`3D`x`*`x`*` : Dimension `3D`

The second part of the class name represents the color channel order of a image.

> * TCLImager`*`x`BGRA`x`*` : Color channel order `BGRA`
> * TCLImager`*`x`RGBA`x`*` : Color channel order `RGBA`

The third part of the class name represents the color data type of a image.

> * TCLImager`*`x`*`x`UInt8` : Device-side `uint8` @ OpenCL C / Host-side `UInt8 (Byte)` @ Delphi
> * TCLImager`*`x`*`x`UFix8` : Device-side `float` @ OpenCL C / Host-side `UInt8 (Byte)` @ Delphi
> * TCLImager`*`x`*`x`UInt32` : Device-side `uint` @ OpenCL C / Host-side `UInt32 (Cardinal)` @ Delphi
> * TCLImager`*`x`*`x`SFlo32` : Device-side `float` @ OpenCL C / Host-side `Single` @ Delphi

The `CountX`/`CountY`/`CountZ` property sets the number of pixels in the X/Y/Z direction.

> `Object Pascal`
> ```Delphi
> _Imager := TCLImager3DxBGRAxUInt8.Create( _Queuer );
> _Imager.CountX := 100;  // Number of pixels in the X direction
> _Imager.CountY := 200;  // Number of pixels in the Y direction
> _Imager.CountZ := 300;  // Number of pixels in the Z direction
> ```

##### 4.2.5.2. Sampler

The sampler object (`TCLSamplr`) defines the interpolation method to get the pixel color in real-number coordinates. The `TCLSamplr` class is generated with the `TCLContex` class as an argument.

> `Object Pascal`
> ```Delphi
> _Samplr := TCLSamplr.Create( _Contex );
> ```

#### 4.2.6. Program

The "**program**" object (`TCLProgra`) reads the source code and compiles it into an executable binary. The `TCLProgra` class is created with the `TCLContex` class as an argument. The `TCLProgra` class is abstract and serves as the base class for the `TCLLibrar` and `TCLExecut` classes, depending on the type of source code.

**Library**: The `TCLLibrar` class is a program that does not include functions to execute directly.

> `Object Pascal`
> ```Delphi
> _Librar := TCLLibrar.Create( _Contex );
>
> _Librar.Source.LoadFromFile( 'Librar.cl' );  // load Sourcecode
> ```

**Executable**: The `TCLExecut` class is a program that includes functions (**Kernel**s) to execute directly.

> `Object Pascal`
> ```Delphi
> _Execut := TCLExecut.Create( _Contex );
>
> _Execut.Source.LoadFromFile( 'Execut.cl' );  // load Sourcecode
> ```

#### 4.2.7. Build

A "**build**" (`TCLBuildr`) is an "action" performed by a **program**, but it is explicitly represented as a class in this library. The `TCLBuildr` class is created with the `TCLExecut` and `TCLDevice` classes as arguments.

> `Object Pascal`
> ```Delphi
> _Buildr := TCLBuildr.Create( _Execut, _Device );
>   {or}
> _Buildr := _Execut.Buildrs[ _Device ];
>   {or}
> _Buildr := _Execut.BuildTo( _Device );
> ```

The **kernel** object (see section 4.2.8.) automatically creates the `TCLBuildr` class at runtime. However, you can check for compilation and linking errors by creating a `TCLBuildr` object before running the kernel.

> `Object Pascal`
> ```Delphi
> _Buildr.Handle;  // Run build
>
> _Buildr.BuildOK  :Boolean  // Whether both compile and link succeeded
> _Buildr.BuildLog :String   // The compile and link logs
> ```

#### 4.2.8. Kernel

The "**kernel**" object (`TCLKernel`) represents an executable function in a program.

> `OpenCL C`
> ```C
> kernel void Main( ･･･ ) {
>   ･･･
> }
> ```

The `TCLKernel` class is instantiated from the `TCLExecut` and `TCLQueuer` objects.

> `Object Pascal`
> ```Delphi
> _Kernel := TCLKernel.Create( _Execut, 'Main', _Queuer );
>   {or}
> _Kernel := _Execut.Kernels.Add( 'Main', _Queuer );
> ```

**Parameter**: The **memory** object is linked to the parameter in the source code through the `Parames[]` property of the `TCLKernel` class.

> `Object Pascal`
> ```Delphi
> _Kernel.Parames['Buffer'] := _Buffer;  // Connect to buffer
> _Kernel.Parames['Imager'] := _Imager;  // Connect to image
> _Kernel.Parames['Samplr'] := _Samplr;  // Connect to sampler
> ```

**Loop Count**: The OpenCL program repeatedly runs like a triple loop-statement.

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

**Run**:

> `Object Pascal`
> ```Delphi
> _Kernel.Run;  // Run
> ```

## 5. Building

* **IDE**: Embarcadero RAD Studio / Delphi (FireMonkey application; project format version 20.4).
* **Project**: open `OpenCL.dproj` and build. Enabled target platforms: **Win32** and **Win64**.
* **Dependencies**: the required libraries (`LUX`, `LUX.GPU.OpenCL`, including the Khronos `OpenCL-Headers` translation [4]) are bundled under `_LIBRARY/` and referenced directly by `OpenCL.dpr`; no additional installation is needed.
* **Runtime**: an OpenCL runtime (`OpenCL.dll`) must be present, which is normally installed by the GPU vendor driver (NVIDIA / AMD / Intel). If unavailable, the application reports "OpenCL is not available."
* **Data files**: kernels and the gradient texture are loaded from `_DATA/` via paths relative to the executable (`..\..\_DATA\`), matching the default output directory layout (e.g. `Win64\Debug\`).

## 6. References

1. [Khronos OpenCL Registry](https://registry.khronos.org/OpenCL/).
2. [The OpenCL Specification, Version 3.0](https://registry.khronos.org/OpenCL/specs/3.0-unified/html/OpenCL_API.html), The Khronos Group Inc.
3. [The OpenCL C Specification, Version 3.0](https://registry.khronos.org/OpenCL/specs/3.0-unified/html/OpenCL_C.html), The Khronos Group Inc.
4. [KhronosGroup/OpenCL-Headers](https://github.com/KhronosGroup/OpenCL-Headers).

## 💖 [Embarcadero](https://www.embarcadero.com/) [**Delphi**](https://www.embarcadero.com/products/delphi)
Integrated Development Environment (IDE) for Creating Native Cross-Platform Apps.
### Free Download: [**Delphi** Community Edition](https://www.embarcadero.com/products/delphi/starter)
