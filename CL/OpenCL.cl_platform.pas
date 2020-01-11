unit OpenCL.cl_platform;

interface //#################################################################### Å°

(**********************************************************************************
 * Copyright (c) 2008-2015 The Khronos Group Inc.
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
 **********************************************************************************)

(* $Revision: 11803 $ on $Date: 2010-06-25 10:02:12 -0700 (Fri, 25 Jun 2010) $ *)

uses LUX.Code.C;

(*
 * Deprecation flags refer to the last version of the header in which the
 * feature was not deprecated.
 *
 * E.g. VERSION_1_1_DEPRECATED means the feature is present in 1.1 without
 * deprecation but is deprecated in versions later than 1.1.
 *)

{$IFDEF __APPLE__ }
    #define CL_EXTENSION_WEAK_LINK       __attribute__((weak_import))
    #define CL_API_SUFFIX__VERSION_1_0                  AVAILABLE_MAC_OS_X_VERSION_10_6_AND_LATER
    #define CL_EXT_SUFFIX__VERSION_1_0                  CL_EXTENSION_WEAK_LINK AVAILABLE_MAC_OS_X_VERSION_10_6_AND_LATER
    #define CL_API_SUFFIX__VERSION_1_1                  AVAILABLE_MAC_OS_X_VERSION_10_7_AND_LATER
    #define GCL_API_SUFFIX__VERSION_1_1                 AVAILABLE_MAC_OS_X_VERSION_10_7_AND_LATER
    #define CL_EXT_SUFFIX__VERSION_1_1                  CL_EXTENSION_WEAK_LINK AVAILABLE_MAC_OS_X_VERSION_10_7_AND_LATER
    #define CL_EXT_SUFFIX__VERSION_1_0_DEPRECATED       CL_EXTENSION_WEAK_LINK AVAILABLE_MAC_OS_X_VERSION_10_6_AND_LATER_BUT_DEPRECATED_IN_MAC_OS_X_VERSION_10_7
    
    {$IFDEF AVAILABLE_MAC_OS_X_VERSION_10_8_AND_LATER }
        #define CL_API_SUFFIX__VERSION_1_2              AVAILABLE_MAC_OS_X_VERSION_10_8_AND_LATER
        #define GCL_API_SUFFIX__VERSION_1_2             AVAILABLE_MAC_OS_X_VERSION_10_8_AND_LATER
        #define CL_EXT_SUFFIX__VERSION_1_2              CL_EXTENSION_WEAK_LINK AVAILABLE_MAC_OS_X_VERSION_10_8_AND_LATER
        #define CL_EXT_PREFIX__VERSION_1_1_DEPRECATED
        #define CL_EXT_SUFFIX__VERSION_1_1_DEPRECATED   CL_EXTENSION_WEAK_LINK AVAILABLE_MAC_OS_X_VERSION_10_7_AND_LATER_BUT_DEPRECATED_IN_MAC_OS_X_VERSION_10_8
    {$ELSE}
        #warning  This path should never happen outside of internal operating system development.  AvailabilityMacros do not function correctly here!
        #define CL_API_SUFFIX__VERSION_1_2              AVAILABLE_MAC_OS_X_VERSION_10_7_AND_LATER
        #define GCL_API_SUFFIX__VERSION_1_2             AVAILABLE_MAC_OS_X_VERSION_10_7_AND_LATER
        #define CL_EXT_SUFFIX__VERSION_1_2              CL_EXTENSION_WEAK_LINK AVAILABLE_MAC_OS_X_VERSION_10_7_AND_LATER
        #define CL_EXT_SUFFIX__VERSION_1_1_DEPRECATED   CL_EXTENSION_WEAK_LINK AVAILABLE_MAC_OS_X_VERSION_10_7_AND_LATER
    {$ENDIF}
{$ELSE}
    {$DEFINE CL_EXTENSION_WEAK_LINK }
    {$DEFINE CL_API_SUFFIX__VERSION_1_0 }
    {$DEFINE CL_EXT_SUFFIX__VERSION_1_0 }
    {$DEFINE CL_API_SUFFIX__VERSION_1_1 }
    {$DEFINE CL_EXT_SUFFIX__VERSION_1_1 }
    {$DEFINE CL_API_SUFFIX__VERSION_1_2 }
    {$DEFINE CL_EXT_SUFFIX__VERSION_1_2 }
    {$DEFINE CL_API_SUFFIX__VERSION_2_0 }
    {$DEFINE CL_EXT_SUFFIX__VERSION_2_0 }
    {$DEFINE CL_API_SUFFIX__VERSION_2_1 }
    {$DEFINE CL_EXT_SUFFIX__VERSION_2_1 }
    
    {$IFDEF __GNUC__ }
        {$IFDEF CL_USE_DEPRECATED_OPENCL_1_0_APIS }
            {$DEFINE CL_EXT_SUFFIX__VERSION_1_0_DEPRECATED }
            #define CL_EXT_PREFIX__VERSION_1_0_DEPRECATED    
        {$ELSE}
            #define CL_EXT_SUFFIX__VERSION_1_0_DEPRECATED __attribute__((deprecated))
            #define CL_EXT_PREFIX__VERSION_1_0_DEPRECATED    
        {$ENDIF}
    
        {$IFDEF CL_USE_DEPRECATED_OPENCL_1_1_APIS }
            #define CL_EXT_SUFFIX__VERSION_1_1_DEPRECATED    
            #define CL_EXT_PREFIX__VERSION_1_1_DEPRECATED    
        {$ELSE}
            #define CL_EXT_SUFFIX__VERSION_1_1_DEPRECATED __attribute__((deprecated))
            #define CL_EXT_PREFIX__VERSION_1_1_DEPRECATED    
        {$ENDIF}

        {$IFDEF CL_USE_DEPRECATED_OPENCL_1_2_APIS }
            {$DEFINE CL_EXT_SUFFIX__VERSION_1_2_DEPRECATED }
            {$DEFINE CL_EXT_PREFIX__VERSION_1_2_DEPRECATED }
        {$ELSE}
            #define CL_EXT_SUFFIX__VERSION_1_2_DEPRECATED __attribute__((deprecated))
            {$DEFINE CL_EXT_PREFIX__VERSION_1_2_DEPRECATED }
         {$ENDIF}

        {$IFDEF CL_USE_DEPRECATED_OPENCL_2_0_APIS }
            {$DEFINE CL_EXT_SUFFIX__VERSION_2_0_DEPRECATED }
            {$DEFINE CL_EXT_PREFIX__VERSION_2_0_DEPRECATED }
        {$ELSE}
            #define CL_EXT_SUFFIX__VERSION_2_0_DEPRECATED __attribute__((deprecated))
            {$DEFINE CL_EXT_PREFIX__VERSION_2_0_DEPRECATED }
        {$ENDIF}
    {$ELSEIF _WIN32 }
        {$IFDEF CL_USE_DEPRECATED_OPENCL_1_0_APIS }
            {$DEFINE CL_EXT_SUFFIX__VERSION_1_0_DEPRECATED }
            #define CL_EXT_PREFIX__VERSION_1_0_DEPRECATED    
        {$ELSE}
            #define CL_EXT_SUFFIX__VERSION_1_0_DEPRECATED 
            #define CL_EXT_PREFIX__VERSION_1_0_DEPRECATED __declspec(deprecated)     
        {$ENDIF}
    
        {$IFDEF CL_USE_DEPRECATED_OPENCL_1_1_APIS }
            {$DEFINE CL_EXT_SUFFIX__VERSION_1_1_DEPRECATED }
            #define CL_EXT_PREFIX__VERSION_1_1_DEPRECATED    
        {$ELSE}
            #define CL_EXT_SUFFIX__VERSION_1_1_DEPRECATED 
            #define CL_EXT_PREFIX__VERSION_1_1_DEPRECATED __declspec(deprecated)     
        {$ENDIF}
    
        {$IFDEF CL_USE_DEPRECATED_OPENCL_1_2_APIS }
            {$DEFINE CL_EXT_SUFFIX__VERSION_1_2_DEPRECATED }
            {$DEFINE CL_EXT_PREFIX__VERSION_1_2_DEPRECATED }
        {$ELSE}
            {$DEFINE CL_EXT_SUFFIX__VERSION_1_2_DEPRECATED }
            #define CL_EXT_PREFIX__VERSION_1_2_DEPRECATED __declspec(deprecated)
        {$ENDIF}

        {$IFDEF CL_USE_DEPRECATED_OPENCL_2_0_APIS }
            {$DEFINE CL_EXT_SUFFIX__VERSION_2_0_DEPRECATED }
            {$DEFINE CL_EXT_PREFIX__VERSION_2_0_DEPRECATED }
        {$ELSE}
            #define CL_EXT_SUFFIX__VERSION_2_0_DEPRECATED 
            #define CL_EXT_PREFIX__VERSION_2_0_DEPRECATED __declspec(deprecated)
        {$ENDIF}
    {$ELSE}
        {$DEFINE CL_EXT_SUFFIX__VERSION_1_0_DEPRECATED }
        {$DEFINE CL_EXT_PREFIX__VERSION_1_0_DEPRECATED }
    
        {$DEFINE CL_EXT_SUFFIX__VERSION_1_1_DEPRECATED }
        {$DEFINE CL_EXT_PREFIX__VERSION_1_1_DEPRECATED }
    
        {$DEFINE CL_EXT_SUFFIX__VERSION_1_2_DEPRECATED }
        {$DEFINE CL_EXT_PREFIX__VERSION_1_2_DEPRECATED }

        {$DEFINE CL_EXT_SUFFIX__VERSION_2_0_DEPRECATED }
        {$DEFINE CL_EXT_PREFIX__VERSION_2_0_DEPRECATED }
    {$ENDIF}
{$ENDIF}

