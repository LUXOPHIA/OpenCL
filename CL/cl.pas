unit cl;

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
     cl_version,
     cl_platform;

const DLLNAME = 'OpenCL.dll';

(******************************************************************************)

type T_cl_platform_id   = ^T__cl_platform_id  ;  T__cl_platform_id   = record end;  P_cl_platform_id   = ^T_cl_platform_id  ;
type T_cl_device_id     = ^T__cl_device_id    ;  T__cl_device_id     = record end;  P_cl_device_id     = ^T_cl_device_id    ;
type T_cl_context       = ^T__cl_context      ;  T__cl_context       = record end;  P_cl_context       = ^T_cl_context      ;
type T_cl_command_queue = ^T__cl_command_queue;  T__cl_command_queue = record end;  P_cl_command_queue = ^T_cl_command_queue;
type T_cl_mem           = ^T__cl_mem          ;  T__cl_mem           = record end;  P_cl_mem           = ^T_cl_mem          ;
type T_cl_program       = ^T__cl_program      ;  T__cl_program       = record end;  P_cl_program       = ^T_cl_program      ;
type T_cl_kernel        = ^T__cl_kernel       ;  T__cl_kernel        = record end;  P_cl_kernel        = ^T_cl_kernel       ;
type T_cl_event         = ^T__cl_event        ;  T__cl_event         = record end;  P_cl_event         = ^T_cl_event        ;
type T_cl_sampler       = ^T__cl_sampler      ;  T__cl_sampler       = record end;  P_cl_sampler       = ^T_cl_sampler      ;

type T_cl_bool                         = T_cl_uint      ;  P_cl_bool                         = ^T_cl_bool                        ;  (* WARNING!  Unlike cl_ types in cl_platform.h, cl_bool is not guaranteed to be the same size as the bool in kernels. *)
type T_cl_bitfield                     = T_cl_ulong     ;  P_cl_bitfield                     = ^T_cl_bitfield                    ;
type T_cl_properties                   = T_cl_ulong     ;  P_cl_properties                   = ^T_cl_properties                  ;
type T_cl_device_type                  = T_cl_bitfield  ;  P_cl_device_type                  = ^T_cl_device_type                 ;
type T_cl_platform_info                = T_cl_uint      ;  P_cl_platform_info                = ^T_cl_platform_info               ;
type T_cl_device_info                  = T_cl_uint      ;  P_cl_device_info                  = ^T_cl_device_info                 ;
type T_cl_device_fp_config             = T_cl_bitfield  ;  P_cl_device_fp_config             = ^T_cl_device_fp_config            ;
type T_cl_device_mem_cache_type        = T_cl_uint      ;  P_cl_device_mem_cache_type        = ^T_cl_device_mem_cache_type       ;
type T_cl_device_local_mem_type        = T_cl_uint      ;  P_cl_device_local_mem_type        = ^T_cl_device_local_mem_type       ;
type T_cl_device_exec_capabilities     = T_cl_bitfield  ;  P_cl_device_exec_capabilities     = ^T_cl_device_exec_capabilities    ;
{$IF CL_VERSION_2_0 <> 0 }
type T_cl_device_svm_capabilities      = T_cl_bitfield  ;  P_cl_device_svm_capabilities      = ^T_cl_device_svm_capabilities     ;
{$ENDIF}
type T_cl_command_queue_properties     = T_cl_bitfield  ;  P_cl_command_queue_properties     = ^T_cl_command_queue_properties    ;
{$IF CL_VERSION_1_2 <> 0 }
type T_cl_device_partition_property    = T_intptr_t     ;  P_cl_device_partition_property    = ^T_cl_device_partition_property   ;
type T_cl_device_affinity_domain       = T_cl_bitfield  ;  P_cl_device_affinity_domain       = ^T_cl_device_affinity_domain      ;
{$ENDIF}

type T_cl_context_properties           = T_intptr_t     ;  P_cl_context_properties           = ^T_cl_context_properties          ;
type T_cl_context_info                 = T_cl_uint      ;  P_cl_context_info                 = ^T_cl_context_info                ;
{$IF CL_VERSION_2_0 <> 0 }
type T_cl_queue_properties             = T_cl_properties;  P_cl_queue_properties             = ^T_cl_queue_properties            ;
{$ENDIF}
type T_cl_command_queue_info           = T_cl_uint      ;  P_cl_command_queue_info           = ^T_cl_command_queue_info          ;
type T_cl_channel_order                = T_cl_uint      ;  P_cl_channel_order                = ^T_cl_channel_order               ;
type T_cl_channel_type                 = T_cl_uint      ;  P_cl_channel_type                 = ^T_cl_channel_type                ;
type T_cl_mem_flags                    = T_cl_bitfield  ;  P_cl_mem_flags                    = ^T_cl_mem_flags                   ;
{$IF CL_VERSION_2_0 <> 0 }
type T_cl_svm_mem_flags                = T_cl_bitfield  ;  P_cl_svm_mem_flags                = ^T_cl_svm_mem_flags               ;
{$ENDIF}
type T_cl_mem_object_type              = T_cl_uint      ;  P_cl_mem_object_type              = ^T_cl_mem_object_type             ;
type T_cl_mem_info                     = T_cl_uint      ;  P_cl_mem_info                     = ^T_cl_mem_info                    ;
{$IF CL_VERSION_1_2 <> 0 }
type T_cl_mem_migration_flags          = T_cl_bitfield  ;  P_cl_mem_migration_flags          = ^T_cl_mem_migration_flags         ;
{$ENDIF}
type T_cl_image_info                   = T_cl_uint      ;  P_cl_image_info                   = ^T_cl_image_info                  ;
{$IF CL_VERSION_1_1 <> 0 }
type T_cl_buffer_create_type           = T_cl_uint      ;  P_cl_buffer_create_type           = ^T_cl_buffer_create_type          ;
{$ENDIF}
type T_cl_addressing_mode              = T_cl_uint      ;  P_cl_addressing_mode              = ^T_cl_addressing_mode             ;
type T_cl_filter_mode                  = T_cl_uint      ;  P_cl_filter_mode                  = ^T_cl_filter_mode                 ;
type T_cl_sampler_info                 = T_cl_uint      ;  P_cl_sampler_info                 = ^T_cl_sampler_info                ;
type T_cl_map_flags                    = T_cl_bitfield  ;  P_cl_map_flags                    = ^T_cl_map_flags                   ;
{$IF CL_VERSION_2_0 <> 0 }
type T_cl_pipe_properties              = T_intptr_t     ;  P_cl_pipe_properties              = ^T_cl_pipe_properties             ;
type T_cl_pipe_info                    = T_cl_uint      ;  P_cl_pipe_info                    = ^T_cl_pipe_info                   ;
{$ENDIF}
type T_cl_program_info                 = T_cl_uint      ;  P_cl_program_info                 = ^T_cl_program_info                ;
type T_cl_program_build_info           = T_cl_uint      ;  P_cl_program_build_info           = ^T_cl_program_build_info          ;
{$IF CL_VERSION_1_2 <> 0 }
type T_cl_program_binary_type          = T_cl_uint      ;  P_cl_program_binary_type          = ^T_cl_program_binary_type         ;
{$ENDIF}
type T_cl_build_status                 = T_cl_int       ;  P_cl_build_status                 = ^T_cl_build_status                ;
type T_cl_kernel_info                  = T_cl_uint      ;  P_cl_kernel_info                  = ^T_cl_kernel_info                 ;
{$IF CL_VERSION_1_2 <> 0 }
type T_cl_kernel_arg_info              = T_cl_uint      ;  P_cl_kernel_arg_info              = ^T_cl_kernel_arg_info             ;
type T_cl_kernel_arg_address_qualifier = T_cl_uint      ;  P_cl_kernel_arg_address_qualifier = ^T_cl_kernel_arg_address_qualifier;
type T_cl_kernel_arg_access_qualifier  = T_cl_uint      ;  P_cl_kernel_arg_access_qualifier  = ^T_cl_kernel_arg_access_qualifier ;
type T_cl_kernel_arg_type_qualifier    = T_cl_bitfield  ;  P_cl_kernel_arg_type_qualifier    = ^T_cl_kernel_arg_type_qualifier   ;
{$ENDIF}
type T_cl_kernel_work_group_info       = T_cl_uint      ;  P_cl_kernel_work_group_info       = ^T_cl_kernel_work_group_info      ;
{$IF CL_VERSION_2_1 <> 0 }
type T_cl_kernel_sub_group_info        = T_cl_uint      ;  P_cl_kernel_sub_group_info        = ^T_cl_kernel_sub_group_info       ;
{$ENDIF}
type T_cl_event_info                   = T_cl_uint      ;  P_cl_event_info                   = ^T_cl_event_info                  ;
type T_cl_command_type                 = T_cl_uint      ;  P_cl_command_type                 = ^T_cl_command_type                ;
type T_cl_profiling_info               = T_cl_uint      ;  P_cl_profiling_info               = ^T_cl_profiling_info              ;
{$IF CL_VERSION_2_0 <> 0 }
type T_cl_sampler_properties           = T_cl_properties;  P_cl_sampler_properties           = ^T_cl_sampler_properties          ;
type T_cl_kernel_exec_info             = T_cl_uint      ;  P_cl_kernel_exec_info             = ^T_cl_kernel_exec_info            ;
{$ENDIF}
{$IF CL_VERSION_3_0 <> 0 }
type T_cl_device_atomic_capabilities         = T_cl_bitfield  ;  P_cl_device_atomic_capabilities         = ^T_cl_device_atomic_capabilities        ;
type T_cl_device_device_enqueue_capabilities = T_cl_bitfield  ;  P_cl_device_device_enqueue_capabilities = ^T_cl_device_device_enqueue_capabilities;
type T_cl_khronos_vendor_id                  = T_cl_uint      ;  P_cl_khronos_vendor_id                  = ^T_cl_khronos_vendor_id                 ;
type T_cl_mem_properties                     = T_cl_properties;  P_cl_mem_properties                     = ^T_cl_mem_properties                    ;
type T_cl_version                            = T_cl_uint      ;  P_cl_version                            = ^T_cl_version                           ;
{$ENDIF}

