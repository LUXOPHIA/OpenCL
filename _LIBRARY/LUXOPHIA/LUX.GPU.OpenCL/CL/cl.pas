﻿unit cl;

(*******************************************************************************
 * Copyright (c) 2008-2019 The Khronos Group Inc.
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

uses cl_version, cl_platform;

(******************************************************************************)

type T_cl_platform_id   = ^T__cl_platform_id  ;  T__cl_platform_id   = record end;
type T_cl_device_id     = ^T__cl_device_id    ;  T__cl_device_id     = record end;
type T_cl_context       = ^T__cl_context      ;  T__cl_context       = record end;
type T_cl_command_queue = ^T__cl_command_queue;  T__cl_command_queue = record end;
type T_cl_mem           = ^T__cl_mem          ;  T__cl_mem           = record end;
type T_cl_program       = ^T__cl_program      ;  T__cl_program       = record end;
type T_cl_kernel        = ^T__cl_kernel       ;  T__cl_kernel        = record end;
type T_cl_event         = ^T__cl_event        ;  T__cl_event         = record end;
type T_cl_sampler       = ^T__cl_sampler      ;  T__cl_sampler       = record end;

type T_cl_bool                         = T_cl_uint;                     (* WARNING!  Unlike cl_ types in cl_platform.h, cl_bool is not guaranteed to be the same size as the bool in kernels. *)
type T_cl_bitfield                     = T_cl_ulong;
type T_cl_device_type                  = T_cl_bitfield;
type T_cl_platform_info                = T_cl_uint;
type T_cl_device_info                  = T_cl_uint;
type T_cl_device_fp_config             = T_cl_bitfield;
type T_cl_device_mem_cache_type        = T_cl_uint;
type T_cl_device_local_mem_type        = T_cl_uint;
type T_cl_device_exec_capabilities     = T_cl_bitfield;
{$IFDEF CL_VERSION_2_0 }
type T_cl_device_svm_capabilities      = T_cl_bitfield;
{$ENDIF}
type T_cl_command_queue_properties     = T_cl_bitfield;
{$IFDEF CL_VERSION_1_2 }
type T_cl_device_partition_property    = T_intptr_t;
type T_cl_device_affinity_domain       = T_cl_bitfield;
{$ENDIF}

type T_cl_context_properties           = T_intptr_t;
type T_cl_context_info                 = T_cl_uint;
{$IFDEF CL_VERSION_2_0 }
type T_cl_queue_properties             = T_cl_bitfield;
{$ENDIF}
type T_cl_command_queue_info           = T_cl_uint;
type T_cl_channel_order                = T_cl_uint;
type T_cl_channel_type                 = T_cl_uint;
type T_cl_mem_flags                    = T_cl_bitfield;
{$IFDEF CL_VERSION_2_0 }
type T_cl_svm_mem_flags                = T_cl_bitfield;
{$ENDIF}
type T_cl_mem_object_type              = T_cl_uint;
type T_cl_mem_info                     = T_cl_uint;
{$IFDEF CL_VERSION_1_2 }
type T_cl_mem_migration_flags          = T_cl_bitfield;
{$ENDIF}
type T_cl_image_info                   = T_cl_uint;
{$IFDEF CL_VERSION_1_1 }
type T_cl_buffer_create_type           = T_cl_uint;
{$ENDIF}
type T_cl_addressing_mode              = T_cl_uint;
type T_cl_filter_mode                  = T_cl_uint;
type T_cl_sampler_info                 = T_cl_uint;
type T_cl_map_flags                    = T_cl_bitfield;
{$IFDEF CL_VERSION_2_0 }
type T_cl_pipe_properties              = T_intptr_t;
type T_cl_pipe_info                    = T_cl_uint;
{$ENDIF}
type T_cl_program_info                 = T_cl_uint;
type T_cl_program_build_info           = T_cl_uint;
{$IFDEF CL_VERSION_1_2 }
type T_cl_program_binary_type          = T_cl_uint;
{$ENDIF}
type T_cl_build_status                 = T_cl_int;
type T_cl_kernel_info                  = T_cl_uint;
{$IFDEF CL_VERSION_1_2 }
type T_cl_kernel_arg_info              = T_cl_uint;
type T_cl_kernel_arg_address_qualifier = T_cl_uint;
type T_cl_kernel_arg_access_qualifier  = T_cl_uint;
type T_cl_kernel_arg_type_qualifier    = T_cl_bitfield;
{$ENDIF}
type T_cl_kernel_work_group_info       = T_cl_uint;
{$IFDEF CL_VERSION_2_1 }
type T_cl_kernel_sub_group_info        = T_cl_uint;
{$ENDIF}
type T_cl_event_info                   = T_cl_uint;
type T_cl_command_type                 = T_cl_uint;
type T_cl_profiling_info               = T_cl_uint;
{$IFDEF CL_VERSION_2_0 }
type T_cl_sampler_properties           = T_cl_bitfield;
type T_cl_kernel_exec_info             = T_cl_uint;
{$ENDIF}

type T_cl_image_format = record
       image_channel_order     :T_cl_channel_order;
       image_channel_data_type :T_cl_channel_type;
     end;

{$IFDEF CL_VERSION_1_2 }

type T_cl_image_desc = record
       image_type        :T_cl_mem_object_type;
       image_width       :T_size_t;
       image_height      :T_size_t;
       image_depth       :T_size_t;
       image_array_size  :T_size_t;
       image_row_pitch   :T_size_t;
       image_slice_pitch :T_size_t;
       num_mip_levels    :T_cl_uint;
       num_samples       :T_cl_uint;
{$IFDEF CL_VERSION_2_0 }
{$IFDEF __GNUC__ }
    __extension__   (* Prevents warnings about anonymous union in -pedantic builds *)
{$ENDIF}
{$IFDEF _MSC_VER }
#pragma warning( push )
#pragma warning( disable : 4201 ) (* Prevents warning about nameless struct/union in /W4 /Za builds *)
{$ENDIF}
    case  Byte of
{$ENDIF}
       0: ( buffer :T_cl_mem );
{$IFDEF CL_VERSION_2_0 }
       1: ( mem_object :T_cl_mem );
    };
{$IFDEF _MSC_VER }
#pragma warning( pop )
{$ENDIF}
{$ENDIF}
end;

{$ENDIF}

{$IFDEF CL_VERSION_1_1 }

type T_cl_buffer_region = record
       origin :T_size_t;
       size   :T_size_t;
     end;

{$ENDIF}

(******************************************************************************)

(* Error Codes *)
const CL_SUCCESS                                   = 0;
const CL_DEVICE_NOT_FOUND                          = -1;
const CL_DEVICE_NOT_AVAILABLE                      = -2;
const CL_COMPILER_NOT_AVAILABLE                    = -3;
const CL_MEM_OBJECT_ALLOCATION_FAILURE             = -4;
const CL_OUT_OF_RESOURCES                          = -5;
const CL_OUT_OF_HOST_MEMORY                        = -6;
const CL_PROFILING_INFO_NOT_AVAILABLE              = -7;
const CL_MEM_COPY_OVERLAP                          = -8;
const CL_IMAGE_FORMAT_MISMATCH                     = -9;
const CL_IMAGE_FORMAT_NOT_SUPPORTED                = -10;
const CL_BUILD_PROGRAM_FAILURE                     = -11;
const CL_MAP_FAILURE                               = -12;
{$IFDEF CL_VERSION_1_1 }
const CL_MISALIGNED_SUB_BUFFER_OFFSET              = -13;
const CL_EXEC_STATUS_ERROR_FOR_EVENTS_IN_WAIT_LIST  = -14;
{$ENDIF}
{$IFDEF CL_VERSION_1_2 }
const CL_COMPILE_PROGRAM_FAILURE                   = -15;
const CL_LINKER_NOT_AVAILABLE                      = -16;
const CL_LINK_PROGRAM_FAILURE                      = -17;
const CL_DEVICE_PARTITION_FAILED                   = -18;
const CL_KERNEL_ARG_INFO_NOT_AVAILABLE             = -19;
{$ENDIF}

const CL_INVALID_VALUE                             = -30;
const CL_INVALID_DEVICE_TYPE                       = -31;
const CL_INVALID_PLATFORM                          = -32;
const CL_INVALID_DEVICE                            = -33;
const CL_INVALID_CONTEXT                           = -34;
const CL_INVALID_QUEUE_PROPERTIES                  = -35;
const CL_INVALID_COMMAND_QUEUE                     = -36;
const CL_INVALID_HOST_PTR                          = -37;
const CL_INVALID_MEM_OBJECT                        = -38;
const CL_INVALID_IMAGE_FORMAT_DESCRIPTOR           = -39;
const CL_INVALID_IMAGE_SIZE                        = -40;
const CL_INVALID_SAMPLER                           = -41;
const CL_INVALID_BINARY                            = -42;
const CL_INVALID_BUILD_OPTIONS                     = -43;
const CL_INVALID_PROGRAM                           = -44;
const CL_INVALID_PROGRAM_EXECUTABLE                = -45;
const CL_INVALID_KERNEL_NAME                       = -46;
const CL_INVALID_KERNEL_DEFINITION                 = -47;
const CL_INVALID_KERNEL                            = -48;
const CL_INVALID_ARG_INDEX                         = -49;
const CL_INVALID_ARG_VALUE                         = -50;
const CL_INVALID_ARG_SIZE                          = -51;
const CL_INVALID_KERNEL_ARGS                       = -52;
const CL_INVALID_WORK_DIMENSION                    = -53;
const CL_INVALID_WORK_GROUP_SIZE                   = -54;
const CL_INVALID_WORK_ITEM_SIZE                    = -55;
const CL_INVALID_GLOBAL_OFFSET                     = -56;
const CL_INVALID_EVENT_WAIT_LIST                   = -57;
const CL_INVALID_EVENT                             = -58;
const CL_INVALID_OPERATION                         = -59;
const CL_INVALID_GL_OBJECT                         = -60;
const CL_INVALID_BUFFER_SIZE                       = -61;
const CL_INVALID_MIP_LEVEL                         = -62;
const CL_INVALID_GLOBAL_WORK_SIZE                  = -63;
{$IFDEF CL_VERSION_1_1 }
const CL_INVALID_PROPERTY                          = -64;
{$ENDIF}
{$IFDEF CL_VERSION_1_2 }
const CL_INVALID_IMAGE_DESCRIPTOR                  = -65;
const CL_INVALID_COMPILER_OPTIONS                  = -66;
const CL_INVALID_LINKER_OPTIONS                    = -67;
const CL_INVALID_DEVICE_PARTITION_COUNT            = -68;
{$ENDIF}
{$IFDEF CL_VERSION_2_0 }
const CL_INVALID_PIPE_SIZE                         = -69;
const CL_INVALID_DEVICE_QUEUE                      = -70;
{$ENDIF}
{$IFDEF CL_VERSION_2_2 }
const CL_INVALID_SPEC_ID                           = -71;
const CL_MAX_SIZE_RESTRICTION_EXCEEDED             = -72;
{$ENDIF}


