unit LUX.GPU.OpenCL;

interface //#################################################################### ■

uses System.Classes, System.Generics.Collections,
     cl_version,
     cl_platform,
     cl,
     LUX.Code.C;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TCLDevice   = class;
     TCLPlatform = class;
     TOpenCL     = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDevice

     TCLDevice = class
     private
       function GetDeviceInfo<_TYPE_>( const Name_:T_cl_device_info ) :_TYPE_;
       function GetDeviceInfoSize( const Name_:T_cl_device_info ) :T_size_t;
       function GetDeviceInfos<_TYPE_>( const Name_:T_cl_device_info ) :TArray<_TYPE_>;
       function GetDeviceInfoString( const Name_:T_cl_device_info ) :String;
     protected
       _Parent :TCLPlatform;
       _ID     :T_cl_device_id;
       ///// アクセス
       { cl_device_info }
(*     function GetDEVICE_ADDRESS_BITS :T_cl_uint;
       function GetDEVICE_AVAILABLE :T_cl_bool;
       function GetDEVICE_BUILT_IN_KERNELS :String;
       function GetDEVICE_COMPILER_AVAILABLE :T_cl_bool;
       function GetDEVICE_DOUBLE_FP_CONFIG :T_cl_device_fp_config;
       function GetDEVICE_ENDIAN_LITTLE :T_cl_bool;
       function GetDEVICE_ERROR_CORRECTION_SUPPORT :T_cl_bool;
       function GetDEVICE_EXECUTION_CAPABILITIES :T_cl_device_exec_capabilities;
       function GetDEVICE_EXTENSIONS :String;
       function GetDEVICE_GLOBAL_MEM_CACHE_SIZE :T_cl_ulong;
       function GetDEVICE_GLOBAL_MEM_CACHE_TYPE :T_cl_device_mem_cache_type;
       function GetDEVICE_GLOBAL_MEM_CACHELINE_SIZE :T_cl_uint;
       function GetDEVICE_GLOBAL_MEM_SIZE :T_cl_ulong;
       function GetDEVICE_GLOBAL_VARIABLE_PREFERRED_TOTAL_SIZE :T_size_t;
       function GetDEVICE_IL_VERSION :String;
       function GetDEVICE_IMAGE2D_MAX_HEIGHT :T_size_t;
       function GetDEVICE_IMAGE2D_MAX_WIDTH :T_size_t;
       function GetDEVICE_IMAGE3D_MAX_DEPTH :T_size_t;
       function GetDEVICE_IMAGE3D_MAX_HEIGHT :T_size_t;
       function GetDEVICE_IMAGE3D_MAX_WIDTH :T_size_t;
       function GetDEVICE_IMAGE_BASE_ADDRESS_ALIGNMENT :T_cl_uint;
       function GetDEVICE_IMAGE_MAX_ARRAY_SIZE :T_size_t;
       function GetDEVICE_IMAGE_MAX_BUFFER_SIZE :T_size_t;
       function GetDEVICE_IMAGE_PITCH_ALIGNMENT :T_cl_uint;
       function GetDEVICE_IMAGE_SUPPORT :T_cl_bool;
       function GetDEVICE_LINKER_AVAILABLE :T_cl_bool;
       function GetDEVICE_LOCAL_MEM_SIZE :T_cl_ulong;
       function GetDEVICE_LOCAL_MEM_TYPE :T_cl_device_local_mem_type;
       function GetDEVICE_MAX_CLOCK_FREQUENCY :T_cl_uint;
       function GetDEVICE_MAX_COMPUTE_UNITS :T_cl_uint;
       function GetDEVICE_MAX_CONSTANT_ARGS :T_cl_uint;
       function GetDEVICE_MAX_CONSTANT_BUFFER_SIZE :T_cl_ulong;
       function GetDEVICE_MAX_GLOBAL_VARIABLE_SIZE :T_size_t;
       function GetDEVICE_MAX_MEM_ALLOC_SIZE :T_cl_ulong;
       function GetDEVICE_MAX_NUM_SUB_GROUPS :T_cl_uint;
       function GetDEVICE_MAX_ON_DEVICE_EVENTS :T_cl_uint;
       function GetDEVICE_MAX_ON_DEVICE_QUEUES :T_cl_uint;
       function GetDEVICE_MAX_PARAMETER_SIZE :T_size_t;
       function GetDEVICE_MAX_PIPE_ARGS :T_cl_uint;
       function GetDEVICE_MAX_READ_IMAGE_ARGS :T_cl_uint;
       function GetDEVICE_MAX_READ_WRITE_IMAGE_ARGS :T_cl_uint;
       function GetDEVICE_MAX_SAMPLERS :T_cl_uint;
       function GetDEVICE_MAX_WORK_GROUP_SIZE :T_size_t;
       function GetDEVICE_MAX_WORK_ITEM_DIMENSIONS :T_cl_uint;
       function GetDEVICE_MAX_WORK_ITEM_SIZES :TArray<T_size_t>;
       function GetDEVICE_MAX_WRITE_IMAGE_ARGS :T_cl_uint;
       function GetDEVICE_MEM_BASE_ADDR_ALIGN :T_cl_uint;
       function GetDEVICE_NAME :String;
       function GetDEVICE_NATIVE_VECTOR_WIDTH_CHAR :T_cl_uint;
       function GetDEVICE_NATIVE_VECTOR_WIDTH_SHORT :T_cl_uint;
       function GetDEVICE_NATIVE_VECTOR_WIDTH_INT :T_cl_uint;
       function GetDEVICE_NATIVE_VECTOR_WIDTH_LONG :T_cl_uint;
       function GetDEVICE_NATIVE_VECTOR_WIDTH_FLOAT :T_cl_uint;
       function GetDEVICE_NATIVE_VECTOR_WIDTH_DOUBLE :T_cl_uint;
       function GetDEVICE_NATIVE_VECTOR_WIDTH_HALF :T_cl_uint;
       function GetDEVICE_OPENCL_C_VERSION :String;
       function GetDEVICE_PARENT_DEVICE :T_cl_device_id;
       {$IF Declared( CL_VERSION_1_2 ) }
       function GetDEVICE_PARTITION_AFFINITY_DOMAIN :T_cl_device_affinity_domain;
       {$ENDIF}
       function GetDEVICE_PARTITION_MAX_SUB_DEVICES :T_cl_uint;
       {$IF Declared( CL_VERSION_1_2 ) }
       function GetDEVICE_PARTITION_PROPERTIES :TArray<T_cl_device_partition_property>;
       function GetDEVICE_PARTITION_TYPE :TArray<T_cl_device_partition_property>;
       {$ENDIF}
       function GetDEVICE_PIPE_MAX_ACTIVE_RESERVATIONS :T_cl_uint;
       function GetDEVICE_PIPE_MAX_PACKET_SIZE :T_cl_uint;
       function GetDEVICE_PLATFORM :T_cl_platform_id;
       function GetDEVICE_PREFERRED_GLOBAL_ATOMIC_ALIGNMENT :T_cl_uint;
       function GetDEVICE_PREFERRED_INTEROP_USER_SYNC :T_cl_bool;
       function GetDEVICE_PREFERRED_LOCAL_ATOMIC_ALIGNMENT :T_cl_uint;
       function GetDEVICE_PREFERRED_PLATFORM_ATOMIC_ALIGNMENT :T_cl_uint;
       function GetDEVICE_PREFERRED_VECTOR_WIDTH_CHAR :T_cl_uint;
       function GetDEVICE_PREFERRED_VECTOR_WIDTH_SHORT :T_cl_uint;
       function GetDEVICE_PREFERRED_VECTOR_WIDTH_INT :T_cl_uint;
       function GetDEVICE_PREFERRED_VECTOR_WIDTH_LONG :T_cl_uint;
       function GetDEVICE_PREFERRED_VECTOR_WIDTH_FLOAT :T_cl_uint;
       function GetDEVICE_PREFERRED_VECTOR_WIDTH_DOUBLE :T_cl_uint;
       function GetDEVICE_PREFERRED_VECTOR_WIDTH_HALF :T_cl_uint;
       function GetDEVICE_PRINTF_BUFFER_SIZE :T_size_t;
       function GetDEVICE_PROFILE :String;
       function GetDEVICE_PROFILING_TIMER_RESOLUTION :T_size_t;
       function GetDEVICE_QUEUE_ON_DEVICE_MAX_SIZE :T_cl_uint;
       function GetDEVICE_QUEUE_ON_DEVICE_PREFERRED_SIZE :T_cl_uint;
       function GetDEVICE_QUEUE_ON_DEVICE_PROPERTIES :T_cl_command_queue_properties;
       function GetDEVICE_QUEUE_ON_HOST_PROPERTIES :T_cl_command_queue_properties;
       function GetDEVICE_REFERENCE_COUNT :T_cl_uint;
       function GetDEVICE_SINGLE_FP_CONFIG :T_cl_device_fp_config;
       function GetDEVICE_SPIR_VERSIONS :String;
       function GetDEVICE_SUBGROUP_INDEPENDENT_FORWARD_PROGRESS :T_cl_bool;
       {$IF Declared( CL_VERSION_2_0 ) }
       function GetDEVICE_SVM_CAPABILITIES :T_cl_device_svm_capabilities;
       {$ENDIF} *)
     { function GetDEVICE_TERMINATE_CAPABILITY_KHR :T_cl_device_terminate_capability_khr; }
       function GetDEVICE_TYPE :T_cl_device_type;
       function GetDEVICE_VENDOR :String;
       function GetDEVICE_VENDOR_ID :T_cl_uint;
       function GetDEVICE_VERSION :String;
       function GetDRIVER_VERSION :String;
     public
       constructor Create( const Parent_:TCLPlatform; const ID_:T_cl_device_id );
       destructor Destroy; override;
       ///// プロパティ
       property Parent                                       :TCLPlatform                            read   _Parent;
       property ID                                           :T_cl_device_id                         read   _ID;
       { cl_device_info }