type T_cl_image_format = record
       image_channel_order     :T_cl_channel_order;
       image_channel_data_type :T_cl_channel_type;
     end;
     P_cl_image_format = ^T_cl_image_format;

{$IF CL_VERSION_1_2 <> 0 }

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
{$IF CL_VERSION_2_0 <> 0 }
{$IF Defined(__GNUC__) }
    __extension__                   (* Prevents warnings about anonymous union in -pedantic builds *)
{$ENDIF}
{$IF Defined(_MSC_VER) and not Defined(__STDC__) }
#pragma warning( push )
#pragma warning( disable : 4201 )   (* Prevents warning about nameless struct/union in /W4 builds *)
{$ENDIF}
{$IF Defined(_MSC_VER) and Defined(__STDC__) }
    /* Anonymous unions are not supported in /Za builds */
{$ELSE}
     case  Byte of
{$ENDIF}
{$ENDIF}
        0: ( buffer     :T_cl_mem );
{$IF CL_VERSION_2_0 <> 0 }
{$IF Defined(_MSC_VER) and Defined(__STDC__) }
    /* Anonymous unions are not supported in /Za builds */
{$ELSE}
        1: ( mem_object :T_cl_mem );
//    };
{$ENDIF}
{$IF Defined(_MSC_VER) and not Defined(__STDC__) }
#pragma warning( pop )
{$ENDIF}
{$ENDIF}
     end;
     P_cl_image_desc = ^T_cl_image_desc;

{$ENDIF}

{$IF CL_VERSION_1_1 <> 0 }

type T_cl_buffer_region = record
       origin :T_size_t;
       size   :T_size_t;
     end;
     P_cl_buffer_region = ^T_cl_buffer_region;

{$ENDIF}

{$IF CL_VERSION_3_0 <> 0 }

const CL_NAME_VERSION_MAX_NAME_SIZE = 64;

type T_cl_name_version = record
       version :T_cl_version              ;
       name    :array [ 0..CL_NAME_VERSION_MAX_NAME_SIZE-1 ] of T_char;
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
{$IF CL_VERSION_1_1 <> 0 }
const CL_MISALIGNED_SUB_BUFFER_OFFSET              = -13;
const CL_EXEC_STATUS_ERROR_FOR_EVENTS_IN_WAIT_LIST = -14;
{$ENDIF}
{$IF CL_VERSION_1_2 <> 0 }
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
{$IF CL_VERSION_1_1 <> 0 }
const CL_INVALID_PROPERTY                          = -64;
{$ENDIF}
{$IF CL_VERSION_1_2 <> 0 }
const CL_INVALID_IMAGE_DESCRIPTOR                  = -65;
const CL_INVALID_COMPILER_OPTIONS                  = -66;
const CL_INVALID_LINKER_OPTIONS                    = -67;
const CL_INVALID_DEVICE_PARTITION_COUNT            = -68;
{$ENDIF}
{$IF CL_VERSION_2_0 <> 0 }
const CL_INVALID_PIPE_SIZE                         = -69;
const CL_INVALID_DEVICE_QUEUE                      = -70;
{$ENDIF}
{$IF CL_VERSION_2_2 <> 0 }
const CL_INVALID_SPEC_ID                           = -71;
const CL_MAX_SIZE_RESTRICTION_EXCEEDED             = -72;
{$ENDIF}


(* cl_bool *)
const CL_FALSE                                     = 0;
const CL_TRUE                                      = 1;
{$IF CL_VERSION_1_2 <> 0 }
const CL_BLOCKING                                  = CL_TRUE;
const CL_NON_BLOCKING                              = CL_FALSE;
{$ENDIF}

(* cl_platform_info *)
const CL_PLATFORM_PROFILE                          = $0900;
const CL_PLATFORM_VERSION                          = $0901;
const CL_PLATFORM_NAME                             = $0902;
const CL_PLATFORM_VENDOR                           = $0903;
const CL_PLATFORM_EXTENSIONS                       = $0904;
{$IF CL_VERSION_2_1 <> 0 }
const CL_PLATFORM_HOST_TIMER_RESOLUTION            = $0905;
{$ENDIF}
{$IF CL_VERSION_3_0 <> 0 }
const CL_PLATFORM_NUMERIC_VERSION                  = $0906;
const CL_PLATFORM_EXTENSIONS_WITH_VERSION          = $0907;
{$ENDIF}

(* cl_device_type - bitfield *)
const CL_DEVICE_TYPE_DEFAULT                       = (1 shl 0);
const CL_DEVICE_TYPE_CPU                           = (1 shl 1);
const CL_DEVICE_TYPE_GPU                           = (1 shl 2);
const CL_DEVICE_TYPE_ACCELERATOR                   = (1 shl 3);
{$IF CL_VERSION_1_2 <> 0 }
const CL_DEVICE_TYPE_CUSTOM                        = (1 shl 4);
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
{$IF CL_VERSION_2_0 <> 0 }
const CL_DEVICE_QUEUE_ON_HOST_PROPERTIES                = $102A;
{$ENDIF}
const CL_DEVICE_NAME                                    = $102B;
const CL_DEVICE_VENDOR                                  = $102C;
const CL_DRIVER_VERSION                                 = $102D;
const CL_DEVICE_PROFILE                                 = $102E;
const CL_DEVICE_VERSION                                 = $102F;
const CL_DEVICE_EXTENSIONS                              = $1030;
const CL_DEVICE_PLATFORM                                = $1031;
{$IF CL_VERSION_1_2 <> 0 }
const CL_DEVICE_DOUBLE_FP_CONFIG                        = $1032;
{$ENDIF}
(* 0x1033 reserved for CL_DEVICE_HALF_FP_CONFIG which is already defined in "cl_ext.h" *)
{$IF CL_VERSION_1_1 <> 0 }
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
{$IF CL_VERSION_1_2 <> 0 }
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
{$IF CL_VERSION_2_0 <> 0 }
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
{$IF CL_VERSION_2_1 <> 0 }
const CL_DEVICE_IL_VERSION                              = $105B;
const CL_DEVICE_MAX_NUM_SUB_GROUPS                      = $105C;
const CL_DEVICE_SUB_GROUP_INDEPENDENT_FORWARD_PROGRESS  = $105D;
{$ENDIF}
{$IF CL_VERSION_3_0 <> 0 }
const CL_DEVICE_NUMERIC_VERSION                         = $105E;
const CL_DEVICE_EXTENSIONS_WITH_VERSION                 = $1060;
const CL_DEVICE_ILS_WITH_VERSION                        = $1061;
const CL_DEVICE_BUILT_IN_KERNELS_WITH_VERSION           = $1062;
const CL_DEVICE_ATOMIC_MEMORY_CAPABILITIES              = $1063;
const CL_DEVICE_ATOMIC_FENCE_CAPABILITIES               = $1064;
const CL_DEVICE_NON_UNIFORM_WORK_GROUP_SUPPORT          = $1065;
const CL_DEVICE_OPENCL_C_ALL_VERSIONS                   = $1066;
const CL_DEVICE_PREFERRED_WORK_GROUP_SIZE_MULTIPLE      = $1067;
const CL_DEVICE_WORK_GROUP_COLLECTIVE_FUNCTIONS_SUPPORT = $1068;
const CL_DEVICE_GENERIC_ADDRESS_SPACE_SUPPORT           = $1069;
(* 0x106A to 0x106E - Reserved for upcoming KHR extension *)
const CL_DEVICE_OPENCL_C_FEATURES                       = $106F;
const CL_DEVICE_DEVICE_ENQUEUE_CAPABILITIES             = $1070;
const CL_DEVICE_PIPE_SUPPORT                            = $1071;
const CL_DEVICE_LATEST_CONFORMANCE_VERSION_PASSED       = $1072;
{$ENDIF}

(* cl_device_fp_config - bitfield *)
const CL_FP_DENORM                                 = (1 shl 0);
const CL_FP_INF_NAN                                = (1 shl 1);
const CL_FP_ROUND_TO_NEAREST                       = (1 shl 2);
const CL_FP_ROUND_TO_ZERO                          = (1 shl 3);
const CL_FP_ROUND_TO_INF                           = (1 shl 4);
const CL_FP_FMA                                    = (1 shl 5);
{$IF CL_VERSION_1_1 <> 0 }
const CL_FP_SOFT_FLOAT                             = (1 shl 6);
{$ENDIF}
{$IF CL_VERSION_1_2 <> 0 }
const CL_FP_CORRECTLY_ROUNDED_DIVIDE_SQRT          = (1 shl 7);
{$ENDIF}