(* cl_bool *)
const CL_FALSE                                     = 0;
const CL_TRUE                                      = 1;
{$IFDEF CL_VERSION_1_2 }
const CL_BLOCKING                                  = CL_TRUE;
const CL_NON_BLOCKING                              = CL_FALSE;
{$ENDIF}

(* cl_platform_info *)
const CL_PLATFORM_PROFILE                          = $0900;
const CL_PLATFORM_VERSION                          = $0901;
const CL_PLATFORM_NAME                             = $0902;
const CL_PLATFORM_VENDOR                           = $0903;
const CL_PLATFORM_EXTENSIONS                       = $0904;
{$IFDEF CL_VERSION_2_1 }
const CL_PLATFORM_HOST_TIMER_RESOLUTION            = $0905;
{$ENDIF}

(* cl_device_type - bitfield *)
const CL_DEVICE_TYPE_DEFAULT                       = (1 << 0);
const CL_DEVICE_TYPE_CPU                           = (1 << 1);
const CL_DEVICE_TYPE_GPU                           = (1 << 2);
const CL_DEVICE_TYPE_ACCELERATOR                   = (1 << 3);
{$IFDEF CL_VERSION_1_2 }
const CL_DEVICE_TYPE_CUSTOM                        = (1 << 4);
{$ENDIF}
const CL_DEVICE_TYPE_ALL                           = $FFFFFFFF;

(* cl_device_info *)
const CL_DEVICE_TYPE                                    = $1000;
const CL_DEVICE_VENDOR_ID                               = $1001;
const CL_DEVICE_MAX_COMPUTE_UNITS                       = $1002;
const CL_DEVICE_MAX_WORK_ITEM_DIMENSIONS                = $1003;
const CL_DEVICE_MAX_WORK_GROUP_SIZE                     = $1004;
const CL_DEVICE_MAX_WORK_ITEM_SIZES                     = $1005;
const CL_DEVICE_PREFERRED_VECTOR_WIDTH_CHAR             = $1006;
const CL_DEVICE_PREFERRED_VECTOR_WIDTH_SHORT            = $1007;
const CL_DEVICE_PREFERRED_VECTOR_WIDTH_INT              = $1008;
const CL_DEVICE_PREFERRED_VECTOR_WIDTH_LONG             = $1009;
const CL_DEVICE_PREFERRED_VECTOR_WIDTH_FLOAT            = $100A;
const CL_DEVICE_PREFERRED_VECTOR_WIDTH_DOUBLE           = $100B;
const CL_DEVICE_MAX_CLOCK_FREQUENCY                     = $100C;
const CL_DEVICE_ADDRESS_BITS                            = $100D;
const CL_DEVICE_MAX_READ_IMAGE_ARGS                     = $100E;
const CL_DEVICE_MAX_WRITE_IMAGE_ARGS                    = $100F;
const CL_DEVICE_MAX_MEM_ALLOC_SIZE                      = $1010;
const CL_DEVICE_IMAGE2D_MAX_WIDTH                       = $1011;
const CL_DEVICE_IMAGE2D_MAX_HEIGHT                      = $1012;
const CL_DEVICE_IMAGE3D_MAX_WIDTH                       = $1013;
const CL_DEVICE_IMAGE3D_MAX_HEIGHT                      = $1014;
const CL_DEVICE_IMAGE3D_MAX_DEPTH                       = $1015;
const CL_DEVICE_IMAGE_SUPPORT                           = $1016;
const CL_DEVICE_MAX_PARAMETER_SIZE                      = $1017;
const CL_DEVICE_MAX_SAMPLERS                            = $1018;
const CL_DEVICE_MEM_BASE_ADDR_ALIGN                     = $1019;
const CL_DEVICE_MIN_DATA_TYPE_ALIGN_SIZE                = $101A;
const CL_DEVICE_SINGLE_FP_CONFIG                        = $101B;
const CL_DEVICE_GLOBAL_MEM_CACHE_TYPE                   = $101C;
const CL_DEVICE_GLOBAL_MEM_CACHELINE_SIZE               = $101D;
const CL_DEVICE_GLOBAL_MEM_CACHE_SIZE                   = $101E;
const CL_DEVICE_GLOBAL_MEM_SIZE                         = $101F;
const CL_DEVICE_MAX_CONSTANT_BUFFER_SIZE                = $1020;
const CL_DEVICE_MAX_CONSTANT_ARGS                       = $1021;
const CL_DEVICE_LOCAL_MEM_TYPE                          = $1022;
const CL_DEVICE_LOCAL_MEM_SIZE                          = $1023;
const CL_DEVICE_ERROR_CORRECTION_SUPPORT                = $1024;
const CL_DEVICE_PROFILING_TIMER_RESOLUTION              = $1025;
const CL_DEVICE_ENDIAN_LITTLE                           = $1026;
const CL_DEVICE_AVAILABLE                               = $1027;
const CL_DEVICE_COMPILER_AVAILABLE                      = $1028;
const CL_DEVICE_EXECUTION_CAPABILITIES                  = $1029;
const CL_DEVICE_QUEUE_PROPERTIES                        = $102A;    (* deprecated *)
{$IFDEF CL_VERSION_2_0 }
const CL_DEVICE_QUEUE_ON_HOST_PROPERTIES                = $102A;
{$ENDIF}
const CL_DEVICE_NAME                                    = $102B;
const CL_DEVICE_VENDOR                                  = $102C;
const CL_DRIVER_VERSION                                 = $102D;
const CL_DEVICE_PROFILE                                 = $102E;
const CL_DEVICE_VERSION                                 = $102F;
const CL_DEVICE_EXTENSIONS                              = $1030;
const CL_DEVICE_PLATFORM                                = $1031;
{$IFDEF CL_VERSION_1_2 }
const CL_DEVICE_DOUBLE_FP_CONFIG                        = $1032;
{$ENDIF}
(* 0x1033 reserved for CL_DEVICE_HALF_FP_CONFIG which is already defined in "cl_ext.h" *)
{$IFDEF CL_VERSION_1_1 }
const CL_DEVICE_PREFERRED_VECTOR_WIDTH_HALF             = $1034;
const CL_DEVICE_HOST_UNIFIED_MEMORY                     = $1035;   (* deprecated *)
const CL_DEVICE_NATIVE_VECTOR_WIDTH_CHAR                = $1036;
const CL_DEVICE_NATIVE_VECTOR_WIDTH_SHORT               = $1037;
const CL_DEVICE_NATIVE_VECTOR_WIDTH_INT                 = $1038;
const CL_DEVICE_NATIVE_VECTOR_WIDTH_LONG                = $1039;
const CL_DEVICE_NATIVE_VECTOR_WIDTH_FLOAT               = $103A;
const CL_DEVICE_NATIVE_VECTOR_WIDTH_DOUBLE              = $103B;
const CL_DEVICE_NATIVE_VECTOR_WIDTH_HALF                = $103C;
const CL_DEVICE_OPENCL_C_VERSION                        = $103D;
{$ENDIF}
{$IFDEF CL_VERSION_1_2 }
const CL_DEVICE_LINKER_AVAILABLE                        = $103E;
const CL_DEVICE_BUILT_IN_KERNELS                        = $103F;
const CL_DEVICE_IMAGE_MAX_BUFFER_SIZE                   = $1040;
const CL_DEVICE_IMAGE_MAX_ARRAY_SIZE                    = $1041;
const CL_DEVICE_PARENT_DEVICE                           = $1042;
const CL_DEVICE_PARTITION_MAX_SUB_DEVICES               = $1043;
const CL_DEVICE_PARTITION_PROPERTIES                    = $1044;
const CL_DEVICE_PARTITION_AFFINITY_DOMAIN               = $1045;
const CL_DEVICE_PARTITION_TYPE                          = $1046;
const CL_DEVICE_REFERENCE_COUNT                         = $1047;
const CL_DEVICE_PREFERRED_INTEROP_USER_SYNC             = $1048;
const CL_DEVICE_PRINTF_BUFFER_SIZE                      = $1049;
{$ENDIF}
{$IFDEF CL_VERSION_2_0 }
const CL_DEVICE_IMAGE_PITCH_ALIGNMENT                   = $104A;
const CL_DEVICE_IMAGE_BASE_ADDRESS_ALIGNMENT            = $104B;
const CL_DEVICE_MAX_READ_WRITE_IMAGE_ARGS               = $104C;
const CL_DEVICE_MAX_GLOBAL_VARIABLE_SIZE                = $104D;
const CL_DEVICE_QUEUE_ON_DEVICE_PROPERTIES              = $104E;
const CL_DEVICE_QUEUE_ON_DEVICE_PREFERRED_SIZE          = $104F;
const CL_DEVICE_QUEUE_ON_DEVICE_MAX_SIZE                = $1050;
const CL_DEVICE_MAX_ON_DEVICE_QUEUES                    = $1051;
const CL_DEVICE_MAX_ON_DEVICE_EVENTS                    = $1052;
const CL_DEVICE_SVM_CAPABILITIES                        = $1053;
const CL_DEVICE_GLOBAL_VARIABLE_PREFERRED_TOTAL_SIZE    = $1054;
const CL_DEVICE_MAX_PIPE_ARGS                           = $1055;
const CL_DEVICE_PIPE_MAX_ACTIVE_RESERVATIONS            = $1056;
const CL_DEVICE_PIPE_MAX_PACKET_SIZE                    = $1057;
const CL_DEVICE_PREFERRED_PLATFORM_ATOMIC_ALIGNMENT     = $1058;
const CL_DEVICE_PREFERRED_GLOBAL_ATOMIC_ALIGNMENT       = $1059;
const CL_DEVICE_PREFERRED_LOCAL_ATOMIC_ALIGNMENT        = $105A;
{$ENDIF}
{$IFDEF CL_VERSION_2_1 }
const CL_DEVICE_IL_VERSION                              = $105B;
const CL_DEVICE_MAX_NUM_SUB_GROUPS                      = $105C;
const CL_DEVICE_SUB_GROUP_INDEPENDENT_FORWARD_PROGRESS  = $105D;
{$ENDIF}