(*     property DEVICE_ADDRESS_BITS                          :T_cl_uint                              read GetDEVICE_ADDRESS_BITS;
       property DEVICE_AVAILABLE                             :T_cl_bool                              read GetDEVICE_AVAILABLE;
       property DEVICE_BUILT_IN_KERNELS                      :String                                 read GetDEVICE_BUILT_IN_KERNELS;
       property DEVICE_COMPILER_AVAILABLE                    :T_cl_bool                              read GetDEVICE_COMPILER_AVAILABLE;
       property DEVICE_DOUBLE_FP_CONFIG                      :T_cl_device_fp_config                  read GetDEVICE_DOUBLE_FP_CONFIG;
       property DEVICE_ENDIAN_LITTLE                         :T_cl_bool                              read GetDEVICE_ENDIAN_LITTLE;
       property DEVICE_ERROR_CORRECTION_SUPPORT              :T_cl_bool                              read GetDEVICE_ERROR_CORRECTION_SUPPORT;
       property DEVICE_EXECUTION_CAPABILITIES                :T_cl_device_exec_capabilities          read GetDEVICE_EXECUTION_CAPABILITIES;
       property DEVICE_EXTENSIONS                            :String                                 read GetDEVICE_EXTENSIONS;
       property DEVICE_GLOBAL_MEM_CACHE_SIZE                 :T_cl_ulong                             read GetDEVICE_GLOBAL_MEM_CACHE_SIZE;
       property DEVICE_GLOBAL_MEM_CACHE_TYPE                 :T_cl_device_mem_cache_type             read GetDEVICE_GLOBAL_MEM_CACHE_TYPE;
       property DEVICE_GLOBAL_MEM_CACHELINE_SIZE             :T_cl_uint                              read GetDEVICE_GLOBAL_MEM_CACHELINE_SIZE;
       property DEVICE_GLOBAL_MEM_SIZE                       :T_cl_ulong                             read GetDEVICE_GLOBAL_MEM_SIZE;
       property DEVICE_GLOBAL_VARIABLE_PREFERRED_TOTAL_SIZE  :T_size_t                               read GetDEVICE_GLOBAL_VARIABLE_PREFERRED_TOTAL_SIZE;
       property DEVICE_IL_VERSION                            :String                                 read GetDEVICE_IL_VERSION;
       property DEVICE_IMAGE2D_MAX_HEIGHT                    :T_size_t                               read GetDEVICE_IMAGE2D_MAX_HEIGHT;
       property DEVICE_IMAGE2D_MAX_WIDTH                     :T_size_t                               read GetDEVICE_IMAGE2D_MAX_WIDTH;
       property DEVICE_IMAGE3D_MAX_DEPTH                     :T_size_t                               read GetDEVICE_IMAGE3D_MAX_DEPTH;
       property DEVICE_IMAGE3D_MAX_HEIGHT                    :T_size_t                               read GetDEVICE_IMAGE3D_MAX_HEIGHT;
       property DEVICE_IMAGE3D_MAX_WIDTH                     :T_size_t                               read GetDEVICE_IMAGE3D_MAX_WIDTH;
       property DEVICE_IMAGE_BASE_ADDRESS_ALIGNMENT          :T_cl_uint                              read GetDEVICE_IMAGE_BASE_ADDRESS_ALIGNMENT;
       property DEVICE_IMAGE_MAX_ARRAY_SIZE                  :T_size_t                               read GetDEVICE_IMAGE_MAX_ARRAY_SIZE;
       property DEVICE_IMAGE_MAX_BUFFER_SIZE                 :T_size_t                               read GetDEVICE_IMAGE_MAX_BUFFER_SIZE;
       property DEVICE_IMAGE_PITCH_ALIGNMENT                 :T_cl_uint                              read GetDEVICE_IMAGE_PITCH_ALIGNMENT;
       property DEVICE_IMAGE_SUPPORT                         :T_cl_bool                              read GetDEVICE_IMAGE_SUPPORT;
       property DEVICE_LINKER_AVAILABLE                      :T_cl_bool                              read GetDEVICE_LINKER_AVAILABLE;
       property DEVICE_LOCAL_MEM_SIZE                        :T_cl_ulong                             read GetDEVICE_LOCAL_MEM_SIZE;
       property DEVICE_LOCAL_MEM_TYPE                        :T_cl_device_local_mem_type             read GetDEVICE_LOCAL_MEM_TYPE;
       property DEVICE_MAX_CLOCK_FREQUENCY                   :T_cl_uint                              read GetDEVICE_MAX_CLOCK_FREQUENCY;
       property DEVICE_MAX_COMPUTE_UNITS                     :T_cl_uint                              read GetDEVICE_MAX_COMPUTE_UNITS;
       property DEVICE_MAX_CONSTANT_ARGS                     :T_cl_uint                              read GetDEVICE_MAX_CONSTANT_ARGS;
       property DEVICE_MAX_CONSTANT_BUFFER_SIZE              :T_cl_ulong                             read GetDEVICE_MAX_CONSTANT_BUFFER_SIZE;
       property DEVICE_MAX_GLOBAL_VARIABLE_SIZE              :T_size_t                               read GetDEVICE_MAX_GLOBAL_VARIABLE_SIZE;
       property DEVICE_MAX_MEM_ALLOC_SIZE                    :T_cl_ulong                             read GetDEVICE_MAX_MEM_ALLOC_SIZE;
       property DEVICE_MAX_NUM_SUB_GROUPS                    :T_cl_uint                              read GetDEVICE_MAX_NUM_SUB_GROUPS;
       property DEVICE_MAX_ON_DEVICE_EVENTS                  :T_cl_uint                              read GetDEVICE_MAX_ON_DEVICE_EVENTS;
       property DEVICE_MAX_ON_DEVICE_QUEUES                  :T_cl_uint                              read GetDEVICE_MAX_ON_DEVICE_QUEUES;
       property DEVICE_MAX_PARAMETER_SIZE                    :T_size_t                               read GetDEVICE_MAX_PARAMETER_SIZE;
       property DEVICE_MAX_PIPE_ARGS                         :T_cl_uint                              read GetDEVICE_MAX_PIPE_ARGS;
       property DEVICE_MAX_READ_IMAGE_ARGS                   :T_cl_uint                              read GetDEVICE_MAX_READ_IMAGE_ARGS;
       property DEVICE_MAX_READ_WRITE_IMAGE_ARGS             :T_cl_uint                              read GetDEVICE_MAX_READ_WRITE_IMAGE_ARGS;
       property DEVICE_MAX_SAMPLERS                          :T_cl_uint                              read GetDEVICE_MAX_SAMPLERS;
       property DEVICE_MAX_WORK_GROUP_SIZE                   :T_size_t                               read GetDEVICE_MAX_WORK_GROUP_SIZE;
       property DEVICE_MAX_WORK_ITEM_DIMENSIONS              :T_cl_uint                              read GetDEVICE_MAX_WORK_ITEM_DIMENSIONS;
       property DEVICE_MAX_WORK_ITEM_SIZES                   :TArray<T_size_t>                       read GetDEVICE_MAX_WORK_ITEM_SIZES;
       property DEVICE_MAX_WRITE_IMAGE_ARGS                  :T_cl_uint                              read GetDEVICE_MAX_WRITE_IMAGE_ARGS;
       property DEVICE_MEM_BASE_ADDR_ALIGN                   :T_cl_uint                              read GetDEVICE_MEM_BASE_ADDR_ALIGN;
       property DEVICE_NAME                                  :String                                 read GetDEVICE_NAME;
       property DEVICE_NATIVE_VECTOR_WIDTH_CHAR              :T_cl_uint                              read GetDEVICE_NATIVE_VECTOR_WIDTH_CHAR;
       property DEVICE_NATIVE_VECTOR_WIDTH_SHORT             :T_cl_uint                              read GetDEVICE_NATIVE_VECTOR_WIDTH_SHORT;
       property DEVICE_NATIVE_VECTOR_WIDTH_INT               :T_cl_uint                              read GetDEVICE_NATIVE_VECTOR_WIDTH_INT;
       property DEVICE_NATIVE_VECTOR_WIDTH_LONG              :T_cl_uint                              read GetDEVICE_NATIVE_VECTOR_WIDTH_LONG;
       property DEVICE_NATIVE_VECTOR_WIDTH_FLOAT             :T_cl_uint                              read GetDEVICE_NATIVE_VECTOR_WIDTH_FLOAT;
       property DEVICE_NATIVE_VECTOR_WIDTH_DOUBLE            :T_cl_uint                              read GetDEVICE_NATIVE_VECTOR_WIDTH_DOUBLE;
       property DEVICE_NATIVE_VECTOR_WIDTH_HALF              :T_cl_uint                              read GetDEVICE_NATIVE_VECTOR_WIDTH_HALF;
       property DEVICE_OPENCL_C_VERSION                      :String                                 read GetDEVICE_OPENCL_C_VERSION;
       property DEVICE_PARENT_DEVICE                         :T_cl_device_id                         read GetDEVICE_PARENT_DEVICE;
       {$IF Declared( CL_VERSION_1_2 ) }
       property DEVICE_PARTITION_AFFINITY_DOMAIN             :T_cl_device_affinity_domain            read GetDEVICE_PARTITION_AFFINITY_DOMAIN;
       {$ENDIF}
       property DEVICE_PARTITION_MAX_SUB_DEVICES             :T_cl_uint                              read GetDEVICE_PARTITION_MAX_SUB_DEVICES;
       {$IF Declared( CL_VERSION_1_2 ) }
       property DEVICE_PARTITION_PROPERTIES                  :TArray<T_cl_device_partition_property> read GetDEVICE_PARTITION_PROPERTIES;
       property DEVICE_PARTITION_TYPE                        :TArray<T_cl_device_partition_property> read GetDEVICE_PARTITION_TYPE;
       {$ENDIF}
       property DEVICE_PIPE_MAX_ACTIVE_RESERVATIONS          :T_cl_uint                              read GetDEVICE_PIPE_MAX_ACTIVE_RESERVATIONS;
       property DEVICE_PIPE_MAX_PACKET_SIZE                  :T_cl_uint                              read GetDEVICE_PIPE_MAX_PACKET_SIZE;
       property DEVICE_PLATFORM                              :T_cl_platform_id                       read GetDEVICE_PLATFORM;
       property DEVICE_PREFERRED_GLOBAL_ATOMIC_ALIGNMENT     :T_cl_uint                              read GetDEVICE_PREFERRED_GLOBAL_ATOMIC_ALIGNMENT;
       property DEVICE_PREFERRED_INTEROP_USER_SYNC           :T_cl_bool                              read GetDEVICE_PREFERRED_INTEROP_USER_SYNC;
       property DEVICE_PREFERRED_LOCAL_ATOMIC_ALIGNMENT      :T_cl_uint                              read GetDEVICE_PREFERRED_LOCAL_ATOMIC_ALIGNMENT;
       property DEVICE_PREFERRED_PLATFORM_ATOMIC_ALIGNMENT   :T_cl_uint                              read GetDEVICE_PREFERRED_PLATFORM_ATOMIC_ALIGNMENT;
       property DEVICE_PREFERRED_VECTOR_WIDTH_CHAR           :T_cl_uint                              read GetDEVICE_PREFERRED_VECTOR_WIDTH_CHAR;
       property DEVICE_PREFERRED_VECTOR_WIDTH_SHORT          :T_cl_uint                              read GetDEVICE_PREFERRED_VECTOR_WIDTH_SHORT;
       property DEVICE_PREFERRED_VECTOR_WIDTH_INT            :T_cl_uint                              read GetDEVICE_PREFERRED_VECTOR_WIDTH_INT;
       property DEVICE_PREFERRED_VECTOR_WIDTH_LONG           :T_cl_uint                              read GetDEVICE_PREFERRED_VECTOR_WIDTH_LONG;
       property DEVICE_PREFERRED_VECTOR_WIDTH_FLOAT          :T_cl_uint                              read GetDEVICE_PREFERRED_VECTOR_WIDTH_FLOAT;
       property DEVICE_PREFERRED_VECTOR_WIDTH_DOUBLE         :T_cl_uint                              read GetDEVICE_PREFERRED_VECTOR_WIDTH_DOUBLE;
       property DEVICE_PREFERRED_VECTOR_WIDTH_HALF           :T_cl_uint                              read GetDEVICE_PREFERRED_VECTOR_WIDTH_HALF;
       property DEVICE_PRINTF_BUFFER_SIZE                    :T_size_t                               read GetDEVICE_PRINTF_BUFFER_SIZE;
       property DEVICE_PROFILE                               :String                                 read GetDEVICE_PROFILE;
       property DEVICE_PROFILING_TIMER_RESOLUTION            :T_size_t                               read GetDEVICE_PROFILING_TIMER_RESOLUTION;
       property DEVICE_QUEUE_ON_DEVICE_MAX_SIZE              :T_cl_uint                              read GetDEVICE_QUEUE_ON_DEVICE_MAX_SIZE;
       property DEVICE_QUEUE_ON_DEVICE_PREFERRED_SIZE        :T_cl_uint                              read GetDEVICE_QUEUE_ON_DEVICE_PREFERRED_SIZE;
       property DEVICE_QUEUE_ON_DEVICE_PROPERTIES            :T_cl_command_queue_properties          read GetDEVICE_QUEUE_ON_DEVICE_PROPERTIES;
       property DEVICE_QUEUE_ON_HOST_PROPERTIES              :T_cl_command_queue_properties          read GetDEVICE_QUEUE_ON_HOST_PROPERTIES;
       property DEVICE_REFERENCE_COUNT                       :T_cl_uint                              read GetDEVICE_REFERENCE_COUNT;
       property DEVICE_SINGLE_FP_CONFIG                      :T_cl_device_fp_config                  read GetDEVICE_SINGLE_FP_CONFIG;
       property DEVICE_SPIR_VERSIONS                         :String                                 read GetDEVICE_SPIR_VERSIONS;
       property DEVICE_SUBGROUP_INDEPENDENT_FORWARD_PROGRESS :T_cl_bool                              read GetDEVICE_SUBGROUP_INDEPENDENT_FORWARD_PROGRESS;
       {$IF Declared( CL_VERSION_2_0 ) }
       property DEVICE_SVM_CAPABILITIES                      :T_cl_device_svm_capabilities           read GetDEVICE_SVM_CAPABILITIES;
       {$ENDIF} *)
     { property DEVICE_TERMINATE_CAPABILITY_KHR              :T_cl_device_terminate_capability_khr   read GetDEVICE_TERMINATE_CAPABILITY_KHR; }
       property DEVICE_TYPE                                  :T_cl_device_type                       read GetDEVICE_TYPE;
       property DEVICE_VENDOR                                :String                                 read GetDEVICE_VENDOR;
       property DEVICE_VENDOR_ID                             :T_cl_uint                              read GetDEVICE_VENDOR_ID;
       property DEVICE_VERSION                               :String                                 read GetDEVICE_VERSION;
       property DRIVER_VERSION                               :String                                 read GetDRIVER_VERSION;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLPlatform

     TCLPlatform = class
     private
       ///// メソッド
       function GetPlatformInfo<_TYPE_>( const Name_:T_cl_platform_info ) :_TYPE_;
       function GetPlatformInfoSize( const Name_:T_cl_platform_info ) :T_size_t;
       function GetPlatformInfos<_TYPE_>( const Name_:T_cl_platform_info ) :TArray<_TYPE_>;
       function GetPlatformInfoString( const Name_:T_cl_platform_info ) :String;
     protected
       _Parent     :TOpenCL;
       _ID         :T_cl_platform_id;
       _Extensions :TStringList;
       _Devices    :TObjectList<TCLDevice>;
       ///// アクセス
       function GetProfile :String;
       function GetVersion :String;
       function GetName :String;
       function GetVendor :String;
       function GetTimerReso :T_cl_ulong;
       ///// メソッド
       procedure MakeDevices;
     public
       constructor Create( const Parent_:TOpenCL; const ID_:T_cl_platform_id );
       destructor Destroy; override;
       ///// プロパティ
       property Parent     :TOpenCL                read   _Parent    ;
       property ID         :T_cl_platform_id       read   _ID        ;
       property Profile    :String                 read GetProfile   ;
       property Version    :String                 read GetVersion   ;
       property Name       :String                 read GetName      ;
       property Vendor     :String                 read GetVendor    ;
       property Extensions :TStringList            read   _Extensions;
       property TimerReso  :T_cl_ulong             read GetTimerReso ;  { OpenCL 2.1 }
       property Devices    :TObjectList<TCLDevice> read   _Devices   ;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TOpenCL

     TOpenCL = class
     private
       _Platforms :TObjectList<TCLPlatform>;
       ///// メソッド
       procedure MakePlatforms;
     protected
     public
       constructor Create;
       destructor Destroy; override;
       ///// プロパティ
       property Platforms :TObjectList<TCLPlatform> read _Platforms;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

    _OpenCL_ :TOpenCL;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

