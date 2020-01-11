unit OpenCL.cl;

interface //#################################################################### ��

(*******************************************************************************
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
 ******************************************************************************)

uses OpenCL.cl_platform,
     LUX.Code.C;

const DLLNAME = 'OpenCL.dll';

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

type P_cl_platform_id   = ^T_cl_platform_id  ;
type P_cl_device_id     = ^T_cl_device_id    ;
type P_cl_context       = ^T_cl_context      ;
type P_cl_command_queue = ^T_cl_command_queue;
type P_cl_mem           = ^T_cl_mem          ;
type P_cl_program       = ^T_cl_program      ;
type P_cl_kernel        = ^T_cl_kernel       ;
type P_cl_event         = ^T_cl_event        ;
type P_cl_sampler       = ^T_cl_sampler      ;

type T_cl_bool                         = T_cl_uint;  (* WARNING!  Unlike cl_ types in cl_platform.h, cl_bool is not guaranteed to be the same size as the bool in kernels. *)
type T_cl_bitfield                     = T_cl_ulong;
type T_cl_device_type                  = T_cl_bitfield;
type T_cl_platform_info                = T_cl_uint;
type T_cl_device_info                  = T_cl_uint;
type T_cl_device_fp_config             = T_cl_bitfield;
type T_cl_device_mem_cache_type        = T_cl_uint;
type T_cl_device_local_mem_type        = T_cl_uint;
type T_cl_device_exec_capabilities     = T_cl_bitfield;
type T_cl_device_svm_capabilities      = T_cl_bitfield;
type T_cl_command_queue_properties     = T_cl_bitfield;
type T_cl_device_partition_property    = T_intptr_t;
type T_cl_device_affinity_domain       = T_cl_bitfield;

type P_cl_bool                         = P_cl_uint;
type P_cl_bitfield                     = P_cl_ulong;
type P_cl_device_type                  = P_cl_bitfield;
type P_cl_platform_info                = P_cl_uint;
type P_cl_device_info                  = P_cl_uint;
type P_cl_device_fp_config             = P_cl_bitfield;
type P_cl_device_mem_cache_type        = P_cl_uint;
type P_cl_device_local_mem_type        = P_cl_uint;
type P_cl_device_exec_capabilities     = P_cl_bitfield;
type P_cl_device_svm_capabilities      = P_cl_bitfield;
type P_cl_command_queue_properties     = P_cl_bitfield;
type P_cl_device_partition_property    = P_intptr_t;
type P_cl_device_affinity_domain       = P_cl_bitfield;

type T_cl_context_properties           = T_intptr_t;
type T_cl_context_info                 = T_cl_uint;
type T_cl_queue_properties             = T_cl_bitfield;
type T_cl_command_queue_info           = T_cl_uint;
type T_cl_channel_order                = T_cl_uint;
type T_cl_channel_type                 = T_cl_uint;
type T_cl_mem_flags                    = T_cl_bitfield;
type T_cl_svm_mem_flags                = T_cl_bitfield;
type T_cl_mem_object_type              = T_cl_uint;
type T_cl_mem_info                     = T_cl_uint;
type T_cl_mem_migration_flags          = T_cl_bitfield;
type T_cl_image_info                   = T_cl_uint;
type T_cl_buffer_create_type           = T_cl_uint;
type T_cl_addressing_mode              = T_cl_uint;
type T_cl_filter_mode                  = T_cl_uint;
type T_cl_sampler_info                 = T_cl_uint;
type T_cl_map_flags                    = T_cl_bitfield;
type T_cl_pipe_properties              = T_intptr_t;
type T_cl_pipe_info                    = T_cl_uint;
type T_cl_program_info                 = T_cl_uint;
type T_cl_program_build_info           = T_cl_uint;
type T_cl_program_binary_type          = T_cl_uint;
type T_cl_build_status                 = T_cl_int;
type T_cl_kernel_info                  = T_cl_uint;
type T_cl_kernel_arg_info              = T_cl_uint;
type T_cl_kernel_arg_address_qualifier = T_cl_uint;
type T_cl_kernel_arg_access_qualifier  = T_cl_uint;
type T_cl_kernel_arg_type_qualifier    = T_cl_bitfield;
type T_cl_kernel_work_group_info       = T_cl_uint;
type T_cl_kernel_sub_group_info        = T_cl_uint;
type T_cl_event_info                   = T_cl_uint;
type T_cl_command_type                 = T_cl_uint;
type T_cl_profiling_info               = T_cl_uint;
type T_cl_sampler_properties           = T_cl_bitfield;
type T_cl_kernel_exec_info             = T_cl_uint;

type P_cl_context_properties           = P_intptr_t;
type P_cl_context_info                 = P_cl_uint;
type P_cl_queue_properties             = P_cl_bitfield;
type P_cl_command_queue_info           = P_cl_uint;
type P_cl_channel_order                = P_cl_uint;
type P_cl_channel_type                 = P_cl_uint;
type P_cl_mem_flags                    = P_cl_bitfield;
type P_cl_svm_mem_flags                = P_cl_bitfield;
type P_cl_mem_object_type              = P_cl_uint;
type P_cl_mem_info                     = P_cl_uint;
type P_cl_mem_migration_flags          = P_cl_bitfield;
type P_cl_image_info                   = P_cl_uint;
type P_cl_buffer_create_type           = P_cl_uint;
type P_cl_addressing_mode              = P_cl_uint;
type P_cl_filter_mode                  = P_cl_uint;
type P_cl_sampler_info                 = P_cl_uint;
type P_cl_map_flags                    = P_cl_bitfield;
type P_cl_pipe_properties              = P_intptr_t;
type P_cl_pipe_info                    = P_cl_uint;
type P_cl_program_info                 = P_cl_uint;
type P_cl_program_build_info           = P_cl_uint;
type P_cl_program_binary_type          = P_cl_uint;
type P_cl_build_status                 = P_cl_int;
type P_cl_kernel_info                  = P_cl_uint;
type P_cl_kernel_arg_info              = P_cl_uint;
type P_cl_kernel_arg_address_qualifier = P_cl_uint;
type P_cl_kernel_arg_access_qualifier  = P_cl_uint;
type P_cl_kernel_arg_type_qualifier    = P_cl_bitfield;
type P_cl_kernel_work_group_info       = P_cl_uint;
type P_cl_kernel_sub_group_info        = P_cl_uint;
type P_cl_event_info                   = P_cl_uint;
type P_cl_command_type                 = P_cl_uint;
type P_cl_profiling_info               = P_cl_uint;
type P_cl_sampler_properties           = P_cl_bitfield;
type P_cl_kernel_exec_info             = P_cl_uint;

type P_cl_image_format = ^T_cl_image_format;
     T_cl_image_format = record
       image_channel_order     :T_cl_channel_order;
       image_channel_data_type :T_cl_channel_type;
     end;

type P_cl_image_desc = ^T_cl_image_desc;
     T_cl_image_desc = record
          image_type        :T_cl_mem_object_type;
          image_width       :T_size_t;
          image_height      :T_size_t;
          image_depth       :T_size_t;
          image_array_size  :T_size_t;
          image_row_pitch   :T_size_t;
          image_slice_pitch :T_size_t;
          num_mip_levels    :T_cl_uint;
          num_samples       :T_cl_uint;
     case Integer of
       0:( buffer     :T_cl_mem; );
       1:( mem_object :T_cl_mem; );
     end;

type P__cl_buffer_region = ^T__cl_buffer_region;
     T__cl_buffer_region = record
       origin :T_size_t;
       size   :T_size_t;
     end;

(******************************************************************************)

(* Error Codes *)
const CL_SUCCESS                                   =  0;
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
const CL_MISALIGNED_SUB_BUFFER_OFFSET              = -13;
const CL_EXEC_STATUS_ERROR_FOR_EVENTS_IN_WAIT_LIST = -14;
const CL_COMPILE_PROGRAM_FAILURE                   = -15;
const CL_LINKER_NOT_AVAILABLE                      = -16;
const CL_LINK_PROGRAM_FAILURE                      = -17;
const CL_DEVICE_PARTITION_FAILED                   = -18;
const CL_KERNEL_ARG_INFO_NOT_AVAILABLE             = -19;