(* cl_device_fp_config - bitfield *)
const CL_FP_DENORM                                 = (1 << 0);
const CL_FP_INF_NAN                                = (1 << 1);
const CL_FP_ROUND_TO_NEAREST                       = (1 << 2);
const CL_FP_ROUND_TO_ZERO                          = (1 << 3);
const CL_FP_ROUND_TO_INF                           = (1 << 4);
const CL_FP_FMA                                    = (1 << 5);
{$IFDEF CL_VERSION_1_1 }
const CL_FP_SOFT_FLOAT                             = (1 << 6);
{$ENDIF}
{$IFDEF CL_VERSION_1_2 }
const CL_FP_CORRECTLY_ROUNDED_DIVIDE_SQRT          = (1 << 7);
{$ENDIF}

(* cl_device_mem_cache_type *)
const CL_NONE                                      = $0;
const CL_READ_ONLY_CACHE                           = $1;
const CL_READ_WRITE_CACHE                          = $2;

(* cl_device_local_mem_type *)
const CL_LOCAL                                     = $1;
const CL_GLOBAL                                    = $2;

(* cl_device_exec_capabilities - bitfield *)
const CL_EXEC_KERNEL                               = (1 << 0);
const CL_EXEC_NATIVE_KERNEL                        = (1 << 1);

(* cl_command_queue_properties - bitfield *)
const CL_QUEUE_OUT_OF_ORDER_EXEC_MODE_ENABLE       = (1 << 0);
const CL_QUEUE_PROFILING_ENABLE                    = (1 << 1);
{$IFDEF CL_VERSION_2_0 }
const CL_QUEUE_ON_DEVICE                           = (1 << 2);
const CL_QUEUE_ON_DEVICE_DEFAULT                   = (1 << 3);
{$ENDIF}

(* cl_context_info *)
const CL_CONTEXT_REFERENCE_COUNT                   = $1080;
const CL_CONTEXT_DEVICES                           = $1081;
const CL_CONTEXT_PROPERTIES                        = $1082;
{$IFDEF CL_VERSION_1_1 }
const CL_CONTEXT_NUM_DEVICES                       = $1083;
{$ENDIF}

(* cl_context_properties *)
const CL_CONTEXT_PLATFORM                          = $1084;
{$IFDEF CL_VERSION_1_2 }
const CL_CONTEXT_INTEROP_USER_SYNC                 = $1085;
{$ENDIF}

{$IFDEF CL_VERSION_1_2 }

(* cl_device_partition_property *)
const CL_DEVICE_PARTITION_EQUALLY                  = $1086;
const CL_DEVICE_PARTITION_BY_COUNTS                = $1087;
const CL_DEVICE_PARTITION_BY_COUNTS_LIST_END       = $0;
const CL_DEVICE_PARTITION_BY_AFFINITY_DOMAIN       = $1088;

{$ENDIF}

{$IFDEF CL_VERSION_1_2 }

(* cl_device_affinity_domain *)
const CL_DEVICE_AFFINITY_DOMAIN_NUMA                = (1 << 0);
const CL_DEVICE_AFFINITY_DOMAIN_L4_CACHE            = (1 << 1);
const CL_DEVICE_AFFINITY_DOMAIN_L3_CACHE            = (1 << 2);
const CL_DEVICE_AFFINITY_DOMAIN_L2_CACHE            = (1 << 3);
const CL_DEVICE_AFFINITY_DOMAIN_L1_CACHE            = (1 << 4);
const CL_DEVICE_AFFINITY_DOMAIN_NEXT_PARTITIONABLE  = (1 << 5);

{$ENDIF}

{$IFDEF CL_VERSION_2_0 }

(* cl_device_svm_capabilities *)
const CL_DEVICE_SVM_COARSE_GRAIN_BUFFER            = (1 << 0);
const CL_DEVICE_SVM_FINE_GRAIN_BUFFER              = (1 << 1);
const CL_DEVICE_SVM_FINE_GRAIN_SYSTEM              = (1 << 2);
const CL_DEVICE_SVM_ATOMICS                        = (1 << 3);

{$ENDIF}

(* cl_command_queue_info *)
const CL_QUEUE_CONTEXT                             = $1090;
const CL_QUEUE_DEVICE                              = $1091;
const CL_QUEUE_REFERENCE_COUNT                     = $1092;
const CL_QUEUE_PROPERTIES                          = $1093;
{$IFDEF CL_VERSION_2_0 }
const CL_QUEUE_SIZE                                = $1094;
{$ENDIF}
{$IFDEF CL_VERSION_2_1 }
const CL_QUEUE_DEVICE_DEFAULT                      = $1095;
{$ENDIF}

(* cl_mem_flags and cl_svm_mem_flags - bitfield *)
const CL_MEM_READ_WRITE                            = (1 << 0);
const CL_MEM_WRITE_ONLY                            = (1 << 1);
const CL_MEM_READ_ONLY                             = (1 << 2);
const CL_MEM_USE_HOST_PTR                          = (1 << 3);
const CL_MEM_ALLOC_HOST_PTR                        = (1 << 4);
const CL_MEM_COPY_HOST_PTR                         = (1 << 5);
(* reserved                                         (1 << 6)    *)
{$IFDEF CL_VERSION_1_2 }
const CL_MEM_HOST_WRITE_ONLY                       = (1 << 7);
const CL_MEM_HOST_READ_ONLY                        = (1 << 8);
const CL_MEM_HOST_NO_ACCESS                        = (1 << 9);
{$ENDIF}
{$IFDEF CL_VERSION_2_0 }
const CL_MEM_SVM_FINE_GRAIN_BUFFER                 = (1 << 10);   (* used by cl_svm_mem_flags only *)
const CL_MEM_SVM_ATOMICS                           = (1 << 11);   (* used by cl_svm_mem_flags only *)
const CL_MEM_KERNEL_READ_AND_WRITE                 = (1 << 12);
{$ENDIF}

{$IFDEF CL_VERSION_1_2 }

(* cl_mem_migration_flags - bitfield *)
const CL_MIGRATE_MEM_OBJECT_HOST                   = (1 << 0);
const CL_MIGRATE_MEM_OBJECT_CONTENT_UNDEFINED      = (1 << 1);

{$ENDIF}

(* cl_channel_order *)
const CL_R                                         = $10B0;
const CL_A                                         = $10B1;
const CL_RG                                        = $10B2;
const CL_RA                                        = $10B3;
const CL_RGB                                       = $10B4;
const CL_RGBA                                      = $10B5;
const CL_BGRA                                      = $10B6;
const CL_ARGB                                      = $10B7;
const CL_INTENSITY                                 = $10B8;
const CL_LUMINANCE                                 = $10B9;
{$IFDEF CL_VERSION_1_1 }
const CL_Rx                                        = $10BA;
const CL_RGx                                       = $10BB;
const CL_RGBx                                      = $10BC;
{$ENDIF}
{$IFDEF CL_VERSION_1_2 }
const CL_DEPTH                                     = $10BD;
const CL_DEPTH_STENCIL                             = $10BE;
{$ENDIF}
{$IFDEF CL_VERSION_2_0 }
const CL_sRGB                                      = $10BF;
const CL_sRGBx                                     = $10C0;
const CL_sRGBA                                     = $10C1;
const CL_sBGRA                                     = $10C2;
const CL_ABGR                                      = $10C3;
{$ENDIF}

(* cl_channel_type *)
const CL_SNORM_INT8                                = $10D0;
const CL_SNORM_INT16                               = $10D1;
const CL_UNORM_INT8                                = $10D2;
const CL_UNORM_INT16                               = $10D3;
const CL_UNORM_SHORT_565                           = $10D4;
const CL_UNORM_SHORT_555                           = $10D5;
const CL_UNORM_INT_101010                          = $10D6;
const CL_SIGNED_INT8                               = $10D7;
const CL_SIGNED_INT16                              = $10D8;
const CL_SIGNED_INT32                              = $10D9;
const CL_UNSIGNED_INT8                             = $10DA;
const CL_UNSIGNED_INT16                            = $10DB;
const CL_UNSIGNED_INT32                            = $10DC;
const CL_HALF_FLOAT                                = $10DD;
const CL_FLOAT                                     = $10DE;
{$IFDEF CL_VERSION_1_2 }
const CL_UNORM_INT24                               = $10DF;
{$ENDIF}
{$IFDEF CL_VERSION_2_1 }
const CL_UNORM_INT_101010_2                        = $10E0;
{$ENDIF}

(* cl_mem_object_type *)
const CL_MEM_OBJECT_BUFFER                         = $10F0;
const CL_MEM_OBJECT_IMAGE2D                        = $10F1;
const CL_MEM_OBJECT_IMAGE3D                        = $10F2;
{$IFDEF CL_VERSION_1_2 }
const CL_MEM_OBJECT_IMAGE2D_ARRAY                  = $10F3;
const CL_MEM_OBJECT_IMAGE1D                        = $10F4;
const CL_MEM_OBJECT_IMAGE1D_ARRAY                  = $10F5;
const CL_MEM_OBJECT_IMAGE1D_BUFFER                 = $10F6;
{$ENDIF}
{$IFDEF CL_VERSION_2_0 }
const CL_MEM_OBJECT_PIPE                           = $10F7;
{$ENDIF}

(* cl_mem_info *)
const CL_MEM_TYPE                                  = $1100;
const CL_MEM_FLAGS                                 = $1101;
const CL_MEM_SIZE                                  = $1102;
const CL_MEM_HOST_PTR                              = $1103;
const CL_MEM_MAP_COUNT                             = $1104;
const CL_MEM_REFERENCE_COUNT                       = $1105;
const CL_MEM_CONTEXT                               = $1106;
{$IFDEF CL_VERSION_1_1 }
const CL_MEM_ASSOCIATED_MEMOBJECT                  = $1107;
const CL_MEM_OFFSET                                = $1108;
{$ENDIF}
{$IFDEF CL_VERSION_2_0 }
const CL_MEM_USES_SVM_POINTER                      = $1109;
{$ENDIF}

