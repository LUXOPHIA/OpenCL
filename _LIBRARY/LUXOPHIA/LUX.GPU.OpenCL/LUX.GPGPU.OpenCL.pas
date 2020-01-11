unit LUX.GPGPU.OpenCL;

interface //#################################################################### ■

uses OpenCL.cl_platform, OpenCL.cl,
     LUX.Code.C;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TCLDevice = record
       ID         :T_cl_device_id;
       Name       :String;
       Vendor     :String;
       Version    :String;
       Profile    :String;
       Driver     :String;
       Extensions :TArray<String>;
     end;

     TCLPlatform = record
       ID         :T_cl_platform_id;
       Name       :String;
       Vendor     :String;
       Version    :String;
       Profile    :String;
       Extensions :TArray<String>;
       Devices    :TArray<TCLDevice>;
     end;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

function ToErrorMessage( const E_:T_cl_int ) :String;

function GetDevicesN( var DN_:T_cl_uint; const PI_:T_cl_platform_id; const DT_:T_cl_device_type  ) :T_cl_int;

function GetDeviceIDs( var DIs_:TArray<T_cl_device_id>; const PI_:T_cl_platform_id; const DT_:T_cl_device_type; const DN_:T_cl_uint ) :T_cl_int; overload;
function GetDeviceIDs( var DIs_:TArray<T_cl_device_id>; const PI_:T_cl_platform_id; const DT_:T_cl_device_type ) :T_cl_int; overload;

function GetDeviceInfo( var Text_:String; const DI_:T_cl_device_id; const DF_:T_cl_device_info ) :T_cl_int; overload;
function GetDeviceInfo( var Texts_:TArray<String>; const DI_:T_cl_device_id; const DF_:T_cl_device_info ) :T_cl_int; overload;

function GetPlatformsN( var PN_:T_cl_uint ) :T_cl_int;

function GetPlatformIDs( var PIs_:TArray<T_cl_platform_id>; const PN_:T_cl_uint ) :T_cl_int; overload;
function GetPlatformIDs( var PIs_:TArray<T_cl_platform_id> ) :T_cl_int; overload;

function GetPlatformInfo( var Text_:String; const PI_:T_cl_platform_id; const PF_:T_cl_platform_info ) :T_cl_int; overload;
function GetPlatformInfo( var Texts_:TArray<String>; const PI_:T_cl_platform_id; const PF_:T_cl_platform_info ) :T_cl_int; overload;

function GetDevice( var D_:TCLDevice; const DI_:T_cl_device_id ) :T_cl_int;
function GetDevices( var Ds_:TArray<TCLDevice>; const PI_:T_cl_platform_id; const DT_:T_cl_device_type ) :T_cl_int;

function GetPlatform( var P_:TCLPlatform; const ID_:T_cl_platform_id; const DT_:T_cl_device_type ) :T_cl_int;
function GetPlatforms( var Ps_:TArray<TCLPlatform>; const DT_:T_cl_device_type ) :T_cl_int;

implementation //############################################################### ■

uses System.SysUtils;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