const CL_INVALID_VALUE                            = -30;
const CL_INVALID_DEVICE_TYPE                      = -31;
const CL_INVALID_PLATFORM                         = -32;
const CL_INVALID_DEVICE                           = -33;
const CL_INVALID_CONTEXT                          = -34;
const CL_INVALID_QUEUE_PROPERTIES                 = -35;
const CL_INVALID_COMMAND_QUEUE                    = -36;
const CL_INVALID_HOST_PTR                         = -37;
const CL_INVALID_MEM_OBJECT                       = -38;
const CL_INVALID_IMAGE_FORMAT_DESCRIPTOR          = -39;
const CL_INVALID_IMAGE_SIZE                       = -40;
const CL_INVALID_SAMPLER                          = -41;
const CL_INVALID_BINARY                           = -42;
const CL_INVALID_BUILD_OPTIONS                    = -43;
const CL_INVALID_PROGRAM                          = -44;
const CL_INVALID_PROGRAM_EXECUTABLE               = -45;
const CL_INVALID_KERNEL_NAME                      = -46;
const CL_INVALID_KERNEL_DEFINITION                = -47;
const CL_INVALID_KERNEL                           = -48;
const CL_INVALID_ARG_INDEX                        = -49;
const CL_INVALID_ARG_VALUE                        = -50;
const CL_INVALID_ARG_SIZE                         = -51;
const CL_INVALID_KERNEL_ARGS                      = -52;
const CL_INVALID_WORK_DIMENSION                   = -53;
const CL_INVALID_WORK_GROUP_SIZE                  = -54;
const CL_INVALID_WORK_ITEM_SIZE                   = -55;
const CL_INVALID_GLOBAL_OFFSET                    = -56;
const CL_INVALID_EVENT_WAIT_LIST                  = -57;
const CL_INVALID_EVENT                            = -58;
const CL_INVALID_OPERATION                        = -59;
const CL_INVALID_GL_OBJECT                        = -60;
const CL_INVALID_BUFFER_SIZE                      = -61;
const CL_INVALID_MIP_LEVEL                        = -62;
const CL_INVALID_GLOBAL_WORK_SIZE                 = -63;
const CL_INVALID_PROPERTY                         = -64;
const CL_INVALID_IMAGE_DESCRIPTOR                 = -65;
const CL_INVALID_COMPILER_OPTIONS                 = -66;
const CL_INVALID_LINKER_OPTIONS                   = -67;
const CL_INVALID_DEVICE_PARTITION_COUNT           = -68;
const CL_INVALID_PIPE_SIZE                        = -69;
const CL_INVALID_DEVICE_QUEUE                     = -70;

(* OpenCL Version *)
const CL_VERSION_1_0                              = 1;
const CL_VERSION_1_1                              = 1;
const CL_VERSION_1_2                              = 1;
const CL_VERSION_2_0                              = 1;
const CL_VERSION_2_1                              = 1;

(* cl_bool *)
const CL_FALSE                                    = 0;
const CL_TRUE                                     = 1;
const CL_BLOCKING                                 = CL_TRUE;
const CL_NON_BLOCKING                             = CL_FALSE;

(* cl_platform_info *)
const CL_PLATFORM_PROFILE                         = $0900;
const CL_PLATFORM_VERSION                         = $0901;
const CL_PLATFORM_NAME                            = $0902;
const CL_PLATFORM_VENDOR                          = $0903;
const CL_PLATFORM_EXTENSIONS                      = $0904;
const CL_PLATFORM_HOST_TIMER_RESOLUTION           = $0905;

(* cl_device_type - bitfield *)
const CL_DEVICE_TYPE_DEFAULT                      = 1 shl 0;
const CL_DEVICE_TYPE_CPU                          = 1 shl 1;
const CL_DEVICE_TYPE_GPU                          = 1 shl 2;
const CL_DEVICE_TYPE_ACCELERATOR                  = 1 shl 3;
const CL_DEVICE_TYPE_CUSTOM                       = 1 shl 4;
const CL_DEVICE_TYPE_ALL                          = $FFFFFFFF;

(* cl_device_info *)
const CL_DEVICE_TYPE                                   = $1000;
const CL_DEVICE_VENDOR_ID                              = $1001;
const CL_DEVICE_MAX_COMPUTE_UNITS                      = $1002;
const CL_DEVICE_MAX_WORK_ITEM_DIMENSIONS               = $1003;
const CL_DEVICE_MAX_WORK_GROUP_SIZE                    = $1004;
const CL_DEVICE_MAX_WORK_ITEM_SIZES                    = $1005;
const CL_DEVICE_PREFERRED_VECTOR_WIDTH_CHAR            = $1006;
const CL_DEVICE_PREFERRED_VECTOR_WIDTH_SHORT           = $1007;
const CL_DEVICE_PREFERRED_VECTOR_WIDTH_INT             = $1008;
const CL_DEVICE_PREFERRED_VECTOR_WIDTH_LONG            = $1009;
const CL_DEVICE_PREFERRED_VECTOR_WIDTH_FLOAT           = $100A;
const CL_DEVICE_PREFERRED_VECTOR_WIDTH_DOUBLE          = $100B;
const CL_DEVICE_MAX_CLOCK_FREQUENCY                    = $100C;
const CL_DEVICE_ADDRESS_BITS                           = $100D;
const CL_DEVICE_MAX_READ_IMAGE_ARGS                    = $100E;
const CL_DEVICE_MAX_WRITE_IMAGE_ARGS                   = $100F;
const CL_DEVICE_MAX_MEM_ALLOC_SIZE                     = $1010;
const CL_DEVICE_IMAGE2D_MAX_WIDTH                      = $1011;
const CL_DEVICE_IMAGE2D_MAX_HEIGHT                     = $1012;
const CL_DEVICE_IMAGE3D_MAX_WIDTH                      = $1013;
const CL_DEVICE_IMAGE3D_MAX_HEIGHT                     = $1014;
const CL_DEVICE_IMAGE3D_MAX_DEPTH                      = $1015;
const CL_DEVICE_IMAGE_SUPPORT                          = $1016;
const CL_DEVICE_MAX_PARAMETER_SIZE                     = $1017;
const CL_DEVICE_MAX_SAMPLERS                           = $1018;
const CL_DEVICE_MEM_BASE_ADDR_ALIGN                    = $1019;
const CL_DEVICE_MIN_DATA_TYPE_ALIGN_SIZE               = $101A;
const CL_DEVICE_SINGLE_FP_CONFIG                       = $101B;
const CL_DEVICE_GLOBAL_MEM_CACHE_TYPE                  = $101C;
const CL_DEVICE_GLOBAL_MEM_CACHELINE_SIZE              = $101D;
const CL_DEVICE_GLOBAL_MEM_CACHE_SIZE                  = $101E;
const CL_DEVICE_GLOBAL_MEM_SIZE                        = $101F;
const CL_DEVICE_MAX_CONSTANT_BUFFER_SIZE               = $1020;
const CL_DEVICE_MAX_CONSTANT_ARGS                      = $1021;
const CL_DEVICE_LOCAL_MEM_TYPE                         = $1022;
const CL_DEVICE_LOCAL_MEM_SIZE                         = $1023;
const CL_DEVICE_ERROR_CORRECTION_SUPPORT               = $1024;
const CL_DEVICE_PROFILING_TIMER_RESOLUTION             = $1025;
const CL_DEVICE_ENDIAN_LITTLE                          = $1026;
const CL_DEVICE_AVAILABLE                              = $1027;
const CL_DEVICE_COMPILER_AVAILABLE                     = $1028;
const CL_DEVICE_EXECUTION_CAPABILITIES                 = $1029;
const CL_DEVICE_QUEUE_PROPERTIES                       = $102A;  (* deprecated *)
const CL_DEVICE_QUEUE_ON_HOST_PROPERTIES               = $102A;
const CL_DEVICE_NAME                                   = $102B;
const CL_DEVICE_VENDOR                                 = $102C;
const CL_DRIVER_VERSION                                = $102D;
const CL_DEVICE_PROFILE                                = $102E;
const CL_DEVICE_VERSION                                = $102F;
const CL_DEVICE_EXTENSIONS                             = $1030;
const CL_DEVICE_PLATFORM                               = $1031;
const CL_DEVICE_DOUBLE_FP_CONFIG                       = $1032;
(* 0x1033 reserved for CL_DEVICE_HALF_FP_CONFIG *)
const CL_DEVICE_PREFERRED_VECTOR_WIDTH_HALF            = $1034;
const CL_DEVICE_HOST_UNIFIED_MEMORY                    = $1035;  (* deprecated *)
const CL_DEVICE_NATIVE_VECTOR_WIDTH_CHAR               = $1036;
const CL_DEVICE_NATIVE_VECTOR_WIDTH_SHORT              = $1037;
const CL_DEVICE_NATIVE_VECTOR_WIDTH_INT                = $1038;
const CL_DEVICE_NATIVE_VECTOR_WIDTH_LONG               = $1039;
const CL_DEVICE_NATIVE_VECTOR_WIDTH_FLOAT              = $103A;
const CL_DEVICE_NATIVE_VECTOR_WIDTH_DOUBLE             = $103B;
const CL_DEVICE_NATIVE_VECTOR_WIDTH_HALF               = $103C;
const CL_DEVICE_OPENCL_C_VERSION                       = $103D;
const CL_DEVICE_LINKER_AVAILABLE                       = $103E;
const CL_DEVICE_BUILT_IN_KERNELS                       = $103F;
const CL_DEVICE_IMAGE_MAX_BUFFER_SIZE                  = $1040;
const CL_DEVICE_IMAGE_MAX_ARRAY_SIZE                   = $1041;
const CL_DEVICE_PARENT_DEVICE                          = $1042;
const CL_DEVICE_PARTITION_MAX_SUB_DEVICES              = $1043;
const CL_DEVICE_PARTITION_PROPERTIES                   = $1044;
const CL_DEVICE_PARTITION_AFFINITY_DOMAIN              = $1045;
const CL_DEVICE_PARTITION_TYPE                         = $1046;
const CL_DEVICE_REFERENCE_COUNT                        = $1047;
const CL_DEVICE_PREFERRED_INTEROP_USER_SYNC            = $1048;
const CL_DEVICE_PRINTF_BUFFER_SIZE                     = $1049;
const CL_DEVICE_IMAGE_PITCH_ALIGNMENT                  = $104A;
const CL_DEVICE_IMAGE_BASE_ADDRESS_ALIGNMENT           = $104B;
const CL_DEVICE_MAX_READ_WRITE_IMAGE_ARGS              = $104C;
const CL_DEVICE_MAX_GLOBAL_VARIABLE_SIZE               = $104D;
const CL_DEVICE_QUEUE_ON_DEVICE_PROPERTIES             = $104E;
const CL_DEVICE_QUEUE_ON_DEVICE_PREFERRED_SIZE         = $104F;
const CL_DEVICE_QUEUE_ON_DEVICE_MAX_SIZE               = $1050;
const CL_DEVICE_MAX_ON_DEVICE_QUEUES                   = $1051;
const CL_DEVICE_MAX_ON_DEVICE_EVENTS                   = $1052;
const CL_DEVICE_SVM_CAPABILITIES                       = $1053;
const CL_DEVICE_GLOBAL_VARIABLE_PREFERRED_TOTAL_SIZE   = $1054;
const CL_DEVICE_MAX_PIPE_ARGS                          = $1055;
const CL_DEVICE_PIPE_MAX_ACTIVE_RESERVATIONS           = $1056;
const CL_DEVICE_PIPE_MAX_PACKET_SIZE                   = $1057;
const CL_DEVICE_PREFERRED_PLATFORM_ATOMIC_ALIGNMENT    = $1058;
const CL_DEVICE_PREFERRED_GLOBAL_ATOMIC_ALIGNMENT      = $1059;
const CL_DEVICE_PREFERRED_LOCAL_ATOMIC_ALIGNMENT       = $105A;
const CL_DEVICE_IL_VERSION                             = $105B;
const CL_DEVICE_MAX_NUM_SUB_GROUPS                     = $105C;
const CL_DEVICE_SUB_GROUP_INDEPENDENT_FORWARD_PROGRESS = $105D;

