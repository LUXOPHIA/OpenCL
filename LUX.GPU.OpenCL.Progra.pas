unit LUX.GPU.OpenCL.Progra;

interface //#################################################################### ■

uses System.SysUtils, System.Classes, System.Generics.Collections,
     cl_version, cl_platform, cl,
     LUX.Data.List,
     LUX.Code.C,
     LUX.GPU.OpenCL.core,
     LUX.GPU.OpenCL.Device,
     LUX.GPU.OpenCL.Kernel;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TCLProgras   <TCLContex_,TCLPlatfo_,TCLProgra_ :class> = class;
       TCLProgra  <TCLContex_,TCLPlatfo_,TCLProgras_:class> = class;
         TCLSource<TCLContex_,TCLPlatfo_,TCLProgras_:class> = class;

     TCLLibrars <TCLContex_,TCLPlatfo_:class> = class;
       TCLLibrar<TCLContex_,TCLPlatfo_:class> = class;

     TCLExecuts     <TCLContex_,TCLPlatfo_:class> = class;
       TCLExecut    <TCLContex_,TCLPlatfo_:class> = class;
         TCLBuildrs <TCLContex_,TCLPlatfo_:class> = class;
           TCLBuildr<TCLContex_,TCLPlatfo_:class> = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLBuildr<TCLContex_,TCLPlatfo_>

     TCLBuildr<TCLContex_,TCLPlatfo_:class> = class( TListChildr<TCLExecut <TCLContex_,TCLPlatfo_>,
                                                                 TCLBuildrs<TCLContex_,TCLPlatfo_>> )
     private
       type TCLDevice_  = TCLDevice <TCLPlatfo_>;
            TCLExecut_  = TCLExecut <TCLContex_,TCLPlatfo_>;
            TCLBuildrs_ = TCLBuildrs<TCLContex_,TCLPlatfo_>;
       ///// メソッド
       function GetInfo<_TYPE_>( const Handle_:T_cl_program; const Name_:T_cl_program_build_info ) :_TYPE_;
       function GetInfoSize( const Handle_:T_cl_program; const Name_:T_cl_program_build_info ) :T_size_t;
       function GetInfos<_TYPE_>( const Handle_:T_cl_program; const Name_:T_cl_program_build_info ) :TArray<_TYPE_>;
       function GetInfoString( const Handle_:T_cl_program; const Name_:T_cl_program_build_info ) :String;
     protected
       _Handle        :T_cl_program;
       _Device        :TCLDevice_;
       _CompileStatus :T_cl_build_status;
       _CompileLog    :String;
       _LinkStatus    :T_cl_build_status;
       _LinkLog       :String;
       ///// アクセス
       function GetHandle :T_cl_program;
       procedure SetHandle( const Handle_:T_cl_program );
       ///// メソッド
       function Compile :T_cl_int;
       function Link :T_cl_int;
       function CreateHandle :T_cl_int; virtual;
       function DestroHandle :T_cl_int; virtual;
     public
       constructor Create; override;
       constructor Create( const Buildrs_:TCLBuildrs_; const Device_:TCLDevice_ ); overload; virtual;
       destructor Destroy; override;
       ///// プロパティ
       property Execut        :TCLExecut_        read GetOwnere                       ;
       property Buildrs       :TCLBuildrs_       read GetParent                       ;
       property Handle        :T_cl_program      read GetHandle        write SetHandle;
       property Device        :TCLDevice_        read   _Device                       ;
       property CompileStatus :T_cl_build_status read   _CompileStatus                ;
       property CompileLog    :String            read   _CompileLog                   ;
       property LinkStatus    :T_cl_build_status read   _LinkStatus                   ;
       property LinkLog       :String            read   _LinkLog                      ;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLBuildrs<TCLContex_,TCLPlatfo_>

     TCLBuildrs<TCLContex_,TCLPlatfo_:class> = class( TListParent<TCLExecut<TCLContex_,TCLPlatfo_>,
                                                                  TCLBuildr<TCLContex_,TCLPlatfo_>> )
     private
       type TCLDevice_ = TCLDevice<TCLPlatfo_>;
            TCLExecut_ = TCLExecut<TCLContex_,TCLPlatfo_>;
            TCLBuildr_ = TCLBuildr<TCLContex_,TCLPlatfo_>;
            TCLDevDeps = TDictionary<TCLDevice_,TCLBuildr_>;
     protected
       _DevDeps :TCLDevDeps;
       ///// アクセス
       function GetBuildrs( const Device_:TCLDevice_ ) :TCLBuildr_; virtual;
       ///// イベント
       procedure OnInsertChild( const Childr_:TCLBuildr_ ); override;
       procedure OnRemoveChild( const Childr_:TCLBuildr_ ); override;
     public
       constructor Create; override;
       destructor Destroy; override;
       ///// プロパティ
       property Execut                              :TCLExecut_ read GetOwnere ;
       property Buildrs[ const Device_:TCLDevice_ ] :TCLBuildr_ read GetBuildrs; default;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLSource<TCLContex_,TCLPlatfo_,TCLProgras_>

     TCLSource<TCLContex_,TCLPlatfo_,TCLProgras_:class> = class( TStringList )
     private
       type TCLProgra_ = TCLProgra<TCLContex_,TCLPlatfo_,TCLProgras_>;
     protected
       _Progra :TCLProgra_;
       ///// メソッド
       procedure Changed; override;
     public
       constructor Create; overload; virtual;
       constructor Create( const Progra_:TCLProgra_ ); overload; virtual;
       ///// プロパティ
       property Progra :TCLProgra_ read _Progra;
       ///// メソッド
       procedure LoadFromFile( const FileName_:String ); override;
       procedure LoadFromFile( const FileName_:String; Encoding_:TEncoding ); override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLProgra<TCLContex_,TCLPlatfo_,TCLProgras_>

     TCLProgra<TCLContex_,TCLPlatfo_,TCLProgras_:class> = class( TListChildr<TCLContex_,TCLProgras_> )
     private
       type TCLSource_ = TCLSource <TCLContex_,TCLPlatfo_,TCLProgras_>;
       ///// メソッド
       function GetInfo<_TYPE_>( const Name_:T_cl_program_info ) :_TYPE_;
       function GetInfoSize( const Name_:T_cl_program_info ) :T_size_t;
       function GetInfos<_TYPE_>( const Name_:T_cl_program_info ) :TArray<_TYPE_>;
       function GetInfoString( const Name_:T_cl_program_info ) :String;
     protected
       _Handle  :T_cl_program;
       _Name    :String;
       _Source  :TCLSource_;
       _LangVer :TCLVersion;
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
       function CreateHandle :T_cl_int; virtual;
       function DestroHandle :T_cl_int; virtual;
     public
       constructor Create; override;
       destructor Destroy; override;
       ///// プロパティ
       property Contex  :TCLContex_   read GetOwnere                 ;
       property Progras :TCLProgras_  read GetParent                 ;
       property Handle  :T_cl_program read GetHandle  write SetHandle;
       property Name    :String       read   _Name    write   _Name  ;
       property Source  :TCLSource_   read   _Source                 ;
       property LangVer :TCLVersion   read   _LangVer                ;
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
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLLibrar<TCLContex_,TCLPlatfo_>

     TCLLibrar<TCLContex_,TCLPlatfo_:class> = class( TCLProgra<TCLContex_,TCLPlatfo_,TCLLibrars<TCLContex_,TCLPlatfo_>> )
     private
     protected
     public
       constructor Create( const Contex_:TCLContex_ ); overload; virtual;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLExecut<TCLContex_,TCLPlatfo_>

     TCLExecut<TCLContex_,TCLPlatfo_:class> = class( TCLProgra<TCLContex_,TCLPlatfo_,TCLExecuts<TCLContex_,TCLPlatfo_>> )
     private
       type TCLDevice_  = TCLDevice <TCLPlatfo_>;
            TCLExecut_  = TCLExecut <TCLContex_,TCLPlatfo_>;
            TCLBuildrs_ = TCLBuildrs<TCLContex_,TCLPlatfo_>;
            TCLBuildr_  = TCLBuildr <TCLContex_,TCLPlatfo_>;
            TCLKernels_ = TCLKernels<TCLExecut_,TCLContex_,TCLPlatfo_>;
     protected
       _Buildrs :TCLBuildrs_;
       _Kernels :TCLKernels_;
       ///// メソッド
       function DestroHandle :T_cl_int; override;
     public
       constructor Create; override;
       constructor Create( const Contex_:TCLContex_ ); overload; virtual;
       destructor Destroy; override;
       ///// プロパティ
       property Buildrs :TCLBuildrs_ read _Buildrs;
       property Kernels :TCLKernels_ read _Kernels;
       ///// メソッド
       function BuildTo( const Device_:TCLDevice_ ) :TCLBuildr_;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLProgras<TCLContex_,TCLPlatfo_,TCLProgra_>

     TCLProgras<TCLContex_,TCLPlatfo_,TCLProgra_:class> = class( TListParent<TCLContex_,TCLProgra_> )
     private
     protected
     public
       ///// プロパティ
       property Contex :TCLContex_ read GetOwnere;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLLibrars<TCLContex_,TCLPlatfo_>

     TCLLibrars<TCLContex_,TCLPlatfo_:class> = class( TCLProgras<TCLContex_,TCLPlatfo_,TCLLibrar<TCLContex_,TCLPlatfo_>> )
     private
       type TCLLibrar_ = TCLLibrar<TCLContex_,TCLPlatfo_>;
     protected
     public
       ///// メソッド
       function Add :TCLLibrar_; overload;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLExecuts<TCLContex_,TCLPlatfo_>

     TCLExecuts<TCLContex_,TCLPlatfo_:class> = class( TCLProgras<TCLContex_,TCLPlatfo_,TCLExecut<TCLContex_,TCLPlatfo_>> )
     private
       type TCLExecut_ = TCLExecut<TCLContex_,TCLPlatfo_>;
     protected
     public
       ///// メソッド
       function Add :TCLExecut_; overload;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses System.IOUtils, System.AnsiStrings,
     LUX.GPU.OpenCL;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLBuildr<TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