(* cl_image_info *)
const CL_IMAGE_FORMAT                              = $1110;
const CL_IMAGE_ELEMENT_SIZE                        = $1111;
const CL_IMAGE_ROW_PITCH                           = $1112;
const CL_IMAGE_SLICE_PITCH                         = $1113;
const CL_IMAGE_WIDTH                               = $1114;
const CL_IMAGE_HEIGHT                              = $1115;
const CL_IMAGE_DEPTH                               = $1116;
{$IFDEF CL_VERSION_1_2 }
const CL_IMAGE_ARRAY_SIZE                          = $1117;
const CL_IMAGE_BUFFER                              = $1118;
const CL_IMAGE_NUM_MIP_LEVELS                      = $1119;
const CL_IMAGE_NUM_SAMPLES                         = $111A;
{$ENDIF}

{$IFDEF CL_VERSION_2_0 }

(* cl_pipe_info *)
const CL_PIPE_PACKET_SIZE                          = $1120;
const CL_PIPE_MAX_PACKETS                          = $1121;

{$ENDIF}

(* cl_addressing_mode *)
const CL_ADDRESS_NONE                              = $1130;
const CL_ADDRESS_CLAMP_TO_EDGE                     = $1131;
const CL_ADDRESS_CLAMP                             = $1132;
const CL_ADDRESS_REPEAT                            = $1133;
{$IFDEF CL_VERSION_1_1 }
const CL_ADDRESS_MIRRORED_REPEAT                   = $1134;
{$ENDIF}

(* cl_filter_mode *)
const CL_FILTER_NEAREST                            = $1140;
const CL_FILTER_LINEAR                             = $1141;

(* cl_sampler_info *)
const CL_SAMPLER_REFERENCE_COUNT                   = $1150;
const CL_SAMPLER_CONTEXT                           = $1151;
const CL_SAMPLER_NORMALIZED_COORDS                 = $1152;
const CL_SAMPLER_ADDRESSING_MODE                   = $1153;
const CL_SAMPLER_FILTER_MODE                       = $1154;
{$IFDEF CL_VERSION_2_0 }
(* These enumerants are for the cl_khr_mipmap_image extension.
   They have since been added to cl_ext.h with an appropriate
   KHR suffix, but are left here for backwards compatibility. *)
const CL_SAMPLER_MIP_FILTER_MODE                   = $1155;
const CL_SAMPLER_LOD_MIN                           = $1156;
const CL_SAMPLER_LOD_MAX                           = $1157;
{$ENDIF}

(* cl_map_flags - bitfield *)
const CL_MAP_READ                                  = (1 << 0);
const CL_MAP_WRITE                                 = (1 << 1);
{$IFDEF CL_VERSION_1_2 }
const CL_MAP_WRITE_INVALIDATE_REGION               = (1 << 2);
{$ENDIF}

(* cl_program_info *)
const CL_PROGRAM_REFERENCE_COUNT                   = $1160;
const CL_PROGRAM_CONTEXT                           = $1161;
const CL_PROGRAM_NUM_DEVICES                       = $1162;
const CL_PROGRAM_DEVICES                           = $1163;
const CL_PROGRAM_SOURCE                            = $1164;
const CL_PROGRAM_BINARY_SIZES                      = $1165;
const CL_PROGRAM_BINARIES                          = $1166;
{$IFDEF CL_VERSION_1_2 }
const CL_PROGRAM_NUM_KERNELS                       = $1167;
const CL_PROGRAM_KERNEL_NAMES                      = $1168;
{$ENDIF}
{$IFDEF CL_VERSION_2_1 }
const CL_PROGRAM_IL                                = $1169;
{$ENDIF}
{$IFDEF CL_VERSION_2_2 }
const CL_PROGRAM_SCOPE_GLOBAL_CTORS_PRESENT        = $116A;
const CL_PROGRAM_SCOPE_GLOBAL_DTORS_PRESENT        = $116B;
{$ENDIF}

(* cl_program_build_info *)
const CL_PROGRAM_BUILD_STATUS                      = $1181;
const CL_PROGRAM_BUILD_OPTIONS                     = $1182;
const CL_PROGRAM_BUILD_LOG                         = $1183;
{$IFDEF CL_VERSION_1_2 }
const CL_PROGRAM_BINARY_TYPE                       = $1184;
{$ENDIF}
{$IFDEF CL_VERSION_2_0 }
const CL_PROGRAM_BUILD_GLOBAL_VARIABLE_TOTAL_SIZE  = $1185;
{$ENDIF}

{$IFDEF CL_VERSION_1_2 }

(* cl_program_binary_type *)
const CL_PROGRAM_BINARY_TYPE_NONE                  = $0;
const CL_PROGRAM_BINARY_TYPE_COMPILED_OBJECT       = $1;
const CL_PROGRAM_BINARY_TYPE_LIBRARY               = $2;
const CL_PROGRAM_BINARY_TYPE_EXECUTABLE            = $4;

{$ENDIF}

(* cl_build_status *)
const CL_BUILD_SUCCESS                             = 0;
const CL_BUILD_NONE                                = -1;
const CL_BUILD_ERROR                               = -2;
const CL_BUILD_IN_PROGRESS                         = -3;

(* cl_kernel_info *)
const CL_KERNEL_FUNCTION_NAME                      = $1190;
const CL_KERNEL_NUM_ARGS                           = $1191;
const CL_KERNEL_REFERENCE_COUNT                    = $1192;
const CL_KERNEL_CONTEXT                            = $1193;
const CL_KERNEL_PROGRAM                            = $1194;
{$IFDEF CL_VERSION_1_2 }
const CL_KERNEL_ATTRIBUTES                         = $1195;
{$ENDIF}
{$IFDEF CL_VERSION_2_1 }
const CL_KERNEL_MAX_NUM_SUB_GROUPS                 = $11B9;
const CL_KERNEL_COMPILE_NUM_SUB_GROUPS             = $11BA;
{$ENDIF}

{$IFDEF CL_VERSION_1_2 }

(* cl_kernel_arg_info *)
const CL_KERNEL_ARG_ADDRESS_QUALIFIER              = $1196;
const CL_KERNEL_ARG_ACCESS_QUALIFIER               = $1197;
const CL_KERNEL_ARG_TYPE_NAME                      = $1198;
const CL_KERNEL_ARG_TYPE_QUALIFIER                 = $1199;
const CL_KERNEL_ARG_NAME                           = $119A;

{$ENDIF}

{$IFDEF CL_VERSION_1_2 }

(* cl_kernel_arg_address_qualifier *)
const CL_KERNEL_ARG_ADDRESS_GLOBAL                 = $119B;
const CL_KERNEL_ARG_ADDRESS_LOCAL                  = $119C;
const CL_KERNEL_ARG_ADDRESS_CONSTANT               = $119D;
const CL_KERNEL_ARG_ADDRESS_PRIVATE                = $119E;

{$ENDIF}

{$IFDEF CL_VERSION_1_2 }

(* cl_kernel_arg_access_qualifier *)
const CL_KERNEL_ARG_ACCESS_READ_ONLY               = $11A0;
const CL_KERNEL_ARG_ACCESS_WRITE_ONLY              = $11A1;
const CL_KERNEL_ARG_ACCESS_READ_WRITE              = $11A2;
const CL_KERNEL_ARG_ACCESS_NONE                    = $11A3;

{$ENDIF}

{$IFDEF CL_VERSION_1_2 }

(* cl_kernel_arg_type_qualifier *)
const CL_KERNEL_ARG_TYPE_NONE                      = 0;
const CL_KERNEL_ARG_TYPE_CONST                     = (1 << 0);
const CL_KERNEL_ARG_TYPE_RESTRICT                  = (1 << 1);
const CL_KERNEL_ARG_TYPE_VOLATILE                  = (1 << 2);
{$IFDEF CL_VERSION_2_0 }
const CL_KERNEL_ARG_TYPE_PIPE                      = (1 << 3);
{$ENDIF}

{$ENDIF}

(* cl_kernel_work_group_info *)
const CL_KERNEL_WORK_GROUP_SIZE                    = $11B0;
const CL_KERNEL_COMPILE_WORK_GROUP_SIZE            = $11B1;
const CL_KERNEL_LOCAL_MEM_SIZE                     = $11B2;
const CL_KERNEL_PREFERRED_WORK_GROUP_SIZE_MULTIPLE  = $11B3;
const CL_KERNEL_PRIVATE_MEM_SIZE                   = $11B4;
{$IFDEF CL_VERSION_1_2 }
const CL_KERNEL_GLOBAL_WORK_SIZE                   = $11B5;
{$ENDIF}

{$IFDEF CL_VERSION_2_1 }

(* cl_kernel_sub_group_info *)
const CL_KERNEL_MAX_SUB_GROUP_SIZE_FOR_NDRANGE     = $2033;
const CL_KERNEL_SUB_GROUP_COUNT_FOR_NDRANGE        = $2034;
const CL_KERNEL_LOCAL_SIZE_FOR_SUB_GROUP_COUNT     = $11B8;

{$ENDIF}

{$IFDEF CL_VERSION_2_0 }

(* cl_kernel_exec_info *)
const CL_KERNEL_EXEC_INFO_SVM_PTRS                 = $11B6;
const CL_KERNEL_EXEC_INFO_SVM_FINE_GRAIN_SYSTEM    = $11B7;

{$ENDIF}

(* cl_event_info *)
const CL_EVENT_COMMAND_QUEUE                       = $11D0;
const CL_EVENT_COMMAND_TYPE                        = $11D1;
const CL_EVENT_REFERENCE_COUNT                     = $11D2;
const CL_EVENT_COMMAND_EXECUTION_STATUS            = $11D3;
{$IFDEF CL_VERSION_1_1 }
const CL_EVENT_CONTEXT                             = $11D4;
{$ENDIF}