(* cl_device_fp_config - bitfield *)
const CL_FP_DENORM                                = 1 shl 0;
const CL_FP_INF_NAN                               = 1 shl 1;
const CL_FP_ROUND_TO_NEAREST                      = 1 shl 2;
const CL_FP_ROUND_TO_ZERO                         = 1 shl 3;
const CL_FP_ROUND_TO_INF                          = 1 shl 4;
const CL_FP_FMA                                   = 1 shl 5;
const CL_FP_SOFT_FLOAT                            = 1 shl 6;
const CL_FP_CORRECTLY_ROUNDED_DIVIDE_SQRT         = 1 shl 7;

(* cl_device_mem_cache_type *)
const CL_NONE                                     = $0;
const CL_READ_ONLY_CACHE                          = $1;
const CL_READ_WRITE_CACHE                         = $2;

(* cl_device_local_mem_type *)
const CL_LOCAL                                    = $1;
const CL_GLOBAL                                   = $2;

(* cl_device_exec_capabilities - bitfield *)
const CL_EXEC_KERNEL                              = 1 shl 0;
const CL_EXEC_NATIVE_KERNEL                       = 1 shl 1;

(* cl_command_queue_properties - bitfield *)
const CL_QUEUE_OUT_OF_ORDER_EXEC_MODE_ENABLE      = 1 shl 0;
const CL_QUEUE_PROFILING_ENABLE                   = 1 shl 1;
const CL_QUEUE_ON_DEVICE                          = 1 shl 2;
const CL_QUEUE_ON_DEVICE_DEFAULT                  = 1 shl 3;

(* cl_context_info  *)
const CL_CONTEXT_REFERENCE_COUNT                  = $1080;
const CL_CONTEXT_DEVICES                          = $1081;
const CL_CONTEXT_PROPERTIES                       = $1082;
const CL_CONTEXT_NUM_DEVICES                      = $1083;

(* cl_context_properties *)
const CL_CONTEXT_PLATFORM                         = $1084;
const CL_CONTEXT_INTEROP_USER_SYNC                = $1085;
    
(* cl_device_partition_property *)
const CL_DEVICE_PARTITION_EQUALLY                 = $1086;
const CL_DEVICE_PARTITION_BY_COUNTS               = $1087;
const CL_DEVICE_PARTITION_BY_COUNTS_LIST_END      = $0;
const CL_DEVICE_PARTITION_BY_AFFINITY_DOMAIN      = $1088;

(* cl_device_affinity_domain *)
const CL_DEVICE_AFFINITY_DOMAIN_NUMA               = 1 shl 0;
const CL_DEVICE_AFFINITY_DOMAIN_L4_CACHE           = 1 shl 1;
const CL_DEVICE_AFFINITY_DOMAIN_L3_CACHE           = 1 shl 2;
const CL_DEVICE_AFFINITY_DOMAIN_L2_CACHE           = 1 shl 3;
const CL_DEVICE_AFFINITY_DOMAIN_L1_CACHE           = 1 shl 4;
const CL_DEVICE_AFFINITY_DOMAIN_NEXT_PARTITIONABLE = 1 shl 5;
    
(* cl_device_svm_capabilities *)
const CL_DEVICE_SVM_COARSE_GRAIN_BUFFER           = 1 shl 0;
const CL_DEVICE_SVM_FINE_GRAIN_BUFFER             = 1 shl 1;
const CL_DEVICE_SVM_FINE_GRAIN_SYSTEM             = 1 shl 2;
const CL_DEVICE_SVM_ATOMICS                       = 1 shl 3;

(* cl_command_queue_info *)
const CL_QUEUE_CONTEXT                            = $1090;
const CL_QUEUE_DEVICE                             = $1091;
const CL_QUEUE_REFERENCE_COUNT                    = $1092;
const CL_QUEUE_PROPERTIES                         = $1093;
const CL_QUEUE_SIZE                               = $1094;
const CL_QUEUE_DEVICE_DEFAULT                     = $1095;

(* cl_mem_flags and cl_svm_mem_flags - bitfield *)
const CL_MEM_READ_WRITE                           = 1 shl 0;
const CL_MEM_WRITE_ONLY                           = 1 shl 1;
const CL_MEM_READ_ONLY                            = 1 shl 2;
const CL_MEM_USE_HOST_PTR                         = 1 shl 3;
const CL_MEM_ALLOC_HOST_PTR                       = 1 shl 4;
const CL_MEM_COPY_HOST_PTR                        = 1 shl 5;
(* reserved                                         (1 << 6)    *)
const CL_MEM_HOST_WRITE_ONLY                      = 1 shl 7;
const CL_MEM_HOST_READ_ONLY                       = 1 shl 8;
const CL_MEM_HOST_NO_ACCESS                       = 1 shl 9;
const CL_MEM_SVM_FINE_GRAIN_BUFFER                = 1 shl 10;   (* used by cl_svm_mem_flags only *)
const CL_MEM_SVM_ATOMICS                          = 1 shl 11;   (* used by cl_svm_mem_flags only *)
const CL_MEM_KERNEL_READ_AND_WRITE                = 1 shl 12;

(* cl_mem_migration_flags - bitfield *)
const CL_MIGRATE_MEM_OBJECT_HOST                  = 1 shl 0;
const CL_MIGRATE_MEM_OBJECT_CONTENT_UNDEFINED     = 1 shl 1;

(* cl_channel_order *)
const CL_R                                        = $10B0;
const CL_A                                        = $10B1;
const CL_RG                                       = $10B2;
const CL_RA                                       = $10B3;
const CL_RGB                                      = $10B4;
const CL_RGBA                                     = $10B5;
const CL_BGRA                                     = $10B6;
const CL_ARGB                                     = $10B7;
const CL_INTENSITY                                = $10B8;
const CL_LUMINANCE                                = $10B9;
const CL_Rx                                       = $10BA;
const CL_RGx                                      = $10BB;
const CL_RGBx                                     = $10BC;
const CL_DEPTH                                    = $10BD;
const CL_DEPTH_STENCIL                            = $10BE;
const CL_sRGB                                     = $10BF;
const CL_sRGBx                                    = $10C0;
const CL_sRGBA                                    = $10C1;
const CL_sBGRA                                    = $10C2;
const CL_ABGR                                     = $10C3;

(* cl_channel_type *)
const CL_SNORM_INT8                               = $10D0;
const CL_SNORM_INT16                              = $10D1;
const CL_UNORM_INT8                               = $10D2;
const CL_UNORM_INT16                              = $10D3;
const CL_UNORM_SHORT_565                          = $10D4;
const CL_UNORM_SHORT_555                          = $10D5;
const CL_UNORM_INT_101010                         = $10D6;
const CL_SIGNED_INT8                              = $10D7;
const CL_SIGNED_INT16                             = $10D8;
const CL_SIGNED_INT32                             = $10D9;
const CL_UNSIGNED_INT8                            = $10DA;
const CL_UNSIGNED_INT16                           = $10DB;
const CL_UNSIGNED_INT32                           = $10DC;
const CL_HALF_FLOAT                               = $10DD;
const CL_FLOAT                                    = $10DE;
const CL_UNORM_INT24                              = $10DF;
const CL_UNORM_INT_101010_2                       = $10E0;

(* cl_mem_object_type *)
const CL_MEM_OBJECT_BUFFER                        = $10F0;
const CL_MEM_OBJECT_IMAGE2D                       = $10F1;
const CL_MEM_OBJECT_IMAGE3D                       = $10F2;
const CL_MEM_OBJECT_IMAGE2D_ARRAY                 = $10F3;
const CL_MEM_OBJECT_IMAGE1D                       = $10F4;
const CL_MEM_OBJECT_IMAGE1D_ARRAY                 = $10F5;
const CL_MEM_OBJECT_IMAGE1D_BUFFER                = $10F6;
const CL_MEM_OBJECT_PIPE                          = $10F7;