/////////////////////////////////////////////////////////////////////// メソッド

function TCLBuildr<TCLContex_,TCLPlatfo_>.GetInfo<_TYPE_>( const Handle_:T_cl_program; const Name_:T_cl_program_build_info ) :_TYPE_;
begin
     AssertCL( clGetProgramBuildInfo( Handle_, Device.Handle, Name_, SizeOf( _TYPE_ ), @Result, nil ), 'TCLBuildr.GetInfo is Error!' );
end;

function TCLBuildr<TCLContex_,TCLPlatfo_>.GetInfoSize( const Handle_:T_cl_program; const Name_:T_cl_program_build_info ) :T_size_t;
begin
     AssertCL( clGetProgramBuildInfo( Handle_, Device.Handle, Name_, 0, nil, @Result ), 'TCLBuildr.GetInfoSize is Error!' );
end;

function TCLBuildr<TCLContex_,TCLPlatfo_>.GetInfos<_TYPE_>( const Handle_:T_cl_program; const Name_:T_cl_program_build_info ) :TArray<_TYPE_>;
var
   S :T_size_t;
begin
     S := GetInfoSize( Handle_, Name_ );

     SetLength( Result, S div Cardinal( SizeOf( _TYPE_ ) ) );

     AssertCL( clGetProgramBuildInfo( Handle_, Device.Handle, Name_, S, @Result[ 0 ], nil ), 'TCLBuildr.GetInfos is Error!' );