(* cl_command_type *)
const CL_COMMAND_NDRANGE_KERNEL                    = $11F0;
const CL_COMMAND_TASK                              = $11F1;
const CL_COMMAND_NATIVE_KERNEL                     = $11F2;
const CL_COMMAND_READ_BUFFER                       = $11F3;
const CL_COMMAND_WRITE_BUFFER                      = $11F4;
const CL_COMMAND_COPY_BUFFER                       = $11F5;
const CL_COMMAND_READ_IMAGE                        = $11F6;
const CL_COMMAND_WRITE_IMAGE                       = $11F7;
const CL_COMMAND_COPY_IMAGE                        = $11F8;
const CL_COMMAND_COPY_IMAGE_TO_BUFFER              = $11F9;
const CL_COMMAND_COPY_BUFFER_TO_IMAGE              = $11FA;
const CL_COMMAND_MAP_BUFFER                        = $11FB;
const CL_COMMAND_MAP_IMAGE                         = $11FC;
const CL_COMMAND_UNMAP_MEM_OBJECT                  = $11FD;
const CL_COMMAND_MARKER                            = $11FE;
const CL_COMMAND_ACQUIRE_GL_OBJECTS                = $11FF;
const CL_COMMAND_RELEASE_GL_OBJECTS                = $1200;
{$IFDEF CL_VERSION_1_1 }
const CL_COMMAND_READ_BUFFER_RECT                  = $1201;
const CL_COMMAND_WRITE_BUFFER_RECT                 = $1202;
const CL_COMMAND_COPY_BUFFER_RECT                  = $1203;
const CL_COMMAND_USER                              = $1204;
{$ENDIF}
{$IFDEF CL_VERSION_1_2 }
const CL_COMMAND_BARRIER                           = $1205;
const CL_COMMAND_MIGRATE_MEM_OBJECTS               = $1206;
const CL_COMMAND_FILL_BUFFER                       = $1207;
const CL_COMMAND_FILL_IMAGE                        = $1208;
{$ENDIF}
{$IFDEF CL_VERSION_2_0 }
const CL_COMMAND_SVM_FREE                          = $1209;
const CL_COMMAND_SVM_MEMCPY                        = $120A;
const CL_COMMAND_SVM_MEMFILL                       = $120B;
const CL_COMMAND_SVM_MAP                           = $120C;
const CL_COMMAND_SVM_UNMAP                         = $120D;
{$ENDIF}

(* command execution status *)
const CL_COMPLETE                                  = $0;
const CL_RUNNING                                   = $1;
const CL_SUBMITTED                                 = $2;
const CL_QUEUED                                    = $3;

{$IFDEF CL_VERSION_1_1 }

(* cl_buffer_create_type *)
const CL_BUFFER_CREATE_TYPE_REGION                 = $1220;

{$ENDIF}

(* cl_profiling_info *)
const CL_PROFILING_COMMAND_QUEUED                  = $1280;
const CL_PROFILING_COMMAND_SUBMIT                  = $1281;
const CL_PROFILING_COMMAND_START                   = $1282;
const CL_PROFILING_COMMAND_END                     = $1283;
{$IFDEF CL_VERSION_2_0 }
const CL_PROFILING_COMMAND_COMPLETE                = $1284;
{$ENDIF}

(********************************************************************************************************)

(* Platform API *)
extern CL_API_ENTRY cl_int CL_API_CALL
clGetPlatformIDs(cl_uint          num_entries,
                 cl_platform_id * platforms,
                 cl_uint *        num_platforms) CL_API_SUFFIX__VERSION_1_0;

extern CL_API_ENTRY cl_int CL_API_CALL
clGetPlatformInfo(cl_platform_id   platform,
                  cl_platform_info param_name,
                  size_t           param_value_size,
                  void *           param_value,
                  size_t *         param_value_size_ret) CL_API_SUFFIX__VERSION_1_0;

(* Device APIs *)
extern CL_API_ENTRY cl_int CL_API_CALL
clGetDeviceIDs(cl_platform_id   platform,
               cl_device_type   device_type,
               cl_uint          num_entries,
               cl_device_id *   devices,
               cl_uint *        num_devices) CL_API_SUFFIX__VERSION_1_0;

extern CL_API_ENTRY cl_int CL_API_CALL
clGetDeviceInfo(cl_device_id    device,
                cl_device_info  param_name,
                size_t          param_value_size,
                void *          param_value,
                size_t *        param_value_size_ret) CL_API_SUFFIX__VERSION_1_0;

{$IFDEF CL_VERSION_1_2 }

extern CL_API_ENTRY cl_int CL_API_CALL
clCreateSubDevices(cl_device_id                         in_device,
                   const cl_device_partition_property * properties,
                   cl_uint                              num_devices,
                   cl_device_id *                       out_devices,
                   cl_uint *                            num_devices_ret) CL_API_SUFFIX__VERSION_1_2;

extern CL_API_ENTRY cl_int CL_API_CALL
clRetainDevice(cl_device_id device) CL_API_SUFFIX__VERSION_1_2;

extern CL_API_ENTRY cl_int CL_API_CALL
clReleaseDevice(cl_device_id device) CL_API_SUFFIX__VERSION_1_2;

{$ENDIF}

{$IFDEF CL_VERSION_2_1 }

extern CL_API_ENTRY cl_int CL_API_CALL
clSetDefaultDeviceCommandQueue(cl_context           context,
                               cl_device_id         device,
                               cl_command_queue     command_queue) CL_API_SUFFIX__VERSION_2_1;

extern CL_API_ENTRY cl_int CL_API_CALL
clGetDeviceAndHostTimer(cl_device_id    device,
                        cl_ulong*       device_timestamp,
                        cl_ulong*       host_timestamp) CL_API_SUFFIX__VERSION_2_1;

extern CL_API_ENTRY cl_int CL_API_CALL
clGetHostTimer(cl_device_id device,
               cl_ulong *   host_timestamp) CL_API_SUFFIX__VERSION_2_1;

{$ENDIF}

(* Context APIs *)
extern CL_API_ENTRY cl_context CL_API_CALL
clCreateContext(const cl_context_properties * properties,
                cl_uint              num_devices,
                const cl_device_id * devices,
                void (CL_CALLBACK * pfn_notify)(const char * errinfo,
                                                const void * private_info,
                                                size_t       cb,
                                                void *       user_data),
                void *               user_data,
                cl_int *             errcode_ret) CL_API_SUFFIX__VERSION_1_0;

extern CL_API_ENTRY cl_context CL_API_CALL
clCreateContextFromType(const cl_context_properties * properties,
                        cl_device_type      device_type,
                        void (CL_CALLBACK * pfn_notify)(const char * errinfo,
                                                        const void * private_info,
                                                        size_t       cb,
                                                        void *       user_data),
                        void *              user_data,
                        cl_int *            errcode_ret) CL_API_SUFFIX__VERSION_1_0;

extern CL_API_ENTRY cl_int CL_API_CALL
clRetainContext(cl_context context) CL_API_SUFFIX__VERSION_1_0;

extern CL_API_ENTRY cl_int CL_API_CALL
clReleaseContext(cl_context context) CL_API_SUFFIX__VERSION_1_0;

extern CL_API_ENTRY cl_int CL_API_CALL
clGetContextInfo(cl_context         context,
                 cl_context_info    param_name,
                 size_t             param_value_size,
                 void *             param_value,
                 size_t *           param_value_size_ret) CL_API_SUFFIX__VERSION_1_0;

(* Command Queue APIs *)

{$IFDEF CL_VERSION_2_0 }

extern CL_API_ENTRY cl_command_queue CL_API_CALL
clCreateCommandQueueWithProperties(cl_context               context,
                                   cl_device_id             device,
                                   const cl_queue_properties *    properties,
                                   cl_int *                 errcode_ret) CL_API_SUFFIX__VERSION_2_0;

{$ENDIF}

extern CL_API_ENTRY cl_int CL_API_CALL
clRetainCommandQueue(cl_command_queue command_queue) CL_API_SUFFIX__VERSION_1_0;

extern CL_API_ENTRY cl_int CL_API_CALL
clReleaseCommandQueue(cl_command_queue command_queue) CL_API_SUFFIX__VERSION_1_0;

extern CL_API_ENTRY cl_int CL_API_CALL
clGetCommandQueueInfo(cl_command_queue      command_queue,
                      cl_command_queue_info param_name,
                      size_t                param_value_size,
                      void *                param_value,
                      size_t *              param_value_size_ret) CL_API_SUFFIX__VERSION_1_0;

(* Memory Object APIs *)
extern CL_API_ENTRY cl_mem CL_API_CALL
clCreateBuffer(cl_context   context,
               cl_mem_flags flags,
               size_t       size,
               void *       host_ptr,
               cl_int *     errcode_ret) CL_API_SUFFIX__VERSION_1_0;

{$IFDEF CL_VERSION_1_1 }

extern CL_API_ENTRY cl_mem CL_API_CALL
clCreateSubBuffer(cl_mem                   buffer,
                  cl_mem_flags             flags,
                  cl_buffer_create_type    buffer_create_type,
                  const void *             buffer_create_info,
                  cl_int *                 errcode_ret) CL_API_SUFFIX__VERSION_1_1;

{$ENDIF}

{$IFDEF CL_VERSION_1_2 }

extern CL_API_ENTRY cl_mem CL_API_CALL
clCreateImage(cl_context              context,
              cl_mem_flags            flags,
              const cl_image_format * image_format,
              const cl_image_desc *   image_desc,
              void *                  host_ptr,
              cl_int *                errcode_ret) CL_API_SUFFIX__VERSION_1_2;

{$ENDIF}

{$IFDEF CL_VERSION_2_0 }

extern CL_API_ENTRY cl_mem CL_API_CALL
clCreatePipe(cl_context                 context,
             cl_mem_flags               flags,
             cl_uint                    pipe_packet_size,
             cl_uint                    pipe_max_packets,
             const cl_pipe_properties * properties,
             cl_int *                   errcode_ret) CL_API_SUFFIX__VERSION_2_0;

{$ENDIF}

extern CL_API_ENTRY cl_int CL_API_CALL
clRetainMemObject(cl_mem memobj) CL_API_SUFFIX__VERSION_1_0;

extern CL_API_ENTRY cl_int CL_API_CALL
clReleaseMemObject(cl_mem memobj) CL_API_SUFFIX__VERSION_1_0;

extern CL_API_ENTRY cl_int CL_API_CALL
clGetSupportedImageFormats(cl_context           context,
                           cl_mem_flags         flags,
                           cl_mem_object_type   image_type,
                           cl_uint              num_entries,
                           cl_image_format *    image_formats,
                           cl_uint *            num_image_formats) CL_API_SUFFIX__VERSION_1_0;

extern CL_API_ENTRY cl_int CL_API_CALL
clGetMemObjectInfo(cl_mem           memobj,
                   cl_mem_info      param_name,
                   size_t           param_value_size,
                   void *           param_value,
                   size_t *         param_value_size_ret) CL_API_SUFFIX__VERSION_1_0;

extern CL_API_ENTRY cl_int CL_API_CALL
clGetImageInfo(cl_mem           image,
               cl_image_info    param_name,
               size_t           param_value_size,
               void *           param_value,
               size_t *         param_value_size_ret) CL_API_SUFFIX__VERSION_1_0;

{$IFDEF CL_VERSION_2_0 }