(* cl_device_mem_cache_type *)
const CL_NONE                                      = $0;
const CL_READ_ONLY_CACHE                           = $1;
const CL_READ_WRITE_CACHE                          = $2;

(* cl_device_local_mem_type *)
const CL_LOCAL                                     = $1;
const CL_GLOBAL                                    = $2;

(* cl_device_exec_capabilities - bitfield *)
const CL_EXEC_KERNEL                               = (1 shl 0);
const CL_EXEC_NATIVE_KERNEL                        = (1 shl 1);

(* cl_command_queue_properties - bitfield *)
const CL_QUEUE_OUT_OF_ORDER_EXEC_MODE_ENABLE       = (1 shl 0);
const CL_QUEUE_PROFILING_ENABLE                    = (1 shl 1);
{$IF CL_VERSION_2_0 <> 0 }
const CL_QUEUE_ON_DEVICE                           = (1 shl 2);
const CL_QUEUE_ON_DEVICE_DEFAULT                   = (1 shl 3);
{$ENDIF}

(* cl_context_info *)
const CL_CONTEXT_REFERENCE_COUNT                   = $1080;
const CL_CONTEXT_DEVICES                           = $1081;
const CL_CONTEXT_PROPERTIES                        = $1082;
{$IF CL_VERSION_1_1 <> 0 }
const CL_CONTEXT_NUM_DEVICES                       = $1083;
{$ENDIF}

(* cl_context_properties *)
const CL_CONTEXT_PLATFORM                          = $1084;
{$IF CL_VERSION_1_2 <> 0 }
const CL_CONTEXT_INTEROP_USER_SYNC                 = $1085;
{$ENDIF}

{$IF CL_VERSION_1_2 <> 0 }

(* cl_device_partition_property *)
const CL_DEVICE_PARTITION_EQUALLY                  = $1086;
const CL_DEVICE_PARTITION_BY_COUNTS                = $1087;
const CL_DEVICE_PARTITION_BY_COUNTS_LIST_END       = $0;
const CL_DEVICE_PARTITION_BY_AFFINITY_DOMAIN       = $1088;

{$ENDIF}

{$IF CL_VERSION_1_2 <> 0 }

(* cl_device_affinity_domain *)
const CL_DEVICE_AFFINITY_DOMAIN_NUMA                = (1 shl 0);
const CL_DEVICE_AFFINITY_DOMAIN_L4_CACHE            = (1 shl 1);
const CL_DEVICE_AFFINITY_DOMAIN_L3_CACHE            = (1 shl 2);
const CL_DEVICE_AFFINITY_DOMAIN_L2_CACHE            = (1 shl 3);
const CL_DEVICE_AFFINITY_DOMAIN_L1_CACHE            = (1 shl 4);
const CL_DEVICE_AFFINITY_DOMAIN_NEXT_PARTITIONABLE  = (1 shl 5);

{$ENDIF}

{$IF CL_VERSION_2_0 <> 0 }

(* cl_device_svm_capabilities *)
const CL_DEVICE_SVM_COARSE_GRAIN_BUFFER            = (1 shl 0);
const CL_DEVICE_SVM_FINE_GRAIN_BUFFER              = (1 shl 1);
const CL_DEVICE_SVM_FINE_GRAIN_SYSTEM              = (1 shl 2);
const CL_DEVICE_SVM_ATOMICS                        = (1 shl 3);

{$ENDIF}

(* cl_command_queue_info *)
const CL_QUEUE_CONTEXT                             = $1090;
const CL_QUEUE_DEVICE                              = $1091;
const CL_QUEUE_REFERENCE_COUNT                     = $1092;
const CL_QUEUE_PROPERTIES                          = $1093;
{$IF CL_VERSION_2_0 <> 0 }
const CL_QUEUE_SIZE                                = $1094;
{$ENDIF}
{$IF CL_VERSION_2_1 <> 0 }
const CL_QUEUE_DEVICE_DEFAULT                      = $1095;
{$ENDIF}
{$IF CL_VERSION_3_0 <> 0 }
const CL_QUEUE_PROPERTIES_ARRAY                    = $1098;
{$ENDIF}

(* cl_mem_flags and cl_svm_mem_flags - bitfield *)
const CL_MEM_READ_WRITE                            = (1 shl 0);
const CL_MEM_WRITE_ONLY                            = (1 shl 1);
const CL_MEM_READ_ONLY                             = (1 shl 2);
const CL_MEM_USE_HOST_PTR                          = (1 shl 3);
const CL_MEM_ALLOC_HOST_PTR                        = (1 shl 4);
const CL_MEM_COPY_HOST_PTR                         = (1 shl 5);
(* reserved                                         (1 << 6)    *)
{$IF CL_VERSION_1_2 <> 0 }
const CL_MEM_HOST_WRITE_ONLY                       = (1 shl 7);
const CL_MEM_HOST_READ_ONLY                        = (1 shl 8);
const CL_MEM_HOST_NO_ACCESS                        = (1 shl 9);
{$ENDIF}
{$IF CL_VERSION_2_0 <> 0 }
const CL_MEM_SVM_FINE_GRAIN_BUFFER                 = (1 shl 10);   (* used by cl_svm_mem_flags only *)
const CL_MEM_SVM_ATOMICS                           = (1 shl 11);   (* used by cl_svm_mem_flags only *)
const CL_MEM_KERNEL_READ_AND_WRITE                 = (1 shl 12);
{$ENDIF}

{$IF CL_VERSION_1_2 <> 0 }

(* cl_mem_migration_flags - bitfield *)
const CL_MIGRATE_MEM_OBJECT_HOST                   = (1 shl 0);
const CL_MIGRATE_MEM_OBJECT_CONTENT_UNDEFINED      = (1 shl 1);

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
{$IF CL_VERSION_1_1 <> 0 }
const CL_Rx                                        = $10BA;
const CL_RGx                                       = $10BB;
const CL_RGBx                                      = $10BC;
{$ENDIF}
{$IF CL_VERSION_1_2 <> 0 }
const CL_DEPTH                                     = $10BD;
const CL_DEPTH_STENCIL                             = $10BE;
{$ENDIF}
{$IF CL_VERSION_2_0 <> 0 }
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
{$IF CL_VERSION_1_2 <> 0 }
const CL_UNORM_INT24                               = $10DF;
{$ENDIF}
{$IF CL_VERSION_2_1 <> 0 }
const CL_UNORM_INT_101010_2                        = $10E0;
{$ENDIF}

(* cl_mem_object_type *)
const CL_MEM_OBJECT_BUFFER                         = $10F0;
const CL_MEM_OBJECT_IMAGE2D                        = $10F1;
const CL_MEM_OBJECT_IMAGE3D                        = $10F2;
{$IF CL_VERSION_1_2 <> 0 }
const CL_MEM_OBJECT_IMAGE2D_ARRAY                  = $10F3;
const CL_MEM_OBJECT_IMAGE1D                        = $10F4;
const CL_MEM_OBJECT_IMAGE1D_ARRAY                  = $10F5;
const CL_MEM_OBJECT_IMAGE1D_BUFFER                 = $10F6;
{$ENDIF}
{$IF CL_VERSION_2_0 <> 0 }
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
{$IF CL_VERSION_1_1 <> 0 }
const CL_MEM_ASSOCIATED_MEMOBJECT                  = $1107;
const CL_MEM_OFFSET                                = $1108;
{$ENDIF}
{$IF CL_VERSION_2_0 <> 0 }
const CL_MEM_USES_SVM_POINTER                      = $1109;
{$ENDIF}
{$IF CL_VERSION_3_0 <> 0 }
const CL_MEM_PROPERTIES                            = $110A;
{$ENDIF}

(* cl_image_info *)
const CL_IMAGE_FORMAT                              = $1110;
const CL_IMAGE_ELEMENT_SIZE                        = $1111;
const CL_IMAGE_ROW_PITCH                           = $1112;
const CL_IMAGE_SLICE_PITCH                         = $1113;
const CL_IMAGE_WIDTH                               = $1114;
const CL_IMAGE_HEIGHT                              = $1115;
const CL_IMAGE_DEPTH                               = $1116;
{$IF CL_VERSION_1_2 <> 0 }
const CL_IMAGE_ARRAY_SIZE                          = $1117;
const CL_IMAGE_BUFFER                              = $1118;
const CL_IMAGE_NUM_MIP_LEVELS                      = $1119;
const CL_IMAGE_NUM_SAMPLES                         = $111A;
{$ENDIF}


(* cl_pipe_info *)
{$IF CL_VERSION_2_0 <> 0 }
const CL_PIPE_PACKET_SIZE                          = $1120;
const CL_PIPE_MAX_PACKETS                          = $1121;
{$ENDIF}
{$IF CL_VERSION_3_0 <> 0 }
const CL_PIPE_PROPERTIES                           = $1122;
{$ENDIF}

(* cl_addressing_mode *)
const CL_ADDRESS_NONE                              = $1130;
const CL_ADDRESS_CLAMP_TO_EDGE                     = $1131;
const CL_ADDRESS_CLAMP                             = $1132;
const CL_ADDRESS_REPEAT                            = $1133;
{$IF CL_VERSION_1_1 <> 0 }
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
{$IF CL_VERSION_2_0 <> 0 }
(* These enumerants are for the cl_khr_mipmap_image extension.
   They have since been added to cl_ext.h with an appropriate
   KHR suffix, but are left here for backwards compatibility. *)