{$IF Defined( _WIN32 ) and Defined( _MSC_VER ) }

(* scalar types  *)
type T_cl_char   = T_signed__int8   ;  P_cl_char   = P_signed__int8   ;
type T_cl_uchar  = T_unsigned__int8 ;  P_cl_uchar  = P_unsigned__int8 ;
type T_cl_short  = T_signed__int16  ;  P_cl_short  = P_signed__int16  ;
type T_cl_ushort = T_unsigned__int16;  P_cl_ushort = P_unsigned__int16;
type T_cl_int    = T_signed__int32  ;  P_cl_int    = P_signed__int32  ;
type T_cl_uint   = T_unsigned__int32;  P_cl_uint   = P_unsigned__int32;
type T_cl_long   = T_signed__int64  ;  P_cl_long   = P_signed__int64  ;
type T_cl_ulong  = T_unsigned__int64;  P_cl_ulong  = P_unsigned__int64;

type T_cl_half   = T_unsigned__int16;  P_cl_half   = P_unsigned__int16;
type T_cl_float  = T_float          ;  P_cl_float  = P_float          ;
type T_cl_double = T_double         ;  P_cl_double = P_double         ;

(* Macro names and corresponding values defined by OpenCL *)
const CL_CHAR_BIT         = 8;
const CL_SCHAR_MAX        = 127;
const CL_SCHAR_MIN        = (-127-1);
const CL_CHAR_MAX         = CL_SCHAR_MAX;
const CL_CHAR_MIN         = CL_SCHAR_MIN;
const CL_UCHAR_MAX        = 255;
const CL_SHRT_MAX         = 32767;
const CL_SHRT_MIN         = (-32767-1);
const CL_USHRT_MAX        = 65535;
const CL_INT_MAX          = 2147483647;
const CL_INT_MIN          = (-2147483647-1);
const CL_UINT_MAX         = $ffffffff;
#define CL_LONG_MAX         ((cl_long) $7FFFFFFFFFFFFFFFLL)
#define CL_LONG_MIN         ((cl_long) -$7FFFFFFFFFFFFFFFLL - 1LL)
#define CL_ULONG_MAX        ((cl_ulong) $FFFFFFFFFFFFFFFFULL)

const CL_FLT_DIG          = 6;
const CL_FLT_MANT_DIG     = 24;
const CL_FLT_MAX_10_EXP   = +38;
const CL_FLT_MAX_EXP      = +128;
const CL_FLT_MIN_10_EXP   = -37;
const CL_FLT_MIN_EXP      = -125;
const CL_FLT_RADIX        = 2;
const CL_FLT_MAX          = 340282346638528859811704183484516925440.0f;
const CL_FLT_MIN          = 1.175494350822287507969e-38f;
const CL_FLT_EPSILON      = $1.0p-23f;

const CL_DBL_DIG          = 15;
const CL_DBL_MANT_DIG     = 53;
const CL_DBL_MAX_10_EXP   = +308;
const CL_DBL_MAX_EXP      = +1024;
const CL_DBL_MIN_10_EXP   = -307;
const CL_DBL_MIN_EXP      = -1021;
const CL_DBL_RADIX        = 2;
const CL_DBL_MAX          = 179769313486231570814527423731704356798070567525844996598917476803157260780028538760589558632766878171540458953514382464234321326889464182768467546703537516986049910576551282076245490090389328944075868508455133942304583236903222948165808559332123348274797826204144723168738177180919299881250404026184124858368.0;
const CL_DBL_MIN          = 2.225073858507201383090e-308;
const CL_DBL_EPSILON      = 2.220446049250313080847e-16;

const CL_M_E             = 2.718281828459045090796;
const CL_M_LOG2E         = 1.442695040888963387005;
const CL_M_LOG10E        = 0.434294481903251816668;
const CL_M_LN2           = 0.693147180559945286227;
const CL_M_LN10          = 2.302585092994045901094;
const CL_M_PI            = 3.141592653589793115998;
const CL_M_PI_2          = 1.570796326794896557999;
const CL_M_PI_4          = 0.785398163397448278999;
const CL_M_1_PI          = 0.318309886183790691216;
const CL_M_2_PI          = 0.636619772367581382433;
const CL_M_2_SQRTPI      = 1.128379167095512558561;
const CL_M_SQRT2         = 1.414213562373095145475;
const CL_M_SQRT1_2       = 0.707106781186547572737;

const CL_M_E_F           = 2.71828174591064f;
const CL_M_LOG2E_F       = 1.44269502162933f;
const CL_M_LOG10E_F      = 0.43429449200630f;
const CL_M_LN2_F         = 0.69314718246460f;
const CL_M_LN10_F        = 2.30258512496948f;
const CL_M_PI_F          = 3.14159274101257f;
const CL_M_PI_2_F        = 1.57079637050629f;
const CL_M_PI_4_F        = 0.78539818525314f;
const CL_M_1_PI_F        = 0.31830987334251f;
const CL_M_2_PI_F        = 0.63661974668503f;
const CL_M_2_SQRTPI_F    = 1.12837922573090f;
const CL_M_SQRT2_F       = 1.41421353816986f;
const CL_M_SQRT1_2_F     = 0.70710676908493f;

const CL_NAN                    = CL_INFINITY - CL_INFINITY;
const CL_HUGE_VALF :T_cl_float  = 1e50;
const CL_HUGE_VAL  :T_cl_double = 1e500;
const CL_MAXFLOAT               = CL_FLT_MAX;
const CL_INFINITY               = CL_HUGE_VALF;

{$ELSE}