end;

function TCLBuildr<TCLContex_,TCLPlatfo_>.GetInfoString( const Handle_:T_cl_program; const Name_:T_cl_program_build_info ) :String;
begin
     Result := TrimRight( String( P_char( GetInfos<T_char>( Handle_, Name_ ) ) ) );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLBuildr<TCLContex_,TCLPlatfo_>.GetHandle :T_cl_program;
begin
     if not Assigned( _Handle ) then CreateHandle;

     Result := _Handle;
end;

procedure TCLBuildr<TCLContex_,TCLPlatfo_>.SetHandle( const Handle_:T_cl_program );
begin
     if Assigned( _Handle ) then AssertCL( DestroHandle, 'TCLBuildr.DestroHandle is Error!' );

     _Handle := Handle_;
end;

/////////////////////////////////////////////////////////////////////// メソッド

function TCLBuildr<TCLContex_,TCLPlatfo_>.Compile :T_cl_int;
var
   DH :T_cl_device_id;
   Os :String;
   LHs :TArray<T_cl_program>;
   LNs :TArray<P_char>;
   Ls :TCLLibrars;
   L :TCLLibrar;
begin
     inherited;

     DH := Device.Handle;

     Os := '-cl-kernel-arg-info';
     if Ord( Execut.LangVer ) > 100 then Os := Os + ' -cl-std=CL' + Execut.LangVer.ToString;

     Ls := TCLExecut( Execut ).Contex.Librars;

     for L in Ls do
     begin
          LHs := LHs + [ L.Handle ];
          LNs := LNs + [ System.AnsiStrings.StrNew( P_char( AnsiString( L.Name ) ) ) ];
     end;

     Result := clCompileProgram( Execut.Handle,
                                 1, @DH,
                                 P_char( AnsiString( Os ) ),
                                 Ls.Count, @LHs[0], @LNs[0],
                                 nil, nil );

     _CompileStatus := GetInfo<T_cl_build_status>( Execut.Handle, CL_PROGRAM_BUILD_STATUS );
     _CompileLog    := GetInfoString             ( Execut.Handle, CL_PROGRAM_BUILD_LOG    );