function ToErrorMessage( const E_:T_cl_int ) :String;
begin
     case E_ of
       CL_SUCCESS                                  : Result := 'SUCCESS';
       CL_DEVICE_NOT_FOUND                         : Result := 'DEVICE_NOT_FOUND';
       CL_DEVICE_NOT_AVAILABLE                     : Result := 'DEVICE_NOT_AVAILABLE';
       CL_COMPILER_NOT_AVAILABLE                   : Result := 'COMPILER_NOT_AVAILABLE';
       CL_MEM_OBJECT_ALLOCATION_FAILURE            : Result := 'MEM_OBJECT_ALLOCATION_FAILURE';
       CL_OUT_OF_RESOURCES                         : Result := 'OUT_OF_RESOURCES';
       CL_OUT_OF_HOST_MEMORY                       : Result := 'OUT_OF_HOST_MEMORY';
       CL_PROFILING_INFO_NOT_AVAILABLE             : Result := 'PROFILING_INFO_NOT_AVAILABLE';
       CL_MEM_COPY_OVERLAP                         : Result := 'MEM_COPY_OVERLAP';
       CL_IMAGE_FORMAT_MISMATCH                    : Result := 'IMAGE_FORMAT_MISMATCH';
       CL_IMAGE_FORMAT_NOT_SUPPORTED               : Result := 'IMAGE_FORMAT_NOT_SUPPORTED';
       CL_BUILD_PROGRAM_FAILURE                    : Result := 'BUILD_PROGRAM_FAILURE';
       CL_MAP_FAILURE                              : Result := 'MAP_FAILURE';
       CL_MISALIGNED_SUB_BUFFER_OFFSET             : Result := 'MISALIGNED_SUB_BUFFER_OFFSET';
       CL_EXEC_STATUS_ERROR_FOR_EVENTS_IN_WAIT_LIST: Result := 'EXEC_STATUS_ERROR_FOR_EVENTS_IN_WAIT_LIST';
       CL_COMPILE_PROGRAM_FAILURE                  : Result := 'COMPILE_PROGRAM_FAILURE';
       CL_LINKER_NOT_AVAILABLE                     : Result := 'LINKER_NOT_AVAILABLE';
       CL_LINK_PROGRAM_FAILURE                     : Result := 'LINK_PROGRAM_FAILURE';
       CL_DEVICE_PARTITION_FAILED                  : Result := 'DEVICE_PARTITION_FAILED';
       CL_KERNEL_ARG_INFO_NOT_AVAILABLE            : Result := 'KERNEL_ARG_INFO_NOT_AVAILABLE';
       CL_INVALID_VALUE                            : Result := 'INVALID_VALUE';
       CL_INVALID_DEVICE_TYPE                      : Result := 'INVALID_DEVICE_TYPE';
       CL_INVALID_PLATFORM                         : Result := 'INVALID_PLATFORM';
       CL_INVALID_DEVICE                           : Result := 'INVALID_DEVICE';
       CL_INVALID_CONTEXT                          : Result := 'INVALID_CONTEXT';
       CL_INVALID_QUEUE_PROPERTIES                 : Result := 'INVALID_QUEUE_PROPERTIES';
       CL_INVALID_COMMAND_QUEUE                    : Result := 'INVALID_COMMAND_QUEUE';
       CL_INVALID_HOST_PTR                         : Result := 'INVALID_HOST_PTR';
       CL_INVALID_MEM_OBJECT                       : Result := 'INVALID_MEM_OBJECT';
       CL_INVALID_IMAGE_FORMAT_DESCRIPTOR          : Result := 'INVALID_IMAGE_FORMAT_DESCRIPTOR';
       CL_INVALID_IMAGE_SIZE                       : Result := 'INVALID_IMAGE_SIZE';
       CL_INVALID_SAMPLER                          : Result := 'INVALID_SAMPLER';
       CL_INVALID_BINARY                           : Result := 'INVALID_BINARY';
       CL_INVALID_BUILD_OPTIONS                    : Result := 'INVALID_BUILD_OPTIONS';
       CL_INVALID_PROGRAM                          : Result := 'INVALID_PROGRAM';
       CL_INVALID_PROGRAM_EXECUTABLE               : Result := 'INVALID_PROGRAM_EXECUTABLE';
       CL_INVALID_KERNEL_NAME                      : Result := 'INVALID_KERNEL_NAME';
       CL_INVALID_KERNEL_DEFINITION                : Result := 'INVALID_KERNEL_DEFINITION';
       CL_INVALID_KERNEL                           : Result := 'INVALID_KERNEL';
       CL_INVALID_ARG_INDEX                        : Result := 'INVALID_ARG_INDEX';
       CL_INVALID_ARG_VALUE                        : Result := 'INVALID_ARG_VALUE';
       CL_INVALID_ARG_SIZE                         : Result := 'INVALID_ARG_SIZE';
       CL_INVALID_KERNEL_ARGS                      : Result := 'INVALID_KERNEL_ARGS';
       CL_INVALID_WORK_DIMENSION                   : Result := 'INVALID_WORK_DIMENSION';
       CL_INVALID_WORK_GROUP_SIZE                  : Result := 'INVALID_WORK_GROUP_SIZE';
       CL_INVALID_WORK_ITEM_SIZE                   : Result := 'INVALID_WORK_ITEM_SIZE';
       CL_INVALID_GLOBAL_OFFSET                    : Result := 'INVALID_GLOBAL_OFFSET';
       CL_INVALID_EVENT_WAIT_LIST                  : Result := 'INVALID_EVENT_WAIT_LIST';
       CL_INVALID_EVENT                            : Result := 'INVALID_EVENT';
       CL_INVALID_OPERATION                        : Result := 'INVALID_OPERATION';
       CL_INVALID_GL_OBJECT                        : Result := 'INVALID_GL_OBJECT';
       CL_INVALID_BUFFER_SIZE                      : Result := 'INVALID_BUFFER_SIZE';
       CL_INVALID_MIP_LEVEL                        : Result := 'INVALID_MIP_LEVEL';
       CL_INVALID_GLOBAL_WORK_SIZE                 : Result := 'INVALID_GLOBAL_WORK_SIZE';
       CL_INVALID_PROPERTY                         : Result := 'INVALID_PROPERTY';
       CL_INVALID_IMAGE_DESCRIPTOR                 : Result := 'INVALID_IMAGE_DESCRIPTOR';
       CL_INVALID_COMPILER_OPTIONS                 : Result := 'INVALID_COMPILER_OPTIONS';
       CL_INVALID_LINKER_OPTIONS                   : Result := 'INVALID_LINKER_OPTIONS';
       CL_INVALID_DEVICE_PARTITION_COUNT           : Result := 'INVALID_DEVICE_PARTITION_COUNT';
       CL_INVALID_PIPE_SIZE                        : Result := 'INVALID_PIPE_SIZE';
       CL_INVALID_DEVICE_QUEUE                     : Result := 'INVALID_DEVICE_QUEUE';
     end;