function ErrorToMessage( const Error_:T_cl_int ) :String;

procedure AssertCL( const Error_:T_cl_int );

implementation //############################################################### ■

uses System.SysUtils;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDevice

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

/////////////////////////////////////////////////////////////////////// メソッド

function TCLDevice.GetDeviceInfo<_TYPE_>( const Name_:T_cl_device_info ) :_TYPE_;
begin
     AssertCL( clGetDeviceInfo( _ID, Name_, SizeOf( _TYPE_ ), @Result, nil ) );
end;

//------------------------------------------------------------------------------

function TCLDevice.GetDeviceInfoSize( const Name_:T_cl_device_info ) :T_size_t;
begin
     AssertCL( clGetDeviceInfo( _ID, Name_, 0, nil, @Result ) );
end;

//------------------------------------------------------------------------------

function TCLDevice.GetDeviceInfos<_TYPE_>( const Name_:T_cl_device_info ) :TArray<_TYPE_>;
var
   S :T_size_t;
begin
     S := GetDeviceInfoSize( Name_ );

     SetLength( Result, S div Cardinal( SizeOf( _TYPE_ ) ) );

     AssertCL( clGetDeviceInfo( _ID, Name_, S, @Result[ 0 ], nil ) );
end;

//------------------------------------------------------------------------------