end;

function TCLBuildr<TCLContex_,TCLPlatfo_>.Link :T_cl_int;
var
   DH :T_cl_device_id;
   EH :T_cl_program;
begin
     DH := Device.Handle;
     EH := Execut.Handle;

     _Handle := clLinkProgram( TCLExecut( Execut ).Contex.Handle,
                               1, @DH,
                               nil,
                               1, @EH,
                               nil, nil,
                               @Result );
end;

//------------------------------------------------------------------------------

function TCLBuildr<TCLContex_,TCLPlatfo_>.CreateHandle :T_cl_int;
begin
     Result := Compile;

     if Result = CL_SUCCESS then
     begin
          Result := Link;

          if Result = CL_SUCCESS then
          begin
               _LinkStatus := GetInfo<T_cl_build_status>( _Handle, CL_PROGRAM_BUILD_STATUS );
               _LinkLog    := GetInfoString             ( _Handle, CL_PROGRAM_BUILD_LOG    );
          end
          else
          begin
               _LinkStatus := CL_BUILD_NONE;
               _LinkLog    := '';
          end
     end;
end;

function TCLBuildr<TCLContex_,TCLPlatfo_>.DestroHandle :T_cl_int;
begin
     Result := clReleaseProgram( _Handle );

     _Handle := nil;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLBuildr<TCLContex_,TCLPlatfo_>.Create;
begin
     inherited;

     _Handle := nil;

     _CompileStatus := CL_BUILD_NONE;
     _CompileLog    := '';
     _LinkStatus    := CL_BUILD_NONE;
     _LinkLog       := '';
end;

constructor TCLBuildr<TCLContex_,TCLPlatfo_>.Create( const Buildrs_:TCLBuildrs_; const Device_:TCLDevice_ );
begin
     inherited Create( Buildrs_ );

     _Device := Device_;
end;

destructor TCLBuildr<TCLContex_,TCLPlatfo_>.Destroy;
begin
      Handle := nil;

     inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLBuildrs<TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLBuildrs<TCLContex_,TCLPlatfo_>.GetBuildrs( const Device_:TCLDevice_ ) :TCLBuildr_;
begin
     if _DevDeps.ContainsKey( Device_ ) then Result := _DevDeps[ Device_ ]
                                        else Result := TCLBuildr_.Create( Self, Device_ );
end;

/////////////////////////////////////////////////////////////////////// イベント

procedure TCLBuildrs<TCLContex_,TCLPlatfo_>.OnInsertChild( const Childr_:TCLBuildr_ );
begin
     inherited;

     _DevDeps.Add( Childr_.Device, Childr_ );
end;

procedure TCLBuildrs<TCLContex_,TCLPlatfo_>.OnRemoveChild( const Childr_:TCLBuildr_ );
begin
     inherited;

     _DevDeps.Remove( Childr_.Device );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLBuildrs<TCLContex_,TCLPlatfo_>.Create;
begin
     inherited;

     _DevDeps := TCLDevDeps.Create;
end;

destructor TCLBuildrs<TCLContex_,TCLPlatfo_>.Destroy;
begin
     Clear;

     _DevDeps.Free;

     inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLSource<TCLContex_,TCLPlatfo_,TCLProgras_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLSource<TCLContex_,TCLPlatfo_,TCLProgras_>.Changed;
begin
     inherited;

     _Progra.Handle := nil;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLSource<TCLContex_,TCLPlatfo_,TCLProgras_>.Create;
begin
     inherited;

end;

constructor TCLSource<TCLContex_,TCLPlatfo_,TCLProgras_>.Create( const Progra_:TCLProgra_ );
begin
     Create;

     _Progra := Progra_;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLSource<TCLContex_,TCLPlatfo_,TCLProgras_>.LoadFromFile( const FileName_:String );