end;

////////////////////////////////////////////////////////////////////////////////

function GetDevicesN( var DN_:T_cl_uint; const PI_:T_cl_platform_id; const DT_:T_cl_device_type  ) :T_cl_int;
begin
     Result := clGetDeviceIDs( PI_, DT_, 0, nil, @DN_ );
end;

function GetDeviceIDs( var DIs_:TArray<T_cl_device_id>; const PI_:T_cl_platform_id; const DT_:T_cl_device_type; const DN_:T_cl_uint ) :T_cl_int;
begin
     SetLength( DIs_, DN_ );

     Result := clGetDeviceIDs( PI_, DT_, DN_, @DIs_[0], nil );
end;

function GetDeviceIDs( var DIs_:TArray<T_cl_device_id>; const PI_:T_cl_platform_id; const DT_:T_cl_device_type ) :T_cl_int;
var
   N :T_cl_uint;
begin
     Result := GetDevicesN( N, PI_, DT_ );

     if Result <> CL_SUCCESS then Exit;

     Result := GetDeviceIDs( DIs_, PI_, DT_, N );
end;

function GetDeviceInfo( var Text_:String; const DI_:T_cl_device_id; const DF_:T_cl_device_info ) :T_cl_int;
var
   N :T_size_t;
   A :TArray<T_char>;
begin
     Result := clGetDeviceInfo( DI_, DF_, 0, nil, @N );

     if Result <> CL_SUCCESS then Exit;

     SetLength( A, N );

     Result := clGetDeviceInfo( DI_, DF_, N, @A[0], nil );

     Text_ := String( P_char( A ) );
end;

function GetDeviceInfo( var Texts_:TArray<String>; const DI_:T_cl_device_id; const DF_:T_cl_device_info ) :T_cl_int;
var
   T :String;
begin
     Result := GetDeviceInfo( T, DI_, DF_ );

     if Result <> CL_SUCCESS then Exit;

     Texts_ := T.Split( [ '  ', ' ' ] );
end;

////////////////////////////////////////////////////////////////////////////////

function GetPlatformsN( var PN_:T_cl_uint ) :T_cl_int;
begin
     Result := clGetPlatformIDs( 0, nil, @PN_ );
end;

function GetPlatformIDs( var PIs_:TArray<T_cl_platform_id>; const PN_:T_cl_uint ) :T_cl_int;
begin
     SetLength( PIs_, PN_ );

     Result := clGetPlatformIDs( PN_, @PIs_[0], nil );
end;

function GetPlatformIDs( var PIs_:TArray<T_cl_platform_id> ) :T_cl_int;
var
   N :T_cl_uint;
begin
     Result := GetPlatformsN( N );

     if Result <> CL_SUCCESS then Exit;

     Result := GetPlatformIDs( PIs_, N );
end;

function GetPlatformInfo( var Text_:String; const PI_:T_cl_platform_id; const PF_:T_cl_platform_info ) :T_cl_int;
var
   N :T_size_t;
   A :TArray<T_char>;
