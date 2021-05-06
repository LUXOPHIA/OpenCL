unit LUX.GPU.OpenCL.Progra;

interface //#################################################################### ■

uses System.Classes, System.Generics.Collections,
     cl_version, cl_platform, cl,
     LUX.Data.List,
     LUX.Code.C,
     LUX.GPU.OpenCL.root,
     LUX.GPU.OpenCL.Device,
     LUX.GPU.OpenCL.Kernel;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TCLProgras     <TCLContex_,TCLPlatfo_:class> = class;
       TCLProgra    <TCLContex_,TCLPlatfo_:class> = class;
         TCLDeploys <TCLContex_,TCLPlatfo_:class> = class;
           TCLDeploy<TCLContex_,TCLPlatfo_:class> = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDeploy<TCLContex_,TCLPlatfo_>

     TCLDeploy<TCLContex_,TCLPlatfo_:class> = class( TListChildr<TCLProgra <TCLContex_,TCLPlatfo_>,
                                                                 TCLDeploys<TCLContex_,TCLPlatfo_>> )
     private
       type TCLDevice_  = TCLDevice <TCLPlatfo_>;
            TCLProgra_  = TCLProgra <TCLContex_,TCLPlatfo_>;
            TCLDeploys_ = TCLDeploys<TCLContex_,TCLPlatfo_>;
       ///// メソッド
       function Build :T_cl_int;
       function GetInfo<_TYPE_>( const Name_:T_cl_program_build_info ) :_TYPE_;
       function GetInfoSize( const Name_:T_cl_program_build_info ) :T_size_t;
       function GetInfos<_TYPE_>( const Name_:T_cl_program_build_info ) :TArray<_TYPE_>;
       function GetInfoString( const Name_:T_cl_program_build_info ) :String;
     protected
       _Device :TCLDevice_;
       _State  :T_cl_build_status;
       _Log    :String;
     public
       constructor Create( const Deploys_:TCLDeploys_; const Device_:TCLDevice_ ); overload; virtual;
       ///// プロパティ
       property Progra  :TCLProgra_        read GetOwnere;
       property Deploys :TCLDeploys_       read GetParent;
       property Device  :TCLDevice_        read   _Device;
       property State   :T_cl_build_status read   _State ;
       property Log     :String            read   _Log   ;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDeploys<TCLContex_,TCLPlatfo_>

     TCLDeploys<TCLContex_,TCLPlatfo_:class> = class( TListParent<TCLProgra<TCLContex_,TCLPlatfo_>,
                                                                  TCLDeploy<TCLContex_,TCLPlatfo_>> )
     private
       type TCLDevice_ = TCLDevice<TCLPlatfo_>;
            TCLProgra_ = TCLProgra<TCLContex_,TCLPlatfo_>;
            TCLDeploy_ = TCLDeploy<TCLContex_,TCLPlatfo_>;
            TCLDevDeps = TDictionary<TCLDevice_,TCLDeploy_>;
     protected
       _DevDeps :TCLDevDeps;
       ///// イベント
       procedure OnInsertChild( const Childr_:TCLDeploy_ ); override;
       procedure OnRemoveChild( const Childr_:TCLDeploy_ ); override;
     public
       constructor Create; override;
       destructor Destroy; override;
       ///// プロパティ
       property Progra :TCLProgra_ read GetOwnere;
       ///// メソッド
       function Add( const Device_:TCLDevice_ ) :TCLDeploy_; overload;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLProgra<TCLContex_,TCLPlatfo_>

     TCLProgra<TCLContex_,TCLPlatfo_:class> = class( TListChildr<TCLContex_,TCLProgras<TCLContex_,TCLPlatfo_>> )
     private
       type TCLDevice_  = TCLDevice <TCLPlatfo_>;
            TCLProgras_ = TCLProgras<TCLContex_,TCLPlatfo_>;
            TCLProgra_  = TCLProgra <TCLContex_,TCLPlatfo_>;
            TCLDeploys_ = TCLDeploys<TCLContex_,TCLPlatfo_>;
            TCLDeploy_  = TCLDeploy <TCLContex_,TCLPlatfo_>;
            TCLKernels_ = TCLKernels<TCLProgra_,TCLContex_,TCLPlatfo_>;
       ///// メソッド
       function GetInfo<_TYPE_>( const Name_:T_cl_program_info ) :_TYPE_;
       function GetInfoSize( const Name_:T_cl_program_info ) :T_size_t;
       function GetInfos<_TYPE_>( const Name_:T_cl_program_info ) :TArray<_TYPE_>;
       function GetInfoString( const Name_:T_cl_program_info ) :String;
     protected
       _Handle  :T_cl_program;
       _Source  :TStringList;
       _LangVer :TCLVersion;
       _Deploys :TCLDeploys_;
       _Kernels :TCLKernels_;
       ///// アクセス
       function GetHandle :T_cl_program;
       procedure SetHandle( const Handle_:T_cl_program );
       (* cl_program_info *)
       function GetPROGRAM_REFERENCE_COUNT :T_cl_uint;
       function GetPROGRAM_CONTEXT :T_cl_context;
       function GetPROGRAM_NUM_DEVICES :T_cl_uint;
       function GetPROGRAM_DEVICES :TArray<T_cl_device_id>;
       function GetPROGRAM_SOURCE :String;
       function GetPROGRAM_BINARY_SIZES :TArray<T_size_t>;
       function GetPROGRAM_BINARIES :TArray<P_unsigned_char>;
       {$IF CL_VERSION_1_2 <> 0 }
       function GetPROGRAM_NUM_KERNELS :T_size_t;
       function GetPROGRAM_KERNEL_NAMES :String;
       {$ENDIF}
       {$IF CL_VERSION_2_1 <> 0 }
       function GetPROGRAM_IL :String;
       {$ENDIF}
       {$IF CL_VERSION_2_2 <> 0 }
       function GetPROGRAM_SCOPE_GLOBAL_CTORS_PRESENT :T_cl_bool ;
       function GetPROGRAM_SCOPE_GLOBAL_DTORS_PRESENT :T_cl_bool ;
       {$ENDIF}
       ///// メソッド
       procedure CreateHandle;
       procedure DestroHandle;
     public
       constructor Create; override;
       constructor Create( const Contex_:TCLContex_ ); overload; virtual;
       destructor Destroy; override;
       ///// プロパティ
       property Contex  :TCLContex_   read GetOwnere                 ;
       property Progras :TCLProgras_  read GetParent                 ;
       property Handle  :T_cl_program read GetHandle  write SetHandle;
       property Source  :TStringList  read   _Source                 ;
       property LangVer :TCLVersion   read   _LangVer                ;
       property Deploys :TCLDeploys_  read   _Deploys                ;
       property Kernels :TCLKernels_  read   _Kernels                ;
       (* cl_program_info *)
       property PROGRAM_REFERENCE_COUNT            :T_cl_uint               read GetPROGRAM_REFERENCE_COUNT;
       property PROGRAM_CONTEXT                    :T_cl_context            read GetPROGRAM_CONTEXT;
       property PROGRAM_NUM_DEVICES                :T_cl_uint               read GetPROGRAM_NUM_DEVICES;
       property PROGRAM_DEVICES                    :TArray<T_cl_device_id>  read GetPROGRAM_DEVICES;
       property PROGRAM_SOURCE                     :String                  read GetPROGRAM_SOURCE;
       property PROGRAM_BINARY_SIZES               :TArray<T_size_t>        read GetPROGRAM_BINARY_SIZES;
       property PROGRAM_BINARIES                   :TArray<P_unsigned_char> read GetPROGRAM_BINARIES;
       {$IF CL_VERSION_1_2 <> 0 }
       property PROGRAM_NUM_KERNELS                :T_size_t                read GetPROGRAM_NUM_KERNELS;
       property PROGRAM_KERNEL_NAMES               :String                  read GetPROGRAM_KERNEL_NAMES;
       {$ENDIF}
       {$IF CL_VERSION_2_1 <> 0 }
       property PROGRAM_IL                         :String                  read GetPROGRAM_IL;
       {$ENDIF}
       {$IF CL_VERSION_2_2 <> 0 }
       property PROGRAM_SCOPE_GLOBAL_CTORS_PRESENT :T_cl_bool               read GetPROGRAM_SCOPE_GLOBAL_CTORS_PRESENT;
       property PROGRAM_SCOPE_GLOBAL_DTORS_PRESENT :T_cl_bool               read GetPROGRAM_SCOPE_GLOBAL_DTORS_PRESENT;
       {$ENDIF}
       ///// メソッド
       function BuildTo( const Device_:TCLDevice_ ) :TCLDeploy_;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLProgras<TCLContex_,TCLPlatfo_>

     TCLProgras<TCLContex_,TCLPlatfo_:class> = class( TListParent<TCLContex_,TCLProgra<TCLContex_,TCLPlatfo_>> )
     private
       type TCLProgra_ = TCLProgra<TCLContex_,TCLPlatfo_>;
     protected
     public
       ///// プロパティ
       property Contex :TCLContex_ read GetOwnere;
       ///// メソッド
       function Add :TCLProgra_; overload;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses System.SysUtils,
     LUX.GPU.OpenCL;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDeploy<TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