const CL_SAMPLER_MIP_FILTER_MODE                   = $1155;
const CL_SAMPLER_LOD_MIN                           = $1156;
const CL_SAMPLER_LOD_MAX                           = $1157;
{$ENDIF}
{$IF CL_VERSION_3_0 <> 0 }
const CL_SAMPLER_PROPERTIES                        = $1158;
{$ENDIF}

(* cl_map_flags - bitfield *)
const CL_MAP_READ                                  = (1 shl 0);
const CL_MAP_WRITE                                 = (1 shl 1);
{$IF CL_VERSION_1_2 <> 0 }
const CL_MAP_WRITE_INVALIDATE_REGION               = (1 shl 2);
{$ENDIF}

(* cl_program_info *)
const CL_PROGRAM_REFERENCE_COUNT                   = $1160;
const CL_PROGRAM_CONTEXT                           = $1161;
const CL_PROGRAM_NUM_DEVICES                       = $1162;
const CL_PROGRAM_DEVICES                           = $1163;
const CL_PROGRAM_SOURCE                            = $1164;
const CL_PROGRAM_BINARY_SIZES                      = $1165;
const CL_PROGRAM_BINARIES                          = $1166;
{$IF CL_VERSION_1_2 <> 0 }
const CL_PROGRAM_NUM_KERNELS                       = $1167;
const CL_PROGRAM_KERNEL_NAMES                      = $1168;
{$ENDIF}
{$IF CL_VERSION_2_1 <> 0 }
const CL_PROGRAM_IL                                = $1169;
{$ENDIF}
{$IF CL_VERSION_2_2 <> 0 }
const CL_PROGRAM_SCOPE_GLOBAL_CTORS_PRESENT        = $116A;
const CL_PROGRAM_SCOPE_GLOBAL_DTORS_PRESENT        = $116B;
{$ENDIF}

(* cl_program_build_info *)
const CL_PROGRAM_BUILD_STATUS                      = $1181;
const CL_PROGRAM_BUILD_OPTIONS                     = $1182;
const CL_PROGRAM_BUILD_LOG                         = $1183;
{$IF CL_VERSION_1_2 <> 0 }
const CL_PROGRAM_BINARY_TYPE                       = $1184;
{$ENDIF}
{$IF CL_VERSION_2_0 <> 0 }
const CL_PROGRAM_BUILD_GLOBAL_VARIABLE_TOTAL_SIZE  = $1185;
{$ENDIF}

{$IF CL_VERSION_1_2 <> 0 }

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
{$IF CL_VERSION_1_2 <> 0 }
const CL_KERNEL_ATTRIBUTES                         = $1195;
{$ENDIF}

{$IF CL_VERSION_1_2 <> 0 }

(* cl_kernel_arg_info *)
const CL_KERNEL_ARG_ADDRESS_QUALIFIER              = $1196;
const CL_KERNEL_ARG_ACCESS_QUALIFIER               = $1197;
const CL_KERNEL_ARG_TYPE_NAME                      = $1198;
const CL_KERNEL_ARG_TYPE_QUALIFIER                 = $1199;
const CL_KERNEL_ARG_NAME                           = $119A;

{$ENDIF}

{$IF CL_VERSION_1_2 <> 0 }

(* cl_kernel_arg_address_qualifier *)
const CL_KERNEL_ARG_ADDRESS_GLOBAL                 = $119B;
const CL_KERNEL_ARG_ADDRESS_LOCAL                  = $119C;
const CL_KERNEL_ARG_ADDRESS_CONSTANT               = $119D;
const CL_KERNEL_ARG_ADDRESS_PRIVATE                = $119E;

{$ENDIF}

{$IF CL_VERSION_1_2 <> 0 }

(* cl_kernel_arg_access_qualifier *)
const CL_KERNEL_ARG_ACCESS_READ_ONLY               = $11A0;
const CL_KERNEL_ARG_ACCESS_WRITE_ONLY              = $11A1;
const CL_KERNEL_ARG_ACCESS_READ_WRITE              = $11A2;
const CL_KERNEL_ARG_ACCESS_NONE                    = $11A3;

{$ENDIF}

{$IF CL_VERSION_1_2 <> 0 }

(* cl_kernel_arg_type_qualifier *)
const CL_KERNEL_ARG_TYPE_NONE                      = 0;
const CL_KERNEL_ARG_TYPE_CONST                     = (1 shl 0);
const CL_KERNEL_ARG_TYPE_RESTRICT                  = (1 shl 1);
const CL_KERNEL_ARG_TYPE_VOLATILE                  = (1 shl 2);
{$IF CL_VERSION_2_0 <> 0 }
const CL_KERNEL_ARG_TYPE_PIPE                      = (1 shl 3);
{$ENDIF}

{$ENDIF}

(* cl_kernel_work_group_info *)
const CL_KERNEL_WORK_GROUP_SIZE                    = $11B0;
const CL_KERNEL_COMPILE_WORK_GROUP_SIZE            = $11B1;
const CL_KERNEL_LOCAL_MEM_SIZE                     = $11B2;
const CL_KERNEL_PREFERRED_WORK_GROUP_SIZE_MULTIPLE = $11B3;
const CL_KERNEL_PRIVATE_MEM_SIZE                   = $11B4;
{$IF CL_VERSION_1_2 <> 0 }
const CL_KERNEL_GLOBAL_WORK_SIZE                   = $11B5;
{$ENDIF}

{$IF CL_VERSION_2_1 <> 0 }

(* cl_kernel_sub_group_info *)
const CL_KERNEL_MAX_SUB_GROUP_SIZE_FOR_NDRANGE     = $2033;
const CL_KERNEL_SUB_GROUP_COUNT_FOR_NDRANGE        = $2034;
const CL_KERNEL_LOCAL_SIZE_FOR_SUB_GROUP_COUNT     = $11B8;
const CL_KERNEL_MAX_NUM_SUB_GROUPS                 = $11B9;
const CL_KERNEL_COMPILE_NUM_SUB_GROUPS             = $11BA;

{$ENDIF}

{$IF CL_VERSION_2_0 <> 0 }

(* cl_kernel_exec_info *)
const CL_KERNEL_EXEC_INFO_SVM_PTRS                 = $11B6;
const CL_KERNEL_EXEC_INFO_SVM_FINE_GRAIN_SYSTEM    = $11B7;

{$ENDIF}

(* cl_event_info *)
const CL_EVENT_COMMAND_QUEUE                       = $11D0;
const CL_EVENT_COMMAND_TYPE                        = $11D1;
const CL_EVENT_REFERENCE_COUNT                     = $11D2;
const CL_EVENT_COMMAND_EXECUTION_STATUS            = $11D3;
{$IF CL_VERSION_1_1 <> 0 }
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
{$IF CL_VERSION_1_1 <> 0 }
const CL_COMMAND_READ_BUFFER_RECT                  = $1201;
const CL_COMMAND_WRITE_BUFFER_RECT                 = $1202;
const CL_COMMAND_COPY_BUFFER_RECT                  = $1203;
const CL_COMMAND_USER                              = $1204;
{$ENDIF}
{$IF CL_VERSION_1_2 <> 0 }
const CL_COMMAND_BARRIER                           = $1205;
const CL_COMMAND_MIGRATE_MEM_OBJECTS               = $1206;
const CL_COMMAND_FILL_BUFFER                       = $1207;
const CL_COMMAND_FILL_IMAGE                        = $1208;
{$ENDIF}
{$IF CL_VERSION_2_0 <> 0 }
const CL_COMMAND_SVM_FREE                          = $1209;
const CL_COMMAND_SVM_MEMCPY                        = $120A;
const CL_COMMAND_SVM_MEMFILL                       = $120B;
const CL_COMMAND_SVM_MAP                           = $120C;
const CL_COMMAND_SVM_UNMAP                         = $120D;
{$ENDIF}
{$IF CL_VERSION_3_0 <> 0 }
const CL_COMMAND_SVM_MIGRATE_MEM                   = $120E;
{$ENDIF}

(* command execution status *)
const CL_COMPLETE                                  = $0;
const CL_RUNNING                                   = $1;
const CL_SUBMITTED                                 = $2;
const CL_QUEUED                                    = $3;

{$IF CL_VERSION_1_1 <> 0 }

(* cl_buffer_create_type *)
const CL_BUFFER_CREATE_TYPE_REGION                 = $1220;

{$ENDIF}

(* cl_profiling_info *)
const CL_PROFILING_COMMAND_QUEUED                  = $1280;
const CL_PROFILING_COMMAND_SUBMIT                  = $1281;
const CL_PROFILING_COMMAND_START                   = $1282;
const CL_PROFILING_COMMAND_END                     = $1283;
{$IF CL_VERSION_2_0 <> 0 }
const CL_PROFILING_COMMAND_COMPLETE                = $1284;
{$ENDIF}

(* cl_device_atomic_capabilities - bitfield *)
{$IF CL_VERSION_3_0 <> 0 }
const CL_DEVICE_ATOMIC_ORDER_RELAXED               = 1 shl 0;
const CL_DEVICE_ATOMIC_ORDER_ACQ_REL               = 1 shl 1;
const CL_DEVICE_ATOMIC_ORDER_SEQ_CST               = 1 shl 2;
const CL_DEVICE_ATOMIC_SCOPE_WORK_ITEM             = 1 shl 3;
const CL_DEVICE_ATOMIC_SCOPE_WORK_GROUP            = 1 shl 4;
const CL_DEVICE_ATOMIC_SCOPE_DEVICE                = 1 shl 5;
const CL_DEVICE_ATOMIC_SCOPE_ALL_DEVICES           = 1 shl 6;
{$ENDIF}

