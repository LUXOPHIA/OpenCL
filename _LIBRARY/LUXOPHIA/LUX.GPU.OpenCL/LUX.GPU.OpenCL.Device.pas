unit LUX.GPU.OpenCL.Device;

interface //#################################################################### ■

uses cl_version, cl_platform, cl,
     LUX.Data.List,
     LUX.Code.C,
     LUX.GPU.OpenCL.core;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TCLDevices <TCLPlatfo_:class> = class;
       TCLDevice<TCLPlatfo_:class> = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDevice<TCLPlatfo_>

     TCLDevice<TCLPlatfo_:class> = class( TListChildr<TCLPlatfo_,TCLDevices<TCLPlatfo_>> )
     private
       type TCLDevices_ = TCLDevices<TCLPlatfo_>;
       ///// メソッド
       function GetInfo<_TYPE_>( const Name_:T_cl_device_info ) :_TYPE_;
       function GetInfoSize( const Name_:T_cl_device_info ) :T_size_t;
       function GetInfos<_TYPE_>( const Name_:T_cl_device_info ) :TArray<_TYPE_>;
       function GetInfoString( const Name_:T_cl_device_info ) :String;
     protected
       _Handle :T_cl_device_id;
       ///// アクセス
       function GetLanVer :TCLVersion;
       (* cl_device_info *)
       function GetDEVICE_TYPE :T_cl_device_type;
       function GetDEVICE_VENDOR_ID :T_cl_uint;
       function GetDEVICE_MAX_COMPUTE_UNITS :T_cl_uint;
       function GetDEVICE_MAX_WORK_ITEM_DIMENSIONS :T_cl_uint;
       function GetDEVICE_MAX_WORK_GROUP_SIZE :T_size_t;
       function GetDEVICE_MAX_WORK_ITEM_SIZES :TArray<T_size_t>;
       function GetDEVICE_PREFERRED_VECTOR_WIDTH_CHAR :T_cl_uint;
       function GetDEVICE_PREFERRED_VECTOR_WIDTH_SHORT :T_cl_uint;
       function GetDEVICE_PREFERRED_VECTOR_WIDTH_INT :T_cl_uint;
       function GetDEVICE_PREFERRED_VECTOR_WIDTH_LONG :T_cl_uint;
       function GetDEVICE_PREFERRED_VECTOR_WIDTH_FLOAT :T_cl_uint;
       function GetDEVICE_PREFERRED_VECTOR_WIDTH_DOUBLE :T_cl_uint;
       function GetDEVICE_MAX_CLOCK_FREQUENCY :T_cl_uint;
       function GetDEVICE_ADDRESS_BITS :T_cl_uint;
       function GetDEVICE_MAX_READ_IMAGE_ARGS :T_cl_uint;
       function GetDEVICE_MAX_WRITE_IMAGE_ARGS :T_cl_uint;
       function GetDEVICE_MAX_MEM_ALLOC_SIZE :T_cl_ulong;
       function GetDEVICE_IMAGE2D_MAX_WIDTH :T_size_t;
       function GetDEVICE_IMAGE2D_MAX_HEIGHT :T_size_t;
       function GetDEVICE_IMAGE3D_MAX_WIDTH :T_size_t;
       function GetDEVICE_IMAGE3D_MAX_HEIGHT :T_size_t;
       function GetDEVICE_IMAGE3D_MAX_DEPTH :T_size_t;
       function GetDEVICE_IMAGE_SUPPORT :T_cl_bool;
       function GetDEVICE_MAX_PARAMETER_SIZE :T_size_t;
       function GetDEVICE_MAX_SAMPLERS :T_cl_uint;
       function GetDEVICE_MEM_BASE_ADDR_ALIGN :T_cl_uint;
       function GetDEVICE_MIN_DATA_TYPE_ALIGN_SIZE :T_cl_uint;
       function GetDEVICE_SINGLE_FP_CONFIG :T_cl_device_fp_config;
       function GetDEVICE_GLOBAL_MEM_CACHE_TYPE :T_cl_device_mem_cache_type;
       function GetDEVICE_GLOBAL_MEM_CACHELINE_SIZE :T_cl_uint;
       function GetDEVICE_GLOBAL_MEM_CACHE_SIZE :T_cl_ulong;
       function GetDEVICE_GLOBAL_MEM_SIZE :T_cl_ulong;
       function GetDEVICE_MAX_CONSTANT_BUFFER_SIZE :T_cl_ulong;
       function GetDEVICE_MAX_CONSTANT_ARGS :T_cl_uint;
       function GetDEVICE_LOCAL_MEM_TYPE :T_cl_device_local_mem_type;
       function GetDEVICE_LOCAL_MEM_SIZE :T_cl_ulong;
       function GetDEVICE_ERROR_CORRECTION_SUPPORT :T_cl_bool;
       function GetDEVICE_PROFILING_TIMER_RESOLUTION :T_size_t;
       function GetDEVICE_ENDIAN_LITTLE :T_cl_bool;
       function GetDEVICE_AVAILABLE :T_cl_bool;
       function GetDEVICE_COMPILER_AVAILABLE :T_cl_bool;
       function GetDEVICE_EXECUTION_CAPABILITIES :T_cl_device_exec_capabilities;
       function GetDEVICE_QUEUE_PROPERTIES :T_cl_command_queue_properties;
       {$IF CL_VERSION_2_0 <> 0 }
       function GetDEVICE_QUEUE_ON_HOST_PROPERTIES :T_cl_command_queue_properties;
       {$ENDIF}
       function GetDEVICE_NAME :String;
       function GetDEVICE_VENDOR :String;
       function GetDRIVER_VERSION :String;
       function GetDEVICE_PROFILE :String;
       function GetDEVICE_VERSION :String;
       function GetDEVICE_EXTENSIONS :String;
       function GetDEVICE_PLATFORM :T_cl_platform_id;
       {$IF CL_VERSION_1_2 <> 0 }
       function GetDEVICE_DOUBLE_FP_CONFIG :T_cl_device_fp_config;
       {$ENDIF}
       {$IF CL_VERSION_1_1 <> 0 }
       function GetDEVICE_PREFERRED_VECTOR_WIDTH_HALF :T_cl_uint;
       function GetDEVICE_HOST_UNIFIED_MEMORY :T_cl_bool;
       function GetDEVICE_NATIVE_VECTOR_WIDTH_CHAR :T_cl_uint;
       function GetDEVICE_NATIVE_VECTOR_WIDTH_SHORT :T_cl_uint;
       function GetDEVICE_NATIVE_VECTOR_WIDTH_INT :T_cl_uint;
       function GetDEVICE_NATIVE_VECTOR_WIDTH_LONG :T_cl_uint;
       function GetDEVICE_NATIVE_VECTOR_WIDTH_FLOAT :T_cl_uint;
       function GetDEVICE_NATIVE_VECTOR_WIDTH_DOUBLE :T_cl_uint;
       function GetDEVICE_NATIVE_VECTOR_WIDTH_HALF :T_cl_uint;
       function GetDEVICE_OPENCL_C_VERSION :String;
       {$ENDIF}
       {$IF CL_VERSION_1_2 <> 0 }
       function GetDEVICE_LINKER_AVAILABLE :T_cl_bool;
       function GetDEVICE_BUILT_IN_KERNELS :String;
       function GetDEVICE_IMAGE_MAX_BUFFER_SIZE :T_size_t;
       function GetDEVICE_IMAGE_MAX_ARRAY_SIZE :T_size_t;
       function GetDEVICE_PARENT_DEVICE :T_cl_device_id;
       function GetDEVICE_PARTITION_MAX_SUB_DEVICES :T_cl_uint;
       function GetDEVICE_PARTITION_PROPERTIES :TArray<T_cl_device_partition_property>;
       function GetDEVICE_PARTITION_AFFINITY_DOMAIN :T_cl_device_affinity_domain;
       function GetDEVICE_PARTITION_TYPE :TArray<T_cl_device_partition_property>;
       function GetDEVICE_REFERENCE_COUNT :T_cl_uint;
       function GetDEVICE_PREFERRED_INTEROP_USER_SYNC :T_cl_bool;
       function GetDEVICE_PRINTF_BUFFER_SIZE :T_size_t;
       {$ENDIF}
       {$IF CL_VERSION_2_0 <> 0 }
       function GetDEVICE_IMAGE_PITCH_ALIGNMENT :T_cl_uint;
       function GetDEVICE_IMAGE_BASE_ADDRESS_ALIGNMENT :T_cl_uint;
       function GetDEVICE_MAX_READ_WRITE_IMAGE_ARGS :T_cl_uint;
       function GetDEVICE_MAX_GLOBAL_VARIABLE_SIZE :T_size_t;
       function GetDEVICE_QUEUE_ON_DEVICE_PROPERTIES :T_cl_command_queue_properties;
       function GetDEVICE_QUEUE_ON_DEVICE_PREFERRED_SIZE :T_cl_uint;
       function GetDEVICE_QUEUE_ON_DEVICE_MAX_SIZE :T_cl_uint;
       function GetDEVICE_MAX_ON_DEVICE_QUEUES :T_cl_uint;
       function GetDEVICE_MAX_ON_DEVICE_EVENTS :T_cl_uint;
       function GetDEVICE_SVM_CAPABILITIES :T_cl_device_svm_capabilities;
       function GetDEVICE_GLOBAL_VARIABLE_PREFERRED_TOTAL_SIZE :T_size_t;
       function GetDEVICE_MAX_PIPE_ARGS :T_cl_uint;
       function GetDEVICE_PIPE_MAX_ACTIVE_RESERVATIONS :T_cl_uint;
       function GetDEVICE_PIPE_MAX_PACKET_SIZE :T_cl_uint;
       function GetDEVICE_PREFERRED_PLATFORM_ATOMIC_ALIGNMENT :T_cl_uint;
       function GetDEVICE_PREFERRED_GLOBAL_ATOMIC_ALIGNMENT :T_cl_uint;
       function GetDEVICE_PREFERRED_LOCAL_ATOMIC_ALIGNMENT :T_cl_uint;
       {$ENDIF}
       {$IF CL_VERSION_2_1 <> 0 }
       function GetDEVICE_IL_VERSION :String;
       function GetDEVICE_MAX_NUM_SUB_GROUPS :T_cl_uint;
       function GetDEVICE_SUB_GROUP_INDEPENDENT_FORWARD_PROGRESS :T_cl_bool;
       {$ENDIF}
       {$IF CL_VERSION_3_0 <> 0 }
       function GetDEVICE_NUMERIC_VERSION :T_cl_version;
       function GetDEVICE_EXTENSIONS_WITH_VERSION :TArray<T_cl_name_version>;
       function GetDEVICE_ILS_WITH_VERSION :TArray<T_cl_name_version>;
       function GetDEVICE_BUILT_IN_KERNELS_WITH_VERSION :TArray<T_cl_name_version>;
       function GetDEVICE_ATOMIC_MEMORY_CAPABILITIES :T_cl_device_atomic_capabilities;
       function GetDEVICE_ATOMIC_FENCE_CAPABILITIES :T_cl_device_atomic_capabilities;
       function GetDEVICE_NON_UNIFORM_WORK_GROUP_SUPPORT :T_cl_bool;
       function GetDEVICE_OPENCL_C_ALL_VERSIONS :TArray<T_cl_name_version>;
       function GetDEVICE_PREFERRED_WORK_GROUP_SIZE_MULTIPLE :T_size_t;
       function GetDEVICE_WORK_GROUP_COLLECTIVE_FUNCTIONS_SUPPORT :T_cl_bool;
       function GetDEVICE_GENERIC_ADDRESS_SPACE_SUPPORT :T_cl_bool;
       function GetDEVICE_OPENCL_C_FEATURES :TArray<T_cl_name_version>;
       function GetDEVICE_DEVICE_ENQUEUE_CAPABILITIES :T_cl_device_device_enqueue_capabilities;
       function GetDEVICE_PIPE_SUPPORT :T_cl_bool;
       function GetDEVICE_LATEST_CONFORMANCE_VERSION_PASSED :String;
       {$ENDIF}
     public
       constructor Create( const Devices_:TCLDevices_; const Handle_:T_cl_device_id ); overload; virtual;
       destructor Destroy; override;
       ///// プロパティ
       property Platfo                                         :TCLPlatfo_                              read GetOwnere;
       property Devices                                        :TCLDevices_                             read GetParent;
       property Handle                                         :T_cl_device_id                          read   _Handle;
       property LanVer                                         :TCLVersion                              read GetLanVer;
       (* cl_device_info *)
       property DEVICE_TYPE                                    :T_cl_device_type                        read GetDEVICE_TYPE;
       property DEVICE_VENDOR_ID                               :T_cl_uint                               read GetDEVICE_VENDOR_ID;
       property DEVICE_MAX_COMPUTE_UNITS                       :T_cl_uint                               read GetDEVICE_MAX_COMPUTE_UNITS;
       property DEVICE_MAX_WORK_ITEM_DIMENSIONS                :T_cl_uint                               read GetDEVICE_MAX_WORK_ITEM_DIMENSIONS;
       property DEVICE_MAX_WORK_GROUP_SIZE                     :T_size_t                                read GetDEVICE_MAX_WORK_GROUP_SIZE;
       property DEVICE_MAX_WORK_ITEM_SIZES                     :TArray<T_size_t>                        read GetDEVICE_MAX_WORK_ITEM_SIZES;
       property DEVICE_PREFERRED_VECTOR_WIDTH_CHAR             :T_cl_uint                               read GetDEVICE_PREFERRED_VECTOR_WIDTH_CHAR;
       property DEVICE_PREFERRED_VECTOR_WIDTH_SHORT            :T_cl_uint                               read GetDEVICE_PREFERRED_VECTOR_WIDTH_SHORT;
       property DEVICE_PREFERRED_VECTOR_WIDTH_INT              :T_cl_uint                               read GetDEVICE_PREFERRED_VECTOR_WIDTH_INT;
       property DEVICE_PREFERRED_VECTOR_WIDTH_LONG             :T_cl_uint                               read GetDEVICE_PREFERRED_VECTOR_WIDTH_LONG;
       property DEVICE_PREFERRED_VECTOR_WIDTH_FLOAT            :T_cl_uint                               read GetDEVICE_PREFERRED_VECTOR_WIDTH_FLOAT;
       property DEVICE_PREFERRED_VECTOR_WIDTH_DOUBLE           :T_cl_uint                               read GetDEVICE_PREFERRED_VECTOR_WIDTH_DOUBLE;
       property DEVICE_MAX_CLOCK_FREQUENCY                     :T_cl_uint                               read GetDEVICE_MAX_CLOCK_FREQUENCY;
       property DEVICE_ADDRESS_BITS                            :T_cl_uint                               read GetDEVICE_ADDRESS_BITS;
       property DEVICE_MAX_READ_IMAGE_ARGS                     :T_cl_uint                               read GetDEVICE_MAX_READ_IMAGE_ARGS;
       property DEVICE_MAX_WRITE_IMAGE_ARGS                    :T_cl_uint                               read GetDEVICE_MAX_WRITE_IMAGE_ARGS;
       property DEVICE_MAX_MEM_ALLOC_SIZE                      :T_cl_ulong                              read GetDEVICE_MAX_MEM_ALLOC_SIZE;
       property DEVICE_IMAGE2D_MAX_WIDTH                       :T_size_t                                read GetDEVICE_IMAGE2D_MAX_WIDTH;
       property DEVICE_IMAGE2D_MAX_HEIGHT                      :T_size_t                                read GetDEVICE_IMAGE2D_MAX_HEIGHT;
       property DEVICE_IMAGE3D_MAX_WIDTH                       :T_size_t                                read GetDEVICE_IMAGE3D_MAX_WIDTH;
       property DEVICE_IMAGE3D_MAX_HEIGHT                      :T_size_t                                read GetDEVICE_IMAGE3D_MAX_HEIGHT;
       property DEVICE_IMAGE3D_MAX_DEPTH                       :T_size_t                                read GetDEVICE_IMAGE3D_MAX_DEPTH;
       property DEVICE_IMAGE_SUPPORT                           :T_cl_bool                               read GetDEVICE_IMAGE_SUPPORT;
       property DEVICE_MAX_PARAMETER_SIZE                      :T_size_t                                read GetDEVICE_MAX_PARAMETER_SIZE;
       property DEVICE_MAX_SAMPLERS                            :T_cl_uint                               read GetDEVICE_MAX_SAMPLERS;
       property DEVICE_MEM_BASE_ADDR_ALIGN                     :T_cl_uint                               read GetDEVICE_MEM_BASE_ADDR_ALIGN;
       property DEVICE_MIN_DATA_TYPE_ALIGN_SIZE                :T_cl_uint                               read GetDEVICE_MIN_DATA_TYPE_ALIGN_SIZE;
       property DEVICE_SINGLE_FP_CONFIG                        :T_cl_device_fp_config                   read GetDEVICE_SINGLE_FP_CONFIG;
       property DEVICE_GLOBAL_MEM_CACHE_TYPE                   :T_cl_device_mem_cache_type              read GetDEVICE_GLOBAL_MEM_CACHE_TYPE;
       property DEVICE_GLOBAL_MEM_CACHELINE_SIZE               :T_cl_uint                               read GetDEVICE_GLOBAL_MEM_CACHELINE_SIZE;
       property DEVICE_GLOBAL_MEM_CACHE_SIZE                   :T_cl_ulong                              read GetDEVICE_GLOBAL_MEM_CACHE_SIZE;
       property DEVICE_GLOBAL_MEM_SIZE                         :T_cl_ulong                              read GetDEVICE_GLOBAL_MEM_SIZE;
       property DEVICE_MAX_CONSTANT_BUFFER_SIZE                :T_cl_ulong                              read GetDEVICE_MAX_CONSTANT_BUFFER_SIZE;
       property DEVICE_MAX_CONSTANT_ARGS                       :T_cl_uint                               read GetDEVICE_MAX_CONSTANT_ARGS;
       property DEVICE_LOCAL_MEM_TYPE                          :T_cl_device_local_mem_type              read GetDEVICE_LOCAL_MEM_TYPE;
       property DEVICE_LOCAL_MEM_SIZE                          :T_cl_ulong                              read GetDEVICE_LOCAL_MEM_SIZE;
       property DEVICE_ERROR_CORRECTION_SUPPORT                :T_cl_bool                               read GetDEVICE_ERROR_CORRECTION_SUPPORT;
       property DEVICE_PROFILING_TIMER_RESOLUTION              :T_size_t                                read GetDEVICE_PROFILING_TIMER_RESOLUTION;
       property DEVICE_ENDIAN_LITTLE                           :T_cl_bool                               read GetDEVICE_ENDIAN_LITTLE;
       property DEVICE_AVAILABLE                               :T_cl_bool                               read GetDEVICE_AVAILABLE;
       property DEVICE_COMPILER_AVAILABLE                      :T_cl_bool                               read GetDEVICE_COMPILER_AVAILABLE;
       property DEVICE_EXECUTION_CAPABILITIES                  :T_cl_device_exec_capabilities           read GetDEVICE_EXECUTION_CAPABILITIES;
       property DEVICE_QUEUE_PROPERTIES                        :T_cl_command_queue_properties           read GetDEVICE_QUEUE_PROPERTIES;
       {$IF CL_VERSION_2_0 <> 0 }
       property DEVICE_QUEUE_ON_HOST_PROPERTIES                :T_cl_command_queue_properties           read GetDEVICE_QUEUE_ON_HOST_PROPERTIES;
       {$ENDIF}
       property DEVICE_NAME                                    :String                                  read GetDEVICE_NAME;
       property DEVICE_VENDOR                                  :String                                  read GetDEVICE_VENDOR;
       property DRIVER_VERSION                                 :String                                  read GetDRIVER_VERSION;
       property DEVICE_PROFILE                                 :String                                  read GetDEVICE_PROFILE;
       property DEVICE_VERSION                                 :String                                  read GetDEVICE_VERSION;
       property DEVICE_EXTENSIONS                              :String                                  read GetDEVICE_EXTENSIONS;
       property DEVICE_PLATFORM                                :T_cl_platform_id                        read GetDEVICE_PLATFORM;
       {$IF CL_VERSION_1_2 <> 0 }
       property DEVICE_DOUBLE_FP_CONFIG                        :T_cl_device_fp_config                   read GetDEVICE_DOUBLE_FP_CONFIG;
       {$ENDIF}
       {$IF CL_VERSION_1_1 <> 0 }
       property DEVICE_PREFERRED_VECTOR_WIDTH_HALF             :T_cl_uint                               read GetDEVICE_PREFERRED_VECTOR_WIDTH_HALF;
       property DEVICE_HOST_UNIFIED_MEMORY                     :T_cl_bool                               read GetDEVICE_HOST_UNIFIED_MEMORY;
       property DEVICE_NATIVE_VECTOR_WIDTH_CHAR                :T_cl_uint                               read GetDEVICE_NATIVE_VECTOR_WIDTH_CHAR;
       property DEVICE_NATIVE_VECTOR_WIDTH_SHORT               :T_cl_uint                               read GetDEVICE_NATIVE_VECTOR_WIDTH_SHORT;
       property DEVICE_NATIVE_VECTOR_WIDTH_INT                 :T_cl_uint                               read GetDEVICE_NATIVE_VECTOR_WIDTH_INT;
       property DEVICE_NATIVE_VECTOR_WIDTH_LONG                :T_cl_uint                               read GetDEVICE_NATIVE_VECTOR_WIDTH_LONG;
       property DEVICE_NATIVE_VECTOR_WIDTH_FLOAT               :T_cl_uint                               read GetDEVICE_NATIVE_VECTOR_WIDTH_FLOAT;
       property DEVICE_NATIVE_VECTOR_WIDTH_DOUBLE              :T_cl_uint                               read GetDEVICE_NATIVE_VECTOR_WIDTH_DOUBLE;
       property DEVICE_NATIVE_VECTOR_WIDTH_HALF                :T_cl_uint                               read GetDEVICE_NATIVE_VECTOR_WIDTH_HALF;
       property DEVICE_OPENCL_C_VERSION                        :String                                  read GetDEVICE_OPENCL_C_VERSION;
       {$ENDIF}
       {$IF CL_VERSION_1_2 <> 0 }
       property DEVICE_LINKER_AVAILABLE                        :T_cl_bool                               read GetDEVICE_LINKER_AVAILABLE;
       property DEVICE_BUILT_IN_KERNELS                        :String                                  read GetDEVICE_BUILT_IN_KERNELS;
       property DEVICE_IMAGE_MAX_BUFFER_SIZE                   :T_size_t                                read GetDEVICE_IMAGE_MAX_BUFFER_SIZE;
       property DEVICE_IMAGE_MAX_ARRAY_SIZE                    :T_size_t                                read GetDEVICE_IMAGE_MAX_ARRAY_SIZE;
       property DEVICE_PARENT_DEVICE                           :T_cl_device_id                          read GetDEVICE_PARENT_DEVICE;
       property DEVICE_PARTITION_MAX_SUB_DEVICES               :T_cl_uint                               read GetDEVICE_PARTITION_MAX_SUB_DEVICES;
       property DEVICE_PARTITION_PROPERTIES                    :TArray<T_cl_device_partition_property>  read GetDEVICE_PARTITION_PROPERTIES;
       property DEVICE_PARTITION_AFFINITY_DOMAIN               :T_cl_device_affinity_domain             read GetDEVICE_PARTITION_AFFINITY_DOMAIN;
       property DEVICE_PARTITION_TYPE                          :TArray<T_cl_device_partition_property>  read GetDEVICE_PARTITION_TYPE;
       property DEVICE_REFERENCE_COUNT                         :T_cl_uint                               read GetDEVICE_REFERENCE_COUNT;
       property DEVICE_PREFERRED_INTEROP_USER_SYNC             :T_cl_bool                               read GetDEVICE_PREFERRED_INTEROP_USER_SYNC;
       property DEVICE_PRINTF_BUFFER_SIZE                      :T_size_t                                read GetDEVICE_PRINTF_BUFFER_SIZE;
       {$ENDIF}
       {$IF CL_VERSION_2_0 <> 0 }
       property DEVICE_IMAGE_PITCH_ALIGNMENT                   :T_cl_uint                               read GetDEVICE_IMAGE_PITCH_ALIGNMENT;
       property DEVICE_IMAGE_BASE_ADDRESS_ALIGNMENT            :T_cl_uint                               read GetDEVICE_IMAGE_BASE_ADDRESS_ALIGNMENT;
       property DEVICE_MAX_READ_WRITE_IMAGE_ARGS               :T_cl_uint                               read GetDEVICE_MAX_READ_WRITE_IMAGE_ARGS;
       property DEVICE_MAX_GLOBAL_VARIABLE_SIZE                :T_size_t                                read GetDEVICE_MAX_GLOBAL_VARIABLE_SIZE;
       property DEVICE_QUEUE_ON_DEVICE_PROPERTIES              :T_cl_command_queue_properties           read GetDEVICE_QUEUE_ON_DEVICE_PROPERTIES;
       property DEVICE_QUEUE_ON_DEVICE_PREFERRED_SIZE          :T_cl_uint                               read GetDEVICE_QUEUE_ON_DEVICE_PREFERRED_SIZE;
       property DEVICE_QUEUE_ON_DEVICE_MAX_SIZE                :T_cl_uint                               read GetDEVICE_QUEUE_ON_DEVICE_MAX_SIZE;
       property DEVICE_MAX_ON_DEVICE_QUEUES                    :T_cl_uint                               read GetDEVICE_MAX_ON_DEVICE_QUEUES;
       property DEVICE_MAX_ON_DEVICE_EVENTS                    :T_cl_uint                               read GetDEVICE_MAX_ON_DEVICE_EVENTS;
       property DEVICE_SVM_CAPABILITIES                        :T_cl_device_svm_capabilities            read GetDEVICE_SVM_CAPABILITIES;
       property DEVICE_GLOBAL_VARIABLE_PREFERRED_TOTAL_SIZE    :T_size_t                                read GetDEVICE_GLOBAL_VARIABLE_PREFERRED_TOTAL_SIZE;
       property DEVICE_MAX_PIPE_ARGS                           :T_cl_uint                               read GetDEVICE_MAX_PIPE_ARGS;
       property DEVICE_PIPE_MAX_ACTIVE_RESERVATIONS            :T_cl_uint                               read GetDEVICE_PIPE_MAX_ACTIVE_RESERVATIONS;
       property DEVICE_PIPE_MAX_PACKET_SIZE                    :T_cl_uint                               read GetDEVICE_PIPE_MAX_PACKET_SIZE;
       property DEVICE_PREFERRED_PLATFORM_ATOMIC_ALIGNMENT     :T_cl_uint                               read GetDEVICE_PREFERRED_PLATFORM_ATOMIC_ALIGNMENT;
       property DEVICE_PREFERRED_GLOBAL_ATOMIC_ALIGNMENT       :T_cl_uint                               read GetDEVICE_PREFERRED_GLOBAL_ATOMIC_ALIGNMENT;
       property DEVICE_PREFERRED_LOCAL_ATOMIC_ALIGNMENT        :T_cl_uint                               read GetDEVICE_PREFERRED_LOCAL_ATOMIC_ALIGNMENT;
       {$ENDIF}
       {$IF CL_VERSION_2_1 <> 0 }
       property DEVICE_IL_VERSION                              :String                                  read GetDEVICE_IL_VERSION;
       property DEVICE_MAX_NUM_SUB_GROUPS                      :T_cl_uint                               read GetDEVICE_MAX_NUM_SUB_GROUPS;
       property DEVICE_SUB_GROUP_INDEPENDENT_FORWARD_PROGRESS  :T_cl_bool                               read GetDEVICE_SUB_GROUP_INDEPENDENT_FORWARD_PROGRESS;
       {$ENDIF}
       {$IF CL_VERSION_3_0 <> 0 }
       property DEVICE_NUMERIC_VERSION                         :T_cl_version                            read GetDEVICE_NUMERIC_VERSION;
       property DEVICE_EXTENSIONS_WITH_VERSION                 :TArray<T_cl_name_version>               read GetDEVICE_EXTENSIONS_WITH_VERSION;
       property DEVICE_ILS_WITH_VERSION                        :TArray<T_cl_name_version>               read GetDEVICE_ILS_WITH_VERSION;
       property DEVICE_BUILT_IN_KERNELS_WITH_VERSION           :TArray<T_cl_name_version>               read GetDEVICE_BUILT_IN_KERNELS_WITH_VERSION;
       property DEVICE_ATOMIC_MEMORY_CAPABILITIES              :T_cl_device_atomic_capabilities         read GetDEVICE_ATOMIC_MEMORY_CAPABILITIES;
       property DEVICE_ATOMIC_FENCE_CAPABILITIES               :T_cl_device_atomic_capabilities         read GetDEVICE_ATOMIC_FENCE_CAPABILITIES;
       property DEVICE_NON_UNIFORM_WORK_GROUP_SUPPORT          :T_cl_bool                               read GetDEVICE_NON_UNIFORM_WORK_GROUP_SUPPORT;
       property DEVICE_OPENCL_C_ALL_VERSIONS                   :TArray<T_cl_name_version>               read GetDEVICE_OPENCL_C_ALL_VERSIONS;
       property DEVICE_PREFERRED_WORK_GROUP_SIZE_MULTIPLE      :T_size_t                                read GetDEVICE_PREFERRED_WORK_GROUP_SIZE_MULTIPLE;
       property DEVICE_WORK_GROUP_COLLECTIVE_FUNCTIONS_SUPPORT :T_cl_bool                               read GetDEVICE_WORK_GROUP_COLLECTIVE_FUNCTIONS_SUPPORT;
       property DEVICE_GENERIC_ADDRESS_SPACE_SUPPORT           :T_cl_bool                               read GetDEVICE_GENERIC_ADDRESS_SPACE_SUPPORT;
       property DEVICE_OPENCL_C_FEATURES                       :TArray<T_cl_name_version>               read GetDEVICE_OPENCL_C_FEATURES;
       property DEVICE_DEVICE_ENQUEUE_CAPABILITIES             :T_cl_device_device_enqueue_capabilities read GetDEVICE_DEVICE_ENQUEUE_CAPABILITIES;
       property DEVICE_PIPE_SUPPORT                            :T_cl_bool                               read GetDEVICE_PIPE_SUPPORT;
       property DEVICE_LATEST_CONFORMANCE_VERSION_PASSED       :String                                  read GetDEVICE_LATEST_CONFORMANCE_VERSION_PASSED;
       {$ENDIF}
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDevices<TCLPlatfo_>

     TCLDevices<TCLPlatfo_:class> = class( TListParent<TCLPlatfo_,TCLDevice<TCLPlatfo_>> )
     private
       type TCLDevice_ = TCLDevice<TCLPlatfo_>;
     protected
       ///// メソッド
       procedure FindDevices;
       ///// イベント
       procedure OnInit; override;
     public
       ///// プロパティ
       property Platfo :TCLPlatfo_ read GetOwnere;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses System.SysUtils, System.RegularExpressions,
     LUX.GPU.OpenCL;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDevice<TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