(* scalar types  *)
type T_cl_char   = T_int8_t  ;  P_cl_char   = P_int8_t  ;
type T_cl_uchar  = T_uint8_t ;  P_cl_uchar  = P_uint8_t ;
type T_cl_short  = T_int16_t ;  P_cl_short  = P_int16_t ;
type T_cl_ushort = T_uint16_t;  P_cl_ushort = P_uint16_t;
type T_cl_int    = T_int32_t ;  P_cl_int    = P_int32_t ;
type T_cl_uint   = T_uint32_t;  P_cl_uint   = P_uint32_t;
type T_cl_long   = T_int64_t ;  P_cl_long   = P_int64_t ;
type T_cl_ulong  = T_uint64_t;  P_cl_ulong  = P_uint64_t;

type T_cl_half   = T_uint16_t;  P_cl_half   = P_uint16_t;
type T_cl_float  = T_float   ;  P_cl_float  = P_float   ;
type T_cl_double = T_double  ;  P_cl_double = P_double  ;

(* Macro names and corresponding values defined by OpenCL *)
const CL_CHAR_BIT              = 8;
const CL_SCHAR_MAX             = 127;
const CL_SCHAR_MIN             = -127-1;
const CL_CHAR_MAX              = CL_SCHAR_MAX;
const CL_CHAR_MIN              = CL_SCHAR_MIN;
const CL_UCHAR_MAX             = 255;
const CL_SHRT_MAX              = 32767;
const CL_SHRT_MIN              = -32767-1;
const CL_USHRT_MAX             = 65535;
const CL_INT_MAX               = 2147483647;
const CL_INT_MIN               = -2147483647-1;
const CL_UINT_MAX              = $ffffffff;
const CL_LONG_MAX  :T_cl_long  =  $7FFFFFFFFFFFFFFF;
const CL_LONG_MIN  :T_cl_long  = -$7FFFFFFFFFFFFFFF - 1;
const CL_ULONG_MAX :T_cl_ulong =  $FFFFFFFFFFFFFFFF;

const CL_FLT_DIG          = 6;
const CL_FLT_MANT_DIG     = 24;
const CL_FLT_MAX_10_EXP   = +38;
const CL_FLT_MAX_EXP      = +128;
const CL_FLT_MIN_10_EXP   = -37;
const CL_FLT_MIN_EXP      = -125;
const CL_FLT_RADIX        = 2;
/////const CL_FLT_MAX          = $1.fffffep127f;
/////const CL_FLT_MIN          = $1.0p-126f;
/////const CL_FLT_EPSILON      = $1.0p-23f;

const CL_DBL_DIG          = 15;
const CL_DBL_MANT_DIG     = 53;
const CL_DBL_MAX_10_EXP   = +308;
const CL_DBL_MAX_EXP      = +1024;
const CL_DBL_MIN_10_EXP   = -307;
const CL_DBL_MIN_EXP      = -1021;
const CL_DBL_RADIX        = 2;
/////const CL_DBL_MAX          = $1.fffffffffffffp1023;
/////const CL_DBL_MIN          = $1.0p-1022;
/////const CL_DBL_EPSILON      = $1.0p-52;

const CL_M_E             = 2.718281828459045090796;
const CL_M_LOG2E         = 1.442695040888963387005;
const CL_M_LOG10E        = 0.434294481903251816668;
const CL_M_LN2           = 0.693147180559945286227;
const CL_M_LN10          = 2.302585092994045901094;
const CL_M_PI            = 3.141592653589793115998;
const CL_M_PI_2          = 1.570796326794896557999;
const CL_M_PI_4          = 0.785398163397448278999;
const CL_M_1_PI          = 0.318309886183790691216;
const CL_M_2_PI          = 0.636619772367581382433;
const CL_M_2_SQRTPI      = 1.128379167095512558561;
const CL_M_SQRT2         = 1.414213562373095145475;
const CL_M_SQRT1_2       = 0.707106781186547572737;

const CL_M_E_F           = 2.71828174591064;
const CL_M_LOG2E_F       = 1.44269502162933;
const CL_M_LOG10E_F      = 0.43429449200630;
const CL_M_LN2_F         = 0.69314718246460;
const CL_M_LN10_F        = 2.30258512496948;
const CL_M_PI_F          = 3.14159274101257;
const CL_M_PI_2_F        = 1.57079637050629;
const CL_M_PI_4_F        = 0.78539818525314;
const CL_M_1_PI_F        = 0.31830987334251;
const CL_M_2_PI_F        = 0.63661974668503;
const CL_M_2_SQRTPI_F    = 1.12837922573090;
const CL_M_SQRT2_F       = 1.41421353816986;
const CL_M_SQRT1_2_F     = 0.70710676908493;

const CL_HUGE_VALF :T_cl_float  = 1e50;
const CL_HUGE_VAL  :T_cl_double = 1e500;
const CL_NAN                    = 0/0;
/////const CL_MAXFLOAT = CL_FLT_MAX;
const CL_INFINITY :T_cl_float   = 1e50;

{$ENDIF}

(* Mirror types to GL types. Mirror types allow us to avoid deciding which 87s to load based on whether we are using GL or GLES here. *)
type T_cl_GLuint = T_unsigned_int;
type T_cl_GLint  = T_int;
type T_cl_GLenum = T_unsigned_int;

(*
 * Vector types 
 *
 *  Note:   OpenCL requires that all types be naturally aligned. 
 *          This means that vector types must be naturally aligned.
 *          For example, a vector of four floats must be aligned to
 *          a 16 byte boundary (calculated as 4 * the natural 4-byte 
 *          alignment of the float).  The alignment qualifiers here
 *          will only function properly if your compiler supports them
 *          and if you don't actively work to defeat them.  For example,
 *          in order for a cl_float4 to be 16 byte aligned in a struct,
 *          the start of the struct must itself be 16-byte aligned. 
 *
 *          Maintaining proper alignment is the user's responsibility.
 *)

(* Define basic vector types *)
{$IF Defined( __VEC__ ) }
   #include <altivec.h>   (* may be omitted depending on compiler. AltiVec spec provides no way to detect whether the header is required. *)
   type T__cl_uchar16 = T_vector_unsigned_char;
   type T__cl_char16  = T_vector_signed_char;
   type T__cl_ushort8 = T_vector_unsigned_short;
   type T__cl_short8  = T_vector_signed_short;
   type T__cl_uint4   = T_vector_unsigned_int;
   type T__cl_int4    = T_vector_signed_int;
   type T__cl_float4  = T_vector_float;
   const __CL_UCHAR16__  = 1;
   const __CL_CHAR16__   = 1;
   const __CL_USHORT8__  = 1;
   const __CL_SHORT8__   = 1;
   const __CL_UINT4__    = 1;
   const __CL_INT4__     = 1;
   const __CL_FLOAT4__   = 1;
{$ENDIF}

{$IF Defined( __SSE__ ) }
    {$IF Defined( __MINGW64__ ) }
        #include <intrin.h>
    {$ELSE}
        #include <xmmintrin.h>
    {$ENDIF}
    {$IF Defined( __GNUC__ ) }
        typedef float __cl_float4   __attribute__((vector_size(16)));
    {$ELSE}
        typedef __m128 __cl_float4;
    {$ENDIF}
    const __CL_FLOAT4__   = 1;
{$ENDIF}