(* cl_device_device_enqueue_capabilities - bitfield *)
{$IF CL_VERSION_3_0 <> 0 }
const CL_DEVICE_QUEUE_SUPPORTED                    = 1 shl 0;
const CL_DEVICE_QUEUE_REPLACEABLE_DEFAULT          = 1 shl 1;
{$ENDIF}

(* cl_khronos_vendor_id *)
const CL_KHRONOS_VENDOR_ID_CODEPLAY                = $10004;

{$IF CL_VERSION_3_0 <> 0 }

(* cl_version *)
const CL_VERSION_MAJOR_BITS                        = 10;
const CL_VERSION_MINOR_BITS                        = 10;
const CL_VERSION_PATCH_BITS                        = 12;

const CL_VERSION_MAJOR_MASK                        = ( 1 shl CL_VERSION_MAJOR_BITS ) - 1;
const CL_VERSION_MINOR_MASK                        = ( 1 shl CL_VERSION_MINOR_BITS ) - 1;
const CL_VERSION_PATCH_MASK                        = ( 1 shl CL_VERSION_PATCH_BITS ) - 1;

//#define CL_VERSION_MAJOR(version) \
//  ((version) >> (CL_VERSION_MINOR_BITS + CL_VERSION_PATCH_BITS))

//#define CL_VERSION_MINOR(version) \
//  (((version) >> CL_VERSION_PATCH_BITS) & CL_VERSION_MINOR_MASK)

//#define CL_VERSION_PATCH(version) ((version) & CL_VERSION_PATCH_MASK)

//#define CL_MAKE_VERSION(major, minor, patch)                      \
//  ((((major) & CL_VERSION_MAJOR_MASK)                             \
//       << (CL_VERSION_MINOR_BITS + CL_VERSION_PATCH_BITS)) |      \
//   (((minor) & CL_VERSION_MINOR_MASK) << CL_VERSION_PATCH_BITS) | \
//   ((patch) & CL_VERSION_PATCH_MASK))

{$ENDIF}

(********************************************************************************************************)