begin
     inherited;

     Progra.Name := TPath.GetFileName( FileName_ );
end;

procedure TCLSource<TCLContex_,TCLPlatfo_,TCLProgras_>.LoadFromFile( const FileName_:String; Encoding_:TEncoding );
begin
     inherited;

     Progra.Name := TPath.GetFileName( FileName_ );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLProgra<TCLContex_,TCLPlatfo_,TCLProgras_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

/////////////////////////////////////////////////////////////////////// メソッド

function TCLProgra<TCLContex_,TCLPlatfo_,TCLProgras_>.GetInfo<_TYPE_>( const Name_:T_cl_program_info ) :_TYPE_;
begin
     AssertCL( clGetProgramInfo( Handle, Name_, SizeOf( _TYPE_ ), @Result, nil ), 'TCLProgra.GetInfo is Error!' );
end;

function TCLProgra<TCLContex_,TCLPlatfo_,TCLProgras_>.GetInfoSize( const Name_:T_cl_program_info ) :T_size_t;
begin
     AssertCL( clGetProgramInfo( Handle, Name_, 0, nil, @Result ), 'TCLProgra.GetInfoSize is Error!' );
end;

function TCLProgra<TCLContex_,TCLPlatfo_,TCLProgras_>.GetInfos<_TYPE_>( const Name_:T_cl_program_info ) :TArray<_TYPE_>;
var
   S :T_size_t;
begin
     S := GetInfoSize( Name_ );

     SetLength( Result, S div Cardinal( SizeOf( _TYPE_ ) ) );

     AssertCL( clGetProgramInfo( Handle, Name_, S, @Result[ 0 ], nil ), 'TCLProgra.GetInfos is Error!' );
end;

function TCLProgra<TCLContex_,TCLPlatfo_,TCLProgras_>.GetInfoString( const Name_:T_cl_program_info ) :String;
begin
     Result := TrimRight( String( P_char( GetInfos<T_char>( Name_ ) ) ) );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLProgra<TCLContex_,TCLPlatfo_,TCLProgras_>.GetHandle :T_cl_program;
begin
     if not Assigned( _Handle ) then CreateHandle;

     Result := _Handle;
end;

procedure TCLProgra<TCLContex_,TCLPlatfo_,TCLProgras_>.SetHandle( const Handle_:T_cl_program );
begin
     if Assigned( _Handle ) then AssertCL( DestroHandle, 'TCLProgra.DestroHandle is Error!' );

     _Handle := Handle_;
end;

//---------------------------------------------------------(* cl_program_info *)

function TCLProgra<TCLContex_,TCLPlatfo_,TCLProgras_>.GetPROGRAM_REFERENCE_COUNT :T_cl_uint; begin Result := GetInfo<T_cl_uint>( CL_PROGRAM_REFERENCE_COUNT ); end;
function TCLProgra<TCLContex_,TCLPlatfo_,TCLProgras_>.GetPROGRAM_CONTEXT :T_cl_context; begin Result := GetInfo<T_cl_context>( CL_PROGRAM_CONTEXT ); end;
function TCLProgra<TCLContex_,TCLPlatfo_,TCLProgras_>.GetPROGRAM_NUM_DEVICES :T_cl_uint; begin Result := GetInfo<T_cl_uint>( CL_PROGRAM_NUM_DEVICES ); end;
function TCLProgra<TCLContex_,TCLPlatfo_,TCLProgras_>.GetPROGRAM_DEVICES :TArray<T_cl_device_id>; begin Result := GetInfos<T_cl_device_id>( CL_PROGRAM_DEVICES ); end;
function TCLProgra<TCLContex_,TCLPlatfo_,TCLProgras_>.GetPROGRAM_SOURCE :String; begin Result := GetInfoString( CL_PROGRAM_SOURCE ); end;
function TCLProgra<TCLContex_,TCLPlatfo_,TCLProgras_>.GetPROGRAM_BINARY_SIZES :TArray<T_size_t>; begin Result := GetInfos<T_size_t>( CL_PROGRAM_BINARY_SIZES ); end;
function TCLProgra<TCLContex_,TCLPlatfo_,TCLProgras_>.GetPROGRAM_BINARIES :TArray<P_unsigned_char>; begin Result := GetInfos<P_unsigned_char>( CL_PROGRAM_BINARIES ); end;
{$IF CL_VERSION_1_2 <> 0 }
function TCLProgra<TCLContex_,TCLPlatfo_,TCLProgras_>.GetPROGRAM_NUM_KERNELS :T_size_t; begin Result := GetInfo<T_size_t>( CL_PROGRAM_NUM_KERNELS ); end;
function TCLProgra<TCLContex_,TCLPlatfo_,TCLProgras_>.GetPROGRAM_KERNEL_NAMES :String; begin Result := GetInfoString( CL_PROGRAM_KERNEL_NAMES ); end;
{$ENDIF}
{$IF CL_VERSION_2_1 <> 0 }
function TCLProgra<TCLContex_,TCLPlatfo_,TCLProgras_>.GetPROGRAM_IL :String; begin Result := GetInfoString( CL_PROGRAM_IL ); end;
{$ENDIF}
{$IF CL_VERSION_2_2 <> 0 }
function TCLProgra<TCLContex_,TCLPlatfo_,TCLProgras_>.GetPROGRAM_SCOPE_GLOBAL_CTORS_PRESENT :T_cl_bool; begin Result := GetInfo<T_cl_bool>( CL_PROGRAM_SCOPE_GLOBAL_CTORS_PRESENT ); end;
function TCLProgra<TCLContex_,TCLPlatfo_,TCLProgras_>.GetPROGRAM_SCOPE_GLOBAL_DTORS_PRESENT :T_cl_bool; begin Result := GetInfo<T_cl_bool>( CL_PROGRAM_SCOPE_GLOBAL_DTORS_PRESENT ); end;
{$ENDIF}