{$IF Defined( __SSE2__ ) }
    {$IF Defined( __MINGW64__ ) }
        #include <intrin.h>
    {$ELSE}
        #include <emmintrin.h>
    {$ENDIF}
    {$IF Defined( __GNUC__ ) }
        type T__cl_uchar16 = T_cl_uchar;   //__attribute__((vector_size(16)))
        type T__cl_char16  = T_cl_char;    //__attribute__((vector_size(16)))
        type T__cl_ushort8 = T_cl_ushort;  //__attribute__((vector_size(16)))
        type T__cl_short8  = T_cl_short;   //__attribute__((vector_size(16)))
        type T__cl_uint4   = T_cl_uint;    //__attribute__((vector_size(16)))
        type T__cl_int4    = T_cl_int;     //__attribute__((vector_size(16)))
        type T__cl_ulong2  = T_cl_ulong;   //__attribute__((vector_size(16)))
        type T__cl_long2   = T_cl_long;    //__attribute__((vector_size(16)))
        type T__cl_double2 = T_cl_double;  //__attribute__((vector_size(16)))
    {$ELSE}
        type T__cl_uchar16 = T__m128i;
        type T__cl_char16  = T__m128i;
        type T__cl_ushort8 = T__m128i;
        type T__cl_short8  = T__m128i;
        type T__cl_uint4   = T__m128i;
        type T__cl_int4    = T__m128i;
        type T__cl_ulong2  = T__m128i;
        type T__cl_long2   = T__m128i;
        type T__cl_double2 = T__m128d;
    {$ENDIF}
    const __CL_UCHAR16__  = 1;
    const __CL_CHAR16__   = 1;
    const __CL_USHORT8__  = 1;
    const __CL_SHORT8__   = 1;
    const __CL_INT4__     = 1;
    const __CL_UINT4__    = 1;
    const __CL_ULONG2__   = 1;
    const __CL_LONG2__    = 1;
    const __CL_DOUBLE2__  = 1;
{$ENDIF}

{$IF Defined( __MMX__ ) }
    #include <mmintrin.h>
    {$IF Defined( __GNUC__ ) }
        type T__cl_uchar8  = T_cl_uchar;   //__attribute__((vector_size(8)))
        type T__cl_char8   = T_cl_char;    //__attribute__((vector_size(8)))
        type T__cl_ushort4 = T_cl_ushort;  //__attribute__((vector_size(8)))
        type T__cl_short4  = T_cl_short;   //__attribute__((vector_size(8)))
        type T__cl_uint2   = T_cl_uint;    //__attribute__((vector_size(8)))
        type T__cl_int2    = T_cl_int;     //__attribute__((vector_size(8)))
        type T__cl_ulong1  = T_cl_ulong;   //__attribute__((vector_size(8)))
        type T__cl_long1   = T_cl_long;    //__attribute__((vector_size(8)))
        type T__cl_float2  = T_cl_float;   //__attribute__((vector_size(8)))
    {$ELSE}
        type T__cl_uchar8  = T__m64;
        type T__cl_char8   = T__m64;
        type T__cl_ushort4 = T__m64;
        type T__cl_short4  = T__m64;
        type T__cl_uint2   = T__m64;
        type T__cl_int2    = T__m64;
        type T__cl_ulong1  = T__m64;
        type T__cl_long1   = T__m64;
        type T__cl_float2  = T__m64;
    {$ENDIF}
    const __CL_UCHAR8__   = 1;
    const __CL_CHAR8__    = 1;
    const __CL_USHORT4__  = 1;
    const __CL_SHORT4__   = 1;
    const __CL_INT2__     = 1;
    const __CL_UINT2__    = 1;
    const __CL_ULONG1__   = 1;
    const __CL_LONG1__    = 1;
    const __CL_FLOAT2__   = 1;
{$ENDIF}

{$IF Defined( __AVX__ ) }
    {$IF Defined( __MINGW64__ ) }
        #include <intrin.h>
    {$ELSE}
        #include <immintrin.h> 
    {$ENDIF}
    {$IF Defined( __GNUC__ ) }
        typedef cl_float    __cl_float8     __attribute__((vector_size(32)));
        typedef cl_double   __cl_double4    __attribute__((vector_size(32)));
    {$ELSE}
        typedef __m256      __cl_float8;
        typedef __m256d     __cl_double4;
    {$ENDIF}
    const __CL_FLOAT8__   = 1;
    const __CL_DOUBLE4__  = 1;
{$ENDIF}

(* Define capabilities for anonymous struct members. *)
{$IF Defined( __GNUC__) and not Defined( __STRICT_ANSI__ ) }
const __CL_HAS_ANON_STRUCT__ = 1;
const __CL_ANON_STRUCT__     = __extension__;
{$ELSEIF Defined( _WIN32 ) and ( _MSC_VER >= 1500 ) }
   (* Microsoft Developer Studio 2008 supports anonymous structs, but
    * complains by default. *)
const __CL_HAS_ANON_STRUCT__ = 1;
{$DEFINE __CL_ANON_STRUCT__ }
   (* Disable warning C4201: nonstandard extension used : nameless
    * struct/union *)
#pragma warning( push )
#pragma warning( disable : 4201 )
{$ELSE}
const __CL_HAS_ANON_STRUCT__ = 0;
{$DEFINE __CL_ANON_STRUCT__ }
{$ENDIF}