function TCLDevice.GetDeviceInfoString( const Name_:T_cl_device_info ) :String;
begin
     Result := String( P_char( GetDeviceInfos<T_char>( Name_ ) ) );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLDevice.GetDEVICE_TYPE :T_cl_device_type;
begin
     Result := GetDeviceInfo<T_cl_device_type>( CL_DEVICE_TYPE );
end;

function TCLDevice.GetDEVICE_VENDOR :String;
begin
     Result := GetDeviceInfoString( CL_DEVICE_VENDOR );
end;

function TCLDevice.GetDEVICE_VENDOR_ID :T_cl_uint;
begin
     Result := GetDeviceInfo<T_cl_uint>( CL_DEVICE_VENDOR_ID );
end;

function TCLDevice.GetDEVICE_VERSION :String;
begin
     Result := GetDeviceInfoString( CL_DEVICE_VERSION );
end;

function TCLDevice.GetDRIVER_VERSION :String;
begin
     Result := GetDeviceInfoString( CL_DRIVER_VERSION );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLDevice.Create( const Parent_:TCLPlatform; const ID_:T_cl_device_id );
begin
     inherited Create;

     _Parent := Parent_;
     _ID     := ID_;
end;

destructor TCLDevice.Destroy;
begin

     inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLPlatform

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