(* Platform API *)
function
clGetPlatformIDs( num_entries_   :T_cl_uint;
                  platforms_     :P_cl_platform_id;
                  num_platforms_ :P_cl_uint ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

function
clGetPlatformInfo( platform_             :T_cl_platform_id;
                   param_name_           :T_cl_platform_info;
                   param_value_size_     :T_size_t;
                   param_value_          :P_void;
                   param_value_size_ret_ :P_size_t ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

(* Device APIs *)
function
clGetDeviceIDs( platform_    :T_cl_platform_id;
                device_type_ :T_cl_device_type;
                num_entries_ :T_cl_uint;
                devices_     :P_cl_device_id;
                num_devices_ :P_cl_uint ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

function
clGetDeviceInfo( device_               :T_cl_device_id;
                 param_name_           :T_cl_device_info;
                 param_value_size_     :T_size_t;
                 param_value_          :P_void;
                 param_value_size_ret_ :P_size_t ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

{$IF CL_VERSION_1_2 <> 0 }

function
clCreateSubDevices(       in_device_       :T_cl_device_id;
                    const properties_      :P_cl_device_partition_property;
                          num_devices_     :T_cl_uint;
                          out_devices_     :P_cl_device_id;
                          num_devices_ret_ :P_cl_uint ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_2}

function
clRetainDevice( device_ :T_cl_device_id ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_2}

function
clReleaseDevice( device_ :T_cl_device_id ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_2}

{$ENDIF}

{$IF CL_VERSION_2_1 <> 0 }

function
clSetDefaultDeviceCommandQueue( context_       :T_cl_context;
                                device_        :T_cl_device_id;
                                command_queue_ :T_cl_command_queue ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_2_1}

function
clGetDeviceAndHostTimer( device_           :T_cl_device_id;
                         device_timestamp_ :P_cl_ulong;
                         host_timestamp_   :P_cl_ulong ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_2_1}

function
clGetHostTimer( device_         :T_cl_device_id;
                host_timestamp_ :P_cl_ulong ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_2_1}

{$ENDIF}

(* Context APIs *)

type P_CL_CALLBACK_clCreateContext = procedure( const errinfo_      :P_char;
                                                const private_info_ :P_void;
                                                      cb_           :T_size_t;
                                                      user_data_    :P_void );

function
clCreateContext( const properties_  :P_cl_context_properties;
                       num_devices_ :T_cl_uint;
                 const devices_     :P_cl_device_id;
                       pfn_notify_  :P_CL_CALLBACK_clCreateContext;
                       user_data_   :P_void;
                       errcode_ret_ :P_cl_int ) :T_cl_context; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

type P_CL_CALLBACK_clCreateContextFromType = procedure( const errinfo_      :P_char;
                                                        const private_info_ :P_void;
                                                              cb_           :T_size_t;
                                                              user_data_    :P_void );

function
clCreateContextFromType( const properties_  :P_cl_context_properties;
                               device_type_ :T_cl_device_type;
                               pfn_notify_  :P_CL_CALLBACK_clCreateContextFromType;
                               user_data_   :P_void;
                               errcode_ret_ :P_cl_int ) :T_cl_context; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

function
clRetainContext( context_ :T_cl_context ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

function
clReleaseContext( context_ :T_cl_context ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

function
clGetContextInfo( context_              :T_cl_context;
                  param_name_           :T_cl_context_info;
                  param_value_size_     :T_size_t;
                  param_value_          :P_void;
                  param_value_size_ret_ :P_size_t ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

{$IF CL_VERSION_3_0 <> 0 }

type T_pfn_notify = procedure ( context_   :T_cl_context;
                                user_data_ :P_void );

function
clSetContextDestructorCallback( context_    :T_cl_context;
                                pfn_notify_ :T_pfn_notify;
                                user_data_  :P_void ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_3_0}

{$ENDIF}

(* Command Queue APIs *)

{$IF CL_VERSION_2_0 <> 0 }

function
clCreateCommandQueueWithProperties(       context_     :T_cl_context;
                                          device_      :T_cl_device_id;
                                    const properties_  :P_cl_queue_properties;
                                          errcode_ret_ :P_cl_int ) :T_cl_command_queue; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_2_0}

{$ENDIF}

function
clRetainCommandQueue( command_queue_ :T_cl_command_queue ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

function
clReleaseCommandQueue( command_queue_ :T_cl_command_queue ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

function
clGetCommandQueueInfo( command_queue_        :T_cl_command_queue;
                       param_name_           :T_cl_command_queue_info;
                       param_value_size_     :T_size_t;
                       param_value_          :P_void;
                       param_value_size_ret_ :P_size_t ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

(* Memory Object APIs *)
function
clCreateBuffer( context_     :T_cl_context;
                flags_       :T_cl_mem_flags;
                size_        :T_size_t;
                host_ptr_    :P_void;
                errcode_ret_ :P_cl_int ) :T_cl_mem; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

{$IF CL_VERSION_1_1 <> 0 }

function
clCreateSubBuffer(       buffer_             :T_cl_mem;
                         flags_              :T_cl_mem_flags;
                         buffer_create_type_ :T_cl_buffer_create_type;
                   const buffer_create_info_ :P_void;
                         errcode_ret_        :P_cl_int ) :T_cl_mem; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_1}

{$ENDIF}

{$IF CL_VERSION_1_2 <> 0 }

function
clCreateImage(       context_      :T_cl_context;
                     flags_        :T_cl_mem_flags;
               const image_format_ :P_cl_image_format;
               const image_desc_   :P_cl_image_desc;
                     host_ptr_     :P_void;
                     errcode_ret_  :P_cl_int ) :T_cl_mem; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_2}

{$ENDIF}

{$IF CL_VERSION_2_0 <> 0 }

function
clCreatePipe(       context_          :T_cl_context;
                    flags_            :T_cl_mem_flags;
                    pipe_packet_size_ :T_cl_uint;
                    pipe_max_packets_ :T_cl_uint;
              const properties_       :P_cl_pipe_properties;
                    errcode_ret_      :P_cl_int ) :T_cl_mem; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_2_0}

{$ENDIF}

{$IF CL_VERSION_3_0 <> 0 }

function
clCreateBufferWithProperties(       context_     :T_cl_context;
                              const properties_  :P_cl_mem_properties;
                                    flags_       :T_cl_mem_flags;
                                    size_        :T_size_t;
                                    host_ptr_    :P_void;
                                    errcode_ret_ :P_cl_int ) :T_cl_mem; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_3_0}

function
clCreateImageWithProperties( context_ :T_cl_context;
                             const properties_   :P_cl_mem_properties;
                                   flags_        :T_cl_mem_flags;
                             const image_format_ :P_cl_image_format;
                             const image_desc_   :P_cl_image_desc;
                                   host_ptr_     :P_void;
                                   errcode_ret_  :P_cl_int ) :T_cl_mem; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_3_0}

{$ENDIF}

function
clRetainMemObject( memobj_ :T_cl_mem ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

function
clReleaseMemObject( memobj_ :T_cl_mem ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

function
clGetSupportedImageFormats( context_           :T_cl_context;
                            flags_             :T_cl_mem_flags;
                            image_type_        :T_cl_mem_object_type;
                            num_entries_       :T_cl_uint;
                            image_formats_     :P_cl_image_format;
                            num_image_formats_ :P_cl_uint ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

function
clGetMemObjectInfo( memobj_               :T_cl_mem;
                    param_name_           :T_cl_mem_info;
                    param_value_size_     :T_size_t;
                    param_value_          :P_void;
                    param_value_size_ret_ :P_size_t ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

function
clGetImageInfo( image_                :T_cl_mem;
                param_name_           :T_cl_image_info;
                param_value_size_     :T_size_t;
                param_value_          :P_void;
                param_value_size_ret_ :P_size_t ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

{$IF CL_VERSION_2_0 <> 0 }

function
clGetPipeInfo( pipe_                 :T_cl_mem;
               param_name_           :T_cl_pipe_info;
               param_value_size_     :T_size_t;
               param_value_          :P_void;
               param_value_size_ret_ :P_size_t ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_2_0}

{$ENDIF}

{$IF CL_VERSION_1_1 <> 0 }

type P_CL_CALLBACK_clSetMemObjectDestructorCallback = procedure( memobj_    :T_cl_mem;
                                                                 user_data_ :P_void );

function
clSetMemObjectDestructorCallback( memobj_     :T_cl_mem;
                                  pfn_notify_ :P_CL_CALLBACK_clSetMemObjectDestructorCallback;
                                  user_data_  :P_void ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_1}

{$ENDIF}

(* SVM Allocation APIs *)

{$IF CL_VERSION_2_0 <> 0 }

function
clSVMAlloc( context_   :T_cl_context;
            flags_     :T_cl_svm_mem_flags;
            size_      :T_size_t;
            alignment_ :T_cl_uint ) :P_void; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_2_0}

procedure
clSVMFree( context_     :T_cl_context;
           svm_pointer_ :P_void ); stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_2_0}

{$ENDIF}

(* Sampler APIs *)

{$IF CL_VERSION_2_0 <> 0 }

function
clCreateSamplerWithProperties(       context_            :T_cl_context;
                               const sampler_properties_ :P_cl_sampler_properties;
                                     errcode_ret_        :P_cl_int ) :T_cl_sampler; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_2_0}

{$ENDIF}

function
clRetainSampler( sampler_ :T_cl_sampler ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

function
clReleaseSampler( sampler_ :T_cl_sampler ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

function
clGetSamplerInfo( sampler_              :T_cl_sampler;
                  param_name_           :T_cl_sampler_info;
                  param_value_size_     :T_size_t;
                  param_value_          :P_void;
                  param_value_size_ret_ :P_size_t ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

(* Program Object APIs *)
function
clCreateProgramWithSource(       context_     :T_cl_context;
                                 count_       :T_cl_uint;
                           const strings_     :PP_char;
                           const lengths_     :P_size_t;
                                 errcode_ret_ :P_cl_int ) :T_cl_program; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

function
clCreateProgramWithBinary(       context_       :T_cl_context;
                                 num_devices_   :T_cl_uint;
                           const device_list_   :P_cl_device_id;
                           const lengths_       :P_size_t;
                           const binaries_      :PP_unsigned_char;
                                 binary_status_ :P_cl_int;
                                 errcode_ret_   :P_cl_int ) :T_cl_program; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

{$IF CL_VERSION_1_2 <> 0 }

function
clCreateProgramWithBuiltInKernels(       context_      :T_cl_context;
                                         num_devices_  :T_cl_uint;
                                   const device_list_  :P_cl_device_id;
                                   const kernel_names_ :P_char;
                                         errcode_ret_  :P_cl_int ) :T_cl_program; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_2}

{$ENDIF}

{$IF CL_VERSION_2_1 <> 0 }

function
clCreateProgramWithIL(       context_     :T_cl_context;
                       const il_          :P_void;
                             length_      :T_size_t;
                             errcode_ret_ :P_cl_int ) :T_cl_program; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_2_1}

{$ENDIF}

function
clRetainProgram( program_ :T_cl_program ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

function
clReleaseProgram( program_ :T_cl_program ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

type P_CL_CALLBACK_clBuildProgram = procedure( program_   :T_cl_program;
                                               user_data_ :P_void );

function
clBuildProgram(       program_     :T_cl_program;
                      num_devices_ :T_cl_uint;
                const device_list_ :P_cl_device_id;
                const options_     :P_char;
                      pfn_notify_  :P_CL_CALLBACK_clBuildProgram;
                      user_data_   :P_void ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

{$IF CL_VERSION_1_2 <> 0 }

type P_CL_CALLBACK_clCompileProgram = procedure( program_   :T_cl_program;
                                                 user_data_ :P_void );

function
clCompileProgram(       program_              :T_cl_program;
                        num_devices_          :T_cl_uint;
                  const device_list_          :P_cl_device_id;
                  const options_              :P_char;
                        num_input_headers_    :T_cl_uint;
                  const input_headers_        :P_cl_program;
                  const header_include_names_ :PP_char;
                        pfn_notify_           :P_CL_CALLBACK_clCompileProgram;
                        user_data_            :P_void ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_2}

type P_CL_CALLBACK_clLinkProgram = procedure( program_   :T_cl_program;
                                              user_data_ :P_void );

function
clLinkProgram(       context_            :T_cl_context;
                     num_devices_        :T_cl_uint;
               const device_list_        :P_cl_device_id;
               const options_            :P_char;
                     num_input_programs_ :T_cl_uint;
               const input_programs_     :P_cl_program;
                     pfn_notify_         :P_CL_CALLBACK_clLinkProgram;
                     user_data_          :P_void;
                     errcode_ret_        :P_cl_int ) :T_cl_program; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_2}

{$ENDIF}

{$IF CL_VERSION_2_2 <> 0 }

type P_CL_CALLBACK_clSetProgramReleaseCallback = procedure( program_   :T_cl_program;
                                                            user_data_ :P_void );

function
clSetProgramReleaseCallback( program_    :T_cl_program;
                             pfn_notify_ :P_CL_CALLBACK_clSetProgramReleaseCallback;
                             user_data_  :P_void ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_2_2_DEPRECATED}

function
clSetProgramSpecializationConstant(       program_    :T_cl_program;
                                          spec_id_    :T_cl_uint;
                                          spec_size_  :T_size_t;
                                    const spec_value_ :P_void ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_2_2}

{$ENDIF}

{$IF CL_VERSION_1_2 <> 0 }

function
clUnloadPlatformCompiler( platform_ :T_cl_platform_id ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_2}

{$ENDIF}

function
clGetProgramInfo( program_              :T_cl_program;
                  param_name_           :T_cl_program_info;
                  param_value_size_     :T_size_t;
                  param_value_          :P_void;
                  param_value_size_ret_ :P_size_t ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

function
clGetProgramBuildInfo( program_              :T_cl_program;
                       device_               :T_cl_device_id;
                       param_name_           :T_cl_program_build_info;
                       param_value_size_     :T_size_t;
                       param_value_          :P_void;
                       param_value_size_ret_ :P_size_t ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

(* Kernel Object APIs *)
function
clCreateKernel(       program_     :T_cl_program;
                const kernel_name_ :P_char;
                      errcode_ret_ :P_cl_int ) :T_cl_kernel; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

function
clCreateKernelsInProgram( program_         :T_cl_program;
                          num_kernels_     :T_cl_uint;
                          kernels_         :P_cl_kernel;
                          num_kernels_ret_ :P_cl_uint ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

{$IF CL_VERSION_2_1 <> 0 }

function
clCloneKernel( source_kernel_ :T_cl_kernel;
               errcode_ret_   :P_cl_int ) :T_cl_kernel; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_2_1}

{$ENDIF}

function
clRetainKernel( kernel_ :T_cl_kernel ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

function
clReleaseKernel( kernel_ :T_cl_kernel ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

function
clSetKernelArg(       kernel_    :T_cl_kernel;
                      arg_index_ :T_cl_uint;
                      arg_size_  :T_size_t;
                const arg_value_ :P_void ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

{$IF CL_VERSION_2_0 <> 0 }

function
clSetKernelArgSVMPointer(       kernel_    :T_cl_kernel;
                                arg_index_ :T_cl_uint;
                          const arg_value_ :P_void ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_2_0}

function
clSetKernelExecInfo(       kernel_           :T_cl_kernel;
                           param_name_       :T_cl_kernel_exec_info;
                           param_value_size_ :T_size_t;
                     const param_value_      :P_void ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_2_0}

{$ENDIF}

function
clGetKernelInfo( kernel_               :T_cl_kernel;
                 param_name_           :T_cl_kernel_info;
                 param_value_size_     :T_size_t;
                 param_value_          :P_void;
                 param_value_size_ret_ :P_size_t ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

{$IF CL_VERSION_1_2 <> 0 }

function
clGetKernelArgInfo( kernel_               :T_cl_kernel;
                    arg_indx_             :T_cl_uint;
                    param_name_           :T_cl_kernel_arg_info;
                    param_value_size_     :T_size_t;
                    param_value_          :P_void;
                    param_value_size_ret_ :P_size_t ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_2}

{$ENDIF}

function
clGetKernelWorkGroupInfo( kernel_               :T_cl_kernel;
                          device_               :T_cl_device_id;
                          param_name_           :T_cl_kernel_work_group_info;
                          param_value_size_     :T_size_t;
                          param_value_          :P_void;
                          param_value_size_ret_ :P_size_t ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

{$IF CL_VERSION_2_1 <> 0 }

function
clGetKernelSubGroupInfo(       kernel_               :T_cl_kernel;
                               device_               :T_cl_device_id;
                               param_name_           :T_cl_kernel_sub_group_info;
                               input_value_size_     :T_size_t;
                         const input_value_          :P_void;
                               param_value_size_     :T_size_t;
                               param_value_          :P_void;
                               param_value_size_ret_ :P_size_t ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_2_1}

{$ENDIF}

(* Event Object APIs *)
function
clWaitForEvents(       num_events_ :T_cl_uint;
                 const event_list_ :P_cl_event ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

function
clGetEventInfo( event_                :T_cl_event;
                param_name_           :T_cl_event_info;
                param_value_size_     :T_size_t;
                param_value_          :P_void;
                param_value_size_ret_ :P_size_t ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

{$IF CL_VERSION_1_1 <> 0 }

function
clCreateUserEvent( context_     :T_cl_context;
                   errcode_ret_ :P_cl_int ) :T_cl_event; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_1}

{$ENDIF}

function
clRetainEvent( event_ :T_cl_event ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

function
clReleaseEvent( event_ :T_cl_event ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

{$IF CL_VERSION_1_1 <> 0 }

function
clSetUserEventStatus( event_            :T_cl_event;
                      execution_status_ :T_cl_int ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_1}

type P_CL_CALLBACK_clSetEventCallback = procedure( event_                :T_cl_event;
                                                   event_command_status_ :T_cl_int;
                                                   user_data_            :P_void );

function
clSetEventCallback( event_                      :T_cl_event;
                    command_exec_callback_type_ :T_cl_int;
                    pfn_notify_                 :P_CL_CALLBACK_clSetEventCallback;
                    user_data_                  :P_void ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_1}

{$ENDIF}

(* Profiling APIs *)
function
clGetEventProfilingInfo( event_                :T_cl_event;
                         param_name_           :T_cl_profiling_info;
                         param_value_size_     :T_size_t;
                         param_value_          :P_void;
                         param_value_size_ret_ :P_size_t ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

(* Flush and Finish APIs *)
function
clFlush( command_queue_ :T_cl_command_queue ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

function
clFinish( command_queue_ :T_cl_command_queue ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

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
                           event_                   :P_cl_event ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

{$IF CL_VERSION_1_1 <> 0 }

function
clEnqueueReadBufferRect(       command_queue_           :T_cl_command_queue;
                               buffer_                  :T_cl_mem;
                               blocking_read_           :T_cl_bool;
                         const buffer_origin_           :P_size_t;
                         const host_origin_             :P_size_t;
                         const region_                  :P_size_t;
                               buffer_row_pitch_        :T_size_t;
                               buffer_slice_pitch_      :T_size_t;
                               host_row_pitch_          :T_size_t;
                               host_slice_pitch_        :T_size_t;
                               ptr_                     :P_void;
                               num_events_in_wait_list_ :T_cl_uint;
                         const event_wait_list_         :P_cl_event;
                               event_                   :P_cl_event ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_1}

{$ENDIF}

function
clEnqueueWriteBuffer(       command_queue_           :T_cl_command_queue;
                            buffer_                  :T_cl_mem;
                            blocking_write_          :T_cl_bool;
                            offset_                  :T_size_t;
                            size_                    :T_size_t;
                      const ptr_                     :P_void;
                            num_events_in_wait_list_ :T_cl_uint;
                      const event_wait_list_         :P_cl_event;
                            event_                   :P_cl_event ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

{$IF CL_VERSION_1_1 <> 0 }

function
clEnqueueWriteBufferRect(       command_queue_           :T_cl_command_queue;
                                buffer_                  :T_cl_mem;
                                blocking_write_          :T_cl_bool;
                          const buffer_origin_           :P_size_t;
                          const host_origin_             :P_size_t;
                          const region_                  :P_size_t;
                                buffer_row_pitch_        :T_size_t;
                                buffer_slice_pitch_      :T_size_t;
                                host_row_pitch_          :T_size_t;
                                host_slice_pitch_        :T_size_t;
                          const ptr_                     :P_void;
                                num_events_in_wait_list_ :T_cl_uint;
                          const event_wait_list_         :P_cl_event;
                                event_                   :P_cl_event ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_1}

{$ENDIF}

{$IF CL_VERSION_1_2 <> 0 }

function
clEnqueueFillBuffer(       command_queue_           :T_cl_command_queue;
                           buffer_                  :T_cl_mem;
                     const pattern_                 :P_void;
                           pattern_size_            :T_size_t;
                           offset_                  :T_size_t;
                           size_                    :T_size_t;
                           num_events_in_wait_list_ :T_cl_uint;
                     const event_wait_list_         :P_cl_event;
                           event_                   :P_cl_event ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_2}

{$ENDIF}

function
clEnqueueCopyBuffer(       command_queue_           :T_cl_command_queue;
                           src_buffer_              :T_cl_mem;
                           dst_buffer_              :T_cl_mem;
                           src_offset_              :T_size_t;
                           dst_offset_              :T_size_t;
                           size_                    :T_size_t;
                           num_events_in_wait_list_ :T_cl_uint;
                     const event_wait_list_         :P_cl_event;
                           event_                   :P_cl_event ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

{$IF CL_VERSION_1_1 <> 0 }

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
                               event_                   :P_cl_event ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_1}

{$ENDIF}

function
clEnqueueReadImage(       command_queue_           :T_cl_command_queue;
                          image_                   :T_cl_mem;
                          blocking_read_           :T_cl_bool;
                    const origin_                  :P_size_t;
                    const region_                  :P_size_t;
                          row_pitch_               :T_size_t;
                          slice_pitch_             :T_size_t;
                          ptr_                     :P_void;
                          num_events_in_wait_list_ :T_cl_uint;
                    const event_wait_list_         :P_cl_event;
                          event_                   :P_cl_event ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

function
clEnqueueWriteImage(       command_queue_           :T_cl_command_queue;
                           image_                   :T_cl_mem;
                           blocking_write_          :T_cl_bool;
                     const origin_                  :P_size_t;
                     const region_                  :P_size_t;
                           input_row_pitch_         :T_size_t;
                           input_slice_pitch_       :T_size_t;
                     const ptr_                     :P_void;
                           num_events_in_wait_list_ :T_cl_uint;
                     const event_wait_list_         :P_cl_event;
                           event_                   :P_cl_event ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

{$IF CL_VERSION_1_2 <> 0 }

function
clEnqueueFillImage(       command_queue_           :T_cl_command_queue;
                          image_                   :T_cl_mem;
                    const fill_color_              :P_void;
                    const origin_                  :P_size_t;
                    const region_                  :P_size_t;
                          num_events_in_wait_list_ :T_cl_uint;
                    const event_wait_list_         :P_cl_event;
                          event_                   :P_cl_event ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_2}

{$ENDIF}

function
clEnqueueCopyImage(       command_queue_           :T_cl_command_queue;
                          src_image_               :T_cl_mem;
                          dst_image_               :T_cl_mem;
                    const src_origin_              :P_size_t;
                    const dst_origin_              :P_size_t;
                    const region_                  :P_size_t;
                          num_events_in_wait_list_ :T_cl_uint;
                    const event_wait_list_         :P_cl_event;
                          event_                   :P_cl_event ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

function
clEnqueueCopyImageToBuffer(       command_queue_           :T_cl_command_queue;
                                  src_image_               :T_cl_mem;
                                  dst_buffer_              :T_cl_mem;
                            const src_origin_              :P_size_t;
                            const region_                  :P_size_t;
                                  dst_offset_              :T_size_t;
                                  num_events_in_wait_list_ :T_cl_uint;
                            const event_wait_list_         :P_cl_event;
                                  event_                   :P_cl_event ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

function
clEnqueueCopyBufferToImage(       command_queue_           :T_cl_command_queue;
                                  src_buffer_              :T_cl_mem;
                                  dst_image_               :T_cl_mem;
                                  src_offset_              :T_size_t;
                            const dst_origin_              :P_size_t;
                            const region_                  :P_size_t;
                                  num_events_in_wait_list_ :T_cl_uint;
                            const event_wait_list_         :P_cl_event;
                                  event_                   :P_cl_event ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

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
                          errcode_ret_             :P_cl_int ) :P_void; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

function
clEnqueueMapImage(       command_queue_           :T_cl_command_queue;
                         image_                   :T_cl_mem;
                         blocking_map_            :T_cl_bool;
                         map_flags_               :T_cl_map_flags;
                   const origin_                  :P_size_t;
                   const region_                  :P_size_t;
                         image_row_pitch_         :P_size_t;
                         image_slice_pitch_       :P_size_t;
                         num_events_in_wait_list_ :T_cl_uint;
                   const event_wait_list_         :P_cl_event;
                         event_                   :P_cl_event;
                         errcode_ret_             :P_cl_int ) :P_void; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

function
clEnqueueUnmapMemObject(       command_queue_           :T_cl_command_queue;
                               memobj_                  :T_cl_mem;
                               mapped_ptr_              :P_void;
                               num_events_in_wait_list_ :T_cl_uint;
                         const event_wait_list_         :P_cl_event;
                               event_                   :P_cl_event ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

{$IF CL_VERSION_1_2 <> 0 }

function
clEnqueueMigrateMemObjects(       command_queue_           :T_cl_command_queue;
                                  num_mem_objects_         :T_cl_uint;
                            const mem_objects_             :P_cl_mem;
                                  flags_                   :T_cl_mem_migration_flags;
                                  num_events_in_wait_list_ :T_cl_uint;
                            const event_wait_list_         :P_cl_event;
                                  event_                   :P_cl_event ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_2}

{$ENDIF}

function
clEnqueueNDRangeKernel(       command_queue_           :T_cl_command_queue;
                              kernel_                  :T_cl_kernel;
                              work_dim_                :T_cl_uint;
                        const global_work_offset_      :P_size_t;
                        const global_work_size_        :P_size_t;
                        const local_work_size_         :P_size_t;
                              num_events_in_wait_list_ :T_cl_uint;
                        const event_wait_list_         :P_cl_event;
                              event_                   :P_cl_event ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

type P_CL_CALLBACK_clEnqueueNativeKernel = function :P_void;

function
clEnqueueNativeKernel(       command_queue_           :T_cl_command_queue;
                             user_func_               :P_CL_CALLBACK_clEnqueueNativeKernel;
                             args_                    :P_void;
                             cb_args_                 :T_size_t;
                             num_mem_objects_         :T_cl_uint;
                       const mem_list_                :P_cl_mem;
                       const args_mem_loc_            :PP_void;
                             num_events_in_wait_list_ :T_cl_uint;
                       const event_wait_list_         :P_cl_event;
                             event_                   :P_cl_event ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0}

{$IF CL_VERSION_1_2 <> 0 }

function
clEnqueueMarkerWithWaitList(       command_queue_           :T_cl_command_queue;
                                   num_events_in_wait_list_ :T_cl_uint;
                             const event_wait_list_         :P_cl_event;
                                   event_                   :P_cl_event ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_2}

function
clEnqueueBarrierWithWaitList(       command_queue_           :T_cl_command_queue;
                                    num_events_in_wait_list_ :T_cl_uint;
                              const event_wait_list_         :P_cl_event;
                                    event_                   :P_cl_event ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_2}

{$ENDIF}

{$IF CL_VERSION_2_0 <> 0 }

type P_CL_CALLBACK_clEnqueueSVMFree = procedure( queue_            :T_cl_command_queue;
                                                 num_svm_pointers_ :T_cl_uint;
                                                 svm_pointers_     :array of P_void;
                                                 user_data_        :P_void );

function
clEnqueueSVMFree(       command_queue_           :T_cl_command_queue;
                        num_svm_pointers_        :T_cl_uint;
                        svm_pointers_            :array of P_void;
                        pfn_free_func_           :P_CL_CALLBACK_clEnqueueSVMFree;
                        user_data_               :P_void;
                        num_events_in_wait_list_ :T_cl_uint;
                  const event_wait_list_         :P_cl_event;
                        event_                   :P_cl_event ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_2_0}

function
clEnqueueSVMMemcpy(       command_queue_           :T_cl_command_queue;
                          blocking_copy_           :T_cl_bool;
                          dst_ptr_                 :P_void;
                    const src_ptr_                 :P_void;
                          size_                    :T_size_t;
                          num_events_in_wait_list_ :T_cl_uint;
                    const event_wait_list_         :P_cl_event;
                          event_                   :P_cl_event ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_2_0}

function
clEnqueueSVMMemFill(       command_queue_           :T_cl_command_queue;
                           svm_ptr_                 :P_void;
                     const pattern_                 :P_void;
                           pattern_size_            :T_size_t;
                           size_                    :T_size_t;
                           num_events_in_wait_list_ :T_cl_uint;
                     const event_wait_list_         :P_cl_event;
                           event_                   :P_cl_event ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_2_0}

function
clEnqueueSVMMap(       command_queue_           :T_cl_command_queue;
                       blocking_map_            :T_cl_bool;
                       flags_                   :T_cl_map_flags;
                       svm_ptr_                 :P_void;
                       size_                    :T_size_t;
                       num_events_in_wait_list_ :T_cl_uint;
                 const event_wait_list_         :P_cl_event;
                       event_                   :P_cl_event ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_2_0}

function
clEnqueueSVMUnmap(       command_queue_           :T_cl_command_queue;
                         svm_ptr_                 :P_void;
                         num_events_in_wait_list_ :T_cl_uint;
                   const event_wait_list_         :P_cl_event;
                         event_                   :P_cl_event ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_2_0}

{$ENDIF}

{$IF CL_VERSION_2_1 <> 0 }

function
clEnqueueSVMMigrateMem(       command_queue_           :T_cl_command_queue;
                              num_svm_pointers_        :T_cl_uint;
                        const svm_pointers_            :PP_void;
                        const sizes_                   :P_size_t;
                              flags_                   :T_cl_mem_migration_flags;
                              num_events_in_wait_list_ :T_cl_uint;
                        const event_wait_list_         :P_cl_event;
                              event_                   :P_cl_event ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_2_1}

{$ENDIF}

{$IF CL_VERSION_1_2 <> 0 }

(* Extension function access
 *
 * Returns the extension function address for the given function name,
 * or NULL if a valid function can not be found.  The client must
 * check to make sure the address is not NULL, before using or
 * calling the returned function address.
 *)
function
clGetExtensionFunctionAddressForPlatform(       platform_  :T_cl_platform_id;
                                          const func_name_ :P_char ) :P_void; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_2}

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
    function
    clSetCommandQueueProperty( command_queue_  :T_cl_command_queue;
                               properties_     :T_cl_command_queue_properties;
                               enable_         :T_cl_bool;
                               old_properties_ :P_cl_command_queue_properties ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_0_DEPRECATED}
{$ENDIF} (* CL_USE_DEPRECATED_OPENCL_1_0_APIS *)

(* Deprecated OpenCL 1.1 APIs *)
function {CL_EXT_PREFIX__VERSION_1_1_DEPRECATED}
clCreateImage2D(       context_         :T_cl_context;
                       flags_           :T_cl_mem_flags;
                 const image_format_    :P_cl_image_format;
                       image_width_     :T_size_t;
                       image_height_    :T_size_t;
                       image_row_pitch_ :T_size_t;
                       host_ptr_        :P_void;
                       errcode_ret_     :P_cl_int ) :T_cl_mem; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_1_DEPRECATED}

function {CL_EXT_PREFIX__VERSION_1_1_DEPRECATED}
clCreateImage3D(       context_           :T_cl_context;
                       flags_             :T_cl_mem_flags;
                 const image_format_      :P_cl_image_format;
                       image_width_       :T_size_t;
                       image_height_      :T_size_t;
                       image_depth_       :T_size_t;
                       image_row_pitch_   :T_size_t;
                       image_slice_pitch_ :T_size_t;
                       host_ptr_          :P_void;
                       errcode_ret_       :P_cl_int ) :T_cl_mem; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_1_DEPRECATED}

function {CL_EXT_PREFIX__VERSION_1_1_DEPRECATED}
clEnqueueMarker( command_queue_ :T_cl_command_queue;
                 event_         :P_cl_event ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_1_DEPRECATED}

function {CL_EXT_PREFIX__VERSION_1_1_DEPRECATED}
clEnqueueWaitForEvents(       command_queue_ :T_cl_command_queue;
                              num_events_    :T_cl_uint;
                        const event_list_    :P_cl_event ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_1_DEPRECATED}

function {CL_EXT_PREFIX__VERSION_1_1_DEPRECATED}
clEnqueueBarrier( command_queue_ :T_cl_command_queue ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_1_DEPRECATED}

function {CL_EXT_PREFIX__VERSION_1_1_DEPRECATED}
clUnloadCompiler :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_1_DEPRECATED}

function {CL_EXT_PREFIX__VERSION_1_1_DEPRECATED}
clGetExtensionFunctionAddress( const func_name_ :P_char ) :P_void; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_1_DEPRECATED}

(* Deprecated OpenCL 2.0 APIs *)
function {CL_EXT_PREFIX__VERSION_1_2_DEPRECATED}
clCreateCommandQueue( context_     :T_cl_context;
                      device_      :T_cl_device_id;
                      properties_  :T_cl_command_queue_properties;
                      errcode_ret_ :P_cl_int ) :T_cl_command_queue; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_2_DEPRECATED}

function {CL_EXT_PREFIX__VERSION_1_2_DEPRECATED}
clCreateSampler( context_           :T_cl_context;
                 normalized_coords_ :T_cl_bool;
                 addressing_mode_   :T_cl_addressing_mode;
                 filter_mode_       :T_cl_filter_mode;
                 errcode_ret_       :P_cl_int ) :T_cl_sampler; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_2_DEPRECATED}

function {CL_EXT_PREFIX__VERSION_1_2_DEPRECATED}
clEnqueueTask(       command_queue_           :T_cl_command_queue;
                     kernel_                  :T_cl_kernel;
                     num_events_in_wait_list_ :T_cl_uint;
               const event_wait_list_         :P_cl_event;
                     event_                   :P_cl_event ) :T_cl_int; stdcall; external DLLNAME; {CL_API_SUFFIX__VERSION_1_2_DEPRECATED}

implementation //############################################################### ■

end. //######################################################################### ■