(* cl_mem_info *)
const CL_MEM_TYPE                                 = $1100;
const CL_MEM_FLAGS                                = $1101;
const CL_MEM_SIZE                                 = $1102;
const CL_MEM_HOST_PTR                             = $1103;
const CL_MEM_MAP_COUNT                            = $1104;
const CL_MEM_REFERENCE_COUNT                      = $1105;
const CL_MEM_CONTEXT                              = $1106;
const CL_MEM_ASSOCIATED_MEMOBJECT                 = $1107;
const CL_MEM_OFFSET                               = $1108;
const CL_MEM_USES_SVM_POINTER                     = $1109;

(* cl_image_info *)
const CL_IMAGE_FORMAT                             = $1110;
const CL_IMAGE_ELEMENT_SIZE                       = $1111;
const CL_IMAGE_ROW_PITCH                          = $1112;
const CL_IMAGE_SLICE_PITCH                        = $1113;
const CL_IMAGE_WIDTH                              = $1114;
const CL_IMAGE_HEIGHT                             = $1115;
const CL_IMAGE_DEPTH                              = $1116;
const CL_IMAGE_ARRAY_SIZE                         = $1117;
const CL_IMAGE_BUFFER                             = $1118;
const CL_IMAGE_NUM_MIP_LEVELS                     = $1119;
const CL_IMAGE_NUM_SAMPLES                        = $111A;
    
(* cl_pipe_info *)
const CL_PIPE_PACKET_SIZE                         = $1120;
const CL_PIPE_MAX_PACKETS                         = $1121;

(* cl_addressing_mode *)
const CL_ADDRESS_NONE                             = $1130;
const CL_ADDRESS_CLAMP_TO_EDGE                    = $1131;
const CL_ADDRESS_CLAMP                            = $1132;
const CL_ADDRESS_REPEAT                           = $1133;
const CL_ADDRESS_MIRRORED_REPEAT                  = $1134;

(* cl_filter_mode *)
const CL_FILTER_NEAREST                           = $1140;
const CL_FILTER_LINEAR                            = $1141;

(* cl_sampler_info *)
const CL_SAMPLER_REFERENCE_COUNT                  = $1150;
const CL_SAMPLER_CONTEXT                          = $1151;
const CL_SAMPLER_NORMALIZED_COORDS                = $1152;
const CL_SAMPLER_ADDRESSING_MODE                  = $1153;
const CL_SAMPLER_FILTER_MODE                      = $1154;
const CL_SAMPLER_MIP_FILTER_MODE                  = $1155;
const CL_SAMPLER_LOD_MIN                          = $1156;
const CL_SAMPLER_LOD_MAX                          = $1157;

(* cl_map_flags - bitfield *)
const CL_MAP_READ                                 = 1 shl 0;
const CL_MAP_WRITE                                = 1 shl 1;
const CL_MAP_WRITE_INVALIDATE_REGION              = 1 shl 2;

(* cl_program_info *)
const CL_PROGRAM_REFERENCE_COUNT                  = $1160;
const CL_PROGRAM_CONTEXT                          = $1161;
const CL_PROGRAM_NUM_DEVICES                      = $1162;
const CL_PROGRAM_DEVICES                          = $1163;
const CL_PROGRAM_SOURCE                           = $1164;
const CL_PROGRAM_BINARY_SIZES                     = $1165;
const CL_PROGRAM_BINARIES                         = $1166;
const CL_PROGRAM_NUM_KERNELS                      = $1167;
const CL_PROGRAM_KERNEL_NAMES                     = $1168;
const CL_PROGRAM_IL                               = $1169;

(* cl_program_build_info *)
const CL_PROGRAM_BUILD_STATUS                     = $1181;
const CL_PROGRAM_BUILD_OPTIONS                    = $1182;
const CL_PROGRAM_BUILD_LOG                        = $1183;
const CL_PROGRAM_BINARY_TYPE                      = $1184;
const CL_PROGRAM_BUILD_GLOBAL_VARIABLE_TOTAL_SIZE = $1185;
    
(* cl_program_binary_type *)
const CL_PROGRAM_BINARY_TYPE_NONE                 = $0;
const CL_PROGRAM_BINARY_TYPE_COMPILED_OBJECT      = $1;
const CL_PROGRAM_BINARY_TYPE_LIBRARY              = $2;
const CL_PROGRAM_BINARY_TYPE_EXECUTABLE           = $4;

(* cl_build_status *)
const CL_BUILD_SUCCESS                            =  0;
const CL_BUILD_NONE                               = -1;
const CL_BUILD_ERROR                              = -2;
const CL_BUILD_IN_PROGRESS                        = -3;

(* cl_kernel_info *)
const CL_KERNEL_FUNCTION_NAME                     = $1190;
const CL_KERNEL_NUM_ARGS                          = $1191;
const CL_KERNEL_REFERENCE_COUNT                   = $1192;
const CL_KERNEL_CONTEXT                           = $1193;
const CL_KERNEL_PROGRAM                           = $1194;
const CL_KERNEL_ATTRIBUTES                        = $1195;
const CL_KERNEL_MAX_NUM_SUB_GROUPS                = $11B9;
const CL_KERNEL_COMPILE_NUM_SUB_GROUPS            = $11BA;

(* cl_kernel_arg_info *)
const CL_KERNEL_ARG_ADDRESS_QUALIFIER             = $1196;
const CL_KERNEL_ARG_ACCESS_QUALIFIER              = $1197;
const CL_KERNEL_ARG_TYPE_NAME                     = $1198;
const CL_KERNEL_ARG_TYPE_QUALIFIER                = $1199;
const CL_KERNEL_ARG_NAME                          = $119A;

(* cl_kernel_arg_address_qualifier *)
const CL_KERNEL_ARG_ADDRESS_GLOBAL                = $119B;
const CL_KERNEL_ARG_ADDRESS_LOCAL                 = $119C;
const CL_KERNEL_ARG_ADDRESS_CONSTANT              = $119D;
const CL_KERNEL_ARG_ADDRESS_PRIVATE               = $119E;

(* cl_kernel_arg_access_qualifier *)
const CL_KERNEL_ARG_ACCESS_READ_ONLY              = $11A0;
const CL_KERNEL_ARG_ACCESS_WRITE_ONLY             = $11A1;
const CL_KERNEL_ARG_ACCESS_READ_WRITE             = $11A2;
const CL_KERNEL_ARG_ACCESS_NONE                   = $11A3;
    
(* cl_kernel_arg_type_qualifer *)
const CL_KERNEL_ARG_TYPE_NONE                     = 0;
const CL_KERNEL_ARG_TYPE_CONST                    = 1 shl 0;
const CL_KERNEL_ARG_TYPE_RESTRICT                 = 1 shl 1;
const CL_KERNEL_ARG_TYPE_VOLATILE                 = 1 shl 2;
const CL_KERNEL_ARG_TYPE_PIPE                     = 1 shl 3;

(* cl_kernel_work_group_info *)
const CL_KERNEL_WORK_GROUP_SIZE                   = $11B0;
const CL_KERNEL_COMPILE_WORK_GROUP_SIZE           = $11B1;
const CL_KERNEL_LOCAL_MEM_SIZE                    = $11B2;
const CL_KERNEL_PREFERRED_WORK_GROUP_SIZE_MULTIPLE = $11B3;
const CL_KERNEL_PRIVATE_MEM_SIZE                  = $11B4;
const CL_KERNEL_GLOBAL_WORK_SIZE                  = $11B5;

(* cl_kernel_sub_group_info *)
const CL_KERNEL_MAX_SUB_GROUP_SIZE_FOR_NDRANGE    = $2033;
const CL_KERNEL_SUB_GROUP_COUNT_FOR_NDRANGE       = $2034;
const CL_KERNEL_LOCAL_SIZE_FOR_SUB_GROUP_COUNT    = $11B8;
    
(* cl_kernel_exec_info *)
const CL_KERNEL_EXEC_INFO_SVM_PTRS                = $11B6;
const CL_KERNEL_EXEC_INFO_SVM_FINE_GRAIN_SYSTEM   = $11B7;

(* cl_event_info  *)
const CL_EVENT_COMMAND_QUEUE                      = $11D0;
const CL_EVENT_COMMAND_TYPE                       = $11D1;
const CL_EVENT_REFERENCE_COUNT                    = $11D2;
const CL_EVENT_COMMAND_EXECUTION_STATUS           = $11D3;
const CL_EVENT_CONTEXT                            = $11D4;