/////////////////////////////////////////////////////////////////////// メソッド

function TCLPlatform.GetPlatformInfo<_TYPE_>( const Name_:T_cl_platform_info ) :_TYPE_;
begin
     AssertCL( clGetPlatformInfo( _ID, Name_, SizeOf( _TYPE_ ), @Result, nil ) );
end;

//------------------------------------------------------------------------------

function TCLPlatform.GetPlatformInfoSize( const Name_:T_cl_platform_info ) :T_size_t;
begin
     AssertCL( clGetPlatformInfo( _ID, Name_, 0, nil, @Result ) );
end;

//------------------------------------------------------------------------------

function TCLPlatform.GetPlatformInfos<_TYPE_>( const Name_:T_cl_platform_info ) :TArray<_TYPE_>;
var
   S :T_size_t;
begin
     S := GetPlatformInfoSize( Name_ );

     SetLength( Result, S div Cardinal( SizeOf( _TYPE_ ) ) );

     AssertCL( clGetPlatformInfo( _ID, Name_, S, @Result[ 0 ], nil ) );
end;

//------------------------------------------------------------------------------

function TCLPlatform.GetPlatformInfoString( const Name_:T_cl_platform_info ) :String;
begin
     Result := String( P_char( GetPlatformInfos<T_char>( Name_ ) ) );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLPlatform.GetProfile :String;