/////////////////////////////////////////////////////////////////////// メソッド

function TCLDeploy<TCLContex_,TCLPlatfo_>.Build :T_cl_int;
var
   Os :String;
begin
     Os := '-cl-kernel-arg-info';

     if Ord( Progra.LangVer ) > 100 then Os := Os + ' -cl-std=CL' + Progra.LangVer.ToString;

     Result := clBuildProgram( Progra.Handle, 1, @Device.Handle, P_char( AnsiString( Os ) ), nil, nil );
end;

//------------------------------------------------------------------------------

function TCLDeploy<TCLContex_,TCLPlatfo_>.GetInfo<_TYPE_>( const Name_:T_cl_program_build_info ) :_TYPE_;
begin
     AssertCL( clGetProgramBuildInfo( Progra.Handle, Device.Handle, Name_, SizeOf( _TYPE_ ), @Result, nil ) );
end;

function TCLDeploy<TCLContex_,TCLPlatfo_>.GetInfoSize( const Name_:T_cl_program_build_info ) :T_size_t;
begin
     AssertCL( clGetProgramBuildInfo( Progra.Handle, Device.Handle, Name_, 0, nil, @Result ) );
end;

function TCLDeploy<TCLContex_,TCLPlatfo_>.GetInfos<_TYPE_>( const Name_:T_cl_program_build_info ) :TArray<_TYPE_>;
var
   S :T_size_t;