(* Define alignment keys *)
{$IF Defined( __GNUC__ ) }
    #define CL_ALIGNED(_x)          __attribute__ ((aligned(_x)))
{$ELSEIF Defined( _WIN32 ) and Defined( _MSC_VER ) }
    (* Alignment keys neutered on windows because MSVC can't swallow function arguments with alignment requirements     *)
    (* http://msdn.microsoft.com/en-us/library/373ak2y1%28VS.71%29.aspx                                                 *)
    (* #include <crtdefs.h>                                                                                             *)
    (* #define CL_ALIGNED(_x)          _CRT_ALIGN(_x)                                                                   *)
    {$DEFINE CL_ALIGNED(_x) }
{$ELSE}
/////   #warning  Need to implement some method to align data here
/////   #define  CL_ALIGNED(_x)
{$ENDIF}

(* Indicate whether .xyzw, .s0123 and .hi.lo are supported *)
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
    (* .xyzw and .s0123...{f|F} are supported *)
    const CL_HAS_NAMED_VECTOR_FIELDS = 1;
    (* .hi and .lo are supported *)
    const CL_HAS_HI_LO_VECTOR_FIELDS = 1;
{$ENDIF}

(* Define cl_vector types *)

(* ---- cl_charn ---- *)
type T_cl_char2 = packed record
     case Integer of
       0:( s :array [ 0..2-1 ] of T_cl_char; );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1:( x, y :T_cl_char; );
       2:( s0, s1 :T_cl_char; );
       3:( lo, hi :T_cl_char; );
{$ENDIF}
{$IF Defined( __CL_CHAR2__ ) }
       4:( v2 :T__cl_char2; );
{$ENDIF}
     end;

type T_cl_char4 = packed record
     case Integer of
       0:( s :array [ 0..4-1 ] of T_cl_char; );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1:( x, y, z, w :T_cl_char; );
       2:( s0, s1, s2, s3 :T_cl_char; );
       3:( lo, hi :T_cl_char2; );
{$ENDIF}
{$IF Defined( __CL_CHAR2__ ) }
       4:( v2 :array [ 0..1 ] of T__cl_char2;
{$ENDIF}
{$IF Defined( __CL_CHAR4__ ) }
       5:( v4 :T__cl_char4 );
{$ENDIF}
     end;

(* cl_char3 is identical in size, alignment and behavior to cl_char4. See section 6.1.5. *)
type T_cl_char3 = T_cl_char4;

type T_cl_char8 = packed record
     case Integer of
       0:( s :array [ 0..8-1 ] of T_cl_char; );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1:( x, y, z, w :T_cl_char; );
       2:( s0, s1, s2, s3, s4, s5, s6, s7 :T_cl_char; );
       3:( lo, hi :T_cl_char4; );
{$ENDIF}
{$IF Defined( __CL_CHAR2__ ) }
       4:( v2 :array [ 0..3 ] of T__cl_char2; );
{$ENDIF}
{$IF Defined( __CL_CHAR4__ ) }
       5:( v4 :array [ 0..1 ] of T__cl_char4; );
{$ENDIF}
{$IF Defined( __CL_CHAR8__ ) }
       6:( v8 :T__cl_char8; );
{$ENDIF}
     end;

type T_cl_char16 = packed record
     case Integer of
       0:( s :array [ 0..16-1 ] of T_cl_char; );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1:( x, y, z, w, __spacer4, __spacer5, __spacer6, __spacer7, __spacer8, __spacer9, sa, sb, sc, sd, se, sf :T_cl_char; );
       2:( s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, sA, sB, sC, sD, sE, sF :T_cl_char; );
       3:( lo, hi :T_cl_char8; );
{$ENDIF}
{$IF Defined( __CL_CHAR2__ ) }
       4:( v2 :array [ 0..7 ] of T__cl_char2; );
{$ENDIF}
{$IF Defined( __CL_CHAR4__ ) }
       5:( v4 :array [ 0..3 ] of T__cl_char4; );
{$ENDIF}
{$IF Defined( __CL_CHAR8__ ) }
       6:( v8 :array [ 0..1 ] of T__cl_char8; );
{$ENDIF}
{$IF Defined( __CL_CHAR16__ ) }
       7:( v16 :T__cl_char16; );
{$ENDIF}
     end;

(* ---- cl_ucharn ---- *)
type T_cl_uchar2 = packed record
     case Integer of
       0:( s :array [ 0..2-1 ] of T_cl_uchar; );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1:( x, y :T_cl_uchar; );
       2:( s0, s1 :T_cl_uchar; );
       3:( lo, hi :T_cl_uchar; );
{$ENDIF}
{$IF Defined( __cl_uchar2__ ) }
       4:( v2 :T__cl_uchar2; );
{$ENDIF}
     end;

type T_cl_uchar4 = packed record
     case Integer of
       0:( s :array [ 0..4-1 ] of T_cl_uchar; );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1:( x, y, z, w :T_cl_uchar; );
       2:( s0, s1, s2, s3 :T_cl_uchar; );
       3:( lo, hi :T_cl_uchar2; );
{$ENDIF}
{$IF Defined( __CL_UCHAR2__ ) }
       4:( v2 :array [ 0..2-1 ] of T__cl_uchar2; );
{$ENDIF}
{$IF Defined( __CL_UCHAR4__ ) }
       5:( v4 :T__cl_uchar4; );
{$ENDIF}
     end;

(* cl_uchar3 is identical in size, alignment and behavior to cl_uchar4. See section 6.1.5. *)
type  T_cl_uchar3 = T_cl_uchar4;

type T_cl_uchar8 = packed record
     case Integer of
       0:( s :array [ 0..8-1 ] of T_cl_uchar; );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1:( x, y, z, w :T_cl_uchar; );
       2:( s0, s1, s2, s3, s4, s5, s6, s7 :T_cl_uchar; );
       3:( lo, hi :T_cl_uchar4; );
{$ENDIF}
{$IF Defined( __CL_UCHAR2__ ) }
       4:( v2 :array [ 0..4-1 ] of T__cl_uchar2; );
{$ENDIF}
{$IF Defined( __CL_UCHAR4__ ) }
       5:( v4 :array [ 0..2-1 ] of T__cl_uchar4; );
{$ENDIF}
{$IF Defined( __CL_UCHAR8__ ) }
       6:( v8 :T__cl_uchar8; );
{$ENDIF}
     end;

type T_cl_uchar16 = packed record
     case Integer of
       0:( s :array [ 0..16-1 ] of T_cl_uchar; );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1:( x, y, z, w, __spacer4, __spacer5, __spacer6, __spacer7, __spacer8, __spacer9, sa, sb, sc, sd, se, sf :T_cl_uchar; );
       2:( s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, sA, sB, sC, sD, sE, sF :T_cl_uchar; );
       3:( lo, hi :T_cl_uchar8; );
{$ENDIF}
{$IF Defined( __CL_UCHAR2__ ) }
       4:( v2 :array [ 0..8-1 ] of T__cl_uchar2; );
{$ENDIF}
{$IF Defined( __CL_UCHAR4__ ) }
       5:( v4 :array [ 0..4-1 ] of T__cl_uchar4; );
{$ENDIF}
{$IF Defined( __CL_UCHAR8__ ) }
       6:( v8 :array [ 0..2-1 ] of T__cl_uchar8; );
{$ENDIF}
{$IF Defined( __CL_UCHAR16__ ) }
       7:( v16 :T__cl_uchar16; );
{$ENDIF}
     end;

(* ---- cl_shortn ---- *)
type T_cl_short2 = packed record
     case Integer of
       0:( s :array [ 0..2-1 ] of T_cl_short; );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1:( x, y :T_cl_short; );
       2:( s0, s1 :T_cl_short; );
       3:( lo, hi :T_cl_short; );
{$ENDIF}
{$IF Defined( __CL_SHORT2__ ) }
       4:( v2 :T__cl_short2; );
{$ENDIF}
     end;

type T_cl_short4 = packed record
     case Integer of
       0:( s :array [ 0..4-1 ] of T_cl_short; );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1:( x, y, z, w :T_cl_short; );
       2:( s0, s1, s2, s3 :T_cl_short; );
       3:( lo, hi :T_cl_short2; );
{$ENDIF}
{$IF Defined( __CL_SHORT2__ ) }
       4:( v2 :array [ 0..2-1 ] of T__cl_short2; );
{$ENDIF}
{$IF Defined( __CL_SHORT4__ ) }
       5:( v4 :T__cl_short4; );
{$ENDIF}
     end;

(* cl_short3 is identical in size, alignment and behavior to cl_short4. See section 6.1.5. *)
type T_cl_short3 = T_cl_short4;

type T_cl_short8 = packed record
     case Integer of
       0:( s :array [ 0..8-1 ] of T_cl_short; );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1:( x, y, z, w :T_cl_short; );
       2:( s0, s1, s2, s3, s4, s5, s6, s7 :T_cl_short; );
       3:( lo, hi :T_cl_short4; );
{$ENDIF}
{$IF Defined( __CL_SHORT2__ ) }
       4:( v2 :array [ 0..4-1 ] of T__cl_short2; );
{$ENDIF}
{$IF Defined( __CL_SHORT4__ ) }
       5:( v4 :array [ 0..2-1 ] of T__cl_short4; );
{$ENDIF}
{$IF Defined( __CL_SHORT8__ ) }
       6:( v8 :T__cl_short8; );
{$ENDIF}
     end;

type T_cl_short16 = packed record
     case Integer of
       0:( s :array [ 0..16-1 ] of T_cl_short; );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1:( x, y, z, w, __spacer4, __spacer5, __spacer6, __spacer7, __spacer8, __spacer9, sa, sb, sc, sd, se, sf :T_cl_short; );
       2:( s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, sA, sB, sC, sD, sE, sF :T_cl_short; );
       3:( lo, hi :T_cl_short8; );
{$ENDIF}
{$IF Defined( __CL_SHORT2__ ) }
       4:( v2 :array [ 0..8-1 ] of T__cl_short2; );
{$ENDIF}
{$IF Defined( __CL_SHORT4__ ) }
       5:( v4 :array [ 0..4-1 ] of T__cl_short4; );
{$ENDIF}
{$IF Defined( __CL_SHORT8__ ) }
       6:( v8 :array [ 0..2-1 ] of T__cl_short8; );
{$ENDIF}
{$IF Defined( __CL_SHORT16__ ) }
       7:( v16 :T__cl_short16; );
{$ENDIF}
     end;

(* ---- cl_ushortn ---- *)
type T_cl_ushort2 = packed record
     case Integer of
       0:( s :array [ 0..2-1 ] of T_cl_ushort; );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1:( x, y :T_cl_ushort; );
       2:( s0, s1 :T_cl_ushort; );
       3:( lo, hi :T_cl_ushort; );
{$ENDIF}
{$IF Defined( __CL_USHORT2__ ) }
       4:( v2 :T__cl_ushort2; );
{$ENDIF}
     end;

type T_cl_ushort4 = packed record
     case Integer of
       0:( s :array [ 0..4-1 ] of T_cl_ushort; );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1:( x, y, z, w :T_cl_ushort; );
       2:( s0, s1, s2, s3 :T_cl_ushort; );
       3:( lo, hi :T_cl_ushort2; );
{$ENDIF}
{$IF Defined( __CL_USHORT2__ ) }
       4:( v2 :array [ 0..2-1 ] of T__cl_ushort2; );
{$ENDIF}
{$IF Defined( __CL_USHORT4__ ) }
       5:( v4 :T__cl_ushort4; );
{$ENDIF}
     end;

(* cl_ushort3 is identical in size, alignment and behavior to cl_ushort4. See section 6.1.5. *)
type T_cl_ushort3 = T_cl_ushort4;

type T_cl_ushort8 = packed record
     case Integer of
       0:( s :array [ 0..8-1 ] of T_cl_ushort; );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1:( x, y, z, w :T_cl_ushort; );
       2:( s0, s1, s2, s3, s4, s5, s6, s7 :T_cl_ushort; );
       3:( lo, hi :T_cl_ushort4; );
{$ENDIF}
{$IF Defined( __CL_USHORT2__ ) }
       4:( v2 :array [ 0..4-1 ] of T__cl_ushort2; );
{$ENDIF}
{$IF Defined( __CL_USHORT4__ ) }
       5:( v4 :array [ 0..2-1 ] of T__cl_ushort4; );
{$ENDIF}
{$IF Defined( __CL_USHORT8__ ) }
       6:( v8 :T__cl_ushort8; );
{$ENDIF}
     end;

type T_cl_ushort16 = packed record
     case Integer of
       0:( s :array [ 0..16-1 ] of T_cl_ushort; );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1:( x, y, z, w, __spacer4, __spacer5, __spacer6, __spacer7, __spacer8, __spacer9, sa, sb, sc, sd, se, sf :T_cl_ushort; );
       2:( s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, sA, sB, sC, sD, sE, sF :T_cl_ushort; );
       3:( lo, hi :T_cl_ushort8; );
{$ENDIF}
{$IF Defined( __CL_USHORT2__ ) }
       4:( v2 :array [ 0..8-1 ] of T__cl_ushort2; );
{$ENDIF}
{$IF Defined( __CL_USHORT4__ ) }
       5:( v4 :array [ 0..4-1 ] of T__cl_ushort4; );
{$ENDIF}
{$IF Defined( __CL_USHORT8__ ) }
       6:( v8 :array [ 0..2-1 ] of T__cl_ushort8; );
{$ENDIF}
{$IF Defined( __CL_USHORT16__ ) }
       7:( v16 :T__cl_ushort16; );
{$ENDIF}
     end;

(* ---- cl_intn ---- *)
type T_cl_int2 = packed record
     case Integer of
       0:( s :array [ 0..2-1 ] of T_cl_int; );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1:( x, y :T_cl_int; );
       2:( s0, s1 :T_cl_int; );
       3:( lo, hi :T_cl_int; );
{$ENDIF}
{$IF Defined( __CL_INT2__ ) }
       4:( v2 :T__cl_int2; );
{$ENDIF}
     end;

type T_cl_int4 = packed record
     case Integer of
       0:( s :array [ 0..4-1 ] of T_cl_int; );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1:( x, y, z, w :T_cl_int; );
       2:( s0, s1, s2, s3 :T_cl_int; );
       3:( lo, hi :T_cl_int2; );
{$ENDIF}
{$IF Defined( __CL_INT2__ ) }
       4:( v2 :array [ 0..2-1 ] of T__cl_int2; );
{$ENDIF}
{$IF Defined( __CL_INT4__ ) }
       5:( v4 :T__cl_int4; );
{$ENDIF}
     end;

(* cl_int3 is identical in size, alignment and behavior to cl_int4. See section 6.1.5. *)
type T_cl_int3 = T_cl_int4;

type T_cl_int8 = packed record
     case Integer of
       0:( s :array [ 0..8-1 ] of T_cl_int; );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1:( x, y, z, w :T_cl_int; );
       2:( s0, s1, s2, s3, s4, s5, s6, s7 :T_cl_int; );
       3:( lo, hi :T_cl_int4; );
{$ENDIF}
{$IF Defined( __CL_INT2__ ) }
       4:( v2 :array [ 0..4-1 ] of T__cl_int2; );
{$ENDIF}
{$IF Defined( __CL_INT4__ ) }
       5:( v4 :array [ 0..2-1 ] of T__cl_int4; );
{$ENDIF}
{$IF Defined( __CL_INT8__ ) }
       6:( v8 :T__cl_int8; );
{$ENDIF}
     end;

type T_cl_int16 = packed record
     case Integer of
       0:( s :array [ 0..16-1 ] of T_cl_int; );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1:( x, y, z, w, __spacer4, __spacer5, __spacer6, __spacer7, __spacer8, __spacer9, sa, sb, sc, sd, se, sf :T_cl_int; );
       2:( s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, sA, sB, sC, sD, sE, sF :T_cl_int; );
       3:( lo, hi :T_cl_int8; );
{$ENDIF}
{$IF Defined( __CL_INT2__ ) }
       4:( v2 :array [ 0..8-1 ] of T__cl_int2; );
{$ENDIF}
{$IF Defined( __CL_INT4__ ) }
       5:( v4 :array [ 0..4-1 ] of T__cl_int4; );
{$ENDIF}
{$IF Defined( __CL_INT8__ ) }
       6:( v8 :array [ 0..2-1 ] of T__cl_int8; );
{$ENDIF}
{$IF Defined( __CL_INT16__ ) }
       7:( v16 :T__cl_int16; );
{$ENDIF}
     end;

(* ---- cl_uintn ---- *)
type T_cl_uint2 = packed record
     case Integer of
       0:( s :array [ 0..2-1 ] of T_cl_uint; );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1:( x, y :T_cl_uint; );
       2:( s0, s1 :T_cl_uint; );
       3:( lo, hi :T_cl_uint; );
{$ENDIF}
{$IF Defined( __CL_UINT2__ ) }
       4:( v2 :T__cl_uint2; );
{$ENDIF}
     end;

type T_cl_uint4 = packed record
     case Integer of
       0:( s :array [ 0..4-1 ] of T_cl_uint; );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1:( x, y, z, w :T_cl_uint; );
       2:( s0, s1, s2, s3 :T_cl_uint; );
       3:( lo, hi :T_cl_uint2; );
{$ENDIF}
{$IF Defined( __CL_UINT2__ ) }
       4:( v2 :array [ 0..2-1 ] of T__cl_uint2; );
{$ENDIF}
{$IF Defined( __CL_UINT4__ ) }
       5:( v4 :T__cl_uint4; );
{$ENDIF}
     end;

(* cl_uint3 is identical in size, alignment and behavior to cl_uint4. See section 6.1.5. *)
type T_cl_uint3 = T_cl_uint4;

type T_cl_uint8 = packed record
     case Integer of
       0:( s :array [ 0..8-1 ] of T_cl_uint; );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1:( x, y, z, w :T_cl_uint; );
       2:( s0, s1, s2, s3, s4, s5, s6, s7 :T_cl_uint; );
       3:( lo, hi :T_cl_uint4; );
{$ENDIF}
{$IF Defined( __CL_UINT2__ ) }
       4:( v2 :array [ 0..4-1 ] of T__cl_uint2; );
{$ENDIF}
{$IF Defined( __CL_UINT4__ ) }
       5:( v4 :array [ 0..2-1 ] of T__cl_uint4; );
{$ENDIF}
{$IF Defined( __CL_UINT8__ ) }
       6:( v8 :T__cl_uint8; );
{$ENDIF}
     end;

type T_cl_uint16 = packed record
     case Integer of
       0:( s :array [ 0..16-1 ] of T_cl_uint; );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1:( x, y, z, w, __spacer4, __spacer5, __spacer6, __spacer7, __spacer8, __spacer9, sa, sb, sc, sd, se, sf :T_cl_uint; );
       2:( s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, sA, sB, sC, sD, sE, sF :T_cl_uint; );
       3:( lo, hi :T_cl_uint8; );
{$ENDIF}
{$IF Defined( __CL_UINT2__ ) }
       4:( v2 :array [ 0..8-1 ] of T__cl_uint2; );
{$ENDIF}
{$IF Defined( __CL_UINT4__ ) }
       5:( v4 :array [ 0..4-1 ] of T__cl_uint4; );
{$ENDIF}
{$IF Defined( __CL_UINT8__ ) }
       6:( v8 :array [ 0..2-1 ] of T__cl_uint8; );
{$ENDIF}
{$IF Defined( __CL_UINT16__ ) }
       7:( v16 :T__cl_uint16; );
{$ENDIF}
     end;

(* ---- cl_longn ---- *)
type T_cl_long2 = packed record
     case Integer of
       0:( s :array [ 0..2-1 ] of T_cl_long; );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1:( x, y :T_cl_long; );
       2:( s0, s1 :T_cl_long; );
       3:( lo, hi :T_cl_long; );
{$ENDIF}
{$IF Defined( __CL_LONG2__ ) }
       4:( v2 :T__cl_long2; );
{$ENDIF}
     end;

type T_cl_long4 = packed record
     case Integer of
       0:( s :array [ 0..4-1 ] of T_cl_long; );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1:( x, y, z, w :T_cl_long; );
       2:( s0, s1, s2, s3 :T_cl_long; );
       3:( lo, hi :T_cl_long2; );
{$ENDIF}
{$IF Defined( __CL_LONG2__ ) }
       4:( v2 :array [ 0..2-1 ] of T__cl_long2; );
{$ENDIF}
{$IF Defined( __CL_LONG4__ ) }
       5:( v4 :T__cl_long4; );
{$ENDIF}
     end;

(* cl_long3 is identical in size, alignment and behavior to cl_long4. See section 6.1.5. *)
type T_cl_long3 = T_cl_long4;

type T_cl_long8 = packed record
     case Integer of
       0:( s :array [ 0..8-1 ] of T_cl_long; );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1:( x, y, z, w :T_cl_long; );
       2:( s0, s1, s2, s3, s4, s5, s6, s7 :T_cl_long; );
       3:( lo, hi :T_cl_long4; );
{$ENDIF}
{$IF Defined( __CL_LONG2__ ) }
       4:( v2 :array [ 0..4-1 ] of T__cl_long2; );
{$ENDIF}
{$IF Defined( __CL_LONG4__ ) }
       5:( v4 :array [ 0..2-1 ] of T__cl_long4; );
{$ENDIF}
{$IF Defined( __CL_LONG8__ ) }
       6:( v8 :T__cl_long8; );
{$ENDIF}
     end;

type T_cl_long16 = packed record
     case Integer of
       0:( s :array [ 0..16-1 ] of T_cl_long; );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1:( x, y, z, w, __spacer4, __spacer5, __spacer6, __spacer7, __spacer8, __spacer9, sa, sb, sc, sd, se, sf :T_cl_long; );
       2:( s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, sA, sB, sC, sD, sE, sF :T_cl_long; );
       3:( lo, hi :T_cl_long8; );
{$ENDIF}
{$IF Defined( __CL_LONG2__ ) }
       4:( v2 :array [ 0..8-1 ] of T__cl_long2; );
{$ENDIF}
{$IF Defined( __CL_LONG4__ ) }
       5:( v4 :array [ 0..4-1 ] of T__cl_long4; );
{$ENDIF}
{$IF Defined( __CL_LONG8__ ) }
       6:( v8 :array [ 0..2-1 ] of T__cl_long8; );
{$ENDIF}
{$IF Defined( __CL_LONG16__ ) }
       7:( v16 :T__cl_long16; );
{$ENDIF}
     end;

(* ---- cl_ulongn ---- *)
type T_cl_ulong2 = packed record
     case Integer of
       0:( s :array [ 0..2-1 ] of T_cl_ulong; );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1:( x, y :T_cl_ulong; );
       2:( s0, s1 :T_cl_ulong; );
       3:( lo, hi :T_cl_ulong; );
{$ENDIF}
{$IF Defined( __CL_ULONG2__ ) }
       4:( v2 :T__cl_ulong2; );
{$ENDIF}
     end;

type T_cl_ulong4 = packed record
     case Integer of
       0:( s :array [ 0..4-1 ] of T_cl_ulong; );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1:( x, y, z, w :T_cl_ulong; );
       2:( s0, s1, s2, s3 :T_cl_ulong; );
       3:( lo, hi :T_cl_ulong2; );
{$ENDIF}
{$IF Defined( __CL_ULONG2__ ) }
       4:( v2 :array [ 0..2-1 ] of T__cl_ulong2; );
{$ENDIF}
{$IF Defined( __CL_ULONG4__ ) }
       5:( v4 :T__cl_ulong4; );
{$ENDIF}
     end;

(* cl_ulong3 is identical in size, alignment and behavior to cl_ulong4. See section 6.1.5. *)
type T_cl_ulong3 = T_cl_ulong4;

type T_cl_ulong8 = packed record
     case Integer of
       0:( s :array [ 0..8-1 ] of T_cl_ulong; );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1:( x, y, z, w :T_cl_ulong; );
       2:( s0, s1, s2, s3, s4, s5, s6, s7 :T_cl_ulong; );
       3:( lo, hi :T_cl_ulong4; );
{$ENDIF}
{$IF Defined( __CL_ULONG2__ ) }
       4:( v2 :array [ 0..4-1 ] of T__cl_ulong2; );
{$ENDIF}
{$IF Defined( __CL_ULONG4__ ) }
       5:( v4 :array [ 0..2-1 ] of T__cl_ulong4; );
{$ENDIF}
{$IF Defined( __CL_ULONG8__ ) }
       6:( v8 :T__cl_ulong8; );
{$ENDIF}
     end;

type T_cl_ulong16 = packed record
     case Integer of
       0:( s :array [ 0..16-1 ] of T_cl_ulong; );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1:( x, y, z, w, __spacer4, __spacer5, __spacer6, __spacer7, __spacer8, __spacer9, sa, sb, sc, sd, se, sf :T_cl_ulong; );
       2:( s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, sA, sB, sC, sD, sE, sF :T_cl_ulong; );
       3:( lo, hi :T_cl_ulong8; );
{$ENDIF}
{$IF Defined( __CL_ULONG2__ ) }
       4:( v2 :array [ 0..8-1 ] of T__cl_ulong2; );
{$ENDIF}
{$IF Defined( __CL_ULONG4__ ) }
       5:( v4 :array [ 0..4-1 ] of T__cl_ulong4; );
{$ENDIF}
{$IF Defined( __CL_ULONG8__ ) }
       6:( v8 :array [ 0..2-1 ] of T__cl_ulong8; );
{$ENDIF}
{$IF Defined( __CL_ULONG16__ ) }
       7:( v16 :T__cl_ulong16; );
{$ENDIF}
     end;

(* --- cl_floatn ---- *)

type T_cl_float2 = packed record
     case Integer of
       0:( s :array [ 0..2-1 ] of T_cl_float; );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1:( x, y :T_cl_float; );
       2:( s0, s1 :T_cl_float; );
       3:( lo, hi :T_cl_float; );
{$ENDIF}
{$IF Defined( __CL_FLOAT2__ ) }
       4:( v2 :T__cl_float2; );
{$ENDIF}
     end;

type T_cl_float4 = packed record
     case Integer of
       0:( s :array [ 0..4-1 ] of T_cl_float; );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1:( x, y, z, w :T_cl_float; );
       2:( s0, s1, s2, s3 :T_cl_float; );
       3:( lo, hi :T_cl_float2; );
{$ENDIF}
{$IF Defined( __CL_FLOAT2__ ) }
       4:( v2 :array [ 0..2-1 ] of T__cl_float2; );
{$ENDIF}
{$IF Defined( __CL_FLOAT4__ ) }
       5:( v4 :T__cl_float4; );
{$ENDIF}
     end;

(* cl_float3 is identical in size, alignment and behavior to cl_float4. See section 6.1.5. *)
type T_cl_float3 = T_cl_float4;

type T_cl_float8 = packed record
     case Integer of
       0:( s :array [ 0..8-1 ] of T_cl_float; );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1:( x, y, z, w :T_cl_float; );
       2:( s0, s1, s2, s3, s4, s5, s6, s7 :T_cl_float; );
       3:( lo, hi :T_cl_float4; );
{$ENDIF}
{$IF Defined( __CL_FLOAT2__ ) }
       4:( v2 :array [ 0..4-1 ] of T__cl_float2; );
{$ENDIF}
{$IF Defined( __CL_FLOAT4__ ) }
       5:( v4 :array [ 0..2-1 ] of T__cl_float4; );
{$ENDIF}
{$IF Defined( __CL_FLOAT8__ ) }
       6:( v8 :T__cl_float8; );
{$ENDIF}
     end;

type T_cl_float16 = packed record
     case Integer of
       0:( s :array [ 0..16-1 ] of T_cl_float; );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1:( x, y, z, w, __spacer4, __spacer5, __spacer6, __spacer7, __spacer8, __spacer9, sa, sb, sc, sd, se, sf :T_cl_float; );
       2:( s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, sA, sB, sC, sD, sE, sF :T_cl_float; );
       3:( lo, hi :T_cl_float8; );
{$ENDIF}
{$IF Defined( __CL_FLOAT2__ ) }
       4:( v2 :array [ 0..8-1 ] of T__cl_float2; );
{$ENDIF}
{$IF Defined( __CL_FLOAT4__ ) }
       5:( v4 :array [ 0..4-1 ] of T__cl_float4; );
{$ENDIF}
{$IF Defined( __CL_FLOAT8__ ) }
       6:( v8 :array [ 0..2-1 ] of T__cl_float8; );
{$ENDIF}
{$IF Defined( __CL_FLOAT16__ ) }
       7:( v16 :T__cl_float16; );
{$ENDIF}
     end;

(* --- cl_doublen ---- *)

type T_cl_double2 = packed record
     case Integer of
       0:( s :array [ 0..2-1 ] of T_cl_double; );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1:( x, y :T_cl_double; );
       2:( s0, s1 :T_cl_double; );
       3:( lo, hi :T_cl_double; );
{$ENDIF}
{$IF Defined( __CL_DOUBLE2__ ) }
       4:( v2 :T__cl_double2; );
{$ENDIF}
     end;

type T_cl_double4 = packed record
     case Integer of
       0:( s :array [ 0..4-1 ] of T_cl_double; );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1:( x, y, z, w :T_cl_double; );
       2:( s0, s1, s2, s3 :T_cl_double; );
       3:( lo, hi :T_cl_double2; );
{$ENDIF}
{$IF Defined( __CL_DOUBLE2__ ) }
       4:( v2 :array [ 0..2-1 ] of T__cl_double2; );
{$ENDIF}
{$IF Defined( __CL_DOUBLE4__ ) }
       5:( v4 :T__cl_double4; );
{$ENDIF}
     end;

(* cl_double3 is identical in size, alignment and behavior to cl_double4. See section 6.1.5. *)
type T_cl_double3 = T_cl_double4;

type T_cl_double8 = packed record
     case Integer of
       0:( s :array [ 0..8-1 ] of T_cl_double; );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1:( x, y, z, w :T_cl_double; );
       2:( s0, s1, s2, s3, s4, s5, s6, s7 :T_cl_double; );
       3:( lo, hi :T_cl_double4; );
{$ENDIF}
{$IF Defined( __CL_DOUBLE2__ ) }
       4:( v2 :array [ 0..4-1 ] of T__cl_double2; );
{$ENDIF}
{$IF Defined( __CL_DOUBLE4__ ) }
       5:( v4 :array [ 0..2-1 ] of T__cl_double4; );
{$ENDIF}
{$IF Defined( __CL_DOUBLE8__ ) }
       6:( v8 :T__cl_double8; );
{$ENDIF}
     end;

type T_cl_double16 = packed record
     case Integer of
       0:( s :array [ 0..16-1 ] of T_cl_double; );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1:( x, y, z, w, __spacer4, __spacer5, __spacer6, __spacer7, __spacer8, __spacer9, sa, sb, sc, sd, se, sf :T_cl_double; );
       2:( s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, sA, sB, sC, sD, sE, sF :T_cl_double; );
       3:( lo, hi :T_cl_double8; );
{$ENDIF}
{$IF Defined( __CL_DOUBLE2__ ) }
       4:( v2 :array [ 0..8-1 ] of T__cl_double2; );
{$ENDIF}
{$IF Defined( __CL_DOUBLE4__ ) }
       5:( v4 :array [ 0..4-1 ] of T__cl_double4; );
{$ENDIF}
{$IF Defined( __CL_DOUBLE8__ ) }
       6:( v8 :array [ 0..2-1 ] of T__cl_double8; );
{$ENDIF}
{$IF Defined( __CL_DOUBLE16__ ) }
       7:( v16 :T__cl_double16; );
{$ENDIF}
     end;

(* Macro to facilitate debugging
 * Usage:
 *   Place CL_PROGRAM_STRING_DEBUG_INFO on the line before the first line of your source. 
 *   The first line ends with:   CL_PROGRAM_STRING_DEBUG_INFO \"
 *   Each line thereafter of OpenCL C source must end with: \n\
 *   The last line ends in ";
 *
 *   Example:
 *
 *   const char *my_program = CL_PROGRAM_STRING_DEBUG_INFO "\
 *   kernel void foo( int a, float * b )             \n\
 *   {                                               \n\
 *      // my comment                                \n\
 *      *b[ get_global_id(0)] = a;                   \n\
 *   }                                               \n\
 *   ";
 *
 * This should correctly set up the line, (column) and file information for your source 
 * string so you can do source level debugging.
 *)
/////#define  __CL_STRINGIFY( _x )               # _x
/////#define  _CL_STRINGIFY( _x )                __CL_STRINGIFY( _x )
/////#define  CL_PROGRAM_STRING_DEBUG_INFO       "#line "  _CL_STRINGIFY(__LINE__) " \"" __FILE__ "\" \n\n"

implementation //############################################################### Å°

end. //######################################################################### Å°
