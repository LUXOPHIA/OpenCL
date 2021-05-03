unit cl_version;

(*******************************************************************************
 * Copyright (c) 2018-2020 The Khronos Group Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 ******************************************************************************)

interface //#################################################################### ■

(* Detect which version to target *)
{$IF not defined(CL_TARGET_OPENCL_VERSION) }
//{$MESSAGE 'cl_version.h: CL_TARGET_OPENCL_VERSION is not defined. Defaulting to 300 (OpenCL 3.0)' }
const CL_TARGET_OPENCL_VERSION = 300;
{$ENDIF}
//{$IF ( CL_TARGET_OPENCL_VERSION <> 100 ) and
//     ( CL_TARGET_OPENCL_VERSION <> 110 ) and
//     ( CL_TARGET_OPENCL_VERSION <> 120 ) and
//     ( CL_TARGET_OPENCL_VERSION <> 200 ) and
//     ( CL_TARGET_OPENCL_VERSION <> 210 ) and
//     ( CL_TARGET_OPENCL_VERSION <> 220 ) and
//     ( CL_TARGET_OPENCL_VERSION <> 300 ) }
//{$MESSAGE 'cl_version: CL_TARGET_OPENCL_VERSION is not a valid value (100, 110, 120, 200, 210, 220, 300). Defaulting to 300 (OpenCL 3.0)' }
//{#UNDEF CL_TARGET_OPENCL_VERSION }
//const CL_TARGET_OPENCL_VERSION = 300;
//{$ENDIF}


(* OpenCL Version *)
{$IF ( CL_TARGET_OPENCL_VERSION >= 300 ) and not defined(CL_VERSION_3_0) }
const CL_VERSION_3_0  = 1;
{$ENDIF}
//{$IF ( CL_TARGET_OPENCL_VERSION >= 220 ) and not defined(CL_VERSION_2_2) }
const CL_VERSION_2_2  = 1;
//{$ENDIF}
//{$IF ( CL_TARGET_OPENCL_VERSION >= 210 ) and not defined(CL_VERSION_2_1) }
const CL_VERSION_2_1  = 1;
//{$ENDIF}
//{$IF ( CL_TARGET_OPENCL_VERSION >= 200 ) and not defined(CL_VERSION_2_0) }
const CL_VERSION_2_0  = 1;
//{$ENDIF}
//{$IF ( CL_TARGET_OPENCL_VERSION >= 120 ) and not defined(CL_VERSION_1_2) }
const CL_VERSION_1_2  = 1;
//{$ENDIF}
//{$IF ( CL_TARGET_OPENCL_VERSION >= 110 ) and not defined(CL_VERSION_1_1) }
const CL_VERSION_1_1  = 1;
//{$ENDIF}
//{$IF ( CL_TARGET_OPENCL_VERSION >= 100 ) and not defined(CL_VERSION_1_0) }
const CL_VERSION_1_0  = 1;
//{$ENDIF}

(* Allow deprecated APIs for older OpenCL versions. *)
//{$IF ( CL_TARGET_OPENCL_VERSION <= 220 ) and not defined(CL_USE_DEPRECATED_OPENCL_2_2_APIS) }
//{$DEFINE CL_USE_DEPRECATED_OPENCL_2_2_APIS }
//{$ENDIF}
//{$IF ( CL_TARGET_OPENCL_VERSION <= 210 ) and not defined(CL_USE_DEPRECATED_OPENCL_2_1_APIS) }
//{$DEFINE CL_USE_DEPRECATED_OPENCL_2_1_APIS }
//{$ENDIF}
//{$IF ( CL_TARGET_OPENCL_VERSION <= 200 ) and not defined(CL_USE_DEPRECATED_OPENCL_2_0_APIS) }
//{$DEFINE CL_USE_DEPRECATED_OPENCL_2_0_APIS }
//{$ENDIF}
//{$IF ( CL_TARGET_OPENCL_VERSION <= 120 ) and not defined(CL_USE_DEPRECATED_OPENCL_1_2_APIS) }
//{$DEFINE CL_USE_DEPRECATED_OPENCL_1_2_APIS }
//{$ENDIF}
//{$IF ( CL_TARGET_OPENCL_VERSION <= 110 ) and not defined(CL_USE_DEPRECATED_OPENCL_1_1_APIS) }
//{$DEFINE CL_USE_DEPRECATED_OPENCL_1_1_APIS }
//{$ENDIF}
//{$IF ( CL_TARGET_OPENCL_VERSION <= 100 ) and not defined(CL_USE_DEPRECATED_OPENCL_1_0_APIS) }
//{$DEFINE CL_USE_DEPRECATED_OPENCL_1_0_APIS }
//{$ENDIF}

implementation //############################################################### ■

end. //######################################################################### ■