begin
     Result := GetPlatformInfoString( CL_PLATFORM_PROFILE );
end;

function TCLPlatform.GetVersion :String;
begin
     Result := GetPlatformInfoString( CL_PLATFORM_VERSION );
end;

function TCLPlatform.GetName :String;
begin
     Result := GetPlatformInfoString( CL_PLATFORM_NAME );
end;

function TCLPlatform.GetVendor :String;
begin
     Result := GetPlatformInfoString( CL_PLATFORM_VENDOR );
end;

function TCLPlatform.GetTimerReso :T_cl_ulong;
begin
     {$IF Declared( CL_VERSION_2_1 ) }
     Result := GetPlatformInfo<T_cl_ulong>( CL_PLATFORM_HOST_TIMER_RESOLUTION );
     {$ELSE}
     Result := 0;
     {$ENDIF}
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLPlatform.MakeDevices;
const
     DEVICETYPE = CL_DEVICE_TYPE_ALL;
var
   DsN :T_cl_uint;
   Ds :TArray<T_cl_device_id>;
   D :T_cl_device_id;
begin
     AssertCL( clGetDeviceIDs( _ID, DEVICETYPE, 0, nil, @DsN ) );

     SetLength( Ds, DsN );

     AssertCL( clGetDeviceIDs( _ID, DEVICETYPE, DsN, @Ds[0], nil ) );

     for D in Ds do _Devices.Add( TCLDevice.Create( Self, D ) );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLPlatform.Create( const Parent_:TOpenCL; const ID_:T_cl_platform_id );