(* cl_command_type *)
const CL_COMMAND_NDRANGE_KERNEL                   = $11F0;
const CL_COMMAND_TASK                             = $11F1;
const CL_COMMAND_NATIVE_KERNEL                    = $11F2;
const CL_COMMAND_READ_BUFFER                      = $11F3;
const CL_COMMAND_WRITE_BUFFER                     = $11F4;
const CL_COMMAND_COPY_BUFFER                      = $11F5;
const CL_COMMAND_READ_IMAGE                       = $11F6;
const CL_COMMAND_WRITE_IMAGE                      = $11F7;
const CL_COMMAND_COPY_IMAGE                       = $11F8;
const CL_COMMAND_COPY_IMAGE_TO_BUFFER             = $11F9;
const CL_COMMAND_COPY_BUFFER_TO_IMAGE             = $11FA;
const CL_COMMAND_MAP_BUFFER                       = $11FB;
const CL_COMMAND_MAP_IMAGE                        = $11FC;
const CL_COMMAND_UNMAP_MEM_OBJECT                 = $11FD;
const CL_COMMAND_MARKER                           = $11FE;
const CL_COMMAND_ACQUIRE_GL_OBJECTS               = $11FF;
const CL_COMMAND_RELEASE_GL_OBJECTS               = $1200;
const CL_COMMAND_READ_BUFFER_RECT                 = $1201;
const CL_COMMAND_WRITE_BUFFER_RECT                = $1202;
const CL_COMMAND_COPY_BUFFER_RECT                 = $1203;
const CL_COMMAND_USER                             = $1204;
const CL_COMMAND_BARRIER                          = $1205;
const CL_COMMAND_MIGRATE_MEM_OBJECTS              = $1206;
const CL_COMMAND_FILL_BUFFER                      = $1207;
const CL_COMMAND_FILL_IMAGE                       = $1208;
const CL_COMMAND_SVM_FREE                         = $1209;
const CL_COMMAND_SVM_MEMCPY                       = $120A;
const CL_COMMAND_SVM_MEMFILL                      = $120B;
const CL_COMMAND_SVM_MAP                          = $120C;
const CL_COMMAND_SVM_UNMAP                        = $120D;

(* command execution status *)
const CL_COMPLETE                                 = $0;
const CL_RUNNING                                  = $1;
const CL_SUBMITTED                                = $2;
const CL_QUEUED                                   = $3;

(* cl_buffer_create_type  *)
const CL_BUFFER_CREATE_TYPE_REGION                = $1220;

(* cl_profiling_info  *)
const CL_PROFILING_COMMAND_QUEUED                 = $1280;
const CL_PROFILING_COMMAND_SUBMIT                 = $1281;
const CL_PROFILING_COMMAND_START                  = $1282;
const CL_PROFILING_COMMAND_END                    = $1283;
const CL_PROFILING_COMMAND_COMPLETE               = $1284;

(********************************************************************************************************)

(* Platform API *)
function
clGetPlatformIDs( num_entries_   :T_cl_uint;
                  platforms_     :P_cl_platform_id;
                  num_platforms_ :P_cl_uint        ) :T_cl_int; stdcall; external DLLNAME;

function
clGetPlatformInfo( platform_             :T_cl_platform_id;
                   param_name_           :T_cl_platform_info;
                   param_value_size_     :T_size_t;
                   param_value_          :P_void;
                   param_value_size_ret_ :P_size_t           ) :T_cl_int; stdcall; external DLLNAME;

(* Device APIs *)
function
clGetDeviceIDs( platform_    :T_cl_platform_id;
                device_type_ :T_cl_device_type;
                num_entries_ :T_cl_uint;
                devices_     :P_cl_device_id;
                num_devices_ :P_cl_uint        ) :T_cl_int; stdcall; external DLLNAME;

function
clGetDeviceInfo( device_               :T_cl_device_id;
                 param_name_           :T_cl_device_info;
                 param_value_size_     :T_size_t;
                 param_value_          :P_void;
                 param_value_size_ret_ :P_size_t         ) :T_cl_int; stdcall; external DLLNAME;

function
clCreateSubDevices(       in_device_       :T_cl_device_id;
                    const properties_      :P_cl_device_partition_property;
                          num_devices_     :T_cl_uint;
                          out_devices_     :P_cl_device_id;
                          num_devices_ret_ :P_cl_uint                      ) :T_cl_int; stdcall; external DLLNAME;

function
clRetainDevice( device_ :T_cl_device_id ) :T_cl_int; stdcall; external DLLNAME;
    
function
clReleaseDevice( device_ :T_cl_device_id ) :T_cl_int; stdcall; external DLLNAME;

function
clSetDefaultDeviceCommandQueue( context_       :T_cl_context;
                                device_        :T_cl_device_id;
                                command_queue_ :T_cl_command_queue ) :T_cl_int; stdcall; external DLLNAME;

function
clGetDeviceAndHostTimer( device_           :T_cl_device_id;
                         device_timestamp_ :P_cl_ulong;
                         host_timestamp_   :P_cl_ulong     ) :T_cl_int; stdcall; external DLLNAME;

function
clGetHostTimer( device_         :T_cl_device_id;
                host_timestamp_ :P_cl_ulong     )  :T_cl_int; stdcall; external DLLNAME;

type PFN_clCreateContext_notify = procedure( const _1:P_char; const _2:P_void; _3:T_size_t; _4:P_void );

(* Context APIs  *)
function
clCreateContext( const properties_  :P_cl_context_properties;
                       num_devices_ :T_cl_uint;
                 const devices_     :P_cl_device_id;
                       pfn_notify_  :PFN_clCreateContext_notify;
                       user_data_   :P_void;
                       errcode_ret_ :P_cl_int                   ) :T_cl_context; stdcall; external DLLNAME;

function
clCreateContextFromType( const properties_  :P_cl_context_properties;
                               device_type_ :T_cl_device_type;
                               pfn_notify_  :PFN_clCreateContext_notify;
                               user_data_   :P_void;
                               errcode_ret_ :P_cl_int                   ) :T_cl_context; stdcall; external DLLNAME;

function
clRetainContext( context_ :T_cl_context ) :T_cl_int; stdcall; external DLLNAME;

function
clReleaseContext( context_ :T_cl_context ) :T_cl_int; stdcall; external DLLNAME;

function
clGetContextInfo( context_              :T_cl_context;
                  param_name_           :T_cl_context_info;
                  param_value_size_     :T_size_t;
                  param_value_          :P_void;
                  param_value_size_ret_ :P_size_t          ) :T_cl_int; stdcall; external DLLNAME;

(* Command Queue APIs *)
function
clCreateCommandQueueWithProperties(       context_     :T_cl_context;
                                          device_      :T_cl_device_id;
                                    const properties_  :P_cl_queue_properties;
                                          errcode_ret_ :P_cl_int              ) :T_cl_command_queue; stdcall; external DLLNAME;

function
clRetainCommandQueue( command_queue_ :T_cl_command_queue ) :T_cl_int; stdcall; external DLLNAME;

function
clReleaseCommandQueue( command_queue_ :T_cl_command_queue ) :T_cl_int; stdcall; external DLLNAME;

function
clGetCommandQueueInfo( command_queue_        :T_cl_command_queue;
                       param_name_           :T_cl_command_queue_info;
                       param_value_size_     :T_size_t;
                       param_value_          :P_void;
                       param_value_size_ret_ :P_size_t                ) :T_cl_int; stdcall; external DLLNAME;

(* Memory Object APIs *)
function
clCreateBuffer( context_     :T_cl_context;
                flags_       :T_cl_mem_flags;
                size_        :T_size_t;
                host_ptr_    :P_void;
                errcode_ret_ :P_cl_int       ) :T_cl_mem; stdcall; external DLLNAME;

function
clCreateSubBuffer(       buffer_             :T_cl_mem;
                         flags_              :T_cl_mem_flags;
                         buffer_create_type_ :T_cl_buffer_create_type;
                   const buffer_create_info_ :P_void;
                         errcode_ret_        :P_cl_int                ) :T_cl_mem; stdcall; external DLLNAME;

function
clCreateImage(       context_      :T_cl_context;
                     flags_        :T_cl_mem_flags;
               const image_format_ :P_cl_image_format;
               const image_desc_   :P_cl_image_desc;
                     host_ptr_     :P_void;
                     errcode_ret_  :P_cl_int          ) :T_cl_mem; stdcall; external DLLNAME;

function
clCreatePipe(       context_          :T_cl_context;
                    flags_            :T_cl_mem_flags;
                    pipe_packet_size_ :T_cl_uint;
                    pipe_max_packets_ :T_cl_uint;
              const properties_       :P_cl_pipe_properties;
                    errcode_ret_      :P_cl_int             ) :T_cl_mem; stdcall; external DLLNAME;

function
clRetainMemObject( memobj_ :T_cl_mem ) :T_cl_int; stdcall; external DLLNAME;

function
clReleaseMemObject( memobj_ :T_cl_mem ) :T_cl_int; stdcall; external DLLNAME;

function
clGetSupportedImageFormats( context_           :T_cl_context;
                            flags_             :T_cl_mem_flags;
                            image_type_        :T_cl_mem_object_type;
                            num_entries_       :T_cl_uint;
                            image_formats_     :P_cl_image_format;
                            num_image_formats_ :P_cl_uint            ) :T_cl_int; stdcall; external DLLNAME;
                                    
function
clGetMemObjectInfo( memobj_               :T_cl_mem;
                    param_name_           :T_cl_mem_info;
                    param_value_size_     :T_size_t;
                    param_value_          :P_void;
                    param_value_size_ret_ :P_size_t      ) :T_cl_int; stdcall; external DLLNAME;

function
clGetImageInfo( image_                :T_cl_mem;
                param_name_           :T_cl_image_info;
                param_value_size_     :T_size_t;
                param_value_          :P_void;
                param_value_size_ret_ :P_size_t        ) :T_cl_int; stdcall; external DLLNAME;