begin
     S := GetInfoSize( Name_ );

     SetLength( Result, S div Cardinal( SizeOf( _TYPE_ ) ) );

     AssertCL( clGetProgramBuildInfo( Progra.Handle, Device.Handle, Name_, S, @Result[ 0 ], nil ) );
end;

function TCLDeploy<TCLContex_,TCLPlatfo_>.GetInfoString( const Name_:T_cl_program_build_info ) :String;
begin
     Result := TrimRight( String( P_char( GetInfos<T_char>( Name_ ) ) ) );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLDeploy<TCLContex_,TCLPlatfo_>.Create( const Deploys_:TCLDeploys_; const Device_:TCLDevice_ );
begin
     inherited Create( Deploys_ );

     _Device := Device_;

     Build;

     _State := GetInfo<T_cl_build_status>( CL_PROGRAM_BUILD_STATUS );
     _Log   := GetInfoString             ( CL_PROGRAM_BUILD_LOG    );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDeploys<TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// イベント

procedure TCLDeploys<TCLContex_,TCLPlatfo_>.OnInsertChild( const Childr_:TCLDeploy_ );
begin
     inherited;

     _DevDeps.Add( Childr_.Device, Childr_ );
end;

procedure TCLDeploys<TCLContex_,TCLPlatfo_>.OnRemoveChild( const Childr_:TCLDeploy_ );
begin
     inherited;

     _DevDeps.Remove( Childr_.Device );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLDeploys<TCLContex_,TCLPlatfo_>.Create;