var
   E :String;
begin
     inherited Create;

     _Extensions := TStringList.Create;
     _Devices    := TObjectList<TCLDevice>.Create;

     _Parent := Parent_;
     _ID     := ID_;

     for E in GetPlatformInfoString( CL_PLATFORM_EXTENSIONS ).Split( [ ' ' ] )
     do _Extensions.Add( E );

     MakeDevices;
end;

destructor TCLPlatform.Destroy;
begin
     _Extensions.Free;
     _Devices   .Free;

     inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TOpenCL

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

/////////////////////////////////////////////////////////////////////// メソッド

procedure TOpenCL.MakePlatforms;
var
   PsN :T_cl_uint;
   Ps :TArray<T_cl_platform_id>;
   P :T_cl_platform_id;
begin
     AssertCL( clGetPlatformIDs( 0, nil, @PsN ) );

     SetLength( Ps, PsN );

     AssertCL( clGetPlatformIDs( PsN, @Ps[0], nil ) );

     for P in Ps do _Platforms.Add( TCLPlatform.Create( Self, P ) );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TOpenCL.Create;
begin
     inherited;

     _Platforms := TObjectList<TCLPlatform>.Create;

     MakePlatforms;
end;

destructor TOpenCL.Destroy;
begin
     _Platforms.Free;

     inherited;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