extern CL_API_ENTRY cl_int CL_API_CALL
clGetPipeInfo(cl_mem           pipe,
              cl_pipe_info     param_name,
              size_t           param_value_size,
              void *           param_value,
              size_t *         param_value_size_ret) CL_API_SUFFIX__VERSION_2_0;

{$ENDIF}

{$IFDEF CL_VERSION_1_1 }

extern CL_API_ENTRY cl_int CL_API_CALL
clSetMemObjectDestructorCallback(cl_mem memobj,
                                 void (CL_CALLBACK * pfn_notify)(cl_mem memobj,
                                                                 void * user_data),
                                 void * user_data) CL_API_SUFFIX__VERSION_1_1;

{$ENDIF}

(* SVM Allocation APIs *)

{$IFDEF CL_VERSION_2_0 }

extern CL_API_ENTRY void * CL_API_CALL
clSVMAlloc(cl_context       context,
           cl_svm_mem_flags flags,
           size_t           size,
           cl_uint          alignment) CL_API_SUFFIX__VERSION_2_0;

extern CL_API_ENTRY void CL_API_CALL
clSVMFree(cl_context        context,
          void *            svm_pointer) CL_API_SUFFIX__VERSION_2_0;

{$ENDIF}

(* Sampler APIs *)

{$IFDEF CL_VERSION_2_0 }

extern CL_API_ENTRY cl_sampler CL_API_CALL
clCreateSamplerWithProperties(cl_context                     context,
                              const cl_sampler_properties *  sampler_properties,
                              cl_int *                       errcode_ret) CL_API_SUFFIX__VERSION_2_0;

{$ENDIF}

extern CL_API_ENTRY cl_int CL_API_CALL
clRetainSampler(cl_sampler sampler) CL_API_SUFFIX__VERSION_1_0;

extern CL_API_ENTRY cl_int CL_API_CALL
clReleaseSampler(cl_sampler sampler) CL_API_SUFFIX__VERSION_1_0;

extern CL_API_ENTRY cl_int CL_API_CALL
clGetSamplerInfo(cl_sampler         sampler,
                 cl_sampler_info    param_name,
                 size_t             param_value_size,
                 void *             param_value,
                 size_t *           param_value_size_ret) CL_API_SUFFIX__VERSION_1_0;

(* Program Object APIs *)
extern CL_API_ENTRY cl_program CL_API_CALL
clCreateProgramWithSource(cl_context        context,
                          cl_uint           count,
                          const char **     strings,
                          const size_t *    lengths,
                          cl_int *          errcode_ret) CL_API_SUFFIX__VERSION_1_0;

extern CL_API_ENTRY cl_program CL_API_CALL
clCreateProgramWithBinary(cl_context                     context,
                          cl_uint                        num_devices,
                          const cl_device_id *           device_list,
                          const size_t *                 lengths,
                          const unsigned char **         binaries,
                          cl_int *                       binary_status,
                          cl_int *                       errcode_ret) CL_API_SUFFIX__VERSION_1_0;

{$IFDEF CL_VERSION_1_2 }

extern CL_API_ENTRY cl_program CL_API_CALL
clCreateProgramWithBuiltInKernels(cl_context            context,
                                  cl_uint               num_devices,
                                  const cl_device_id *  device_list,
                                  const char *          kernel_names,
                                  cl_int *              errcode_ret) CL_API_SUFFIX__VERSION_1_2;

{$ENDIF}

{$IFDEF CL_VERSION_2_1 }

extern CL_API_ENTRY cl_program CL_API_CALL
clCreateProgramWithIL(cl_context    context,
                     const void*    il,
                     size_t         length,
                     cl_int*        errcode_ret) CL_API_SUFFIX__VERSION_2_1;

{$ENDIF}

extern CL_API_ENTRY cl_int CL_API_CALL
clRetainProgram(cl_program program) CL_API_SUFFIX__VERSION_1_0;

extern CL_API_ENTRY cl_int CL_API_CALL
clReleaseProgram(cl_program program) CL_API_SUFFIX__VERSION_1_0;

extern CL_API_ENTRY cl_int CL_API_CALL
clBuildProgram(cl_program           program,
               cl_uint              num_devices,
               const cl_device_id * device_list,
               const char *         options,
               void (CL_CALLBACK *  pfn_notify)(cl_program program,
                                                void * user_data),
               void *               user_data) CL_API_SUFFIX__VERSION_1_0;

{$IFDEF CL_VERSION_1_2 }

extern CL_API_ENTRY cl_int CL_API_CALL
clCompileProgram(cl_program           program,
                 cl_uint              num_devices,
                 const cl_device_id * device_list,
                 const char *         options,
                 cl_uint              num_input_headers,
                 const cl_program *   input_headers,
                 const char **        header_include_names,
                 void (CL_CALLBACK *  pfn_notify)(cl_program program,
                                                  void * user_data),
                 void *               user_data) CL_API_SUFFIX__VERSION_1_2;

extern CL_API_ENTRY cl_program CL_API_CALL
clLinkProgram(cl_context           context,
              cl_uint              num_devices,
              const cl_device_id * device_list,
              const char *         options,
              cl_uint              num_input_programs,
              const cl_program *   input_programs,
              void (CL_CALLBACK *  pfn_notify)(cl_program program,
                                               void * user_data),
              void *               user_data,
              cl_int *             errcode_ret) CL_API_SUFFIX__VERSION_1_2;

{$ENDIF}

{$IFDEF CL_VERSION_2_2 }

extern CL_API_ENTRY cl_int CL_API_CALL
clSetProgramReleaseCallback(cl_program          program,
                            void (CL_CALLBACK * pfn_notify)(cl_program program,
                                                            void * user_data),
                            void *              user_data) CL_API_SUFFIX__VERSION_2_2;

extern CL_API_ENTRY cl_int CL_API_CALL
clSetProgramSpecializationConstant(cl_program  program,
                                   cl_uint     spec_id,
                                   size_t      spec_size,
                                   const void* spec_value) CL_API_SUFFIX__VERSION_2_2;

{$ENDIF}

{$IFDEF CL_VERSION_1_2 }

extern CL_API_ENTRY cl_int CL_API_CALL
clUnloadPlatformCompiler(cl_platform_id platform) CL_API_SUFFIX__VERSION_1_2;

{$ENDIF}

extern CL_API_ENTRY cl_int CL_API_CALL
clGetProgramInfo(cl_program         program,
                 cl_program_info    param_name,
                 size_t             param_value_size,
                 void *             param_value,
                 size_t *           param_value_size_ret) CL_API_SUFFIX__VERSION_1_0;

extern CL_API_ENTRY cl_int CL_API_CALL
clGetProgramBuildInfo(cl_program            program,
                      cl_device_id          device,
                      cl_program_build_info param_name,
                      size_t                param_value_size,
                      void *                param_value,
                      size_t *              param_value_size_ret) CL_API_SUFFIX__VERSION_1_0;

(* Kernel Object APIs *)
extern CL_API_ENTRY cl_kernel CL_API_CALL
clCreateKernel(cl_program      program,
               const char *    kernel_name,
               cl_int *        errcode_ret) CL_API_SUFFIX__VERSION_1_0;

extern CL_API_ENTRY cl_int CL_API_CALL
clCreateKernelsInProgram(cl_program     program,
                         cl_uint        num_kernels,
                         cl_kernel *    kernels,
                         cl_uint *      num_kernels_ret) CL_API_SUFFIX__VERSION_1_0;

{$IFDEF CL_VERSION_2_1 }

extern CL_API_ENTRY cl_kernel CL_API_CALL
clCloneKernel(cl_kernel     source_kernel,
              cl_int*       errcode_ret) CL_API_SUFFIX__VERSION_2_1;

{$ENDIF}

extern CL_API_ENTRY cl_int CL_API_CALL
clRetainKernel(cl_kernel    kernel) CL_API_SUFFIX__VERSION_1_0;

extern CL_API_ENTRY cl_int CL_API_CALL
clReleaseKernel(cl_kernel   kernel) CL_API_SUFFIX__VERSION_1_0;

extern CL_API_ENTRY cl_int CL_API_CALL
clSetKernelArg(cl_kernel    kernel,
               cl_uint      arg_index,
               size_t       arg_size,
               const void * arg_value) CL_API_SUFFIX__VERSION_1_0;

{$IFDEF CL_VERSION_2_0 }

extern CL_API_ENTRY cl_int CL_API_CALL
clSetKernelArgSVMPointer(cl_kernel    kernel,
                         cl_uint      arg_index,
                         const void * arg_value) CL_API_SUFFIX__VERSION_2_0;

extern CL_API_ENTRY cl_int CL_API_CALL
clSetKernelExecInfo(cl_kernel            kernel,
                    cl_kernel_exec_info  param_name,
                    size_t               param_value_size,
                    const void *         param_value) CL_API_SUFFIX__VERSION_2_0;

{$ENDIF}

extern CL_API_ENTRY cl_int CL_API_CALL
clGetKernelInfo(cl_kernel       kernel,
                cl_kernel_info  param_name,
                size_t          param_value_size,
                void *          param_value,
                size_t *        param_value_size_ret) CL_API_SUFFIX__VERSION_1_0;

{$IFDEF CL_VERSION_1_2 }

extern CL_API_ENTRY cl_int CL_API_CALL
clGetKernelArgInfo(cl_kernel       kernel,
                   cl_uint         arg_indx,
                   cl_kernel_arg_info  param_name,
                   size_t          param_value_size,
                   void *          param_value,
                   size_t *        param_value_size_ret) CL_API_SUFFIX__VERSION_1_2;

{$ENDIF}

extern CL_API_ENTRY cl_int CL_API_CALL
clGetKernelWorkGroupInfo(cl_kernel                  kernel,
                         cl_device_id               device,
                         cl_kernel_work_group_info  param_name,
                         size_t                     param_value_size,
                         void *                     param_value,
                         size_t *                   param_value_size_ret) CL_API_SUFFIX__VERSION_1_0;

{$IFDEF CL_VERSION_2_1 }

extern CL_API_ENTRY cl_int CL_API_CALL
clGetKernelSubGroupInfo(cl_kernel                   kernel,
                        cl_device_id                device,
                        cl_kernel_sub_group_info    param_name,
                        size_t                      input_value_size,
                        const void*                 input_value,
                        size_t                      param_value_size,
                        void*                       param_value,
                        size_t*                     param_value_size_ret) CL_API_SUFFIX__VERSION_2_1;

{$ENDIF}

(* Event Object APIs *)
extern CL_API_ENTRY cl_int CL_API_CALL
clWaitForEvents(cl_uint             num_events,
                const cl_event *    event_list) CL_API_SUFFIX__VERSION_1_0;