/////////////////////////////////////////////////////////////////////// メソッド

function TCLDevice<TCLPlatfo_>.GetInfo<_TYPE_>( const Name_:T_cl_device_info ) :_TYPE_;
begin
     AssertCL( clGetDeviceInfo( Handle, Name_, SizeOf( _TYPE_ ), @Result, nil ), 'TCLDevice.GetInfo is Error!' );
end;

function TCLDevice<TCLPlatfo_>.GetInfoSize( const Name_:T_cl_device_info ) :T_size_t;
begin
     AssertCL( clGetDeviceInfo( Handle, Name_, 0, nil, @Result ), 'TCLDevice.GetInfoSize is Error!' );
end;

function TCLDevice<TCLPlatfo_>.GetInfos<_TYPE_>( const Name_:T_cl_device_info ) :TArray<_TYPE_>;
var
   S :T_size_t;
begin
     S := GetInfoSize( Name_ );

     SetLength( Result, S div Cardinal( SizeOf( _TYPE_ ) ) );

     AssertCL( clGetDeviceInfo( Handle, Name_, S, @Result[ 0 ], nil ), 'TCLDevice.GetInfos is Error!' );
end;

function TCLDevice<TCLPlatfo_>.GetInfoString( const Name_:T_cl_device_info ) :String;
begin
     Result := TrimRight( String( P_char( GetInfos<T_char>( Name_ ) ) ) );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLDevice<TCLPlatfo_>.GetLanVer :TCLVersion;