begin
     inherited;

     _DevDeps := TCLDevDeps.Create;
end;

destructor TCLDeploys<TCLContex_,TCLPlatfo_>.Destroy;
begin
     _DevDeps.Free;

     inherited;
end;

/////////////////////////////////////////////////////////////////////// メソッド

function TCLDeploys<TCLContex_,TCLPlatfo_>.Add( const Device_:TCLDevice_ ) :TCLDeploy_;
begin
     if _DevDeps.ContainsKey( Device_ ) then Result := _DevDeps[ Device_ ]
                                        else Result := TCLDeploy_.Create( Self, Device_ );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLProgra<TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

/////////////////////////////////////////////////////////////////////// メソッド

function TCLProgra<TCLContex_,TCLPlatfo_>.GetInfo<_TYPE_>( const Name_:T_cl_program_info ) :_TYPE_;
begin
     AssertCL( clGetProgramInfo( Handle, Name_, SizeOf( _TYPE_ ), @Result, nil ) );
end;

function TCLProgra<TCLContex_,TCLPlatfo_>.GetInfoSize( const Name_:T_cl_program_info ) :T_size_t;
begin
     AssertCL( clGetProgramInfo( Handle, Name_, 0, nil, @Result ) );
end;

function TCLProgra<TCLContex_,TCLPlatfo_>.GetInfos<_TYPE_>( const Name_:T_cl_program_info ) :TArray<_TYPE_>;
var
   S :T_size_t;
begin
     S := GetInfoSize( Name_ );

     SetLength( Result, S div Cardinal( SizeOf( _TYPE_ ) ) );

     AssertCL( clGetProgramInfo( Handle, Name_, S, @Result[ 0 ], nil ) );
end;

function TCLProgra<TCLContex_,TCLPlatfo_>.GetInfoString( const Name_:T_cl_program_info ) :String;
begin
     Result := TrimRight( String( P_char( GetInfos<T_char>( Name_ ) ) ) );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLProgra<TCLContex_,TCLPlatfo_>.GetHandle :T_cl_program;
begin
     if not Assigned( _Handle ) then CreateHandle;

     Result := _Handle;
end;

procedure TCLProgra<TCLContex_,TCLPlatfo_>.SetHandle( const Handle_:T_cl_program );
begin
     if Assigned( _Handle ) then DestroHandle;

     _Handle := Handle_;
end;

//---------------------------------------------------------(* cl_program_info *)

