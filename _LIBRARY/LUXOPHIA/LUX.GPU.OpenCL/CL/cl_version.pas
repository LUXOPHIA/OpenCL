unit cl_version;

(*******************************************************************************
 * Copyright (c) 2018 The Khronos Group Inc.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and/or associated documentation files (the
 * "Materials"), to deal in the Materials without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Materials, and to
 * permit persons to whom the Materials are furnished to do so, subject to
 * the following conditions:
 *
 * The above copyright notice and this permission notice shall be included
 * in all copies or substantial portions of the Materials.
 *
 * MODIFICATIONS TO THIS FILE MAY MEAN IT NO LONGER ACCURATELY REFLECTS
 * KHRONOS STANDARDS. THE UNMODIFIED, NORMATIVE VERSIONS OF KHRONOS
 * SPECIFICATIONS AND HEADER INFORMATION ARE LOCATED AT
 *    https://www.khronos.org/registry/
 *
 * THE MATERIALS ARE PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
 * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 * MATERIALS OR THE USE OR OTHER DEALINGS IN THE MATERIALS.
 ******************************************************************************)

interface //#################################################################### ■

(* Detect which version to target *)
{$IF not defined(CL_TARGET_OPENCL_VERSION) }
{$MESSAGE 'cl_version.h: CL_TARGET_OPENCL_VERSION is not defined. Defaulting to 220 (OpenCL 2.2)' }
const CL_TARGET_OPENCL_VERSION = 220;
{$ENDIF}
{$IF ( CL_TARGET_OPENCL_VERSION <> 100 ) and ( CL_TARGET_OPENCL_VERSION <> 110 ) and ( CL_TARGET_OPENCL_VERSION <> 120 ) and ( CL_TARGET_OPENCL_VERSION <> 200 ) and ( CL_TARGET_OPENCL_VERSION <> 210 ) and ( CL_TARGET_OPENCL_VERSION <> 220 ) }
{$MESSAGE 'cl_version: CL_TARGET_OPENCL_VERSION is not a valid value (100, 110, 120, 200, 210, 220). Defaulting to 220 (OpenCL 2.2)' }
{#UNDEF CL_TARGET_OPENCL_VERSION }
const CL_TARGET_OPENCL_VERSION = 220;
{$ENDIF}


(* OpenCL Version *)
{$IF ( CL_TARGET_OPENCL_VERSION >= 220 ) and not defined(CL_VERSION_2_2) }
const CL_VERSION_2_2  = 1;
{$ENDIF}
{$IF ( CL_TARGET_OPENCL_VERSION >= 210 ) and not defined(CL_VERSION_2_1) }
const CL_VERSION_2_1  = 1;
{$ENDIF}
{$IF ( CL_TARGET_OPENCL_VERSION >= 200 ) and not defined(CL_VERSION_2_0) }
const CL_VERSION_2_0  = 1;
{$ENDIF}
{$IF ( CL_TARGET_OPENCL_VERSION >= 120 ) and not defined(CL_VERSION_1_2) }
const CL_VERSION_1_2  = 1;
{$ENDIF}
{$IF ( CL_TARGET_OPENCL_VERSION >= 110 ) and not defined(CL_VERSION_1_1) }
const CL_VERSION_1_1  = 1;
{$ENDIF}
{$IF ( CL_TARGET_OPENCL_VERSION >= 100 ) and not defined(CL_VERSION_1_0) }
const CL_VERSION_1_0  = 1;
{$ENDIF}

(* Allow deprecated APIs for older OpenCL versions. *)
{$IF ( CL_TARGET_OPENCL_VERSION <= 210 ) and not defined(CL_USE_DEPRECATED_OPENCL_2_1_APIS) }
{$DEFINE CL_USE_DEPRECATED_OPENCL_2_1_APIS }
{$ENDIF}
{$IF ( CL_TARGET_OPENCL_VERSION <= 200 ) and not defined(CL_USE_DEPRECATED_OPENCL_2_0_APIS) }
{$DEFINE CL_USE_DEPRECATED_OPENCL_2_0_APIS }
{$ENDIF}
{$IF ( CL_TARGET_OPENCL_VERSION <= 120 ) and not defined(CL_USE_DEPRECATED_OPENCL_1_2_APIS) }
{$DEFINE CL_USE_DEPRECATED_OPENCL_1_2_APIS }
{$ENDIF}
{$IF ( CL_TARGET_OPENCL_VERSION <= 110 ) and not defined(CL_USE_DEPRECATED_OPENCL_1_1_APIS) }
{$DEFINE CL_USE_DEPRECATED_OPENCL_1_1_APIS }
{$ENDIF}
{$IF ( CL_TARGET_OPENCL_VERSION <= 100 ) and not defined(CL_USE_DEPRECATED_OPENCL_1_0_APIS) }
{$DEFINE CL_USE_DEPRECATED_OPENCL_1_0_APIS }
{$ENDIF}

implementation //############################################################### ■

end. //######################################################################### ■