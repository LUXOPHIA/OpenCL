unit cl_platform;

(*******************************************************************************
 * Copyright (c) 2008-2020 The Khronos Group Inc.
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

uses LUX.Code.C,
     cl_version;

//#ifdef __cplusplus
//extern "C" {
//#endif

//{$IF defined( _WIN32 ) }
//    #if !defined(CL_API_ENTRY)
//        #define CL_API_ENTRY
//    #endif
//    #if !defined(CL_API_CALL)
//        #define CL_API_CALL     __stdcall
//    #endif
//    #if !defined(CL_CALLBACK)
//        #define CL_CALLBACK     __stdcall
//    #endif
//{$ELSE}
//    #if !defined(CL_API_ENTRY)
//        #define CL_API_ENTRY
//    #endif
//    #if !defined(CL_API_CALL)
//        #define CL_API_CALL
//    #endif
//    #if !defined(CL_CALLBACK)
//        #define CL_CALLBACK
//    #endif
//{$ENDIF}

(*
 * Deprecation flags refer to the last version of the header in which the
 * feature was not deprecated.
 *
 * E.g. VERSION_1_1_DEPRECATED means the feature is present in 1.1 without
 * deprecation but is deprecated in versions later than 1.1.
 *)

//#ifndef CL_API_SUFFIX_USER
//#define CL_API_SUFFIX_USER
//#endif

//#ifndef CL_API_PREFIX_USER
//#define CL_API_PREFIX_USER
//#endif

//#define CL_API_SUFFIX_COMMON CL_API_SUFFIX_USER
//#define CL_API_PREFIX_COMMON CL_API_PREFIX_USER

//#define CL_API_SUFFIX__VERSION_1_0 CL_API_SUFFIX_COMMON
//#define CL_API_SUFFIX__VERSION_1_1 CL_API_SUFFIX_COMMON
//#define CL_API_SUFFIX__VERSION_1_2 CL_API_SUFFIX_COMMON
//#define CL_API_SUFFIX__VERSION_2_0 CL_API_SUFFIX_COMMON
//#define CL_API_SUFFIX__VERSION_2_1 CL_API_SUFFIX_COMMON
//#define CL_API_SUFFIX__VERSION_2_2 CL_API_SUFFIX_COMMON
//#define CL_API_SUFFIX__VERSION_3_0 CL_API_SUFFIX_COMMON
//#define CL_API_SUFFIX__EXPERIMENTAL CL_API_SUFFIX_COMMON


//#ifdef __GNUC__
//  #define CL_API_SUFFIX_DEPRECATED __attribute__((deprecated))
//  #define CL_API_PREFIX_DEPRECATED
//#elif defined(_WIN32)
//  #define CL_API_SUFFIX_DEPRECATED
//  #define CL_API_PREFIX_DEPRECATED __declspec(deprecated)
//#else
//  #define CL_API_SUFFIX_DEPRECATED
//  #define CL_API_PREFIX_DEPRECATED
//#endif

//#ifdef CL_USE_DEPRECATED_OPENCL_1_0_APIS
//    #define CL_API_SUFFIX__VERSION_1_0_DEPRECATED CL_API_SUFFIX_COMMON
//    #define CL_API_PREFIX__VERSION_1_0_DEPRECATED CL_API_PREFIX_COMMON
//#else
//    #define CL_API_SUFFIX__VERSION_1_0_DEPRECATED CL_API_SUFFIX_COMMON CL_API_SUFFIX_DEPRECATED
//    #define CL_API_PREFIX__VERSION_1_0_DEPRECATED CL_API_PREFIX_COMMON CL_API_PREFIX_DEPRECATED
//#endif

//#ifdef CL_USE_DEPRECATED_OPENCL_1_1_APIS
//    #define CL_API_SUFFIX__VERSION_1_1_DEPRECATED CL_API_SUFFIX_COMMON
//    #define CL_API_PREFIX__VERSION_1_1_DEPRECATED CL_API_PREFIX_COMMON
//#else
//    #define CL_API_SUFFIX__VERSION_1_1_DEPRECATED CL_API_SUFFIX_COMMON CL_API_SUFFIX_DEPRECATED
//    #define CL_API_PREFIX__VERSION_1_1_DEPRECATED CL_API_PREFIX_COMMON CL_API_PREFIX_DEPRECATED
//#endif

//#ifdef CL_USE_DEPRECATED_OPENCL_1_2_APIS
//    #define CL_API_SUFFIX__VERSION_1_2_DEPRECATED CL_API_SUFFIX_COMMON
//    #define CL_API_PREFIX__VERSION_1_2_DEPRECATED CL_API_PREFIX_COMMON
//#else
//    #define CL_API_SUFFIX__VERSION_1_2_DEPRECATED CL_API_SUFFIX_COMMON CL_API_SUFFIX_DEPRECATED
//    #define CL_API_PREFIX__VERSION_1_2_DEPRECATED CL_API_PREFIX_COMMON CL_API_PREFIX_DEPRECATED
//#endif

//#ifdef CL_USE_DEPRECATED_OPENCL_2_0_APIS
//    #define CL_API_SUFFIX__VERSION_2_0_DEPRECATED CL_API_SUFFIX_COMMON
//    #define CL_API_PREFIX__VERSION_2_0_DEPRECATED CL_API_PREFIX_COMMON
//#else
//    #define CL_API_SUFFIX__VERSION_2_0_DEPRECATED CL_API_SUFFIX_COMMON CL_API_SUFFIX_DEPRECATED
//    #define CL_API_PREFIX__VERSION_2_0_DEPRECATED CL_API_PREFIX_COMMON CL_API_PREFIX_DEPRECATED
//#endif

//#ifdef CL_USE_DEPRECATED_OPENCL_2_1_APIS
//    #define CL_API_SUFFIX__VERSION_2_1_DEPRECATED CL_API_SUFFIX_COMMON
//    #define CL_API_PREFIX__VERSION_2_1_DEPRECATED CL_API_PREFIX_COMMON
//#else
//    #define CL_API_SUFFIX__VERSION_2_1_DEPRECATED CL_API_SUFFIX_COMMON CL_API_SUFFIX_DEPRECATED
//    #define CL_API_PREFIX__VERSION_2_1_DEPRECATED CL_API_PREFIX_COMMON CL_API_PREFIX_DEPRECATED
//#endif

//#ifdef CL_USE_DEPRECATED_OPENCL_2_2_APIS
//    #define CL_API_SUFFIX__VERSION_2_2_DEPRECATED CL_API_SUFFIX_COMMON
//    #define CL_API_PREFIX__VERSION_2_2_DEPRECATED CL_API_PREFIX_COMMON
//#else
//    #define CL_API_SUFFIX__VERSION_2_2_DEPRECATED CL_API_SUFFIX_COMMON CL_API_SUFFIX_DEPRECATED
//    #define CL_API_PREFIX__VERSION_2_2_DEPRECATED CL_API_PREFIX_COMMON CL_API_PREFIX_DEPRECATED
//#endif

{$IF defined( _WIN32 ) and defined( _MSC_VER ) }

{$IF Defined( __clang__ ) }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wlanguage-extension-token"
{$ENDIF}

(* intptr_t is used in cl.h and provided by stddef.h in Visual C++, but not in clang *)
(* stdint.h was missing before Visual Studio 2010, include it for later versions and for clang *)
//#if defined(__clang__) || _MSC_VER >= 1600
//    #include <stdint.h>
//#endif

(* scalar types  *)
type T_cl_char   = T_signed___int8;
type T_cl_uchar  = T_unsigned___int8;
type T_cl_short  = T_signed___int16;
type T_cl_ushort = T_unsigned___int16;
type T_cl_int    = T_signed___int32;
type T_cl_uint   = T_unsigned___int32;
type T_cl_long   = T_signed___int64;
type T_cl_ulong  = T_unsigned___int64;

type T_cl_half   = T_unsigned___int16;
type T_cl_float  = T_float;
type T_cl_double = T_double;

{$IF Defined( __clang__ ) }
#pragma clang diagnostic pop
{$ENDIF}

(* Macro names and corresponding values defined by OpenCL *)
const CL_CHAR_BIT         = 8;
const CL_SCHAR_MAX        = 127;
const CL_SCHAR_MIN        = -127 - 1;
const CL_CHAR_MAX         = CL_SCHAR_MAX;
const CL_CHAR_MIN         = CL_SCHAR_MIN;
const CL_UCHAR_MAX        = 255;
const CL_SHRT_MAX         = 32767;
const CL_SHRT_MIN         = -32767 - 1;
const CL_USHRT_MAX        = 65535;
const CL_INT_MAX          = 2147483647;
const CL_INT_MIN          = -2147483647 - 1;
const CL_UINT_MAX         = $ffffffff;
const CL_LONG_MAX         = T_cl_long( $7FFFFFFFFFFFFFFF );
const CL_LONG_MIN         = T_cl_long( -$7FFFFFFFFFFFFFFF - 1 );
const CL_ULONG_MAX        = T_cl_ulong( $FFFFFFFFFFFFFFFF );

const CL_FLT_DIG          = 6;
const CL_FLT_MANT_DIG     = 24;
const CL_FLT_MAX_10_EXP   = +38;
const CL_FLT_MAX_EXP      = +128;
const CL_FLT_MIN_10_EXP   = -37;
const CL_FLT_MIN_EXP      = -125;
const CL_FLT_RADIX        = 2;
const CL_FLT_MAX          = 340282346638528859811704183484516925440.0;
const CL_FLT_MIN          = 1.175494350822287507969e-38;
const CL_FLT_EPSILON      = 1.1920928955078125e-7;

const CL_HALF_DIG          = 3;
const CL_HALF_MANT_DIG     = 11;
const CL_HALF_MAX_10_EXP   = +4;
const CL_HALF_MAX_EXP      = +16;
const CL_HALF_MIN_10_EXP   = -4;
const CL_HALF_MIN_EXP      = -13;
const CL_HALF_RADIX        = 2;
const CL_HALF_MAX          = 65504.0;
const CL_HALF_MIN          = 6.103515625e-05;
const CL_HALF_EPSILON      = 9.765625e-04;

const CL_DBL_DIG          = 15;
const CL_DBL_MANT_DIG     = 53;
const CL_DBL_MAX_10_EXP   = +308;
const CL_DBL_MAX_EXP      = +1024;
const CL_DBL_MIN_10_EXP   = -307;
const CL_DBL_MIN_EXP      = -1021;
const CL_DBL_RADIX        = 2;
const CL_DBL_MAX          = 1.7976931348623158e+308;
const CL_DBL_MIN          = 2.225073858507201383090e-308;
const CL_DBL_EPSILON      = 2.220446049250313080847e-16;

const CL_M_E              = 2.7182818284590452354;
const CL_M_LOG2E          = 1.4426950408889634074;
const CL_M_LOG10E         = 0.43429448190325182765;
const CL_M_LN2            = 0.69314718055994530942;
const CL_M_LN10           = 2.30258509299404568402;
const CL_M_PI             = 3.14159265358979323846;
const CL_M_PI_2           = 1.57079632679489661923;
const CL_M_PI_4           = 0.78539816339744830962;
const CL_M_1_PI           = 0.31830988618379067154;
const CL_M_2_PI           = 0.63661977236758134308;
const CL_M_2_SQRTPI       = 1.12837916709551257390;
const CL_M_SQRT2          = 1.41421356237309504880;
const CL_M_SQRT1_2        = 0.70710678118654752440;

const CL_M_E_F            = 2.718281828;
const CL_M_LOG2E_F        = 1.442695041;
const CL_M_LOG10E_F       = 0.434294482;
const CL_M_LN2_F          = 0.693147181;
const CL_M_LN10_F         = 2.302585093;
const CL_M_PI_F           = 3.141592654;
const CL_M_PI_2_F         = 1.570796327;
const CL_M_PI_4_F         = 0.785398163;
const CL_M_1_PI_F         = 0.318309886;
const CL_M_2_PI_F         = 0.636619772;
const CL_M_2_SQRTPI_F     = 1.128379167;
const CL_M_SQRT2_F        = 1.414213562;
const CL_M_SQRT1_2_F      = 0.707106781;

const CL_NAN              = CL_INFINITY - CL_INFINITY;
const CL_HUGE_VALF        = T_cl_float( 1e50 );
const CL_HUGE_VAL         = T_cl_double( 1e500 );
const CL_MAXFLOAT         = CL_FLT_MAX;
const CL_INFINITY         = CL_HUGE_VALF;

{$ELSE}

//#include <stdint.h>

(* scalar types  *)
type T_cl_char   = T_int8_t  ;  P_cl_char   = ^T_cl_char  ;
type T_cl_uchar  = T_uint8_t ;  P_cl_uchar  = ^T_cl_uchar ;
type T_cl_short  = T_int16_t ;  P_cl_short  = ^T_cl_short ;
type T_cl_ushort = T_uint16_t;  P_cl_ushort = ^T_cl_ushort;
type T_cl_int    = T_int32_t ;  P_cl_int    = ^T_cl_int   ;
type T_cl_uint   = T_uint32_t;  P_cl_uint   = ^T_cl_uint  ;
type T_cl_long   = T_int64_t ;  P_cl_long   = ^T_cl_long  ;
type T_cl_ulong  = T_uint64_t;  P_cl_ulong  = ^T_cl_ulong ;

type T_cl_half   = T_uint16_t;  P_cl_half   = ^T_cl_half  ;
type T_cl_float  = T_float   ;  P_cl_float  = ^T_cl_float ;
type T_cl_double = T_double  ;  P_cl_double = ^T_cl_double;

(* Macro names and corresponding values defined by OpenCL *)
const CL_CHAR_BIT         = 8;
const CL_SCHAR_MAX        = 127;
const CL_SCHAR_MIN        = -127 - 1;
const CL_CHAR_MAX         = CL_SCHAR_MAX;
const CL_CHAR_MIN         = CL_SCHAR_MIN;
const CL_UCHAR_MAX        = 255;
const CL_SHRT_MAX         = 32767;
const CL_SHRT_MIN         = -32767 - 1;
const CL_USHRT_MAX        = 65535;
const CL_INT_MAX          = 2147483647;
const CL_INT_MIN          = -2147483647 - 1;
const CL_UINT_MAX         = $ffffffff;
const CL_LONG_MAX         = T_cl_long( $7FFFFFFFFFFFFFFF );
const CL_LONG_MIN         = T_cl_long( -$7FFFFFFFFFFFFFFF - 1 );
const CL_ULONG_MAX        = T_cl_ulong( $FFFFFFFFFFFFFFFF );

const CL_FLT_DIG          = 6;
const CL_FLT_MANT_DIG     = 24;
const CL_FLT_MAX_10_EXP   = +38;
const CL_FLT_MAX_EXP      = +128;
const CL_FLT_MIN_10_EXP   = -37;
const CL_FLT_MIN_EXP      = -125;
const CL_FLT_RADIX        = 2;
const CL_FLT_MAX          = 340282346638528859811704183484516925440.0;
const CL_FLT_MIN          = 1.175494350822287507969e-38;
const CL_FLT_EPSILON      = 1.1920928955078125e-7;

const CL_HALF_DIG          = 3;
const CL_HALF_MANT_DIG     = 11;
const CL_HALF_MAX_10_EXP   = +4;
const CL_HALF_MAX_EXP      = +16;
const CL_HALF_MIN_10_EXP   = -4;
const CL_HALF_MIN_EXP      = -13;
const CL_HALF_RADIX        = 2;
const CL_HALF_MAX          = 65504.0;
const CL_HALF_MIN          = 6.103515625e-05;
const CL_HALF_EPSILON      = 9.765625e-04;

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

const CL_M_E              = 2.7182818284590452354;
const CL_M_LOG2E          = 1.4426950408889634074;
const CL_M_LOG10E         = 0.43429448190325182765;
const CL_M_LN2            = 0.69314718055994530942;
const CL_M_LN10           = 2.30258509299404568402;
const CL_M_PI             = 3.14159265358979323846;
const CL_M_PI_2           = 1.57079632679489661923;
const CL_M_PI_4           = 0.78539816339744830962;
const CL_M_1_PI           = 0.31830988618379067154;
const CL_M_2_PI           = 0.63661977236758134308;
const CL_M_2_SQRTPI       = 1.12837916709551257390;
const CL_M_SQRT2          = 1.41421356237309504880;
const CL_M_SQRT1_2        = 0.70710678118654752440;

const CL_M_E_F            = 2.718281828;
const CL_M_LOG2E_F        = 1.442695041;
const CL_M_LOG10E_F       = 0.434294482;
const CL_M_LN2_F          = 0.693147181;
const CL_M_LN10_F         = 2.302585093;
const CL_M_PI_F           = 3.141592654;
const CL_M_PI_2_F         = 1.570796327;
const CL_M_PI_4_F         = 0.785398163;
const CL_M_1_PI_F         = 0.318309886;
const CL_M_2_PI_F         = 0.636619772;
const CL_M_2_SQRTPI_F     = 1.128379167;
const CL_M_SQRT2_F        = 1.414213562;
const CL_M_SQRT1_2_F      = 0.707106781;

{$IF defined( __GNUC__ ) }
    const CL_HUGE_VALF     = __builtin_huge_valf();
    const CL_HUGE_VAL      = __builtin_huge_val();
    const CL_NAN           = __builtin_nanf( "" );
{$ELSE}
    const CL_HUGE_VALF     = T_cl_float( 1e50 );
    const CL_HUGE_VAL      = T_cl_double( 1e500 );
//    float nanf( const char * );
    const CL_NAN           = 0/0;
{$ENDIF}
const CL_MAXFLOAT         = CL_FLT_MAX;
const CL_INFINITY         = CL_HUGE_VALF;

{$ENDIF}

//#include <stddef.h>

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
{$IF defined( __VEC__ ) }
  #if !defined(__clang__)
     #include <altivec.h>   /* may be omitted depending on compiler. AltiVec spec provides no way to detect whether the header is required. */
  #endif
    typedef __vector unsigned char     __cl_uchar16;
    typedef __vector signed char       __cl_char16;
    typedef __vector unsigned short    __cl_ushort8;
    typedef __vector signed short      __cl_short8;
    typedef __vector unsigned int      __cl_uint4;
    typedef __vector signed int        __cl_int4;
    typedef __vector float             __cl_float4;
    const __CL_UCHAR16__  = 1;
    const __CL_CHAR16__   = 1;
    const __CL_USHORT8__  = 1;
    const __CL_SHORT8__   = 1;
    const __CL_UINT4__    = 1;
    const __CL_INT4__     = 1;
    const __CL_FLOAT4__   = 1;
{$ENDIF}

{$IF defined( __SSE__ ) }
    {$IF defined( __MINGW64__ ) }
        #include <intrin.h>
    {$ELSE}
        #include <xmmintrin.h>
    {$ENDIF}
    {$IF defined( __GNUC__ ) }
        typedef float __cl_float4   __attribute__((vector_size(16)));
    {$ELSE}
        type T___cl_float4 = T___m128;
    {$ENDIF}
    const __CL_FLOAT4__   = 1;
{$ENDIF}

{$IF defined( __SSE2__ ) }
    {$IF defined( __MINGW64__ ) }
        #include <intrin.h>
    {$ELSE}
        #include <emmintrin.h>
    {$ENDIF}
    {$IF defined( __GNUC__ ) }
        typedef cl_uchar    __cl_uchar16    __attribute__((vector_size(16)));
        typedef cl_char     __cl_char16     __attribute__((vector_size(16)));
        typedef cl_ushort   __cl_ushort8    __attribute__((vector_size(16)));
        typedef cl_short    __cl_short8     __attribute__((vector_size(16)));
        typedef cl_uint     __cl_uint4      __attribute__((vector_size(16)));
        typedef cl_int      __cl_int4       __attribute__((vector_size(16)));
        typedef cl_ulong    __cl_ulong2     __attribute__((vector_size(16)));
        typedef cl_long     __cl_long2      __attribute__((vector_size(16)));
        typedef cl_double   __cl_double2    __attribute__((vector_size(16)));
    {$ELSE}
        type T___cl_uchar16 = T___m128i;
        type T___cl_char16  = T___m128i;
        type T___cl_ushort8 = T___m128i;
        type T___cl_short8  = T___m128i;
        type T___cl_uint4   = T___m128i;
        type T___cl_int4    = T___m128i;
        type T___cl_ulong2  = T___m128i;
        type T___cl_long2   = T___m128i;
        type T___cl_double2 = T___m128d;
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

{$IF defined( __MMX__ ) }
    #include <mmintrin.h>
    {$IF defined( __GNUC__ ) }
        typedef cl_uchar    __cl_uchar8     __attribute__((vector_size(8)));
        typedef cl_char     __cl_char8      __attribute__((vector_size(8)));
        typedef cl_ushort   __cl_ushort4    __attribute__((vector_size(8)));
        typedef cl_short    __cl_short4     __attribute__((vector_size(8)));
        typedef cl_uint     __cl_uint2      __attribute__((vector_size(8)));
        typedef cl_int      __cl_int2       __attribute__((vector_size(8)));
        typedef cl_ulong    __cl_ulong1     __attribute__((vector_size(8)));
        typedef cl_long     __cl_long1      __attribute__((vector_size(8)));
        typedef cl_float    __cl_float2     __attribute__((vector_size(8)));
    {$ELSE}
        type T___cl_uchar8  = T___m64;
        type T___cl_char8   = T___m64;
        type T___cl_ushort4 = T___m64;
        type T___cl_short4  = T___m64;
        type T___cl_uint2   = T___m64;
        type T___cl_int2    = T___m64;
        type T___cl_ulong1  = T___m64;
        type T___cl_long1   = T___m64;
        type T___cl_float2  = T___m64;
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

{$IF defined( __AVX__ ) }
    {$IF defined( __MINGW64__ ) }
        #include <intrin.h>
    {$ELSE}
        #include <immintrin.h>
    {$ENDIF}
    {$IF defined( __GNUC__ ) }
        typedef cl_float    __cl_float8     __attribute__((vector_size(32)));
        typedef cl_double   __cl_double4    __attribute__((vector_size(32)));
    {$ELSE}
        type T___cl_float8  = T___m256;
        type T___cl_double4 = T___m256d;
    {$ENDIF}
    const __CL_FLOAT8__   = 1;
    const __CL_DOUBLE4__  = 1;
{$ENDIF}

(* Define capabilities for anonymous struct members. *)
{$IF not Defined( __cplusplus ) and Defined( __STDC_VERSION__ ) {and ( __STDC_VERSION__ >= 201112 )} }  //[dcc64 警告] cl_platform.pas(485): W1021 比較結果は常に False になります
const __CL_HAS_ANON_STRUCT__ = 1;
//#define  __CL_ANON_STRUCT__
{$ELSEIF Defined( _WIN32 ) and Defined( _MSC_VER ) and not Defined( __STDC__ ) }
const __CL_HAS_ANON_STRUCT__ = 1;
//#define  __CL_ANON_STRUCT__
{$ELSEIF Defined( __GNUC__ ) and not defined( __STRICT_ANSI__ ) }
const __CL_HAS_ANON_STRUCT__ = 1;
//#define  __CL_ANON_STRUCT__ __extension__
{$ELSEIF Defined( __clang__ ) }
const __CL_HAS_ANON_STRUCT__ = 1;
//#define  __CL_ANON_STRUCT__ __extension__
{$ELSE}
const __CL_HAS_ANON_STRUCT__ = 0;
//#define  __CL_ANON_STRUCT__
{$ENDIF}

{$IF Defined( _WIN32 ) and Defined( _MSC_VER ) and ( __CL_HAS_ANON_STRUCT__ <> 0 ) }
//   (* Disable warning C4201: nonstandard extension used : nameless struct/union *)
//    #pragma warning( push )
//    #pragma warning( disable : 4201 )
{$ENDIF}

(* Define alignment keys *)
{$IF defined( __GNUC__ ) or defined(__INTEGRITY) }
    #define CL_ALIGNED(_x)          __attribute__ ((aligned(_x)))
{$ELSEIF defined( _WIN32 ) and defined( _MSC_VER ) }
    (* Alignment keys neutered on windows because MSVC can't swallow function arguments with alignment requirements     *)
    (* http://msdn.microsoft.com/en-us/library/373ak2y1%28VS.71%29.aspx                                                 *)
    (* #include <crtdefs.h>                                                                                             *)
    (* #define CL_ALIGNED(_x)          _CRT_ALIGN(_x)                                                                   *)
    #define CL_ALIGNED(_x)
{$ELSE}
//    #warning  Need to implement some method to align data here
//    #define  CL_ALIGNED(_x)
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
type T_cl_char2 = record
     case Byte of
       0: ( s :array [ 0..2-1 ] of T_cl_char );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1: ( x, y :T_cl_char );
       2: ( s0, s1 :T_cl_char );
       3: ( lo, hi :T_cl_char );
{$ENDIF}
{$IF defined( __CL_CHAR2__ ) }
       4: ( v2 :T___cl_char2 );
{$ENDIF}
     end;

type T_cl_char4 = record
     case Byte of
       0: ( s :array [ 0..4-1 ] of T_cl_char );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1: ( x, y, z, w :T_cl_char );
       2: ( s0, s1, s2, s3 :T_cl_char );
       3: ( lo, hi :T_cl_char2 );
{$ENDIF}
{$IF defined( __CL_CHAR2__ ) }
       4: ( v2 :array [ 0..2-1 ] of T___cl_char2 );
{$ENDIF}
{$IF defined( __CL_CHAR4__ ) }
       5: ( v4 :T___cl_char4 );
{$ENDIF}
     end;

(* cl_char3 is identical in size, alignment and behavior to cl_char4. See section 6.1.5. *)
type T_cl_char3 = T_cl_char4;

type T_cl_char8 = record
     case Byte of
       0: ( s :array [ 0..8-1 ] of T_cl_char );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1: ( x, y, z, w :T_cl_char );
       2: ( s0, s1, s2, s3, s4, s5, s6, s7 :T_cl_char );
       3: ( lo, hi :T_cl_char4 );
{$ENDIF}
{$IF defined( __CL_CHAR2__ ) }
       4: ( v2 :array [ 0..4-1 ] of T___cl_char2 );
{$ENDIF}
{$IF defined( __CL_CHAR4__ ) }
       5: ( v4 :array [ 0..2-1 ] of T___cl_char4 );
{$ENDIF}
{$IF defined( __CL_CHAR8__ ) }
       6: ( v8 :T___cl_char8 );
{$ENDIF}
     end;

type T_cl_char16 = record
     case Byte of
       0: ( s :array [ 0..16-1 ] of T_cl_char );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1: ( x, y, z, w, __spacer4, __spacer5, __spacer6, __spacer7, __spacer8, __spacer9, sa, sb, sc, sd, se, sf :T_cl_char );
       2: ( s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, sA, sB, sC, sD, sE, sF :T_cl_char );
       3: ( lo, hi :T_cl_char8 );
{$ENDIF}
{$IF defined( __CL_CHAR2__ ) }
       4: ( v2 :array [ 0..8-1 ] of T___cl_char2 );
{$ENDIF}
{$IF defined( __CL_CHAR4__ ) }
       5: ( v4 :array [ 0..4-1 ] of T___cl_char4 );
{$ENDIF}
{$IF defined( __CL_CHAR8__ ) }
       6: ( v8 :array [ 0..2-1 ] of T___cl_char8 );
{$ENDIF}
{$IF defined( __CL_CHAR16__ ) }
       7: ( v16 :T___cl_char16 );
{$ENDIF}
     end;


(* ---- cl_ucharn ---- *)
type T_cl_uchar2 = record
     case Byte of
       0: ( s :array [ 0..2-1 ] of T_cl_uchar );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1: ( x, y :T_cl_uchar );
       2: ( s0, s1 :T_cl_uchar );
       3: ( lo, hi :T_cl_uchar );
{$ENDIF}
{$IF defined( __cl_uchar2__ ) }
       4: ( v2 :T___cl_uchar2 );
{$ENDIF}
     end;

type T_cl_uchar4 = record
     case Byte of
       0: ( s :array [ 0..4-1 ] of T_cl_uchar );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1: ( x, y, z, w :T_cl_uchar );
       2: ( s0, s1, s2, s3 :T_cl_uchar );
       3: ( lo, hi :T_cl_uchar2 );
{$ENDIF}
{$IF defined( __CL_UCHAR2__ ) }
       4: ( v2 :array [ 0..2-1 ] of T___cl_uchar2 );
{$ENDIF}
{$IF defined( __CL_UCHAR4__ ) }
       5: ( v4 :T___cl_uchar4 );
{$ENDIF}
     end;

(* cl_uchar3 is identical in size, alignment and behavior to cl_uchar4. See section 6.1.5. *)
type T_cl_uchar3 = T_cl_uchar4;

type T_cl_uchar8 = record
     case Byte of
       0: ( s :array [ 0..8-1 ] of T_cl_uchar );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1: ( x, y, z, w :T_cl_uchar );
       2: ( s0, s1, s2, s3, s4, s5, s6, s7 :T_cl_uchar );
       3: ( lo, hi :T_cl_uchar4 );
{$ENDIF}
{$IF defined( __CL_UCHAR2__ ) }
       4: ( v2 :array [ 0..4-1 ] of T___cl_uchar2 );
{$ENDIF}
{$IF defined( __CL_UCHAR4__ ) }
       5: ( v4 :array [ 0..2-1 ] of T___cl_uchar4 );
{$ENDIF}
{$IF defined( __CL_UCHAR8__ ) }
       6: ( v8 :T___cl_uchar8 );
{$ENDIF}
     end;

type T_cl_uchar16 = record
     case Byte of
       0: ( s :array [ 0..16-1 ] of T_cl_uchar );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1: ( x, y, z, w, __spacer4, __spacer5, __spacer6, __spacer7, __spacer8, __spacer9, sa, sb, sc, sd, se, sf :T_cl_uchar );
       2: ( s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, sA, sB, sC, sD, sE, sF :T_cl_uchar );
       3: ( lo, hi :T_cl_uchar8 );
{$ENDIF}
{$IF defined( __CL_UCHAR2__ ) }
       4: ( v2 :array [ 0..8-1 ] of T___cl_uchar2 );
{$ENDIF}
{$IF defined( __CL_UCHAR4__ ) }
       5: ( v4 :array [ 0..4-1 ] of T___cl_uchar4 );
{$ENDIF}
{$IF defined( __CL_UCHAR8__ ) }
       6: ( v8 :array [ 0..2-1 ] of T___cl_uchar8 );
{$ENDIF}
{$IF defined( __CL_UCHAR16__ ) }
       7: ( v16 :T___cl_uchar16 );
{$ENDIF}
     end;


(* ---- cl_shortn ---- *)
type T_cl_short2 = record
     case Byte of
       0: ( s :array [ 0..2-1 ] of T_cl_short );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1: ( x, y :T_cl_short );
       2: ( s0, s1 :T_cl_short );
       3: ( lo, hi :T_cl_short );
{$ENDIF}
{$IF defined( __CL_SHORT2__ ) }
       4: ( v2 :T___cl_short2 );
{$ENDIF}
     end;

type T_cl_short4 = record
     case Byte of
       0: ( s :array [ 0..4-1 ] of T_cl_short );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1: ( x, y, z, w :T_cl_short );
       2: ( s0, s1, s2, s3 :T_cl_short );
       3: ( lo, hi :T_cl_short2 );
{$ENDIF}
{$IF defined( __CL_SHORT2__ ) }
       4: ( v2 :array [ 0..2-1 ] of T___cl_short2 );
{$ENDIF}
{$IF defined( __CL_SHORT4__ ) }
       5: ( v4 :T___cl_short4 );
{$ENDIF}
     end;

(* cl_short3 is identical in size, alignment and behavior to cl_short4. See section 6.1.5. *)
type T_cl_short3 = T_cl_short4;

type T_cl_short8 = record
     case Byte of
       0: ( s :array [ 0..8-1 ] of T_cl_short );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1: ( x, y, z, w :T_cl_short );
       2: ( s0, s1, s2, s3, s4, s5, s6, s7 :T_cl_short );
       3: ( lo, hi :T_cl_short4 );
{$ENDIF}
{$IF defined( __CL_SHORT2__ ) }
       4: ( v2 :array [ 0..4-1 ] of T___cl_short2 );
{$ENDIF}
{$IF defined( __CL_SHORT4__ ) }
       5: ( v4 :array [ 0..2-1 ] of T___cl_short4 );
{$ENDIF}
{$IF defined( __CL_SHORT8__ ) }
       6: ( v8 :T___cl_short8 );
{$ENDIF}
     end;

type T_cl_short16 = record
     case Byte of
       0: ( s :array [ 0..16-1 ] of T_cl_short );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1: ( x, y, z, w, __spacer4, __spacer5, __spacer6, __spacer7, __spacer8, __spacer9, sa, sb, sc, sd, se, sf :T_cl_short );
       2: ( s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, sA, sB, sC, sD, sE, sF :T_cl_short );
       3: ( lo, hi :T_cl_short8 );
{$ENDIF}
{$IF defined( __CL_SHORT2__ ) }
       4: ( v2 :array [ 0..8-1 ] of T___cl_short2 );
{$ENDIF}
{$IF defined( __CL_SHORT4__ ) }
       5: ( v4 :array [ 0..4-1 ] of T___cl_short4 );
{$ENDIF}
{$IF defined( __CL_SHORT8__ ) }
       6: ( v8 :array [ 0..2-1 ] of T___cl_short8 );
{$ENDIF}
{$IF defined( __CL_SHORT16__ ) }
       7: ( v16 :T___cl_short16 );
{$ENDIF}
     end;


(* ---- cl_ushortn ---- *)
type T_cl_ushort2 = record
     case Byte of
       0: ( s :array [ 0..2-1 ] of T_cl_ushort );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1: ( x, y :T_cl_ushort );
       2: ( s0, s1 :T_cl_ushort );
       3: ( lo, hi :T_cl_ushort );
{$ENDIF}
{$IF defined( __CL_USHORT2__ ) }
       4: ( v2 :T___cl_ushort2 );
{$ENDIF}
     end;

type T_cl_ushort4 = record
     case Byte of
       0: ( s :array [ 0..4-1 ] of T_cl_ushort );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1: ( x, y, z, w :T_cl_ushort );
       2: ( s0, s1, s2, s3 :T_cl_ushort );
       3: ( lo, hi :T_cl_ushort2 );
{$ENDIF}
{$IF defined( __CL_USHORT2__ ) }
       4: ( v2 :array [ 0..2-1 ] of T___cl_ushort2 );
{$ENDIF}
{$IF defined( __CL_USHORT4__ ) }
       5: ( v4 :T___cl_ushort4 );
{$ENDIF}
     end;

(* cl_ushort3 is identical in size, alignment and behavior to cl_ushort4. See section 6.1.5. *)
type T_cl_ushort3 = T_cl_ushort4;

type T_cl_ushort8 = record
     case Byte of
       0: ( s :array [ 0..8-1 ] of T_cl_ushort );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1: ( x, y, z, w :T_cl_ushort );
       2: ( s0, s1, s2, s3, s4, s5, s6, s7 :T_cl_ushort );
       3: ( lo, hi :T_cl_ushort4 );
{$ENDIF}
{$IF defined( __CL_USHORT2__ ) }
       4: ( v2 :array [ 0..4-1 ] of T___cl_ushort2 );
{$ENDIF}
{$IF defined( __CL_USHORT4__ ) }
       5: ( v4 :array [ 0..2-1 ] of T___cl_ushort4 );
{$ENDIF}
{$IF defined( __CL_USHORT8__ ) }
       6: ( v8 :T___cl_ushort8 );
{$ENDIF}
     end;

type T_cl_ushort16 = record
     case Byte of
       0: ( s :array [ 0..16-1 ] of T_cl_ushort );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1: ( x, y, z, w, __spacer4, __spacer5, __spacer6, __spacer7, __spacer8, __spacer9, sa, sb, sc, sd, se, sf :T_cl_ushort );
       2: ( s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, sA, sB, sC, sD, sE, sF :T_cl_ushort );
       3: ( lo, hi :T_cl_ushort8 );
{$ENDIF}
{$IF defined( __CL_USHORT2__ ) }
       4: ( v2 :array [ 0..8-1 ] of T___cl_ushort2 );
{$ENDIF}
{$IF defined( __CL_USHORT4__ ) }
       5: ( v4 :array [ 0..4-1 ] of T___cl_ushort4 );
{$ENDIF}
{$IF defined( __CL_USHORT8__ ) }
       6: ( v8 :array [ 0..2-1 ] of T___cl_ushort8 );
{$ENDIF}
{$IF defined( __CL_USHORT16__ ) }
       7: ( v16 :T___cl_ushort16 );
{$ENDIF}
     end;


(* ---- cl_halfn ---- *)
type T_cl_half2 = record
     case Byte of
       0: ( s :array [ 0..2-1 ] of T_cl_half );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1: ( x, y :T_cl_half );
       2: ( s0, s1 :T_cl_half );
       3: ( lo, hi :T_cl_half );
{$ENDIF}
{$IF defined( __CL_HALF2__ ) }
       4: ( v2 :T___cl_half2 );
{$ENDIF}
     end;

type T_cl_half4 = record
     case Byte of
       0: ( s :array [ 0..4-1 ] of T_cl_half );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1: ( x, y, z, w :T_cl_half );
       2: ( s0, s1, s2, s3 :T_cl_half );
       3: ( lo, hi :T_cl_half2 );
{$ENDIF}
{$IF defined( __CL_HALF2__ ) }
       4: ( v2 :array [ 0..2-1 ] of T___cl_half2 );
{$ENDIF}
{$IF defined( __CL_HALF4__ ) }
       5: ( v4 :T___cl_half4 );
{$ENDIF}
     end;

(* cl_half3 is identical in size, alignment and behavior to cl_half4. See section 6.1.5. *)
type T_cl_half3 = T_cl_half4;

type T_cl_half8 = record
     case Byte of
       0: ( s :array [ 0..8-1 ] of T_cl_half );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1: ( x, y, z, w :T_cl_half );
       2: ( s0, s1, s2, s3, s4, s5, s6, s7 :T_cl_half );
       3: ( lo, hi :T_cl_half4 );
{$ENDIF}
{$IF defined( __CL_HALF2__ ) }
       4: ( v2 :array [ 0..4-1 ] of T___cl_half2 );
{$ENDIF}
{$IF defined( __CL_HALF4__ ) }
       5: ( v4 :array [ 0..2-1 ] of T___cl_half4 );
{$ENDIF}
{$IF defined( __CL_HALF8__ ) }
       6: ( v8 :T___cl_half8 );
{$ENDIF}
     end;

type T_cl_half16 = record
     case Byte of
       0: ( s :array [ 0..16-1 ] of T_cl_half );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1: ( x, y, z, w, __spacer4, __spacer5, __spacer6, __spacer7, __spacer8, __spacer9, sa, sb, sc, sd, se, sf :T_cl_half );
       2: ( s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, sA, sB, sC, sD, sE, sF :T_cl_half );
       3: ( lo, hi :T_cl_half8 );
{$ENDIF}
{$IF defined( __CL_HALF2__ ) }
       4: ( v2 :array [ 0..8-1 ] of T___cl_half2 );
{$ENDIF}
{$IF defined( __CL_HALF4__ ) }
       5: ( v4 :array [ 0..4-1 ] of T___cl_half4 );
{$ENDIF}
{$IF defined( __CL_HALF8__ ) }
       6: ( v8 :array [ 0..2-1 ] of T___cl_half8 );
{$ENDIF}
{$IF defined( __CL_HALF16__ ) }
       7: ( v16 :T___cl_half16 );
{$ENDIF}
     end;

(* ---- cl_intn ---- *)
type T_cl_int2 = record
     case Byte of
       0: ( s :array [ 0..2-1 ] of T_cl_int );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1: ( x, y :T_cl_int );
       2: ( s0, s1 :T_cl_int );
       3: ( lo, hi :T_cl_int );
{$ENDIF}
{$IF defined( __CL_INT2__ ) }
       4: ( v2 :T___cl_int2 );
{$ENDIF}
     end;

type T_cl_int4 = record
     case Byte of
       0: ( s :array [ 0..4-1 ] of T_cl_int );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1: ( x, y, z, w :T_cl_int );
       2: ( s0, s1, s2, s3 :T_cl_int );
       3: ( lo, hi :T_cl_int2 );
{$ENDIF}
{$IF defined( __CL_INT2__ ) }
       4: ( v2 :array [ 0..2-1 ] of T___cl_int2 );
{$ENDIF}
{$IF defined( __CL_INT4__ ) }
       5: ( v4 :T___cl_int4 );
{$ENDIF}
     end;

(* cl_int3 is identical in size, alignment and behavior to cl_int4. See section 6.1.5. *)
type T_cl_int3 = T_cl_int4;

type T_cl_int8 = record
     case Byte of
       0: ( s :array [ 0..8-1 ] of T_cl_int );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1: ( x, y, z, w :T_cl_int );
       2: ( s0, s1, s2, s3, s4, s5, s6, s7 :T_cl_int );
       3: ( lo, hi :T_cl_int4 );
{$ENDIF}
{$IF defined( __CL_INT2__ ) }
       4: ( v2 :array [ 0..4-1 ] of T___cl_int2 );
{$ENDIF}
{$IF defined( __CL_INT4__ ) }
       5: ( v4 :array [ 0..2-1 ] of T___cl_int4 );
{$ENDIF}
{$IF defined( __CL_INT8__ ) }
       6: ( v8 :T___cl_int8 );
{$ENDIF}
     end;

type T_cl_int16 = record
     case Byte of
       0: ( s :array [ 0..16-1 ] of T_cl_int );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1: ( x, y, z, w, __spacer4, __spacer5, __spacer6, __spacer7, __spacer8, __spacer9, sa, sb, sc, sd, se, sf :T_cl_int );
       2: ( s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, sA, sB, sC, sD, sE, sF :T_cl_int );
       3: ( lo, hi :T_cl_int8 );
{$ENDIF}
{$IF defined( __CL_INT2__ ) }
       4: ( v2 :array [ 0..8-1 ] of T___cl_int2 );
{$ENDIF}
{$IF defined( __CL_INT4__ ) }
       5: ( v4 :array [ 0..4-1 ] of T___cl_int4 );
{$ENDIF}
{$IF defined( __CL_INT8__ ) }
       6: ( v8 :array [ 0..2-1 ] of T___cl_int8 );
{$ENDIF}
{$IF defined( __CL_INT16__ ) }
       7: ( v16 :T___cl_int16 );
{$ENDIF}
     end;


(* ---- cl_uintn ---- *)
type T_cl_uint2 = record
     case Byte of
       0: ( s :array [ 0..2-1 ] of T_cl_uint );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1: ( x, y :T_cl_uint );
       2: ( s0, s1 :T_cl_uint );
       3: ( lo, hi :T_cl_uint );
{$ENDIF}
{$IF defined( __CL_UINT2__ ) }
       4: ( v2 :T___cl_uint2 );
{$ENDIF}
     end;

type T_cl_uint4 = record
     case Byte of
       0: ( s :array [ 0..4-1 ] of T_cl_uint );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1: ( x, y, z, w :T_cl_uint );
       2: ( s0, s1, s2, s3 :T_cl_uint );
       3: ( lo, hi :T_cl_uint2 );
{$ENDIF}
{$IF defined( __CL_UINT2__ ) }
       4: ( v2 :array [ 0..2-1 ] of T___cl_uint2 );
{$ENDIF}
{$IF defined( __CL_UINT4__ ) }
       5: ( v4 :T___cl_uint4 );
{$ENDIF}
     end;

(* cl_uint3 is identical in size, alignment and behavior to cl_uint4. See section 6.1.5. *)
type T_cl_uint3 = T_cl_uint4;

type T_cl_uint8 = record
     case Byte of
       0: ( s :array [ 0..8-1 ] of T_cl_uint );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1: ( x, y, z, w :T_cl_uint );
       2: ( s0, s1, s2, s3, s4, s5, s6, s7 :T_cl_uint );
       3: ( lo, hi :T_cl_uint4 );
{$ENDIF}
{$IF defined( __CL_UINT2__ ) }
       4: ( v2 :array [ 0..4-1 ] of T___cl_uint2 );
{$ENDIF}
{$IF defined( __CL_UINT4__ ) }
       5: ( v4 :array [ 0..2-1 ] of T___cl_uint4 );
{$ENDIF}
{$IF defined( __CL_UINT8__ ) }
       6: ( v8 :T___cl_uint8 );
{$ENDIF}
     end;

type T_cl_uint16 = record
     case Byte of
       0: ( s :array [ 0..16-1 ] of T_cl_uint );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1: ( x, y, z, w, __spacer4, __spacer5, __spacer6, __spacer7, __spacer8, __spacer9, sa, sb, sc, sd, se, sf :T_cl_uint );
       2: ( s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, sA, sB, sC, sD, sE, sF :T_cl_uint );
       3: ( lo, hi :T_cl_uint8 );
{$ENDIF}
{$IF defined( __CL_UINT2__ ) }
       4: ( v2 :array [ 0..8-1 ] of T___cl_uint2 );
{$ENDIF}
{$IF defined( __CL_UINT4__ ) }
       5: ( v4 :array [ 0..4-1 ] of T___cl_uint4 );
{$ENDIF}
{$IF defined( __CL_UINT8__ ) }
       6: ( v8 :array [ 0..2-1 ] of T___cl_uint8 );
{$ENDIF}
{$IF defined( __CL_UINT16__ ) }
       7: ( v16 :T___cl_uint16 );
{$ENDIF}
     end;

(* ---- cl_longn ---- *)
type T_cl_long2 = record
     case Byte of
       0: ( s :array [ 0..2-1 ] of T_cl_long );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1: ( x, y :T_cl_long );
       2: ( s0, s1 :T_cl_long );
       3: ( lo, hi :T_cl_long );
{$ENDIF}
{$IF defined( __CL_LONG2__ ) }
       4: ( v2 :T___cl_long2 );
{$ENDIF}
     end;

type T_cl_long4 = record
     case Byte of
       0: ( s :array [ 0..4-1 ] of T_cl_long );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1: ( x, y, z, w :T_cl_long );
       2: ( s0, s1, s2, s3 :T_cl_long );
       3: ( lo, hi :T_cl_long2 );
{$ENDIF}
{$IF defined( __CL_LONG2__ ) }
       4: ( v2 :array [ 0..2-1 ] of T___cl_long2 );
{$ENDIF}
{$IF defined( __CL_LONG4__ ) }
       5: ( v4 :T___cl_long4 );
{$ENDIF}
     end;

(* cl_long3 is identical in size, alignment and behavior to cl_long4. See section 6.1.5. *)
type T_cl_long3 = T_cl_long4;

type T_cl_long8 = record
     case Byte of
       0: ( s :array [ 0..8-1 ] of T_cl_long );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1: ( x, y, z, w :T_cl_long );
       2: ( s0, s1, s2, s3, s4, s5, s6, s7 :T_cl_long );
       3: ( lo, hi :T_cl_long4 );
{$ENDIF}
{$IF defined( __CL_LONG2__ ) }
       4: ( v2 :array [ 0..4-1 ] of T___cl_long2 );
{$ENDIF}
{$IF defined( __CL_LONG4__ ) }
       5: ( v4 :array [ 0..2-1 ] of T___cl_long4 );
{$ENDIF}
{$IF defined( __CL_LONG8__ ) }
       6: ( v8 :T___cl_long8 );
{$ENDIF}
     end;

type T_cl_long16 = record
     case Byte of
       0: ( s :array [ 0..16-1 ] of T_cl_long );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1: ( x, y, z, w, __spacer4, __spacer5, __spacer6, __spacer7, __spacer8, __spacer9, sa, sb, sc, sd, se, sf :T_cl_long );
       2: ( s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, sA, sB, sC, sD, sE, sF :T_cl_long );
       3: ( lo, hi :T_cl_long8 );
{$ENDIF}
{$IF defined( __CL_LONG2__ ) }
       4: ( v2 :array [ 0..8-1 ] of T___cl_long2 );
{$ENDIF}
{$IF defined( __CL_LONG4__ ) }
       5: ( v4 :array [ 0..4-1 ] of T___cl_long4 );
{$ENDIF}
{$IF defined( __CL_LONG8__ ) }
       6: ( v8 :array [ 0..2-1 ] of T___cl_long8 );
{$ENDIF}
{$IF defined( __CL_LONG16__ ) }
       7: ( v16 :T___cl_long16 );
{$ENDIF}
     end;


(* ---- cl_ulongn ---- *)
type T_cl_ulong2 = record
     case Byte of
       0: ( s :array [ 0..2-1 ] of T_cl_ulong );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1: ( x, y :T_cl_ulong );
       2: ( s0, s1 :T_cl_ulong );
       3: ( lo, hi :T_cl_ulong );
{$ENDIF}
{$IF defined( __CL_ULONG2__ ) }
       4: ( v2 :T___cl_ulong2 );
{$ENDIF}
     end;

type T_cl_ulong4 = record
     case Byte of
       0: ( s :array [ 0..4-1 ] of T_cl_ulong );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1: ( x, y, z, w :T_cl_ulong );
       2: ( s0, s1, s2, s3 :T_cl_ulong );
       3: ( lo, hi :T_cl_ulong2 );
{$ENDIF}
{$IF defined( __CL_ULONG2__ ) }
       4: ( v2 :array [ 0..2-1 ] of T___cl_ulong2 );
{$ENDIF}
{$IF defined( __CL_ULONG4__ ) }
       5: ( v4 :T___cl_ulong4 );
{$ENDIF}
     end;

(* cl_ulong3 is identical in size, alignment and behavior to cl_ulong4. See section 6.1.5. *)
type T_cl_ulong3 = T_cl_ulong4;

type T_cl_ulong8 = record
     case Byte of
       0: ( s :array [ 0..8-1 ] of T_cl_ulong );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1: ( x, y, z, w :T_cl_ulong );
       2: ( s0, s1, s2, s3, s4, s5, s6, s7 :T_cl_ulong );
       3: ( lo, hi :T_cl_ulong4 );
{$ENDIF}
{$IF defined( __CL_ULONG2__ ) }
       4: ( v2 :array [ 0..4-1 ] of T___cl_ulong2 );
{$ENDIF}
{$IF defined( __CL_ULONG4__ ) }
       5: ( v4 :array [ 0..2-1 ] of T___cl_ulong4 );
{$ENDIF}
{$IF defined( __CL_ULONG8__ ) }
       6: ( v8 :T___cl_ulong8 );
{$ENDIF}
     end;

type T_cl_ulong16 = record
     case Byte of
       0: ( s :array [ 0..16-1 ] of T_cl_ulong );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1: ( x, y, z, w, __spacer4, __spacer5, __spacer6, __spacer7, __spacer8, __spacer9, sa, sb, sc, sd, se, sf :T_cl_ulong );
       2: ( s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, sA, sB, sC, sD, sE, sF :T_cl_ulong );
       3: ( lo, hi :T_cl_ulong8 );
{$ENDIF}
{$IF defined( __CL_ULONG2__ ) }
       4: ( v2 :array [ 0..8-1 ] of T___cl_ulong2 );
{$ENDIF}
{$IF defined( __CL_ULONG4__ ) }
       5: ( v4 :array [ 0..4-1 ] of T___cl_ulong4 );
{$ENDIF}
{$IF defined( __CL_ULONG8__ ) }
       6: ( v8 :array [ 0..2-1 ] of T___cl_ulong8 );
{$ENDIF}
{$IF defined( __CL_ULONG16__ ) }
       7: ( v16 :T___cl_ulong16 );
{$ENDIF}
     end;


(* --- cl_floatn ---- *)

type T_cl_float2 = record
     case Byte of
       0: ( s :array [ 0..2-1 ] of T_cl_float );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1: ( x, y :T_cl_float );
       2: ( s0, s1 :T_cl_float );
       3: ( lo, hi :T_cl_float );
{$ENDIF}
{$IF defined( __CL_FLOAT2__ ) }
       4: ( v2 :T___cl_float2 );
{$ENDIF}
     end;

type T_cl_float4 = record
     case Byte of
       0: ( s :array [ 0..4-1 ] of T_cl_float );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1: ( x, y, z, w :T_cl_float );
       2: ( s0, s1, s2, s3 :T_cl_float );
       3: ( lo, hi :T_cl_float2 );
{$ENDIF}
{$IF defined( __CL_FLOAT2__ ) }
       4: ( v2 :array [ 0..2-1 ] of T___cl_float2 );
{$ENDIF}
{$IF defined( __CL_FLOAT4__ ) }
       5: ( v4 :T___cl_float4 );
{$ENDIF}
     end;

(* cl_float3 is identical in size, alignment and behavior to cl_float4. See section 6.1.5. *)
type T_cl_float3 = T_cl_float4;

type T_cl_float8 = record
     case Byte of
       0: ( s :array [ 0..8-1 ] of T_cl_float );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1: ( x, y, z, w :T_cl_float );
       2: ( s0, s1, s2, s3, s4, s5, s6, s7 :T_cl_float );
       3: ( lo, hi :T_cl_float4 );
{$ENDIF}
{$IF defined( __CL_FLOAT2__ ) }
       4: ( v2 :array [ 0..4-1 ] of T___cl_float2 );
{$ENDIF}
{$IF defined( __CL_FLOAT4__ ) }
       5: ( v4 :array [ 0..2-1 ] of T___cl_float4 );
{$ENDIF}
{$IF defined( __CL_FLOAT8__ ) }
       6: ( v8 :T___cl_float8 );
{$ENDIF}
     end;

type T_cl_float16 = record
     case Byte of
       0: ( s :array [ 0..16-1 ] of T_cl_float );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1: ( x, y, z, w, __spacer4, __spacer5, __spacer6, __spacer7, __spacer8, __spacer9, sa, sb, sc, sd, se, sf :T_cl_float );
       2: ( s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, sA, sB, sC, sD, sE, sF :T_cl_float );
       3: ( lo, hi :T_cl_float8 );
{$ENDIF}
{$IF defined( __CL_FLOAT2__ ) }
       4: ( v2 :array [ 0..8-1 ] of T___cl_float2 );
{$ENDIF}
{$IF defined( __CL_FLOAT4__ ) }
       5: ( v4 :array [ 0..4-1 ] of T___cl_float4 );
{$ENDIF}
{$IF defined( __CL_FLOAT8__ ) }
       6: ( v8 :array [ 0..2-1 ] of T___cl_float8 );
{$ENDIF}
{$IF defined( __CL_FLOAT16__ ) }
       7: ( v16 :T___cl_float16 );
{$ENDIF}
     end;

(* --- cl_doublen ---- *)

type T_cl_double2 = record
     case Byte of
       0: ( s :array [ 0..2-1 ] of T_cl_double );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1: ( x, y :T_cl_double );
       2: ( s0, s1 :T_cl_double );
       3: ( lo, hi :T_cl_double );
{$ENDIF}
{$IF defined( __CL_DOUBLE2__ ) }
       4: ( v2 :T___cl_double2 );
{$ENDIF}
     end;

type T_cl_double4 = record
     case Byte of
       0: ( s :array [ 0..4-1 ] of T_cl_double );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1: ( x, y, z, w :T_cl_double );
       2: ( s0, s1, s2, s3 :T_cl_double );
       3: ( lo, hi :T_cl_double2 );
{$ENDIF}
{$IF defined( __CL_DOUBLE2__ ) }
       4: ( v2 :array [ 0..2-1 ] of T___cl_double2 );
{$ENDIF}
{$IF defined( __CL_DOUBLE4__ ) }
       5: ( v4 :T___cl_double4 );
{$ENDIF}
     end;

(* cl_double3 is identical in size, alignment and behavior to cl_double4. See section 6.1.5. *)
type T_cl_double3 = T_cl_double4;

type T_cl_double8 = record
     case Byte of
       0: ( s :array [ 0..8-1 ] of T_cl_double );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1: ( x, y, z, w :T_cl_double );
       2: ( s0, s1, s2, s3, s4, s5, s6, s7 :T_cl_double );
       3: ( lo, hi :T_cl_double4 );
{$ENDIF}
{$IF defined( __CL_DOUBLE2__ ) }
       4: ( v2 :array [ 0..4-1 ] of T___cl_double2 );
{$ENDIF}
{$IF defined( __CL_DOUBLE4__ ) }
       5: ( v4 :array [ 0..2-1 ] of T___cl_double4 );
{$ENDIF}
{$IF defined( __CL_DOUBLE8__ ) }
       6: ( v8 :T___cl_double8 );
{$ENDIF}
     end;

type T_cl_double16 = record
     case Byte of
       0: ( s :array [ 0..16-1 ] of T_cl_double );
{$IF __CL_HAS_ANON_STRUCT__ <> 0 }
       1: ( x, y, z, w, __spacer4, __spacer5, __spacer6, __spacer7, __spacer8, __spacer9, sa, sb, sc, sd, se, sf :T_cl_double );
       2: ( s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, sA, sB, sC, sD, sE, sF :T_cl_double );
       3: ( lo, hi :T_cl_double8 );
{$ENDIF}
{$IF defined( __CL_DOUBLE2__ ) }
       4: ( v2 :array [ 0..8-1 ] of T___cl_double2 );
{$ENDIF}
{$IF defined( __CL_DOUBLE4__ ) }
       5: ( v4 :array [ 0..4-1 ] of T___cl_double4 );
{$ENDIF}
{$IF defined( __CL_DOUBLE8__ ) }
       6: ( v8 :array [ 0..2-1 ] of T___cl_double8 );
{$ENDIF}
{$IF defined( __CL_DOUBLE16__ ) }
       7: ( v16 :T___cl_double16 );
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
//#define  __CL_STRINGIFY( _x )               # _x
//#define  _CL_STRINGIFY( _x )                __CL_STRINGIFY( _x )
//#define  CL_PROGRAM_STRING_DEBUG_INFO       "#line "  _CL_STRINGIFY(__LINE__) " \"" __FILE__ "\" \n\n"

//#ifdef __cplusplus
//}
//#endif

//#if defined( _WIN32) && defined(_MSC_VER) && __CL_HAS_ANON_STRUCT__
//    #pragma warning( pop )
//#endif

implementation //############################################################### ■

end. //######################################################################### ■