begin
     Result := clGetPlatformInfo( PI_, PF_, 0, nil, @N );

     if Result <> CL_SUCCESS then Exit;

     SetLength( A, N );

     Result := clGetPlatformInfo( PI_, PF_, N, @A[0], nil );

     Text_ := String( P_char( A ) );
end;

function GetPlatformInfo( var Texts_:TArray<String>; const PI_:T_cl_platform_id; const PF_:T_cl_platform_info ) :T_cl_int;
var
   T :String;
begin
     Result := GetPlatformInfo( T, PI_, PF_ );

     if Result <> CL_SUCCESS then Exit;

     Texts_ := T.Split( [ '  ', ' ' ] );
end;

////////////////////////////////////////////////////////////////////////////////

function GetDevice( var D_:TCLDevice; const DI_:T_cl_device_id ) :T_cl_int;
begin
     with D_ do
     begin
          ID := DI_;

          Result := GetDeviceInfo( Name      , ID, CL_DEVICE_NAME       );

          if Result <> CL_SUCCESS then Exit;

          Result := GetDeviceInfo( Vendor    , ID, CL_DEVICE_VENDOR     );

          if Result <> CL_SUCCESS then Exit;

          Result := GetDeviceInfo( Version   , ID, CL_DEVICE_VERSION    );

          if Result <> CL_SUCCESS then Exit;

          Result := GetDeviceInfo( Profile   , ID, CL_DEVICE_PROFILE    );

          if Result <> CL_SUCCESS then Exit;

          Result := GetDeviceInfo( Driver    , ID, CL_DRIVER_VERSION    );

          if Result <> CL_SUCCESS then Exit;

          Result := GetDeviceInfo( Extensions, ID, CL_DEVICE_EXTENSIONS );
     end;
end;

function GetDevices( var Ds_:TArray<TCLDevice>; const PI_:T_cl_platform_id; const DT_:T_cl_device_type ) :T_cl_int;
 var
   N :T_cl_uint;
   DIs :TArray<T_cl_device_id>;
   I :Integer;
begin
     Result := GetDevicesN( N, PI_, DT_ );

     if Result <> CL_SUCCESS then Exit;

     Result := GetDeviceIDs( DIs, PI_, DT_, N );

     if Result <> CL_SUCCESS then Exit;

     SetLength( Ds_, N );

     Result := CL_SUCCESS;
     for I := 0 to N-1 do
     begin
          Result := GetDevice( Ds_[ I ], DIs[ I ] );

          if Result <> CL_SUCCESS then Exit;
     end;
end;

////////////////////////////////////////////////////////////////////////////////

function GetPlatform( var P_:TCLPlatform; const ID_:T_cl_platform_id; const DT_:T_cl_device_type ) :T_cl_int;
begin
     with P_ do
     begin
          ID := ID_;

          Result := GetPlatformInfo( Name      , ID_, CL_PLATFORM_NAME       );

          if Result <> CL_SUCCESS then Exit;

          Result := GetPlatformInfo( Vendor    , ID_, CL_PLATFORM_VENDOR     );

          if Result <> CL_SUCCESS then Exit;

          Result := GetPlatformInfo( Version   , ID_, CL_PLATFORM_VERSION    );

          if Result <> CL_SUCCESS then Exit;

          Result := GetPlatformInfo( Profile   , ID_, CL_PLATFORM_PROFILE    );

          if Result <> CL_SUCCESS then Exit;

          Result := GetPlatformInfo( Extensions, ID_, CL_PLATFORM_EXTENSIONS );

          if Result <> CL_SUCCESS then Exit;

          Result :=      GetDevices( Devices   , ID_, DT_                    );
     end;
end;

function GetPlatforms( var Ps_:TArray<TCLPlatform>; const DT_:T_cl_device_type ) :T_cl_int;
 var
   N :T_cl_uint;
   PIs :TArray<T_cl_platform_id>;
   I :Integer;
begin
     Result := GetPlatformsN( N );

     if Result <> CL_SUCCESS then Exit;

     Result := GetPlatformIDs( PIs, N );

     if Result <> CL_SUCCESS then Exit;

     SetLength( Ps_, N );

     Result := CL_SUCCESS;
     for I := 0 to N-1 do
     begin
          Result := GetPlatform( Ps_[ I ], PIs[ I ], DT_ );

          if Result <> CL_SUCCESS then Exit;
     end;
end;

//############################################################################## □

initialization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 初期化

finalization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 最終化

end. //######################################################################### ■