extern CL_API_ENTRY cl_int CL_API_CALL
clGetEventInfo(cl_event         event,
               cl_event_info    param_name,
               size_t           param_value_size,
               void *           param_value,
               size_t *         param_value_size_ret) CL_API_SUFFIX__VERSION_1_0;

{$IFDEF CL_VERSION_1_1 }

extern CL_API_ENTRY cl_event CL_API_CALL
clCreateUserEvent(cl_context    context,
                  cl_int *      errcode_ret) CL_API_SUFFIX__VERSION_1_1;

{$ENDIF}

extern CL_API_ENTRY cl_int CL_API_CALL
clRetainEvent(cl_event event) CL_API_SUFFIX__VERSION_1_0;

extern CL_API_ENTRY cl_int CL_API_CALL
clReleaseEvent(cl_event event) CL_API_SUFFIX__VERSION_1_0;

{$IFDEF CL_VERSION_1_1 }

extern CL_API_ENTRY cl_int CL_API_CALL
clSetUserEventStatus(cl_event   event,
                     cl_int     execution_status) CL_API_SUFFIX__VERSION_1_1;

extern CL_API_ENTRY cl_int CL_API_CALL
clSetEventCallback(cl_event    event,
                   cl_int      command_exec_callback_type,
                   void (CL_CALLBACK * pfn_notify)(cl_event event,
                                                   cl_int   event_command_status,
                                                   void *   user_data),
                   void *      user_data) CL_API_SUFFIX__VERSION_1_1;

{$ENDIF}

(* Profiling APIs *)
extern CL_API_ENTRY cl_int CL_API_CALL
clGetEventProfilingInfo(cl_event            event,
                        cl_profiling_info   param_name,
                        size_t              param_value_size,
                        void *              param_value,
                        size_t *            param_value_size_ret) CL_API_SUFFIX__VERSION_1_0;

(* Flush and Finish APIs *)
extern CL_API_ENTRY cl_int CL_API_CALL
clFlush(cl_command_queue command_queue) CL_API_SUFFIX__VERSION_1_0;

extern CL_API_ENTRY cl_int CL_API_CALL
clFinish(cl_command_queue command_queue) CL_API_SUFFIX__VERSION_1_0;

(* Enqueued Commands APIs *)
extern CL_API_ENTRY cl_int CL_API_CALL
clEnqueueReadBuffer(cl_command_queue    command_queue,
                    cl_mem              buffer,
                    cl_bool             blocking_read,
                    size_t              offset,
                    size_t              size,
                    void *              ptr,
                    cl_uint             num_events_in_wait_list,
                    const cl_event *    event_wait_list,
                    cl_event *          event) CL_API_SUFFIX__VERSION_1_0;

{$IFDEF CL_VERSION_1_1 }

extern CL_API_ENTRY cl_int CL_API_CALL
clEnqueueReadBufferRect(cl_command_queue    command_queue,
                        cl_mem              buffer,
                        cl_bool             blocking_read,
                        const size_t *      buffer_offset,
                        const size_t *      host_offset,
                        const size_t *      region,
                        size_t              buffer_row_pitch,
                        size_t              buffer_slice_pitch,
                        size_t              host_row_pitch,
                        size_t              host_slice_pitch,
                        void *              ptr,
                        cl_uint             num_events_in_wait_list,
                        const cl_event *    event_wait_list,
                        cl_event *          event) CL_API_SUFFIX__VERSION_1_1;

{$ENDIF}

extern CL_API_ENTRY cl_int CL_API_CALL
clEnqueueWriteBuffer(cl_command_queue   command_queue,
                     cl_mem             buffer,
                     cl_bool            blocking_write,
                     size_t             offset,
                     size_t             size,
                     const void *       ptr,
                     cl_uint            num_events_in_wait_list,
                     const cl_event *   event_wait_list,
                     cl_event *         event) CL_API_SUFFIX__VERSION_1_0;

{$IFDEF CL_VERSION_1_1 }

extern CL_API_ENTRY cl_int CL_API_CALL
clEnqueueWriteBufferRect(cl_command_queue    command_queue,
                         cl_mem              buffer,
                         cl_bool             blocking_write,
                         const size_t *      buffer_offset,
                         const size_t *      host_offset,
                         const size_t *      region,
                         size_t              buffer_row_pitch,
                         size_t              buffer_slice_pitch,
                         size_t              host_row_pitch,
                         size_t              host_slice_pitch,
                         const void *        ptr,
                         cl_uint             num_events_in_wait_list,
                         const cl_event *    event_wait_list,
                         cl_event *          event) CL_API_SUFFIX__VERSION_1_1;

{$ENDIF}

{$IFDEF CL_VERSION_1_2 }

extern CL_API_ENTRY cl_int CL_API_CALL
clEnqueueFillBuffer(cl_command_queue   command_queue,
                    cl_mem             buffer,
                    const void *       pattern,
                    size_t             pattern_size,
                    size_t             offset,
                    size_t             size,
                    cl_uint            num_events_in_wait_list,
                    const cl_event *   event_wait_list,
                    cl_event *         event) CL_API_SUFFIX__VERSION_1_2;

{$ENDIF}

extern CL_API_ENTRY cl_int CL_API_CALL
clEnqueueCopyBuffer(cl_command_queue    command_queue,
                    cl_mem              src_buffer,
                    cl_mem              dst_buffer,
                    size_t              src_offset,
                    size_t              dst_offset,
                    size_t              size,
                    cl_uint             num_events_in_wait_list,
                    const cl_event *    event_wait_list,
                    cl_event *          event) CL_API_SUFFIX__VERSION_1_0;

{$IFDEF CL_VERSION_1_1 }

extern CL_API_ENTRY cl_int CL_API_CALL
clEnqueueCopyBufferRect(cl_command_queue    command_queue,
                        cl_mem              src_buffer,
                        cl_mem              dst_buffer,
                        const size_t *      src_origin,
                        const size_t *      dst_origin,
                        const size_t *      region,
                        size_t              src_row_pitch,
                        size_t              src_slice_pitch,
                        size_t              dst_row_pitch,
                        size_t              dst_slice_pitch,
                        cl_uint             num_events_in_wait_list,
                        const cl_event *    event_wait_list,
                        cl_event *          event) CL_API_SUFFIX__VERSION_1_1;

{$ENDIF}

extern CL_API_ENTRY cl_int CL_API_CALL
clEnqueueReadImage(cl_command_queue     command_queue,
                   cl_mem               image,
                   cl_bool              blocking_read,
                   const size_t *       origin,
                   const size_t *       region,
                   size_t               row_pitch,
                   size_t               slice_pitch,
                   void *               ptr,
                   cl_uint              num_events_in_wait_list,
                   const cl_event *     event_wait_list,
                   cl_event *           event) CL_API_SUFFIX__VERSION_1_0;

extern CL_API_ENTRY cl_int CL_API_CALL
clEnqueueWriteImage(cl_command_queue    command_queue,
                    cl_mem              image,
                    cl_bool             blocking_write,
                    const size_t *      origin,
                    const size_t *      region,
                    size_t              input_row_pitch,
                    size_t              input_slice_pitch,
                    const void *        ptr,
                    cl_uint             num_events_in_wait_list,
                    const cl_event *    event_wait_list,
                    cl_event *          event) CL_API_SUFFIX__VERSION_1_0;

{$IFDEF CL_VERSION_1_2 }

extern CL_API_ENTRY cl_int CL_API_CALL
clEnqueueFillImage(cl_command_queue   command_queue,
                   cl_mem             image,
                   const void *       fill_color,
                   const size_t *     origin,
                   const size_t *     region,
                   cl_uint            num_events_in_wait_list,
                   const cl_event *   event_wait_list,
                   cl_event *         event) CL_API_SUFFIX__VERSION_1_2;

{$ENDIF}

extern CL_API_ENTRY cl_int CL_API_CALL
clEnqueueCopyImage(cl_command_queue     command_queue,
                   cl_mem               src_image,
                   cl_mem               dst_image,
                   const size_t *       src_origin,
                   const size_t *       dst_origin,
                   const size_t *       region,
                   cl_uint              num_events_in_wait_list,
                   const cl_event *     event_wait_list,
                   cl_event *           event) CL_API_SUFFIX__VERSION_1_0;

extern CL_API_ENTRY cl_int CL_API_CALL
clEnqueueCopyImageToBuffer(cl_command_queue command_queue,
                           cl_mem           src_image,
                           cl_mem           dst_buffer,
                           const size_t *   src_origin,
                           const size_t *   region,
                           size_t           dst_offset,
                           cl_uint          num_events_in_wait_list,
                           const cl_event * event_wait_list,
                           cl_event *       event) CL_API_SUFFIX__VERSION_1_0;

extern CL_API_ENTRY cl_int CL_API_CALL
clEnqueueCopyBufferToImage(cl_command_queue command_queue,
                           cl_mem           src_buffer,
                           cl_mem           dst_image,
                           size_t           src_offset,
                           const size_t *   dst_origin,
                           const size_t *   region,
                           cl_uint          num_events_in_wait_list,
                           const cl_event * event_wait_list,
                           cl_event *       event) CL_API_SUFFIX__VERSION_1_0;

extern CL_API_ENTRY void * CL_API_CALL
clEnqueueMapBuffer(cl_command_queue command_queue,
                   cl_mem           buffer,
                   cl_bool          blocking_map,
                   cl_map_flags     map_flags,
                   size_t           offset,
                   size_t           size,
                   cl_uint          num_events_in_wait_list,
                   const cl_event * event_wait_list,
                   cl_event *       event,
                   cl_int *         errcode_ret) CL_API_SUFFIX__VERSION_1_0;

extern CL_API_ENTRY void * CL_API_CALL
clEnqueueMapImage(cl_command_queue  command_queue,
                  cl_mem            image,
                  cl_bool           blocking_map,
                  cl_map_flags      map_flags,
                  const size_t *    origin,
                  const size_t *    region,
                  size_t *          image_row_pitch,
                  size_t *          image_slice_pitch,
                  cl_uint           num_events_in_wait_list,
                  const cl_event *  event_wait_list,
                  cl_event *        event,
                  cl_int *          errcode_ret) CL_API_SUFFIX__VERSION_1_0;

extern CL_API_ENTRY cl_int CL_API_CALL
clEnqueueUnmapMemObject(cl_command_queue command_queue,
                        cl_mem           memobj,
                        void *           mapped_ptr,
                        cl_uint          num_events_in_wait_list,
                        const cl_event * event_wait_list,
                        cl_event *       event) CL_API_SUFFIX__VERSION_1_0;