function ErrorToMessage( const Error_:T_cl_int ) :String;
begin
     case Error_ of
       CL_SUCCESS                                   : Result := 'SUCCESS';
       CL_DEVICE_NOT_FOUND                          : Result := 'DEVICE_NOT_FOUND';
       CL_DEVICE_NOT_AVAILABLE                      : Result := 'DEVICE_NOT_AVAILABLE';
       CL_COMPILER_NOT_AVAILABLE                    : Result := 'COMPILER_NOT_AVAILABLE';
       CL_MEM_OBJECT_ALLOCATION_FAILURE             : Result := 'MEM_OBJECT_ALLOCATION_FAILURE';
       CL_OUT_OF_RESOURCES                          : Result := 'OUT_OF_RESOURCES';
       CL_OUT_OF_HOST_MEMORY                        : Result := 'OUT_OF_HOST_MEMORY';
       CL_PROFILING_INFO_NOT_AVAILABLE              : Result := 'PROFILING_INFO_NOT_AVAILABLE';
       CL_MEM_COPY_OVERLAP                          : Result := 'MEM_COPY_OVERLAP';
       CL_IMAGE_FORMAT_MISMATCH                     : Result := 'IMAGE_FORMAT_MISMATCH';
       CL_IMAGE_FORMAT_NOT_SUPPORTED                : Result := 'IMAGE_FORMAT_NOT_SUPPORTED';
       CL_BUILD_PROGRAM_FAILURE                     : Result := 'BUILD_PROGRAM_FAILURE';
       CL_MAP_FAILURE                               : Result := 'MAP_FAILURE';
{$IF Declared( CL_VERSION_1_1 ) }
       CL_MISALIGNED_SUB_BUFFER_OFFSET              : Result := 'MISALIGNED_SUB_BUFFER_OFFSET';
       CL_EXEC_STATUS_ERROR_FOR_EVENTS_IN_WAIT_LIST  : Result := 'EXEC_STATUS_ERROR_FOR_EVENTS_IN_WAIT_LIST';
{$ENDIF}
{$IF Declared( CL_VERSION_1_2 ) }
       CL_COMPILE_PROGRAM_FAILURE                   : Result := 'COMPILE_PROGRAM_FAILURE';
       CL_LINKER_NOT_AVAILABLE                      : Result := 'LINKER_NOT_AVAILABLE';
       CL_LINK_PROGRAM_FAILURE                      : Result := 'LINK_PROGRAM_FAILURE';
       CL_DEVICE_PARTITION_FAILED                   : Result := 'DEVICE_PARTITION_FAILED';
       CL_KERNEL_ARG_INFO_NOT_AVAILABLE             : Result := 'KERNEL_ARG_INFO_NOT_AVAILABLE';
{$ENDIF}
       CL_INVALID_VALUE                             : Result := 'INVALID_VALUE';
       CL_INVALID_DEVICE_TYPE                       : Result := 'INVALID_DEVICE_TYPE';
       CL_INVALID_PLATFORM                          : Result := 'INVALID_PLATFORM';
       CL_INVALID_DEVICE                            : Result := 'INVALID_DEVICE';
       CL_INVALID_CONTEXT                           : Result := 'INVALID_CONTEXT';
       CL_INVALID_QUEUE_PROPERTIES                  : Result := 'INVALID_QUEUE_PROPERTIES';
       CL_INVALID_COMMAND_QUEUE                     : Result := 'INVALID_COMMAND_QUEUE';
       CL_INVALID_HOST_PTR                          : Result := 'INVALID_HOST_PTR';
       CL_INVALID_MEM_OBJECT                        : Result := 'INVALID_MEM_OBJECT';
       CL_INVALID_IMAGE_FORMAT_DESCRIPTOR           : Result := 'INVALID_IMAGE_FORMAT_DESCRIPTOR';
       CL_INVALID_IMAGE_SIZE                        : Result := 'INVALID_IMAGE_SIZE';
       CL_INVALID_SAMPLER                           : Result := 'INVALID_SAMPLER';
       CL_INVALID_BINARY                            : Result := 'INVALID_BINARY';
       CL_INVALID_BUILD_OPTIONS                     : Result := 'INVALID_BUILD_OPTIONS';
       CL_INVALID_PROGRAM                           : Result := 'INVALID_PROGRAM';
       CL_INVALID_PROGRAM_EXECUTABLE                : Result := 'INVALID_PROGRAM_EXECUTABLE';
       CL_INVALID_KERNEL_NAME                       : Result := 'INVALID_KERNEL_NAME';
       CL_INVALID_KERNEL_DEFINITION                 : Result := 'INVALID_KERNEL_DEFINITION';
       CL_INVALID_KERNEL                            : Result := 'INVALID_KERNEL';
       CL_INVALID_ARG_INDEX                         : Result := 'INVALID_ARG_INDEX';
       CL_INVALID_ARG_VALUE                         : Result := 'INVALID_ARG_VALUE';
       CL_INVALID_ARG_SIZE                          : Result := 'INVALID_ARG_SIZE';
       CL_INVALID_KERNEL_ARGS                       : Result := 'INVALID_KERNEL_ARGS';
       CL_INVALID_WORK_DIMENSION                    : Result := 'INVALID_WORK_DIMENSION';
       CL_INVALID_WORK_GROUP_SIZE                   : Result := 'INVALID_WORK_GROUP_SIZE';
       CL_INVALID_WORK_ITEM_SIZE                    : Result := 'INVALID_WORK_ITEM_SIZE';
       CL_INVALID_GLOBAL_OFFSET                     : Result := 'INVALID_GLOBAL_OFFSET';
       CL_INVALID_EVENT_WAIT_LIST                   : Result := 'INVALID_EVENT_WAIT_LIST';
       CL_INVALID_EVENT                             : Result := 'INVALID_EVENT';
       CL_INVALID_OPERATION                         : Result := 'INVALID_OPERATION';
       CL_INVALID_GL_OBJECT                         : Result := 'INVALID_GL_OBJECT';
       CL_INVALID_BUFFER_SIZE                       : Result := 'INVALID_BUFFER_SIZE';
       CL_INVALID_MIP_LEVEL                         : Result := 'INVALID_MIP_LEVEL';
       CL_INVALID_GLOBAL_WORK_SIZE                  : Result := 'INVALID_GLOBAL_WORK_SIZE';
{$IF Declared( CL_VERSION_1_1 ) }
       CL_INVALID_PROPERTY                          : Result := 'INVALID_PROPERTY';
{$ENDIF}
{$IF Declared( CL_VERSION_1_2 ) }
       CL_INVALID_IMAGE_DESCRIPTOR                  : Result := 'INVALID_IMAGE_DESCRIPTOR';
       CL_INVALID_COMPILER_OPTIONS                  : Result := 'INVALID_COMPILER_OPTIONS';
       CL_INVALID_LINKER_OPTIONS                    : Result := 'INVALID_LINKER_OPTIONS';
       CL_INVALID_DEVICE_PARTITION_COUNT            : Result := 'INVALID_DEVICE_PARTITION_COUNT';
{$ENDIF}
{$IF Declared( CL_VERSION_2_0 ) }
       CL_INVALID_PIPE_SIZE                         : Result := 'INVALID_PIPE_SIZE';
       CL_INVALID_DEVICE_QUEUE                      : Result := 'INVALID_DEVICE_QUEUE';
{$ENDIF}
{$IF Declared( CL_VERSION_2_2 ) }
       CL_INVALID_SPEC_ID                           : Result := 'INVALID_SPEC_ID';
       CL_MAX_SIZE_RESTRICTION_EXCEEDED             : Result := 'MAX_SIZE_RESTRICTION_EXCEEDED';
{$ENDIF}
     end;
end;

procedure AssertCL( const Error_:T_cl_int );
begin
     Assert( Error_ = CL_SUCCESS, ErrorToMessage( Error_ ) );
end;

//############################################################################## □

initialization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 初期化

     _OpenCL_ := TOpenCL.Create;

finalization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 最終化

     _OpenCL_.Free;

end. //######################################################################### ■
