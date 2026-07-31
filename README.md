# LUX.GPU.OpenCL
[English](README.md) | [日本語](ja/README.md)

An [OpenCL](https://registry.khronos.org/OpenCL/) 3.1 wrapper library for **Delphi**, for parallel computing on GPUs (or CPUs). You write an OpenCL C kernel as a plain string, bind Delphi values to its parameters by name, and run it — no manual handle management, no API boilerplate. The complete Khronos C headers are ported 1:1 and are also usable directly [1][3].

----

## 利用ライブラリ

* [**LUX**](https://github.com/LUXOPHIA/LUX) ：The base library providing the math types, generic lists and colors used throughout the wrapper.

## 1. Overview

The library is organised in two layers. The lower layer (`CL/`) is a one-to-one Pascal port of the official Khronos OpenCL C headers, so any OpenCL entry point can be called directly. The upper layer (`Core/`) is an object-oriented wrapper in which every OpenCL object is a Delphi class arranged in the same parent-child hierarchy as the specification, with automatic lifetime management and exception-based error reporting.

### 1.1 Features

* **Complete OpenCL 3.1 bindings** — ported one-to-one from the official [Khronos OpenCL-Headers](https://github.com/KhronosGroup/OpenCL-Headers) [3]. `cl_version.pas` defaults to `CL_TARGET_OPENCL_VERSION = 310`.
* **Dynamic runtime loading** — the OpenCL shared library is loaded at run time, so your application starts even on machines without any OpenCL driver. Check `TOpenCL.Available` to see whether OpenCL can be used.
* **Object-oriented model** — every OpenCL object (platform, device, context, queue, program, kernel, buffer, image, sampler, …) is a Delphi class, arranged in the same parent-child hierarchy as the OpenCL specification [1].
* **Automatic lifetime management** — parents own their children. You never call `Free` on library objects; everything is released when the system shuts down.
* **Exception-based error handling** — every failed OpenCL call raises `ECLError`, which carries the OpenCL error code and a readable message. No silent failures.
* **Typed buffers and images** — `TCLBuffer<T>` gives you an array-like, type-safe view of GPU memory. 1D/2D/3D images are provided in several pixel formats.
* **Zero-copy design** — buffers and images add `CL_MEM_ALLOC_HOST_PTR` to their memory flags and are accessed through Map/Unmap, avoiding needless copies between host and device.
* **Separate compile & link** — programs are built with `clCompileProgram` / `clLinkProgram`, and `#include` in kernel source is resolved from in-memory library programs (`TCLLibrar`) as embedded headers, without touching the disk.

## 2. Technical Background

### 2.1 Platform Model

OpenCL exposes the machine as a strict containment hierarchy: a *platform* (one vendor's implementation) publishes one or more *devices*; a *context* is created on a platform and groups the devices, memory objects and programs that may interact; a *command queue* connects a context to exactly one device and serialises the commands submitted to it [1].

```
Containment hierarchy  ( outermost first )

・platform                ･･･ one vendor's implementation
  ┗・device              ･･･ published by the platform
     ┗・context          ･･･ groups devices / memory / programs
        ┗・command queue ･･･ binds the context to exactly one device
           ┗・command    ･･･ serialised in the order submitted to the queue
```

The wrapper mirrors this containment exactly, which is why `TCLContex` is created from a `TCLPlatfo` while `TCLQueuer` requires both a context and a device:

```pascal
C := TCLContex.Create( P );      // context on platform P
Q := TCLQueuer.Create( C, D );   // queue on context C, device D
```

### 2.2 Execution Model — the NDRange

A kernel launch instantiates an index space of up to three dimensions, the *NDRange*. Each point of that space is a *work item*; work items are grouped into *work-groups* that share local memory and can be synchronised internally. With global size $G_d$, local (work-group) size $L_d$ and global offset $o_d$, the global id of the work item whose work-group id is $w_d$ and whose local id is $l_d$ is

```math
g_d = w_d L_d + l_d + o_d , \qquad d = 0, \dots, D-1 \tag{1}
```

so that the number of work-groups along each dimension and the total number of work items are

```math
W_d = \frac{G_d}{L_d} , \qquad N = \prod_{d=0}^{D-1} G_d . \tag{2}
```

`TCLKernel` exposes $o_d$ as `GloMinX/Y/Z`, $G_d$ as `GloSizX/Y/Z`, and the derived upper bound $o_d + G_d$ as `GloMaxX/Y/Z`. The dimensionality $D$ is *not* set by hand; it is inferred from the values actually used:

```math
D = \begin{cases}
3 & (o_2 > 0) \lor (G_2 > 1) \\
2 & (o_1 > 0) \lor (G_1 > 1) \\
1 & \text{otherwise}
\end{cases} \tag{3}
```

`TCLKernel.Run` passes $o_d$ and $G_d$ to `clEnqueueNDRangeKernel` with a `nil` local size, letting the implementation choose $L_d$, and then calls `clFinish`; `Run` is therefore synchronous. Inside the kernel the same indices are read with `get_global_id( d )`, `get_local_id( d )` and `get_group_id( d )` [2].

### 2.3 Memory Model — mapped, zero-copy allocations

OpenCL distinguishes host memory from global, constant, local and private device memory [1]. This library allocates every memory object with `CL_MEM_ALLOC_HOST_PTR` and reaches its contents through `clEnqueueMapBuffer` / `clEnqueueMapImage`, so on shared-memory devices the host and the device address the *same* pages and no explicit read/write copy is issued. For a `TCLBuffer<T>` of `Count` elements the allocation is

```math
S = \texttt{Count} \cdot \operatorname{sizeof}(T) \tag{4}
```

and `Data[ I ]` maps the region on first access, while `Data.Unmap` releases it so the device may use it. The conventional row-major linearisation between a 3D NDRange and a flat buffer index is

```math
i = g_0 + G_0 \bigl( g_1 + G_1 g_2 \bigr) . \tag{5}
```

Images carry a pixel format instead of an element type. The provided combinations are:

| Class | `cl_channel_order` | `cl_channel_type` | Delphi element |
|:--|:--|:--|:--|
| `TCLImager{1,2,3}DxBGRAxUInt8` | `CL_BGRA` | `CL_UNSIGNED_INT8` | `TByteRGBA` |
| `TCLImager{1,2,3}DxBGRAxUFix8` | `CL_BGRA` | `CL_UNORM_INT8` | `TByteRGBA` |
| `TCLImager{1,2,3}DxRGBAxUInt32` | `CL_RGBA` | `CL_UNSIGNED_INT32` | `TUInt32xRGBA` |
| `TCLImager{1,2,3}DxRGBAxSFlo32` | `CL_RGBA` | `CL_FLOAT` | `TSingleRGBA` |

### 2.4 Program Build Model — separate compile and link

Rather than the monolithic `clBuildProgram`, a `TCLBuildr` (one per device) performs the two-phase build of OpenCL 1.2 and later: `clCompileProgram` followed by `clLinkProgram`. The compile step is issued with the options

```
-cl-kernel-arg-info -cl-std=CL<version>
```

`-cl-kernel-arg-info` is what makes *binding by name* possible: the argument names of the compiled kernel are queried through `clGetKernelArgInfo`, so `K.Parames[ 'Xs' ] := B` can resolve `'Xs'` to an argument index and call `clSetKernelArg`. Every `TCLLibrar` of the context is handed to `clCompileProgram` as an *embedded header* under its `Name`, so a kernel may `#include "MyHeader.cl"` and have it resolved from memory. Compilation is lazy: it happens the first time a kernel is actually needed, and the per-device log is available as `BuildLog`.

## 3. Architecture

### 3.1 Class Hierarchy

Objects form a tree; each parent creates, owns and frees its children, so no user code ever calls `Free` on them. Plural names (`TCLPlatfos`, `TCLDevices`, …) are the owning list classes; singular names are the elements. `LUX.GPU.OpenCL.pas` publishes non-generic aliases of the generic implementation classes.

```
・TOpenCL                                    ･･･ class-static facade, DLL loader
  ┗・TCLSystem                              ･･･ created by class constructor
     ┗・TCLPlatfos — TCLPlatfo             ･･･ clGetPlatformIDs
        ┣・TCLExtenss                       ･･･ TStringList of extension names
        ┣・TCLDevices — TCLDevice          ･･･ clGetDeviceIDs
        ┗・TCLContexs — TCLContex          ･･･ clCreateContext
           ┣・TCLQueuers — TCLQueuer       ･･･ clCreateCommandQueue
           ┣・TCLArgumes — TCLArgume       ･･･ abstract kernel argument
           ┃  ┣・TCLSamplr                 ･･･ clCreateSampler
           ┃  ┗・TCLMemory                 ･･･ clReleaseMemObject
           ┃     ┣・TCLBuffer<T>           ･･･ clCreateBuffer
           ┃     ┃  ┗・TCLBufDat<T>       ･･･ Map / Unmap, Values[ I ]
           ┃     ┗・TCLImager1D/2D/3D      ･･･ clCreateImage
           ┃        ┗・TCLImaDat1D/2D/3D
           ┣・TCLLibrars — TCLLibrar       ･･･ embedded header program
           ┗・TCLExecuts — TCLExecut       ･･･ clCreateProgramWithSource
              ┣・TCLBuildrs — TCLBuildr    ･･･ per-device Compile + Link
              ┗・TCLKernels — TCLKernel    ･･･ clCreateKernel, NDRange, Run
                 ┗・TCLParames — TCLParame ･･･ name→index→clSetKernelArg
```

The data flow of one launch is:

```
1. Upload  ( host → device )

・host array
  ┗・Data[ I ] := …        ･･･ written through the mapped region
     ┗・TCLBufDat<T>
        ┗・Data.Unmap       ･･･ hands the pages over to the device
           ┗・device global memory

2. Binding  ( argument by name )

・TCLParames[ 'Xs' ] := B    ･･･ buffer B becomes the kernel argument 'Xs'

3. Launch  ( execution order )

・TCLKernel.Run
  ┣・clEnqueueNDRangeKernel ･･･ the kernel runs over device global memory
  ┗・clFinish               ･･･ waits for completion, so Run is synchronous

4. Readback  ( device → host )

・device global memory
  ┗・Map                    ･･･ remaps the pages to the host on first access
     ┗・TCLBufDat<T>
        ┗・Data[ I ]        ･･･ read back into the host array
           ┗・host array
```

### 3.2 File Layout

```
・LUX.GPU.OpenCL/
  ┣・CL/                                          ･･･ 1:1 port of the C headers
  ┃  ┣・cl_platform.pas                          ･･･ basic scalar types
  ┃  ┣・cl_version.pas                           ･･･ CL_TARGET_OPENCL_VERSION
  ┃  ┣・cl.pas                                   ･･･ types, consts, functions
  ┃  ┗・cl_functions.pas                         ･･･ ICD-style loader
  ┣・Core/                                        ･･･ object-oriented wrapper
  ┃  ┣・LUX.GPU.OpenCL.core.pas                  ･･･ ECLError / CheckCL etc.
  ┃  ┣・LUX.GPU.OpenCL.Platfo.pas                ･･･ TCLPlatfo, TCLExtenss
  ┃  ┣・LUX.GPU.OpenCL.Device.pas                ･･･ TCLDevice
  ┃  ┣・LUX.GPU.OpenCL.Contex.pas                ･･･ TCLContex
  ┃  ┣・LUX.GPU.OpenCL.Queuer.pas                ･･･ TCLQueuer
  ┃  ┣・LUX.GPU.OpenCL.Argume.pas                ･･･ TCLArgume (argument base)
  ┃  ┣・LUX.GPU.OpenCL.Argume.Samplr.pas         ･･･ TCLSamplr
  ┃  ┣・LUX.GPU.OpenCL.Argume.Memory.pas         ･･･ TCLMemory / TCLMemDat
  ┃  ┣・LUX.GPU.OpenCL.Argume.Memory.Buffer.pas  ･･･ TCLBuffer<T>/TCLBufDat<T>
  ┃  ┣・LUX.GPU.OpenCL.Argume.Memory.Imager*.pas ･･･ TCLImager1D/2D/3D
  ┃  ┣・LUX.GPU.OpenCL.Progra.pas                ･･･ program-related classes
  ┃  ┣・LUX.GPU.OpenCL.Kernel.pas                ･･･ TCLKernel / TCLParame
  ┃  ┗・LUX.GPU.OpenCL.Show.pas                  ･･･ diagnostic tree dump
  ┣・Argume/                                      ･･･ optional argument helpers
  ┃  ┗・LUX.GPU.OpenCL.Argume.Seeder.*           ･･･ TCLSeeder — random seeds
  ┣・Stream/                                      ･･･ optional I/O utilities
  ┃  ┣・LUX.GPU.OpenCL.Stream.FMX.*              ･･･ FMX TBitmap ↔ imager
  ┃  ┗・LUX.GPU.OpenCL.Stream.HDR.*              ･･･ Radiance HDR ↔ imager
  ┣・LUX.GPU.OpenCL.pas                           ･･･ entry point, aliases
  ┗・：KhronosGroup/OpenCL-Headers/               ･･･ vendored C headers
```

## 4. Usage

Add the library folders (and those of `LUX`) to your project's search path, then:

### 4.1 Quick Start

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
     // 1. Is an OpenCL runtime available on this machine?
     if not TOpenCL.Available or ( TOpenCL.Platfos.Count = 0 ) then Exit;

     // 2. Pick the first platform and its first device.
     for P in TOpenCL.Platfos do Break;
     for D in P.Devices       do Break;

     // 3. Create a context on the platform, and a command queue on the device.
     C := TCLContex.Create( P );
     Q := TCLQueuer.Create( C, D );

     // 4. Write an OpenCL C program (kernel source).
     E := TCLExecut.Create( C );
     with E.Source do
     begin
          Add( 'kernel void AddOne( global float* Xs )' );
          Add( '{'                                      );
          Add( '     const int i = get_global_id( 0 );' );
          Add( '     Xs[ i ] = Xs[ i ] + 1;'            );
          Add( '}'                                      );
     end;

     // 5. Get the kernel by its function name.
     K := TCLKernel.Create( E, 'AddOne', Q );

     // 6. Create a typed buffer and fill it. Data[] maps the buffer into host memory.
     B := TCLBuffer<Single>.Create( C, Q );
     B.Count := 10;
     for I := 0 to B.Count-1 do B.Data[ I ] := I;
     B.Data.Unmap;  // hand the data over to the device

     // 7. Bind the buffer to the kernel parameter, by name.
     K.Parames[ 'Xs' ] := B;

     // 8. Run 10 work items. Run is synchronous (it waits for completion).
     K.GloSizX := B.Count;
     K.Run;

     // 9. Read the result. Accessing Data[] maps the buffer again.
     for I := 0 to B.Count-1 do Writeln( B.Data[ I ] :0:1 );  // 1.0 2.0 ... 10.0

     // 10. No Free needed: the platform owns everything and releases it at shutdown.
end;
```

The compilation of the program happens lazily, the first time the kernel is actually needed (§2.4). Kernel source can also be loaded from a file with `E.Source.LoadFromFile( 'MyKernel.cl' )`.

### 4.2 Error Handling and Diagnostics

Every failed OpenCL call raises an `ECLError` exception. Its `Message` contains the OpenCL error name, and its `Code` property holds the raw error code.

```pascal
try
   K.Run;
except
   on X :ECLError do ShowMessage( X.Message );  // e.g.【INVALID_KERNEL_ARGS】...
end;
```

If a kernel fails to build, the compiler log is available per device:

```pascal
ShowMessage( E.BuildTo( D ).BuildLog );
```

To display the whole platform/device tree for diagnostics:

```pascal
TOpenCL.Show( Memo1.Lines );
```

## 5. Requirements

* **Delphi** — developed and tested on Delphi 12.x (Win32 / Win64). Any recent version with generics support is expected to work.
* **OpenCL runtime** — provided by your GPU driver (NVIDIA / AMD / Intel). The library loads it by name at run time: `OpenCL.dll` on Windows, `/System/Library/Frameworks/OpenCL.framework/OpenCL` on macOS, `libOpenCL.so` on Android and `libOpenCL.so.1` elsewhere. OpenCL 2.0 or later is recommended; the bindings target 3.1.
* **[LUXOPHIA/LUX](https://github.com/LUXOPHIA/LUX)** — the base library (math types, generic lists, colors). This repository does not bundle it.

> **New to this library?** Start with the sample repository [LUXOPHIA/OpenCL](https://github.com/LUXOPHIA/OpenCL) [5]: it bundles this library and all dependencies, and contains an interactive Mandelbrot renderer you can build and run immediately.

## 6. Roadmap

* Asynchronous execution (`cl_event` wrapper, `RunAsync`, profiling)
* Half-precision float support (`cl_half.h` port and a `THalf` type)
* More samples

## 7. License

[Apache License 2.0](LICENSE) — the same license as the bundled Khronos OpenCL headers.

## 8. References

1. Khronos OpenCL Working Group, [*The OpenCL Specification*](https://registry.khronos.org/OpenCL/specs/3.0-unified/html/OpenCL_API.html), Khronos Group, 2023.
2. Khronos OpenCL Working Group, [*The OpenCL C Specification*](https://registry.khronos.org/OpenCL/specs/3.0-unified/html/OpenCL_C.html), Khronos Group, 2023.
3. Khronos Group, [*OpenCL-Headers*](https://github.com/KhronosGroup/OpenCL-Headers), GitHub repository.
4. Khronos Group, [*Khronos OpenCL Registry*](https://registry.khronos.org/OpenCL/).
5. LUXOPHIA, [*OpenCL*](https://github.com/LUXOPHIA/OpenCL), GitHub repository — sample application (Mandelbrot renderer).

## 💖 [Embarcadero](https://www.embarcadero.com/) [**Delphi**](https://www.embarcadero.com/products/delphi)
Integrated Development Environment (IDE) for Creating Native Cross-Platform Apps.
### Free Download: [**Delphi** Community Edition](https://www.embarcadero.com/products/delphi/starter)