function
clGetPipeInfo( pipe_                 :T_cl_mem;
               param_name_           :T_cl_pipe_info;
               param_value_size_     :T_size_t;
               param_value_          :P_void;
               param_value_size_ret_ :P_size_t       ) :T_cl_int; stdcall; external DLLNAME;

type PFN_clSetMemObjectDestructorCallback_notify = procedure( memobj:T_cl_mem; user_data:P_void );

function
clSetMemObjectDestructorCallback( memobj_    :T_cl_mem;
                                  pfn_notify :PFN_clSetMemObjectDestructorCallback_notify;
                                  user_data_ :P_void                                      ) :T_cl_int; stdcall; external DLLNAME;

(* SVM Allocation APIs *)
function
clSVMAlloc( context_   :T_cl_context;
            flags_     :T_cl_svm_mem_flags;
            size_      :T_size_t;
            alignment_ :T_cl_uint          ) :P_void; stdcall; external DLLNAME;

procedure
clSVMFree( context_     :T_cl_context;
           svm_pointer_ :P_void       ); stdcall; external DLLNAME;
    
(* Sampler APIs *)
function
clCreateSamplerWithProperties(       context_           :T_cl_context;
                               const normalized_coords_ :P_cl_sampler_properties;
                                     errcode_ret_       :P_cl_int                ) :T_cl_sampler; stdcall; external DLLNAME;

function
clRetainSampler( sampler_ :T_cl_sampler ) :T_cl_int; stdcall; external DLLNAME;

function
clReleaseSampler( sampler_ :T_cl_sampler ) :T_cl_int; stdcall; external DLLNAME;

function
clGetSamplerInfo( sampler_              :T_cl_sampler;
                  param_name_           :T_cl_sampler_info;
                  param_value_size_     :T_size_t;
                  param_value_          :P_void;
                  param_value_size_ret_ :P_size_t          ) :T_cl_int; stdcall; external DLLNAME;
                            
(* Program Object APIs  *)
function
clCreateProgramWithSource(       context_     :T_cl_context;
                                 count_       :T_cl_uint;
                           const strings_     :PP_char;
                           const lengths_     :P_size_t;
                                 errcode_ret_ :P_cl_int     ) :T_cl_program; stdcall; external DLLNAME;

function
clCreateProgramWithBinary(       context_     :T_cl_context;
                                 num_devices_ :T_cl_uint;
                           const device_list_ :P_cl_device_id;
                           const lengths_     :P_size_t;
                           const binaries_    :PP_unsigned_char;
                           binary_status_     :P_cl_int;
                           errcode_ret_       :P_cl_int         ) :T_cl_program; stdcall; external DLLNAME;

function
clCreateProgramWithBuiltInKernels(       context_      :T_cl_context;
                                         num_devices_  :T_cl_uint;
                                   const device_list_  :P_cl_device_id;
                                   const kernel_names_ :P_char;
                                         errcode_ret_  :P_cl_int       ) :T_cl_program; stdcall; external DLLNAME;

function
clCreateProgramWithIL(       context_     :T_cl_context;
                       const il_          :P_void;
                             length_      :T_size_t;
                             errcode_ret_ :P_cl_int     ) :T_cl_program; stdcall; external DLLNAME;

function
clRetainProgram( program_ :T_cl_program ) :T_cl_int; stdcall; external DLLNAME;

function
clReleaseProgram( program_ :T_cl_program ) :T_cl_int; stdcall; external DLLNAME;

type PFN_clBuildProgram_notify = procedure( program_:T_cl_program; user_data_:P_void );

function
clBuildProgram(       program_     :T_cl_program;
                      num_devices_ :T_cl_uint;
                const device_list_ :P_cl_device_id;
                const options_     :P_char;
                      pfn_notify_  :PFN_clBuildProgram_notify;
                      user_data_   :P_void                    ) :T_cl_int; stdcall; external DLLNAME;

function
clCompileProgram(       program_              :T_cl_program;
                        num_devices_          :T_cl_uint;
                  const device_list_          :P_cl_device_id;
                  const options_              :P_char;
                        num_input_headers_    :T_cl_uint;
                  const input_headers_        :P_cl_program;
                  const header_include_names_ :PP_char;
                        pfn_notify_           :PFN_clBuildProgram_notify;
                        user_data_            :P_void                    ) :T_cl_int; stdcall; external DLLNAME;
function
clLinkProgram(       context_            :T_cl_context;
                     num_devices_        :T_cl_uint;
               const device_list_        :P_cl_device_id;
               const options_            :P_char;
                     num_input_programs_ :T_cl_uint;
               const input_programs_     :P_cl_program;
                     pfn_notify_         :PFN_clBuildProgram_notify;
                     user_data_          :P_void;
                     errcode_ret_        :P_cl_int                  ) :T_cl_program; stdcall; external DLLNAME;

function
clUnloadPlatformCompiler( platform_ :T_cl_platform_id ) :T_cl_int; stdcall; external DLLNAME;

function
clGetProgramInfo( program_              :T_cl_program;
                  param_name_           :T_cl_program_info;
                  param_value_size_     :T_size_t;
                  param_value_          :P_void;
                  param_value_size_ret_ :P_size_t          ) :T_cl_int; stdcall; external DLLNAME;

function
clGetProgramBuildInfo( program_              :T_cl_program;
                       device_               :T_cl_device_id;
                       param_name_           :T_cl_program_build_info;
                       param_value_size_     :T_size_t;
                       param_value_          :P_void;
                       param_value_size_ret_ :P_size_t                ) :T_cl_int; stdcall; external DLLNAME;
                            
(* Kernel Object APIs *)
function
clCreateKernel(       program_     :T_cl_program;
                const kernel_name_ :P_char;
                      errcode_ret_ :P_cl_int     ) :T_cl_kernel; stdcall; external DLLNAME;

function
clCreateKernelsInProgram( program_         :T_cl_program;
                          num_kernels_     :T_cl_uint;
                          kernels_         :P_cl_kernel;
                          num_kernels_ret_ :P_cl_uint    ) :T_cl_int; stdcall; external DLLNAME;

function
clCloneKernel( source_kernel_ :T_cl_kernel;
               errcode_ret_   :P_cl_int    ) :T_cl_kernel; stdcall; external DLLNAME;

function
clRetainKernel( kernel_ :T_cl_kernel ) :T_cl_int; stdcall; external DLLNAME;

function
clReleaseKernel( kernel_ :T_cl_kernel ) :T_cl_int; stdcall; external DLLNAME;

function
clSetKernelArg(       kernel_    :T_cl_kernel;
                      arg_index_ :T_cl_uint;
                      arg_size_  :T_size_t;
                const arg_value_ :P_void      ) :T_cl_int; stdcall; external DLLNAME;

function
clSetKernelArgSVMPointer(       kernel_    :T_cl_kernel;
                                arg_index_ :T_cl_uint;
                          const arg_value_ :P_void      ) :T_cl_int; stdcall; external DLLNAME;

function
clSetKernelExecInfo(       kernel_           :T_cl_kernel;
                           param_name_       :T_cl_kernel_exec_info;
                           param_value_size_ :T_size_t;
                     const param_value_      :P_void                ) :T_cl_int; stdcall; external DLLNAME;
    
function
clGetKernelInfo( kernel_               :T_cl_kernel;
                 param_name_           :T_cl_kernel_info;
                 param_value_size_     :T_size_t;
                 param_value_          :P_void;
                 param_value_size_ret_ :P_size_t         ) :T_cl_int; stdcall; external DLLNAME;

function
clGetKernelArgInfo( kernel_               :T_cl_kernel;
                    arg_indx_             :T_cl_uint;
                    param_name_           :T_cl_kernel_arg_info;
                    param_value_size_     :T_size_t;
                    param_value_          :P_void;
                    param_value_size_ret_ :P_size_t             ) :T_cl_int; stdcall; external DLLNAME;

function
clGetKernelWorkGroupInfo( kernel_               :T_cl_kernel;
                          device_               :T_cl_device_id;
                          param_name_           :T_cl_kernel_work_group_info;
                          param_value_size_     :T_size_t;
                          param_value_          :P_void;
                          param_value_size_ret_ :P_size_t                    ) :T_cl_int; stdcall; external DLLNAME;

function
clGetKernelSubGroupInfo(       kernel_               :T_cl_kernel;
                               device_               :T_cl_device_id;
                               param_name_           :T_cl_kernel_sub_group_info;
                               input_value_size_     :T_size_t;
                         const input_value_          :P_void;
                               param_value_size_     :T_size_t;
                               param_value_          :P_void;
                               param_value_size_ret_ :P_size_t                   ) :T_cl_int; stdcall; external DLLNAME;

(* Event Object APIs *)
function
clWaitForEvents(       num_events_ :T_cl_uint;
                 const event_list_ :P_cl_event ) :T_cl_int; stdcall; external DLLNAME;

function
clGetEventInfo( event_                :T_cl_event;
                param_name_           :T_cl_event_info;
                param_value_size_     :T_size_t;
                param_value_          :P_void;
                param_value_size_ret_ :P_size_t        ) :T_cl_int; stdcall; external DLLNAME;
                            
function
clCreateUserEvent( context_     :T_cl_context;
                   errcode_ret_ :P_cl_int     ) :T_cl_event; stdcall; external DLLNAME;
                            
function
clRetainEvent( event_ :T_cl_event ) :T_cl_int; stdcall; external DLLNAME;