var
   M :TMatch;
begin
     M := TRegEx.Match( DEVICE_OPENCL_C_VERSION,
                        'OpenCL +C +([^ ]+)',
                        [ TRegExOption.roIgnoreCase ] );

     if M.Groups.Count = 2 then Result := TCLVersion.From( M.Groups[ 1 ].Value )
                           else Result := TCLVersion.None;
end;

//----------------------------------------------------------(* cl_device_info *)

function TCLDevice<TCLPlatfo_>.GetDEVICE_TYPE :T_cl_device_type; begin Result := GetInfo<T_cl_device_type>( CL_DEVICE_TYPE ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_VENDOR_ID :T_cl_uint; begin Result := GetInfo<T_cl_uint>( CL_DEVICE_VENDOR_ID ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_MAX_COMPUTE_UNITS :T_cl_uint; begin Result := GetInfo<T_cl_uint>( CL_DEVICE_MAX_COMPUTE_UNITS ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_MAX_WORK_ITEM_DIMENSIONS :T_cl_uint; begin Result := GetInfo<T_cl_uint>( CL_DEVICE_MAX_WORK_ITEM_DIMENSIONS ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_MAX_WORK_GROUP_SIZE :T_size_t; begin Result := GetInfo<T_size_t>( CL_DEVICE_MAX_WORK_GROUP_SIZE ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_MAX_WORK_ITEM_SIZES :TArray<T_size_t>; begin Result := GetInfos<T_size_t>( CL_DEVICE_MAX_WORK_ITEM_SIZES ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_PREFERRED_VECTOR_WIDTH_CHAR :T_cl_uint; begin Result := GetInfo<T_cl_uint>( CL_DEVICE_PREFERRED_VECTOR_WIDTH_CHAR ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_PREFERRED_VECTOR_WIDTH_SHORT :T_cl_uint; begin Result := GetInfo<T_cl_uint>( CL_DEVICE_PREFERRED_VECTOR_WIDTH_SHORT ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_PREFERRED_VECTOR_WIDTH_INT :T_cl_uint; begin Result := GetInfo<T_cl_uint>( CL_DEVICE_PREFERRED_VECTOR_WIDTH_INT ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_PREFERRED_VECTOR_WIDTH_LONG :T_cl_uint; begin Result := GetInfo<T_cl_uint>( CL_DEVICE_PREFERRED_VECTOR_WIDTH_LONG ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_PREFERRED_VECTOR_WIDTH_FLOAT :T_cl_uint; begin Result := GetInfo<T_cl_uint>( CL_DEVICE_PREFERRED_VECTOR_WIDTH_FLOAT ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_PREFERRED_VECTOR_WIDTH_DOUBLE :T_cl_uint; begin Result := GetInfo<T_cl_uint>( CL_DEVICE_PREFERRED_VECTOR_WIDTH_DOUBLE ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_MAX_CLOCK_FREQUENCY :T_cl_uint; begin Result := GetInfo<T_cl_uint>( CL_DEVICE_MAX_CLOCK_FREQUENCY ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_ADDRESS_BITS :T_cl_uint; begin Result := GetInfo<T_cl_uint>( CL_DEVICE_ADDRESS_BITS ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_MAX_READ_IMAGE_ARGS :T_cl_uint; begin Result := GetInfo<T_cl_uint>( CL_DEVICE_MAX_READ_IMAGE_ARGS ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_MAX_WRITE_IMAGE_ARGS :T_cl_uint; begin Result := GetInfo<T_cl_uint>( CL_DEVICE_MAX_WRITE_IMAGE_ARGS ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_MAX_MEM_ALLOC_SIZE :T_cl_ulong; begin Result := GetInfo<T_cl_ulong>( CL_DEVICE_MAX_MEM_ALLOC_SIZE ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_IMAGE2D_MAX_WIDTH :T_size_t; begin Result := GetInfo<T_size_t>( CL_DEVICE_IMAGE2D_MAX_WIDTH ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_IMAGE2D_MAX_HEIGHT :T_size_t; begin Result := GetInfo<T_size_t>( CL_DEVICE_IMAGE2D_MAX_HEIGHT ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_IMAGE3D_MAX_WIDTH :T_size_t; begin Result := GetInfo<T_size_t>( CL_DEVICE_IMAGE3D_MAX_WIDTH ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_IMAGE3D_MAX_HEIGHT :T_size_t; begin Result := GetInfo<T_size_t>( CL_DEVICE_IMAGE3D_MAX_HEIGHT ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_IMAGE3D_MAX_DEPTH :T_size_t; begin Result := GetInfo<T_size_t>( CL_DEVICE_IMAGE3D_MAX_DEPTH ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_IMAGE_SUPPORT :T_cl_bool; begin Result := GetInfo<T_cl_bool>( CL_DEVICE_IMAGE_SUPPORT ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_MAX_PARAMETER_SIZE :T_size_t; begin Result := GetInfo<T_size_t>( CL_DEVICE_MAX_PARAMETER_SIZE ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_MAX_SAMPLERS :T_cl_uint; begin Result := GetInfo<T_cl_uint>( CL_DEVICE_MAX_SAMPLERS ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_MEM_BASE_ADDR_ALIGN :T_cl_uint; begin Result := GetInfo<T_cl_uint>( CL_DEVICE_MEM_BASE_ADDR_ALIGN ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_MIN_DATA_TYPE_ALIGN_SIZE :T_cl_uint; begin Result := GetInfo<T_cl_uint>( CL_DEVICE_MIN_DATA_TYPE_ALIGN_SIZE ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_SINGLE_FP_CONFIG :T_cl_device_fp_config; begin Result := GetInfo<T_cl_device_fp_config>( CL_DEVICE_SINGLE_FP_CONFIG ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_GLOBAL_MEM_CACHE_TYPE :T_cl_device_mem_cache_type; begin Result := GetInfo<T_cl_device_mem_cache_type>( CL_DEVICE_GLOBAL_MEM_CACHE_TYPE ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_GLOBAL_MEM_CACHELINE_SIZE :T_cl_uint; begin Result := GetInfo<T_cl_uint>( CL_DEVICE_GLOBAL_MEM_CACHELINE_SIZE ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_GLOBAL_MEM_CACHE_SIZE :T_cl_ulong; begin Result := GetInfo<T_cl_ulong>( CL_DEVICE_GLOBAL_MEM_CACHE_SIZE ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_GLOBAL_MEM_SIZE :T_cl_ulong; begin Result := GetInfo<T_cl_ulong>( CL_DEVICE_GLOBAL_MEM_SIZE ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_MAX_CONSTANT_BUFFER_SIZE :T_cl_ulong; begin Result := GetInfo<T_cl_ulong>( CL_DEVICE_MAX_CONSTANT_BUFFER_SIZE ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_MAX_CONSTANT_ARGS :T_cl_uint; begin Result := GetInfo<T_cl_uint>( CL_DEVICE_MAX_CONSTANT_ARGS ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_LOCAL_MEM_TYPE :T_cl_device_local_mem_type; begin Result := GetInfo<T_cl_device_local_mem_type>( CL_DEVICE_LOCAL_MEM_TYPE ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_LOCAL_MEM_SIZE :T_cl_ulong; begin Result := GetInfo<T_cl_ulong>( CL_DEVICE_LOCAL_MEM_SIZE ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_ERROR_CORRECTION_SUPPORT :T_cl_bool; begin Result := GetInfo<T_cl_bool>( CL_DEVICE_ERROR_CORRECTION_SUPPORT ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_PROFILING_TIMER_RESOLUTION :T_size_t; begin Result := GetInfo<T_size_t>( CL_DEVICE_PROFILING_TIMER_RESOLUTION ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_ENDIAN_LITTLE :T_cl_bool; begin Result := GetInfo<T_cl_bool>( CL_DEVICE_ENDIAN_LITTLE ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_AVAILABLE :T_cl_bool; begin Result := GetInfo<T_cl_bool>( CL_DEVICE_AVAILABLE ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_COMPILER_AVAILABLE :T_cl_bool; begin Result := GetInfo<T_cl_bool>( CL_DEVICE_COMPILER_AVAILABLE ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_EXECUTION_CAPABILITIES :T_cl_device_exec_capabilities; begin Result := GetInfo<T_cl_device_exec_capabilities>( CL_DEVICE_EXECUTION_CAPABILITIES ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_QUEUE_PROPERTIES :T_cl_command_queue_properties; begin Result := GetInfo<T_cl_command_queue_properties>( CL_DEVICE_QUEUE_PROPERTIES ); end;
{$IF CL_VERSION_2_0 <> 0 }
function TCLDevice<TCLPlatfo_>.GetDEVICE_QUEUE_ON_HOST_PROPERTIES :T_cl_command_queue_properties; begin Result := GetInfo<T_cl_command_queue_properties>( CL_DEVICE_QUEUE_ON_HOST_PROPERTIES ); end;
{$ENDIF}
function TCLDevice<TCLPlatfo_>.GetDEVICE_NAME :String; begin Result := GetInfoString( CL_DEVICE_NAME ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_VENDOR :String; begin Result := GetInfoString( CL_DEVICE_VENDOR ); end;
function TCLDevice<TCLPlatfo_>.GetDRIVER_VERSION :String; begin Result := GetInfoString( CL_DRIVER_VERSION ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_PROFILE :String; begin Result := GetInfoString( CL_DEVICE_PROFILE ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_VERSION :String; begin Result := GetInfoString( CL_DEVICE_VERSION ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_EXTENSIONS :String; begin Result := GetInfoString( CL_DEVICE_EXTENSIONS ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_PLATFORM :T_cl_platform_id; begin Result := GetInfo<T_cl_platform_id>( CL_DEVICE_PLATFORM ); end;
{$IF CL_VERSION_1_2 <> 0 }
function TCLDevice<TCLPlatfo_>.GetDEVICE_DOUBLE_FP_CONFIG :T_cl_device_fp_config; begin Result := GetInfo<T_cl_device_fp_config>( CL_DEVICE_DOUBLE_FP_CONFIG ); end;
{$ENDIF}
{$IF CL_VERSION_1_1 <> 0 }
function TCLDevice<TCLPlatfo_>.GetDEVICE_PREFERRED_VECTOR_WIDTH_HALF :T_cl_uint; begin Result := GetInfo<T_cl_uint>( CL_DEVICE_PREFERRED_VECTOR_WIDTH_HALF ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_HOST_UNIFIED_MEMORY :T_cl_bool; begin Result := GetInfo<T_cl_bool>( CL_DEVICE_HOST_UNIFIED_MEMORY ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_NATIVE_VECTOR_WIDTH_CHAR :T_cl_uint; begin Result := GetInfo<T_cl_uint>( CL_DEVICE_NATIVE_VECTOR_WIDTH_CHAR ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_NATIVE_VECTOR_WIDTH_SHORT :T_cl_uint; begin Result := GetInfo<T_cl_uint>( CL_DEVICE_NATIVE_VECTOR_WIDTH_SHORT ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_NATIVE_VECTOR_WIDTH_INT :T_cl_uint; begin Result := GetInfo<T_cl_uint>( CL_DEVICE_NATIVE_VECTOR_WIDTH_INT ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_NATIVE_VECTOR_WIDTH_LONG :T_cl_uint; begin Result := GetInfo<T_cl_uint>( CL_DEVICE_NATIVE_VECTOR_WIDTH_LONG ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_NATIVE_VECTOR_WIDTH_FLOAT :T_cl_uint; begin Result := GetInfo<T_cl_uint>( CL_DEVICE_NATIVE_VECTOR_WIDTH_FLOAT ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_NATIVE_VECTOR_WIDTH_DOUBLE :T_cl_uint; begin Result := GetInfo<T_cl_uint>( CL_DEVICE_NATIVE_VECTOR_WIDTH_DOUBLE ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_NATIVE_VECTOR_WIDTH_HALF :T_cl_uint; begin Result := GetInfo<T_cl_uint>( CL_DEVICE_NATIVE_VECTOR_WIDTH_HALF ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_OPENCL_C_VERSION :String; begin Result := GetInfoString( CL_DEVICE_OPENCL_C_VERSION ); end;
{$ENDIF}
{$IF CL_VERSION_1_2 <> 0 }
function TCLDevice<TCLPlatfo_>.GetDEVICE_LINKER_AVAILABLE :T_cl_bool; begin Result := GetInfo<T_cl_bool>( CL_DEVICE_LINKER_AVAILABLE ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_BUILT_IN_KERNELS :String; begin Result := GetInfoString( CL_DEVICE_BUILT_IN_KERNELS ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_IMAGE_MAX_BUFFER_SIZE :T_size_t; begin Result := GetInfo<T_size_t>( CL_DEVICE_IMAGE_MAX_BUFFER_SIZE ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_IMAGE_MAX_ARRAY_SIZE :T_size_t; begin Result := GetInfo<T_size_t>( CL_DEVICE_IMAGE_MAX_ARRAY_SIZE ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_PARENT_DEVICE :T_cl_device_id; begin Result := GetInfo<T_cl_device_id>( CL_DEVICE_PARENT_DEVICE ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_PARTITION_MAX_SUB_DEVICES :T_cl_uint; begin Result := GetInfo<T_cl_uint>( CL_DEVICE_PARTITION_MAX_SUB_DEVICES ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_PARTITION_PROPERTIES :TArray<T_cl_device_partition_property>; begin Result := GetInfos<T_cl_device_partition_property>( CL_DEVICE_PARTITION_PROPERTIES ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_PARTITION_AFFINITY_DOMAIN :T_cl_device_affinity_domain; begin Result := GetInfo<T_cl_device_affinity_domain>( CL_DEVICE_PARTITION_AFFINITY_DOMAIN ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_PARTITION_TYPE :TArray<T_cl_device_partition_property>; begin Result := GetInfos<T_cl_device_partition_property>( CL_DEVICE_PARTITION_TYPE ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_REFERENCE_COUNT :T_cl_uint; begin Result := GetInfo<T_cl_uint>( CL_DEVICE_REFERENCE_COUNT ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_PREFERRED_INTEROP_USER_SYNC :T_cl_bool; begin Result := GetInfo<T_cl_bool>( CL_DEVICE_PREFERRED_INTEROP_USER_SYNC ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_PRINTF_BUFFER_SIZE :T_size_t; begin Result := GetInfo<T_size_t>( CL_DEVICE_PRINTF_BUFFER_SIZE ); end;
{$ENDIF}
{$IF CL_VERSION_2_0 <> 0 }
function TCLDevice<TCLPlatfo_>.GetDEVICE_IMAGE_PITCH_ALIGNMENT :T_cl_uint; begin Result := GetInfo<T_cl_uint>( CL_DEVICE_IMAGE_PITCH_ALIGNMENT ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_IMAGE_BASE_ADDRESS_ALIGNMENT :T_cl_uint; begin Result := GetInfo<T_cl_uint>( CL_DEVICE_IMAGE_BASE_ADDRESS_ALIGNMENT ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_MAX_READ_WRITE_IMAGE_ARGS :T_cl_uint; begin Result := GetInfo<T_cl_uint>( CL_DEVICE_MAX_READ_WRITE_IMAGE_ARGS ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_MAX_GLOBAL_VARIABLE_SIZE :T_size_t; begin Result := GetInfo<T_size_t>( CL_DEVICE_MAX_GLOBAL_VARIABLE_SIZE ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_QUEUE_ON_DEVICE_PROPERTIES :T_cl_command_queue_properties; begin Result := GetInfo<T_cl_command_queue_properties>( CL_DEVICE_QUEUE_ON_DEVICE_PROPERTIES ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_QUEUE_ON_DEVICE_PREFERRED_SIZE :T_cl_uint; begin Result := GetInfo<T_cl_uint>( CL_DEVICE_QUEUE_ON_DEVICE_PREFERRED_SIZE ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_QUEUE_ON_DEVICE_MAX_SIZE :T_cl_uint; begin Result := GetInfo<T_cl_uint>( CL_DEVICE_QUEUE_ON_DEVICE_MAX_SIZE ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_MAX_ON_DEVICE_QUEUES :T_cl_uint; begin Result := GetInfo<T_cl_uint>( CL_DEVICE_MAX_ON_DEVICE_QUEUES ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_MAX_ON_DEVICE_EVENTS :T_cl_uint; begin Result := GetInfo<T_cl_uint>( CL_DEVICE_MAX_ON_DEVICE_EVENTS ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_SVM_CAPABILITIES :T_cl_device_svm_capabilities; begin Result := GetInfo<T_cl_device_svm_capabilities>( CL_DEVICE_SVM_CAPABILITIES ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_GLOBAL_VARIABLE_PREFERRED_TOTAL_SIZE :T_size_t; begin Result := GetInfo<T_size_t>( CL_DEVICE_GLOBAL_VARIABLE_PREFERRED_TOTAL_SIZE ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_MAX_PIPE_ARGS :T_cl_uint; begin Result := GetInfo<T_cl_uint>( CL_DEVICE_MAX_PIPE_ARGS ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_PIPE_MAX_ACTIVE_RESERVATIONS :T_cl_uint; begin Result := GetInfo<T_cl_uint>( CL_DEVICE_PIPE_MAX_ACTIVE_RESERVATIONS ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_PIPE_MAX_PACKET_SIZE :T_cl_uint; begin Result := GetInfo<T_cl_uint>( CL_DEVICE_PIPE_MAX_PACKET_SIZE ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_PREFERRED_PLATFORM_ATOMIC_ALIGNMENT :T_cl_uint; begin Result := GetInfo<T_cl_uint>( CL_DEVICE_PREFERRED_PLATFORM_ATOMIC_ALIGNMENT ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_PREFERRED_GLOBAL_ATOMIC_ALIGNMENT :T_cl_uint; begin Result := GetInfo<T_cl_uint>( CL_DEVICE_PREFERRED_GLOBAL_ATOMIC_ALIGNMENT ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_PREFERRED_LOCAL_ATOMIC_ALIGNMENT :T_cl_uint; begin Result := GetInfo<T_cl_uint>( CL_DEVICE_PREFERRED_LOCAL_ATOMIC_ALIGNMENT ); end;
{$ENDIF}
{$IF CL_VERSION_2_1 <> 0 }
function TCLDevice<TCLPlatfo_>.GetDEVICE_IL_VERSION :String; begin Result := GetInfoString( CL_DEVICE_IL_VERSION ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_MAX_NUM_SUB_GROUPS :T_cl_uint; begin Result := GetInfo<T_cl_uint>( CL_DEVICE_MAX_NUM_SUB_GROUPS ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_SUB_GROUP_INDEPENDENT_FORWARD_PROGRESS :T_cl_bool; begin Result := GetInfo<T_cl_bool>( CL_DEVICE_SUB_GROUP_INDEPENDENT_FORWARD_PROGRESS ); end;
{$ENDIF}
{$IF CL_VERSION_3_0 <> 0 }
function TCLDevice<TCLPlatfo_>.GetDEVICE_NUMERIC_VERSION :T_cl_version; begin Result := GetInfo<T_cl_version>( CL_DEVICE_NUMERIC_VERSION ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_EXTENSIONS_WITH_VERSION :TArray<T_cl_name_version>; begin Result := GetInfos<T_cl_name_version>( CL_DEVICE_EXTENSIONS_WITH_VERSION ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_ILS_WITH_VERSION :TArray<T_cl_name_version>; begin Result := GetInfos<T_cl_name_version>( CL_DEVICE_ILS_WITH_VERSION ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_BUILT_IN_KERNELS_WITH_VERSION :TArray<T_cl_name_version>; begin Result := GetInfos<T_cl_name_version>( CL_DEVICE_BUILT_IN_KERNELS_WITH_VERSION ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_ATOMIC_MEMORY_CAPABILITIES :T_cl_device_atomic_capabilities; begin Result := GetInfo<T_cl_device_atomic_capabilities>( CL_DEVICE_ATOMIC_MEMORY_CAPABILITIES ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_ATOMIC_FENCE_CAPABILITIES :T_cl_device_atomic_capabilities; begin Result := GetInfo<T_cl_device_atomic_capabilities>( CL_DEVICE_ATOMIC_FENCE_CAPABILITIES ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_NON_UNIFORM_WORK_GROUP_SUPPORT :T_cl_bool; begin Result := GetInfo<T_cl_bool>( CL_DEVICE_NON_UNIFORM_WORK_GROUP_SUPPORT ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_OPENCL_C_ALL_VERSIONS :TArray<T_cl_name_version>; begin Result := GetInfos<T_cl_name_version>( CL_DEVICE_OPENCL_C_ALL_VERSIONS ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_PREFERRED_WORK_GROUP_SIZE_MULTIPLE :T_size_t; begin Result := GetInfo<T_size_t>( CL_DEVICE_PREFERRED_WORK_GROUP_SIZE_MULTIPLE ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_WORK_GROUP_COLLECTIVE_FUNCTIONS_SUPPORT :T_cl_bool; begin Result := GetInfo<T_cl_bool>( CL_DEVICE_WORK_GROUP_COLLECTIVE_FUNCTIONS_SUPPORT ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_GENERIC_ADDRESS_SPACE_SUPPORT :T_cl_bool; begin Result := GetInfo<T_cl_bool>( CL_DEVICE_GENERIC_ADDRESS_SPACE_SUPPORT ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_OPENCL_C_FEATURES :TArray<T_cl_name_version>; begin Result := GetInfos<T_cl_name_version>( CL_DEVICE_OPENCL_C_FEATURES ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_DEVICE_ENQUEUE_CAPABILITIES :T_cl_device_device_enqueue_capabilities; begin Result := GetInfo<T_cl_device_device_enqueue_capabilities>( CL_DEVICE_DEVICE_ENQUEUE_CAPABILITIES ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_PIPE_SUPPORT :T_cl_bool; begin Result := GetInfo<T_cl_bool>( CL_DEVICE_PIPE_SUPPORT ); end;
function TCLDevice<TCLPlatfo_>.GetDEVICE_LATEST_CONFORMANCE_VERSION_PASSED :String; begin Result := GetInfoString( CL_DEVICE_LATEST_CONFORMANCE_VERSION_PASSED ); end;
{$ENDIF}

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLDevice<TCLPlatfo_>.Create( const Devices_:TCLDevices_; const Handle_:T_cl_device_id );
begin
     Create( Devices_ );

     _Handle := Handle_;
end;

destructor TCLDevice<TCLPlatfo_>.Destroy;
begin

     inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDevices<TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLDevices<TCLPlatfo_>.FindDevices;
const
     DEVICETYPE = CL_DEVICE_TYPE_ALL;
var
   DsN :T_cl_uint;
   Ds :TArray<T_cl_device_id>;
   D :T_cl_device_id;
begin
     AssertCL( clGetDeviceIDs( TCLPlatfo( Platfo ).Handle, DEVICETYPE, 0, nil, @DsN ), 'TCLDevices.FindDevices is Error!' );

     SetLength( Ds, DsN );

     AssertCL( clGetDeviceIDs( TCLPlatfo( Platfo ).Handle, DEVICETYPE, DsN, @Ds[0], nil ), 'TCLDevices.FindDevices is Error!' );

     for D in Ds do TCLDevice_.Create( Self, D );
end;

/////////////////////////////////////////////////////////////////////// イベント

procedure TCLDevices<TCLPlatfo_>.OnInit;
begin
     FindDevices;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

end. //######################################################################### ■