{$IFDEF CL_VERSION_1_2 }

extern CL_API_ENTRY cl_int CL_API_CALL
clEnqueueMigrateMemObjects(cl_command_queue       command_queue,
                           cl_uint                num_mem_objects,
                           const cl_mem *         mem_objects,
                           cl_mem_migration_flags flags,
                           cl_uint                num_events_in_wait_list,
                           const cl_event *       event_wait_list,
                           cl_event *             event) CL_API_SUFFIX__VERSION_1_2;

{$ENDIF}

extern CL_API_ENTRY cl_int CL_API_CALL
clEnqueueNDRangeKernel(cl_command_queue command_queue,
                       cl_kernel        kernel,
                       cl_uint          work_dim,
                       const size_t *   global_work_offset,
                       const size_t *   global_work_size,
                       const size_t *   local_work_size,
                       cl_uint          num_events_in_wait_list,
                       const cl_event * event_wait_list,
                       cl_event *       event) CL_API_SUFFIX__VERSION_1_0;

extern CL_API_ENTRY cl_int CL_API_CALL
clEnqueueNativeKernel(cl_command_queue  command_queue,
                      void (CL_CALLBACK * user_func)(void *),
                      void *            args,
                      size_t            cb_args,
                      cl_uint           num_mem_objects,
                      const cl_mem *    mem_list,
                      const void **     args_mem_loc,
                      cl_uint           num_events_in_wait_list,
                      const cl_event *  event_wait_list,
                      cl_event *        event) CL_API_SUFFIX__VERSION_1_0;

{$IFDEF CL_VERSION_1_2 }

extern CL_API_ENTRY cl_int CL_API_CALL
clEnqueueMarkerWithWaitList(cl_command_queue  command_queue,
                            cl_uint           num_events_in_wait_list,
                            const cl_event *  event_wait_list,
                            cl_event *        event) CL_API_SUFFIX__VERSION_1_2;

extern CL_API_ENTRY cl_int CL_API_CALL
clEnqueueBarrierWithWaitList(cl_command_queue  command_queue,
                             cl_uint           num_events_in_wait_list,
                             const cl_event *  event_wait_list,
                             cl_event *        event) CL_API_SUFFIX__VERSION_1_2;

{$ENDIF}

{$IFDEF CL_VERSION_2_0 }

extern CL_API_ENTRY cl_int CL_API_CALL
clEnqueueSVMFree(cl_command_queue  command_queue,
                 cl_uint           num_svm_pointers,
                 void *            svm_pointers[],
                 void (CL_CALLBACK * pfn_free_func)(cl_command_queue queue,
                                                    cl_uint          num_svm_pointers,
                                                    void *           svm_pointers[],
                                                    void *           user_data),
                 void *            user_data,
                 cl_uint           num_events_in_wait_list,
                 const cl_event *  event_wait_list,
                 cl_event *        event) CL_API_SUFFIX__VERSION_2_0;

extern CL_API_ENTRY cl_int CL_API_CALL
clEnqueueSVMMemcpy(cl_command_queue  command_queue,
                   cl_bool           blocking_copy,
                   void *            dst_ptr,
                   const void *      src_ptr,
                   size_t            size,
                   cl_uint           num_events_in_wait_list,
                   const cl_event *  event_wait_list,
                   cl_event *        event) CL_API_SUFFIX__VERSION_2_0;

extern CL_API_ENTRY cl_int CL_API_CALL
clEnqueueSVMMemFill(cl_command_queue  command_queue,
                    void *            svm_ptr,
                    const void *      pattern,
                    size_t            pattern_size,
                    size_t            size,
                    cl_uint           num_events_in_wait_list,
                    const cl_event *  event_wait_list,
                    cl_event *        event) CL_API_SUFFIX__VERSION_2_0;

extern CL_API_ENTRY cl_int CL_API_CALL
clEnqueueSVMMap(cl_command_queue  command_queue,
                cl_bool           blocking_map,
                cl_map_flags      flags,
                void *            svm_ptr,
                size_t            size,
                cl_uint           num_events_in_wait_list,
                const cl_event *  event_wait_list,
                cl_event *        event) CL_API_SUFFIX__VERSION_2_0;

extern CL_API_ENTRY cl_int CL_API_CALL
clEnqueueSVMUnmap(cl_command_queue  command_queue,
                  void *            svm_ptr,
                  cl_uint           num_events_in_wait_list,
                  const cl_event *  event_wait_list,
                  cl_event *        event) CL_API_SUFFIX__VERSION_2_0;

{$ENDIF}

{$IFDEF CL_VERSION_2_1 }

extern CL_API_ENTRY cl_int CL_API_CALL
clEnqueueSVMMigrateMem(cl_command_queue         command_queue,
                       cl_uint                  num_svm_pointers,
                       const void **            svm_pointers,
                       const size_t *           sizes,
                       cl_mem_migration_flags   flags,
                       cl_uint                  num_events_in_wait_list,
                       const cl_event *         event_wait_list,
                       cl_event *               event) CL_API_SUFFIX__VERSION_2_1;

{$ENDIF}

{$IFDEF CL_VERSION_1_2 }

(* Extension function access
 *
 * Returns the extension function address for the given function name,
 * or NULL if a valid function can not be found.  The client must
 * check to make sure the address is not NULL, before using or
 * calling the returned function address.
 *)
extern CL_API_ENTRY void * CL_API_CALL
clGetExtensionFunctionAddressForPlatform(cl_platform_id platform,
                                         const char *   func_name) CL_API_SUFFIX__VERSION_1_2;

{$ENDIF}

{$IFDEF CL_USE_DEPRECATED_OPENCL_1_0_APIS }
    (*
     *  WARNING:
     *     This API introduces mutable state into the OpenCL implementation. It has been REMOVED
     *  to better facilitate thread safety.  The 1.0 API is not thread safe. It is not tested by the
     *  OpenCL 1.1 conformance test, and consequently may not work or may not work dependably.
     *  It is likely to be non-performant. Use of this API is not advised. Use at your own risk.
     *
     *  Software developers previously relying on this API are instructed to set the command queue
     *  properties when creating the queue, instead.
     *)
    extern CL_API_ENTRY cl_int CL_API_CALL
    clSetCommandQueueProperty(cl_command_queue              command_queue,
                              cl_command_queue_properties   properties,
                              cl_bool                       enable,
                              cl_command_queue_properties * old_properties) CL_EXT_SUFFIX__VERSION_1_0_DEPRECATED;
{$ENDIF} (* CL_USE_DEPRECATED_OPENCL_1_0_APIS *)

(* Deprecated OpenCL 1.1 APIs *)
extern CL_API_ENTRY CL_EXT_PREFIX__VERSION_1_1_DEPRECATED cl_mem CL_API_CALL
clCreateImage2D(cl_context              context,
                cl_mem_flags            flags,
                const cl_image_format * image_format,
                size_t                  image_width,
                size_t                  image_height,
                size_t                  image_row_pitch,
                void *                  host_ptr,
                cl_int *                errcode_ret) CL_EXT_SUFFIX__VERSION_1_1_DEPRECATED;

extern CL_API_ENTRY CL_EXT_PREFIX__VERSION_1_1_DEPRECATED cl_mem CL_API_CALL
clCreateImage3D(cl_context              context,
                cl_mem_flags            flags,
                const cl_image_format * image_format,
                size_t                  image_width,
                size_t                  image_height,
                size_t                  image_depth,
                size_t                  image_row_pitch,
                size_t                  image_slice_pitch,
                void *                  host_ptr,
                cl_int *                errcode_ret) CL_EXT_SUFFIX__VERSION_1_1_DEPRECATED;

extern CL_API_ENTRY CL_EXT_PREFIX__VERSION_1_1_DEPRECATED cl_int CL_API_CALL
clEnqueueMarker(cl_command_queue    command_queue,
                cl_event *          event) CL_EXT_SUFFIX__VERSION_1_1_DEPRECATED;

extern CL_API_ENTRY CL_EXT_PREFIX__VERSION_1_1_DEPRECATED cl_int CL_API_CALL
clEnqueueWaitForEvents(cl_command_queue  command_queue,
                        cl_uint          num_events,
                        const cl_event * event_list) CL_EXT_SUFFIX__VERSION_1_1_DEPRECATED;

extern CL_API_ENTRY CL_EXT_PREFIX__VERSION_1_1_DEPRECATED cl_int CL_API_CALL
clEnqueueBarrier(cl_command_queue command_queue) CL_EXT_SUFFIX__VERSION_1_1_DEPRECATED;

extern CL_API_ENTRY CL_EXT_PREFIX__VERSION_1_1_DEPRECATED cl_int CL_API_CALL
clUnloadCompiler(void) CL_EXT_SUFFIX__VERSION_1_1_DEPRECATED;

extern CL_API_ENTRY CL_EXT_PREFIX__VERSION_1_1_DEPRECATED void * CL_API_CALL
clGetExtensionFunctionAddress(const char * func_name) CL_EXT_SUFFIX__VERSION_1_1_DEPRECATED;

(* Deprecated OpenCL 2.0 APIs *)
extern CL_API_ENTRY CL_EXT_PREFIX__VERSION_1_2_DEPRECATED cl_command_queue CL_API_CALL
clCreateCommandQueue(cl_context                     context,
                     cl_device_id                   device,
                     cl_command_queue_properties    properties,
                     cl_int *                       errcode_ret) CL_EXT_SUFFIX__VERSION_1_2_DEPRECATED;

extern CL_API_ENTRY CL_EXT_PREFIX__VERSION_1_2_DEPRECATED cl_sampler CL_API_CALL
clCreateSampler(cl_context          context,
                cl_bool             normalized_coords,
                cl_addressing_mode  addressing_mode,
                cl_filter_mode      filter_mode,
                cl_int *            errcode_ret) CL_EXT_SUFFIX__VERSION_1_2_DEPRECATED;

extern CL_API_ENTRY CL_EXT_PREFIX__VERSION_1_2_DEPRECATED cl_int CL_API_CALL
clEnqueueTask(cl_command_queue  command_queue,
              cl_kernel         kernel,
              cl_uint           num_events_in_wait_list,
              const cl_event *  event_wait_list,
              cl_event *        event) CL_EXT_SUFFIX__VERSION_1_2_DEPRECATED;

implementation //############################################################### ■

end. //######################################################################### ■