function
clReleaseEvent( event_ :T_cl_event ) :T_cl_int; stdcall; external DLLNAME;

function
clSetUserEventStatus( event_            :T_cl_event;
                      execution_status_ :T_cl_int   ) :T_cl_int; stdcall; external DLLNAME;

type PFN_clSetEventCallback_notify = procedure( _1:T_cl_event; _2:T_cl_int; _3:P_void );

function
clSetEventCallback( event_                      :T_cl_event;
                    command_exec_callback_type_ :T_cl_int;
                    pfn_notify_                 :PFN_clSetEventCallback_notify;
                    user_data_                  :P_void                        ) :T_cl_int; stdcall; external DLLNAME;

(* Profiling APIs *)
function
clGetEventProfilingInfo( event_                :T_cl_event;
                         param_name_           :T_cl_profiling_info;
                         param_value_size_     :T_size_t;
                         param_value_          :P_void;
                         param_value_size_ret_ :P_size_t            ) :T_cl_int; stdcall; external DLLNAME;
                                
(* Flush and Finish APIs *)
function
clFlush( command_queue_ :T_cl_command_queue ) :T_cl_int; stdcall; external DLLNAME;

function
clFinish( command_queue_ :T_cl_command_queue ) :T_cl_int; stdcall; external DLLNAME;

(* Enqueued Commands APIs *)
function
clEnqueueReadBuffer(       command_queue_           :T_cl_command_queue;
                           buffer_                  :T_cl_mem;
                           blocking_read_           :T_cl_bool;
                           offset_                  :T_size_t;
                           size_                    :T_size_t;
                           ptr_                     :P_void;
                           num_events_in_wait_list_ :T_cl_uint;
                     const event_wait_list_         :P_cl_event;
                           event_                   :P_cl_event         ) :T_cl_int; stdcall; external DLLNAME;
                            
function
clEnqueueReadBufferRect(       command_queue_           :T_cl_command_queue;
                               buffer_                  :T_cl_mem;
                               blocking_read_           :T_cl_bool;
                         const buffer_offset_           :P_size_t;
                         const host_offset_             :P_size_t;
                         const region_                  :P_size_t;
                               buffer_row_pitch_        :T_size_t;
                               buffer_slice_pitch_      :T_size_t;
                               host_row_pitch_          :T_size_t;
                               host_slice_pitch_        :T_size_t;
                               ptr_                     :P_void;
                               num_events_in_wait_list_ :T_cl_uint;
                         const event_wait_list_         :P_cl_event;
                               event_                   :P_cl_event         ) :T_cl_int; stdcall; external DLLNAME;

function
clEnqueueWriteBuffer(       command_queue_           :T_cl_command_queue;
                            buffer_                  :T_cl_mem;
                            blocking_write_          :T_cl_bool;
                            offset_                  :T_size_t;
                            size_                    :T_size_t;
                      const ptr_                     :P_void;
                            num_events_in_wait_list_ :T_cl_uint;
                      const event_wait_list_         :P_cl_event;
                            event_                   :P_cl_event         ) :T_cl_int; stdcall; external DLLNAME;
                            
function
clEnqueueWriteBufferRect(       command_queue_           :T_cl_command_queue;
                                buffer_                  :T_cl_mem;
                                blocking_write_          :T_cl_bool;
                          const buffer_offset_           :P_size_t;
                          const host_offset_             :P_size_t;
                          const region_                  :P_size_t;
                                buffer_row_pitch_        :T_size_t;
                                buffer_slice_pitch_      :T_size_t;
                                host_row_pitch_          :T_size_t;
                                host_slice_pitch_        :T_size_t;
                          const ptr_                     :P_void;
                                num_events_in_wait_list_ :T_cl_uint;
                          const event_wait_list_         :P_cl_event;
                                event_                   :P_cl_event         ) :T_cl_int; stdcall; external DLLNAME;

function
clEnqueueFillBuffer(       command_queue_           :T_cl_command_queue;
                           buffer_                  :T_cl_mem;
                     const pattern_                 :P_void;
                           pattern_size_            :T_size_t;
                           offset_                  :T_size_t;
                           size_                    :T_size_t;
                           num_events_in_wait_list_ :T_cl_uint;
                     const event_wait_list_         :P_cl_event;
                           event_ :P_cl_event                           ) :T_cl_int; stdcall; external DLLNAME;
                            
function
clEnqueueCopyBuffer(       command_queue_           :T_cl_command_queue;
                           src_buffer_              :T_cl_mem;
                           dst_buffer_              :T_cl_mem;
                           src_offset_              :T_size_t;
                           dst_offset_              :T_size_t;
                           size_                    :T_size_t;
                           num_events_in_wait_list_ :T_cl_uint;
                     const event_wait_list_         :P_cl_event;
                           event_                   :P_cl_event         ) :T_cl_int; stdcall; external DLLNAME;
                            
function
clEnqueueCopyBufferRect(       command_queue_           :T_cl_command_queue;
                               src_buffer_              :T_cl_mem;
                               dst_buffer_              :T_cl_mem;
                         const src_origin_              :P_size_t;
                         const dst_origin_              :P_size_t;
                         const region_                  :P_size_t;
                               src_row_pitch_           :T_size_t;
                               src_slice_pitch_         :T_size_t;
                               dst_row_pitch_           :T_size_t;
                               dst_slice_pitch_         :T_size_t;
                               num_events_in_wait_list_ :T_cl_uint;
                         const event_wait_list_         :P_cl_event;
                               event_                   :P_cl_event         ) :T_cl_int; stdcall; external DLLNAME;

type T_size_t3 = array [ 0..3-1 ] of T_size_t;

function
clEnqueueReadImage(       command_queue_           :T_cl_command_queue;
                          image_                   :T_cl_mem;
                          blocking_read_           :T_cl_bool;
                    const origin_                  :T_size_t3;
                    const region_                  :T_size_t3;
                          row_pitch_               :T_size_t;
                          slice_pitch_             :T_size_t;
                          ptr_                     :P_void;
                          num_events_in_wait_list_ :T_cl_uint;
                    const event_wait_list_         :P_cl_event;
                          event_                   :P_cl_event         ) :T_cl_int; stdcall; external DLLNAME;

function
clEnqueueWriteImage(       command_queue_           :T_cl_command_queue;
                           image_                   :T_cl_mem;
                           blocking_write_          :T_cl_bool;
                     const origin_                  :T_size_t3;
                     const region_                  :T_size_t3;
                           input_row_pitch_         :T_size_t;
                           input_slice_pitch_       :T_size_t;
                     const ptr_                     :P_void;
                           num_events_in_wait_list_ :T_cl_uint;
                     const event_wait_list_         :P_cl_event;
                           event_                   :P_cl_event         ) :T_cl_int; stdcall; external DLLNAME;

function
clEnqueueFillImage(       command_queue_           :T_cl_command_queue;
                          image_                   :T_cl_mem;
                    const fill_color_              :P_void;
                    const origin_                  :T_size_t3;
                    const region_                  :T_size_t3;
                          num_events_in_wait_list_ :T_cl_uint;
                    const event_wait_list_         :P_cl_event;
                          event_                   :P_cl_event         ) :T_cl_int; stdcall; external DLLNAME;

function
clEnqueueCopyImage(       command_queue_           :T_cl_command_queue;
                          src_image_               :T_cl_mem;
                          dst_image_               :T_cl_mem;
                    const src_origin_              :T_size_t3;
                    const dst_origin_              :T_size_t3;
                    const region_                  :T_size_t3;
                          num_events_in_wait_list_ :T_cl_uint;
                    const event_wait_list_         :P_cl_event;
                          event_                   :P_cl_event         ) :T_cl_int; stdcall; external DLLNAME;

function
clEnqueueCopyImageToBuffer(       command_queue_           :T_cl_command_queue;
                                  src_image_               :T_cl_mem;
                                  dst_buffer_              :T_cl_mem;
                            const src_origin_              :T_size_t3;
                            const region_                  :T_size_t3;
                                  dst_offset_              :T_size_t;
                                  num_events_in_wait_list_ :T_cl_uint;
                            const event_wait_list_         :P_cl_event;
                                  event_                   :P_cl_event         ) :T_cl_int; stdcall; external DLLNAME;

function
clEnqueueCopyBufferToImage(       command_queue_           :T_cl_command_queue;
                                  src_buffer_              :T_cl_mem;
                                  dst_image_               :T_cl_mem;
                                  src_offset_              :T_size_t;
                            const dst_origin_              :T_size_t3;
                            const region_                  :T_size_t3;
                                  num_events_in_wait_list_ :T_cl_uint;
                            const event_wait_list_         :P_cl_event;
                                  event_                   :P_cl_event         ) :T_cl_int; stdcall; external DLLNAME;

function
clEnqueueMapBuffer(       command_queue_           :T_cl_command_queue;
                          buffer_                  :T_cl_mem;
                          blocking_map_            :T_cl_bool;
                          map_flags_               :T_cl_map_flags;
                          offset_                  :T_size_t;
                          size_                    :T_size_t;
                          num_events_in_wait_list_ :T_cl_uint;
                    const event_wait_list_         :P_cl_event;
                          event_                   :P_cl_event;
                          errcode_ret_             :P_cl_int           ) :P_void; stdcall; external DLLNAME;