function TCLProgra<TCLContex_,TCLPlatfo_>.GetPROGRAM_REFERENCE_COUNT :T_cl_uint; begin Result := GetInfo<T_cl_uint>( CL_PROGRAM_REFERENCE_COUNT ); end;
function TCLProgra<TCLContex_,TCLPlatfo_>.GetPROGRAM_CONTEXT :T_cl_context; begin Result := GetInfo<T_cl_context>( CL_PROGRAM_CONTEXT ); end;
function TCLProgra<TCLContex_,TCLPlatfo_>.GetPROGRAM_NUM_DEVICES :T_cl_uint; begin Result := GetInfo<T_cl_uint>( CL_PROGRAM_NUM_DEVICES ); end;
function TCLProgra<TCLContex_,TCLPlatfo_>.GetPROGRAM_DEVICES :TArray<T_cl_device_id>; begin Result := GetInfos<T_cl_device_id>( CL_PROGRAM_DEVICES ); end;
function TCLProgra<TCLContex_,TCLPlatfo_>.GetPROGRAM_SOURCE :String; begin Result := GetInfoString( CL_PROGRAM_SOURCE ); end;
function TCLProgra<TCLContex_,TCLPlatfo_>.GetPROGRAM_BINARY_SIZES :TArray<T_size_t>; begin Result := GetInfos<T_size_t>( CL_PROGRAM_BINARY_SIZES ); end;
function TCLProgra<TCLContex_,TCLPlatfo_>.GetPROGRAM_BINARIES :TArray<P_unsigned_char>; begin Result := GetInfos<P_unsigned_char>( CL_PROGRAM_BINARIES ); end;
{$IF CL_VERSION_1_2 <> 0 }
function TCLProgra<TCLContex_,TCLPlatfo_>.GetPROGRAM_NUM_KERNELS :T_size_t; begin Result := GetInfo<T_size_t>( CL_PROGRAM_NUM_KERNELS ); end;
function TCLProgra<TCLContex_,TCLPlatfo_>.GetPROGRAM_KERNEL_NAMES :String; begin Result := GetInfoString( CL_PROGRAM_KERNEL_NAMES ); end;
{$ENDIF}
{$IF CL_VERSION_2_1 <> 0 }
function TCLProgra<TCLContex_,TCLPlatfo_>.GetPROGRAM_IL :String; begin Result := GetInfoString( CL_PROGRAM_IL ); end;
{$ENDIF}
{$IF CL_VERSION_2_2 <> 0 }
function TCLProgra<TCLContex_,TCLPlatfo_>.GetPROGRAM_SCOPE_GLOBAL_CTORS_PRESENT :T_cl_bool; begin Result := GetInfo<T_cl_bool>( CL_PROGRAM_SCOPE_GLOBAL_CTORS_PRESENT ); end;
function TCLProgra<TCLContex_,TCLPlatfo_>.GetPROGRAM_SCOPE_GLOBAL_DTORS_PRESENT :T_cl_bool; begin Result := GetInfo<T_cl_bool>( CL_PROGRAM_SCOPE_GLOBAL_DTORS_PRESENT ); end;
{$ENDIF}

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLProgra<TCLContex_,TCLPlatfo_>.CreateHandle;
var
   C :P_char;
   E :T_cl_int;
begin
     C := P_char( AnsiString( _Source.Text ) );

     _Handle := clCreateProgramWithSource( TCLContex( Contex ).Handle, 1, @C, nil, @E );

     AssertCL( E );
end;

procedure TCLProgra<TCLContex_,TCLPlatfo_>.DestroHandle;
begin
     clReleaseProgram( _Handle );

     _Handle := nil;

     _Deploys.Clear;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLProgra<TCLContex_,TCLPlatfo_>.Create;
begin
     inherited;

     _Source  := TStringList.Create;
     _Deploys := TCLDeploys_.Create( Self );
     _Kernels := TCLKernels_.Create( Self );

     _Handle := nil;

     _LangVer := TCLVersion.From( '3.0' );
end;

constructor TCLProgra<TCLContex_,TCLPlatfo_>.Create( const Contex_:TCLContex_ );
begin
     inherited Create( TCLContex( Contex_ ).Progras );
end;

destructor TCLProgra<TCLContex_,TCLPlatfo_>.Destroy;
begin
      Handle := nil;

     _Kernels.Free;
     _Deploys.Free;
     _Source .Free;

     inherited;
end;

/////////////////////////////////////////////////////////////////////// メソッド

function TCLProgra<TCLContex_,TCLPlatfo_>.BuildTo( const Device_:TCLDevice_ ) :TCLDeploy_;
begin
     Result := Deploys.Add( Device_ );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLProgras<TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

function TCLProgras<TCLContex_,TCLPlatfo_>.Add :TCLProgra_;
begin
     Result := TCLProgra_.Create( Contex );
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

end. //######################################################################### ■
