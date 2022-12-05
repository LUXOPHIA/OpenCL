unit LUX.GPU.OpenCL.core;

interface //#################################################################### ■

uses cl_version, cl_platform, cl,
     LUX.Code.C;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLVersion

     TCLVersion = ( None  =   0,    // 未定義
                    CL100 = 100,    // OpenCL 1.0
                    CL110 = 110,    // OpenCL 1.1
                    CL120 = 120,    // OpenCL 1.2
                    CL200 = 200,    // OpenCL 2.0
                    CL210 = 210,    // OpenCL 2.1
                    CL220 = 220,    // OpenCL 2.1
                    CL300 = 300 );  // OpenCL 3.0

     HCLVersion = record helper for TCLVersion
     {private}
     {public}
       class function From( const Value_:String ) :TCLVersion; static;
       ///// メソッド
       function ToString :String;
     end;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

function ErrorToMessage( const Error_:T_cl_int ) :String;

procedure AssertCL( const Error_:T_cl_int; const Comment_:String = '' );

implementation //############################################################### ■

uses System.SysUtils;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLVersion

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

class function HCLVersion.From( const Value_:String ) :TCLVersion;
begin
     if Value_ = '1.0' then Result := TCLVersion.CL100
                       else
     if Value_ = '1.1' then Result := TCLVersion.CL110
                       else
     if Value_ = '1.2' then Result := TCLVersion.CL120
                       else
     if Value_ = '2.0' then Result := TCLVersion.CL200
                       else
     if Value_ = '2.1' then Result := TCLVersion.CL210
                       else
     if Value_ = '2.2' then Result := TCLVersion.CL220
                       else
     if Value_ = '3.0' then Result := TCLVersion.CL300
                       else Result := TCLVersion.None;
end;

function HCLVersion.ToString :String;
begin
     case Self of
       TCLVersion.CL100: Result := '1.0';
       TCLVersion.CL110: Result := '1.1';
       TCLVersion.CL120: Result := '1.2';
       TCLVersion.CL200: Result := '2.0';
       TCLVersion.CL210: Result := '2.1';
       TCLVersion.CL220: Result := '2.2';
       TCLVersion.CL300: Result := '3.0';
     end;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

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
{$IF cl_version.CL_VERSION_1_1 <> 0 }                                           { TODO : Record Helper を使うと他ユニットの定数が認識できなくなる。 }
       CL_MISALIGNED_SUB_BUFFER_OFFSET              : Result := 'MISALIGNED_SUB_BUFFER_OFFSET';
       CL_EXEC_STATUS_ERROR_FOR_EVENTS_IN_WAIT_LIST : Result := 'EXEC_STATUS_ERROR_FOR_EVENTS_IN_WAIT_LIST';
{$ENDIF}
{$IF cl_version.CL_VERSION_1_2 <> 0 }
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
{$IF cl_version.CL_VERSION_1_1 <> 0 }
       CL_INVALID_PROPERTY                          : Result := 'INVALID_PROPERTY';
{$ENDIF}
{$IF cl_version.CL_VERSION_1_2 <> 0 }
       CL_INVALID_IMAGE_DESCRIPTOR                  : Result := 'INVALID_IMAGE_DESCRIPTOR';
       CL_INVALID_COMPILER_OPTIONS                  : Result := 'INVALID_COMPILER_OPTIONS';
       CL_INVALID_LINKER_OPTIONS                    : Result := 'INVALID_LINKER_OPTIONS';
       CL_INVALID_DEVICE_PARTITION_COUNT            : Result := 'INVALID_DEVICE_PARTITION_COUNT';
{$ENDIF}
{$IF cl_version.CL_VERSION_2_0 <> 0 }
       CL_INVALID_PIPE_SIZE                         : Result := 'INVALID_PIPE_SIZE';
       CL_INVALID_DEVICE_QUEUE                      : Result := 'INVALID_DEVICE_QUEUE';
{$ENDIF}
{$IF cl_version.CL_VERSION_2_2 <> 0 }
       CL_INVALID_SPEC_ID                           : Result := 'INVALID_SPEC_ID';
       CL_MAX_SIZE_RESTRICTION_EXCEEDED             : Result := 'MAX_SIZE_RESTRICTION_EXCEEDED';
{$ENDIF}
     else                                             Result := 'UNKNOWN:' + Error_.ToString;
     end;
end;

procedure AssertCL( const Error_:T_cl_int; const Comment_:String = '' );
begin
     Assert( Error_ = CL_SUCCESS, '【' + ErrorToMessage( Error_ ) + '】' + Comment_ );
end;

end. //######################################################################### ■