/////////////////////////////////////////////////////////////////////// メソッド

function TCLProgra<TCLContex_,TCLPlatfo_,TCLProgras_>.CreateHandle :T_cl_int;
var
   C :P_char;
begin
     C := P_char( AnsiString( _Source.Text ) );

     _Handle := clCreateProgramWithSource( TCLContex( Contex ).Handle, 1, @C, nil, @Result );
end;

function TCLProgra<TCLContex_,TCLPlatfo_,TCLProgras_>.DestroHandle :T_cl_int;
begin
     Result := clReleaseProgram( _Handle );

     _Handle := nil;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLProgra<TCLContex_,TCLPlatfo_,TCLProgras_>.Create;
begin
     inherited;

     _Source := TCLSource_ .Create( Self );

     _Handle := nil;

     _LangVer := TCLVersion.From( '3.0' );
end;

destructor TCLProgra<TCLContex_,TCLPlatfo_,TCLProgras_>.Destroy;
begin
      Handle := nil;

     _Source.Free;

     inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLLibrar<TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLLibrar<TCLContex_,TCLPlatfo_>.Create( const Contex_:TCLContex_ );
begin
     inherited Create( TCLContex( Contex_ ).Librars );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLExecut<TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// メソッド

function TCLExecut<TCLContex_,TCLPlatfo_>.DestroHandle :T_cl_int;
begin
     _Buildrs.Clear;

     inherited;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLExecut<TCLContex_,TCLPlatfo_>.Create;
begin
     inherited;

     _Buildrs := TCLBuildrs_.Create( Self );
     _Kernels := TCLKernels_.Create( Self );
end;

constructor TCLExecut<TCLContex_,TCLPlatfo_>.Create( const Contex_:TCLContex_ );
begin
     inherited Create( TCLContex( Contex_ ).Executs );
end;

destructor TCLExecut<TCLContex_,TCLPlatfo_>.Destroy;
begin
     _Kernels.Free;
     _Buildrs.Free;

     inherited;
end;

/////////////////////////////////////////////////////////////////////// メソッド

function TCLExecut<TCLContex_,TCLPlatfo_>.BuildTo( const Device_:TCLDevice_ ) :TCLBuildr_;
begin
     Result := Buildrs[ Device_ ];
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLProgras<TCLContex_,TCLPlatfo_,TCLProgra_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLLibrars<TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

function TCLLibrars<TCLContex_,TCLPlatfo_>.Add :TCLLibrar_;
begin
     Result := TCLLibrar_.Create( Contex );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLExecuts<TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

function TCLExecuts<TCLContex_,TCLPlatfo_>.Add :TCLExecut_;
begin
     Result := TCLExecut_.Create( Contex );
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

end. //######################################################################### ■