function
clEnqueueMapImage(       command_queue_           :T_cl_command_queue;
                         image_                   :T_cl_mem;
                         blocking_map_            :T_cl_bool;
                         map_flags_               :T_cl_map_flags;
                   const origin_                  :T_size_t3;
                   const region_                  :T_size_t3;
                         image_row_pitch_         :P_size_t;
                         image_slice_pitch_       :P_size_t;
                         num_events_in_wait_list_ :T_cl_uint;
                   const event_wait_list_         :P_cl_event;
                         event_                   :P_cl_event;
                         errcode_ret_             :P_cl_int           ) :P_void; stdcall; external DLLNAME;

function
clEnqueueUnmapMemObject(       command_queue_           :T_cl_command_queue;
                               memobj_                  :T_cl_mem;
                               mapped_ptr_              :P_void;
                               num_events_in_wait_list_ :T_cl_uint;
                         const event_wait_list_         :P_cl_event;
                               event_                   :P_cl_event         ) :T_cl_int; stdcall; external DLLNAME;

function
clEnqueueMigrateMemObjects(       command_queue_           :T_cl_command_queue;
                                  num_mem_objects_         :T_cl_uint;
                            const mem_objects_             :P_cl_mem;
                                  flags_                   :T_cl_mem_migration_flags;
                                  num_events_in_wait_list_ :T_cl_uint;
                            const event_wait_list_         :P_cl_event;
                                  event_                   :P_cl_event               ) :T_cl_int; stdcall; external DLLNAME;

function
clEnqueueNDRangeKernel(       command_queue_           :T_cl_command_queue;
                              kernel_                  :T_cl_kernel;
                              work_dim_                :T_cl_uint;
                        const global_work_offset_      :P_size_t;
                        const global_work_size_        :P_size_t;
                        const local_work_size_         :P_size_t;
                              num_events_in_wait_list_ :T_cl_uint;
                        const event_wait_list_         :P_cl_event;
                              event_                   :P_cl_event         ) :T_cl_int; stdcall; external DLLNAME;

type PFN_clEnqueueNativeKernel_user_func = procedure( _1:P_void );

function
clEnqueueNativeKernel(       command_queue_           :T_cl_command_queue;
                             user_func_               :PFN_clEnqueueNativeKernel_user_func;
                             args_                    :P_void;
                             cb_args_                 :T_size_t;
                             num_mem_objects_         :T_cl_uint;
                       const mem_list_                :P_cl_mem;
                       const args_mem_loc_            :PP_void;
                             num_events_in_wait_list_ :T_cl_uint;
                       const event_wait_list_         :P_cl_event;
                             event_                   :P_cl_event                          ) :T_cl_int; stdcall; external DLLNAME;

function
clEnqueueMarkerWithWaitList(       command_queue_           :T_cl_command_queue;
                                   num_events_in_wait_list_ :T_cl_uint;
                             const event_wait_list_         :P_cl_event;
                                   event_                   :P_cl_event         ) :T_cl_int; stdcall; external DLLNAME;

function
clEnqueueBarrierWithWaitList(       command_queue_           :T_cl_command_queue;
                                    num_events_in_wait_list_ :T_cl_uint;
                              const event_wait_list_         :P_cl_event;
                                    event_                   :P_cl_event         ) :T_cl_int; stdcall; external DLLNAME;

type PFN_clEnqueueSVMFree_free_func = procedure( queue_            :T_cl_command_queue;
                                                 num_svm_pointers_ :T_cl_uint;
                                                 svm_pointers_     :PP_void;
                                                 user_data_        :P_void             );

function
clEnqueueSVMFree(       command_queue_           :T_cl_command_queue;
                        num_svm_pointers_        :T_cl_uint;
                        svm_pointers_            :PP_void;
                        pfn_free_func_           :PFN_clEnqueueSVMFree_free_func;
                        user_data_               :P_void;
                        num_events_in_wait_list_ :T_cl_uint;
                  const event_wait_list_         :P_cl_event;
                        event_                   :P_cl_event                     ) :T_cl_int; stdcall; external DLLNAME;

function
clEnqueueSVMMemcpy(       command_queue_           :T_cl_command_queue;
                          blocking_copy_           :T_cl_bool;
                          dst_ptr_                 :P_void;
                    const src_ptr_                 :P_void;
                          size_                    :T_size_t;
                          num_events_in_wait_list_ :T_cl_uint;
                    const event_wait_list_         :P_cl_event;
                          event_                   :P_cl_event         ) :T_cl_int; stdcall; external DLLNAME;

function
clEnqueueSVMMemFill(       command_queue_           :T_cl_command_queue;
                           svm_ptr_                 :P_void;
                     const pattern_                 :P_void;
                           pattern_size_            :T_size_t;
                           size_                    :T_size_t;
                           num_events_in_wait_list_ :T_cl_uint;
                     const event_wait_list_         :P_cl_event;
                           event_                   :P_cl_event         ) :T_cl_int; stdcall; external DLLNAME;
    
function
clEnqueueSVMMap(       command_queue_           :T_cl_command_queue;
                       blocking_map_            :T_cl_bool;
                       flags_                   :T_cl_map_flags;
                       svm_ptr_                 :P_void;
                       size_                    :T_size_t;
                       num_events_in_wait_list_ :T_cl_uint;
                 const event_wait_list_         :P_cl_event;
                       event_                   :P_cl_event         ) :T_cl_int; stdcall; external DLLNAME;
    
function
clEnqueueSVMUnmap(       command_queue_           :T_cl_command_queue;
                         svm_ptr_                 :P_void;
                         num_events_in_wait_list_ :T_cl_uint;
                   const event_wait_list_         :P_cl_event;
                         event_                   :P_cl_event         ) :T_cl_int; stdcall; external DLLNAME;

function
clEnqueueSVMMigrateMem(       command_queue_           :T_cl_command_queue;
                              num_svm_pointers_        :T_cl_uint;
                        const svm_pointers_            :PP_void;
                        const sizes_                   :P_size_t;
                              flags_                   :T_cl_mem_migration_flags;
                              num_events_in_wait_list_ :T_cl_uint;
                        const event_wait_list_         :P_cl_event;
                              event_                   :P_cl_event               ) :T_cl_int; stdcall; external DLLNAME;

(* Extension function access
 *
 * Returns the extension function address for the given function name,
 * or NULL if a valid function can not be found.  The client must
 * check to make sure the address is not NULL, before using or 
 * calling the returned function address.
 *)
function
clGetExtensionFunctionAddressForPlatform(       platform_  :T_cl_platform_id;
                                          const func_name_ :P_char           ) :P_void; stdcall; external DLLNAME;
    

(* Deprecated OpenCL 1.1 APIs *)
function
clCreateImage2D(       context_         :T_cl_context;
                       flags_           :T_cl_mem_flags;
                 const image_format_    :P_cl_image_format;
                       image_width_     :T_size_t;
                       image_height_    :T_size_t;
                       image_row_pitch_ :T_size_t;
                       host_ptr_        :P_void;
                       errcode_ret_     :P_cl_int          ) :T_cl_mem; stdcall; external DLLNAME; deprecated;
    
function
clCreateImage3D(       context_           :T_cl_context;
                       flags_             :T_cl_mem_flags;
                 const image_format_      :P_cl_image_format;
                       image_width_       :T_size_t;
                       image_height_      :T_size_t;
                       image_depth_       :T_size_t;
                       image_row_pitch_   :T_size_t;
                       image_slice_pitch_ :T_size_t;
                       host_ptr_          :P_void;
                       errcode_ret_       :P_cl_int          ) :T_cl_mem; stdcall; external DLLNAME; deprecated;
    
function
clEnqueueMarker( command_queue_ :T_cl_command_queue;
                 event_         :P_cl_event         ) :T_cl_int; stdcall; external DLLNAME; deprecated;

function
clEnqueueWaitForEvents(       command_queue_ :T_cl_command_queue;
                              num_events_    :T_cl_uint;
                        const event_list_    :P_cl_event         ) :T_cl_int; stdcall; external DLLNAME; deprecated;

function
clEnqueueBarrier( command_queue_ :T_cl_command_queue ) :T_cl_int; stdcall; external DLLNAME; deprecated;

function
clUnloadCompiler :T_cl_int; stdcall; external DLLNAME; deprecated;

function
clGetExtensionFunctionAddress( const func_name_ :P_char ) :P_void; stdcall; external DLLNAME; deprecated;

(* Deprecated OpenCL 2.0 APIs *)
function
clCreateCommandQueue( context_     :T_cl_context;
                      device_      :T_cl_device_id;
                      properties_  :T_cl_command_queue_properties;
                      errcode_ret_ :P_cl_int                      ) :T_cl_command_queue; stdcall; external DLLNAME; deprecated;
    
    
function
clCreateSampler( context_           :T_cl_context;
                 normalized_coords_ :T_cl_bool;
                 addressing_mode_   :T_cl_addressing_mode;
                 filter_mode_       :T_cl_filter_mode;
                 errcode_ret_       :P_cl_int             ) :T_cl_sampler; stdcall; external DLLNAME; deprecated;
    
function
clEnqueueTask(       command_queue_           :T_cl_command_queue;
                     kernel_                  :T_cl_kernel;
                     num_events_in_wait_list_ :T_cl_uint;
               const event_wait_list_         :P_cl_event;
                     event_ :P_cl_event                           ) :T_cl_int; stdcall; external DLLNAME; deprecated;

implementation //############################################################### ��

end. //######################################################################### ��
