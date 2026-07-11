<!---
layout: page
title: "README (English)"
permalink: /
-->
[`［日本語］`](https://luxophia.github.io/LUX.GPU.OpenCL/ja/)

# LUX.GPU.OpenCL

An [OpenCL](https://en.wikipedia.org/wiki/OpenCL) 3.1 wrapper library for [Delphi](https://www.embarcadero.com/products/delphi), for parallel computing on GPUs (or CPUs).

You write an OpenCL C kernel as a plain string, bind Delphi values to its parameters by name, and run it — no manual handle management, no API boilerplate.

----
## ■ 1. Features

* **Complete OpenCL 3.1 bindings** — ported one-to-one from the official [Khronos OpenCL-Headers](https://github.com/KhronosGroup/OpenCL-Headers).
* **Dynamic runtime loading** — `OpenCL.dll` is loaded at run time, so your application starts even on machines without any OpenCL driver. Check `TOpenCL.Available` to see whether OpenCL can be used.
* **Object-oriented model** — every OpenCL object (platform, device, context, queue, program, kernel, buffer, ...) is a Delphi class, arranged in the same parent-child hierarchy as the OpenCL specification.
* **Automatic lifetime management** — parents own their children. You never call `Free` on library objects; everything is released when the system shuts down.
* **Exception-based error handling** — every failed OpenCL call raises `ECLError`, which carries the OpenCL error code and a readable message. No silent failures.
* **Typed buffers and images** — `TCLBuffer<T>` gives you an array-like, type-safe view of GPU memory. 1D/2D/3D images are provided in several pixel formats.
* **Zero-copy design** — buffers use `CL_MEM_ALLOC_HOST_PTR` with Map/Unmap, avoiding needless copies between host and device.
* **Separate compile & link** — programs are compiled with `clCompileProgram` / `clLinkProgram`, and `#include` in kernel source is resolved from in-memory library programs (`TCLLibrar`) without touching the disk.

----
## ■ 2. Requirements

* **Delphi** — developed and tested on Delphi 12.x (Win32 / Win64). Any recent version with generics support is expected to work.
* **OpenCL runtime** — provided by your GPU driver (NVIDIA / AMD / Intel). OpenCL 2.0 or later is recommended.
* **[LUXOPHIA/LUX](https://github.com/LUXOPHIA/LUX)** — the base library (math types, generic lists, colors). This repository does not bundle it.

> **New to this library?** Start with the sample repository [LUXOPHIA/OpenCL](https://github.com/LUXOPHIA/OpenCL): it bundles this library and all dependencies, and contains an interactive Mandelbrot renderer you can build and run immediately.

----
## ■ 3. Quick Start

Add the library folders (and those of `LUX`) to your project's search path, then:

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

The compilation of the program happens lazily, the first time the kernel is actually needed. Kernel source can also be loaded from a file with `E.Source.LoadFromFile( 'MyKernel.cl' )`.

----
## ■ 4. Error Handling

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
ShowMessage( E.BuildTo( D ).CompileLog );
```

To display the whole platform/device tree for diagnostics:

```pascal
TOpenCL.Show( Memo1.Lines );
```

----
## ■ 5. Class Hierarchy

Objects form a tree; each parent creates, owns and frees its children.

```
TOpenCL :singleton facade
 └ TCLSystem :system
    └ TCLPlatfos ─ TCLPlatfo :platform
       ├ TCLDevices ─ TCLDevice :device
       └ TCLContexs ─ TCLContex :context
          ├ TCLQueuers ─ TCLQueuer :command queue
          ├ TCLArgumes ─ TCLBuffer<T> / TCLImager / TCLSamplr :kernel arguments
          ├ TCLLibrars ─ TCLLibrar :library program (for #include)
          └ TCLExecuts ─ TCLExecut :executable program
             ├ TCLBuildrs ─ TCLBuildr :per-device build
             └ TCLKernels ─ TCLKernel :kernel
                └ TCLParames ─ TCLParame :kernel parameter
```

----
## ■ 6. Units

| Folder / Unit | Corresponds to |
|:--|:--|
| `CL/cl_platform.pas` | `cl_platform.h` — basic scalar types |
| `CL/cl_version.pas` | `cl_version.h` — version switches (`CL_TARGET_OPENCL_VERSION`) |
| `CL/cl.pas` | `cl.h` — types, constants and function types of the OpenCL API |
| `CL/cl_functions.pas` | the ICD loader — API function variables + `LoadFunctions` |
| `Core/LUX.GPU.OpenCL.core.pas` | `ECLError` / `CheckCL` / `TCLVersion` |
| `Core/LUX.GPU.OpenCL.*.pas` | the class wrapper (Platfo / Device / Contex / Queuer / Progra / Kernel / Argume ...) |
| `LUX.GPU.OpenCL.pas` | entry point: `TOpenCL`, and short aliases of all classes |
| `Argume/`, `Stream/` | optional utilities (random seeders, FMX image streaming) |

----
## ■ 7. Roadmap

* Asynchronous execution (`cl_event` wrapper, `RunAsync`, profiling)
* Half-precision float support (`cl_half.h` port and a `THalf` type)
* More samples

----
## ■ 8. License

[Apache License 2.0](LICENSE) — the same license as the bundled Khronos OpenCL headers.

## ■ 9. References

* [Khronos OpenCL Registry](https://registry.khronos.org/OpenCL/)
* [KhronosGroup/OpenCL-Headers](https://github.com/KhronosGroup/OpenCL-Headers)
* [LUXOPHIA/OpenCL](https://github.com/LUXOPHIA/OpenCL) — sample application (Mandelbrot renderer)
