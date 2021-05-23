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

     TCLProgras   <TCLSystem_,TCLPlatfo_,TCLContex_,TCLProgra_ :class> = class;
       TCLProgra  <TCLSystem_,TCLPlatfo_,TCLContex_,TCLProgras_:class> = class;
         TCLSource<TCLSystem_,TCLPlatfo_,TCLContex_,TCLProgras_:class> = class;

     TCLLibrars <TCLSystem_,TCLPlatfo_,TCLContex_:class> = class;
       TCLLibrar<TCLSystem_,TCLPlatfo_,TCLContex_:class> = class;

     TCLExecuts     <TCLSystem_,TCLPlatfo_,TCLContex_:class> = class;
       TCLExecut    <TCLSystem_,TCLPlatfo_,TCLContex_:class> = class;
         TCLBuildrs <TCLSystem_,TCLPlatfo_,TCLContex_:class> = class;
           TCLBuildr<TCLSystem_,TCLPlatfo_,TCLContex_:class> = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLBuildr<TCLSystem_,TCLPlatfo_,TCLContex_>

     TCLBuildr<TCLSystem_,TCLPlatfo_,TCLContex_:class> = class( TListChildr<TCLExecut <TCLSystem_,TCLPlatfo_,TCLContex_>,
                                                                            TCLBuildrs<TCLSystem_,TCLPlatfo_,TCLContex_>> )
     private
       type TCLDevice_  = TCLDevice <TCLSystem_,TCLPlatfo_>;
            TCLLibrars_ = TCLLibrars<TCLSystem_,TCLPlatfo_,TCLContex_>;
            TCLLibrar_  = TCLLibrar <TCLSystem_,TCLPlatfo_,TCLContex_>;
            TCLExecut_  = TCLExecut <TCLSystem_,TCLPlatfo_,TCLContex_>;
            TCLBuildrs_ = TCLBuildrs<TCLSystem_,TCLPlatfo_,TCLContex_>;
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

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLBuildrs<TCLSystem_,TCLPlatfo_,TCLContex_>

     TCLBuildrs<TCLSystem_,TCLPlatfo_,TCLContex_:class> = class( TListParent<TCLExecut<TCLSystem_,TCLPlatfo_,TCLContex_>,
                                                                             TCLBuildr<TCLSystem_,TCLPlatfo_,TCLContex_>> )
     private
       type TCLDevice_  = TCLDevice<TCLSystem_,TCLPlatfo_>;
            TCLExecut_  = TCLExecut<TCLSystem_,TCLPlatfo_,TCLContex_>;
            TCLBuildr_  = TCLBuildr<TCLSystem_,TCLPlatfo_,TCLContex_>;
            TCLDevBuis_ = TDictionary<TCLDevice_,TCLBuildr_>;
     protected
       _DevBuis :TCLDevBuis_;
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

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLSource<TCLSystem_,TCLPlatfo_,TCLContex_,TCLProgras_>

     TCLSource<TCLSystem_,TCLPlatfo_,TCLContex_,TCLProgras_:class> = class( TStringList )
     private
       type TCLProgra_ = TCLProgra<TCLSystem_,TCLPlatfo_,TCLContex_,TCLProgras_>;
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

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLProgra<TCLSystem_,TCLPlatfo_,TCLContex_,TCLProgras_>

     TCLProgra<TCLSystem_,TCLPlatfo_,TCLContex_,TCLProgras_:class> = class( TListChildr<TCLContex_,TCLProgras_> )
     private
       type TCLSource_ = TCLSource<TCLSystem_,TCLPlatfo_,TCLContex_,TCLProgras_>;
       ///// メソッド
       function GetInfo<_TYPE_>( const Name_:T_cl_program_info ) :_TYPE_;
       function GetInfoSize( const Name_:T_cl_program_info ) :T_size_t;
       function GetInfos<_TYPE_>( const Name_:T_cl_program_info ) :TArray<_TYPE_>;
       function GetInfoString( const Name_:T_cl_program_info ) :String;
     protected
       _Handle :T_cl_program;
       _Name   :String;
       _Source :TCLSource_;
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
       property Contex  :TCLContex_   read GetOwnere                ;
       property Progras :TCLProgras_  read GetParent                ;
       property Handle  :T_cl_program read GetHandle write SetHandle;
       property Name    :String       read   _Name   write   _Name  ;
       property Source  :TCLSource_   read   _Source                ;
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

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLLibrar<TCLSystem_,TCLPlatfo_,TCLContex_>

     TCLLibrar<TCLSystem_,TCLPlatfo_,TCLContex_:class> = class( TCLProgra<TCLSystem_,TCLPlatfo_,TCLContex_,TCLLibrars<TCLSystem_,TCLPlatfo_,TCLContex_>> )
     private
       type TCLLibrars_ = TCLLibrars<TCLSystem_,TCLPlatfo_,TCLContex_>;
     protected
     public
       constructor Create( const Contex_:TCLContex_ ); overload; virtual;
       ///// プロパティ
       property Librars :TCLLibrars_ read GetParent;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLExecut<TCLSystem_,TCLPlatfo_,TCLContex_>

     TCLExecut<TCLSystem_,TCLPlatfo_,TCLContex_:class> = class( TCLProgra<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecuts<TCLSystem_,TCLPlatfo_,TCLContex_>> )
     private
       type TCLDevice_  = TCLDevice <TCLSystem_,TCLPlatfo_>;
            TCLExecuts_ = TCLExecuts<TCLSystem_,TCLPlatfo_,TCLContex_>;
            TCLExecut_  = TCLExecut <TCLSystem_,TCLPlatfo_,TCLContex_>;
            TCLBuildrs_ = TCLBuildrs<TCLSystem_,TCLPlatfo_,TCLContex_>;
            TCLBuildr_  = TCLBuildr <TCLSystem_,TCLPlatfo_,TCLContex_>;
            TCLKernels_ = TCLKernels<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>;
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
       property Executs :TCLExecuts_ read GetParent ;
       property Buildrs :TCLBuildrs_ read   _Buildrs;
       property Kernels :TCLKernels_ read   _Kernels;
       ///// メソッド
       function BuildTo( const Device_:TCLDevice_ ) :TCLBuildr_;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLProgras<TCLSystem_,TCLPlatfo_,TCLContex_,TCLProgra_>

     TCLProgras<TCLSystem_,TCLPlatfo_,TCLContex_,TCLProgra_:class> = class( TListParent<TCLContex_,TCLProgra_> )
     private
     protected
     public
       ///// プロパティ
       property Contex :TCLContex_ read GetOwnere;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLLibrars<TCLSystem_,TCLPlatfo_,TCLContex_>

     TCLLibrars<TCLSystem_,TCLPlatfo_,TCLContex_:class> = class( TCLProgras<TCLSystem_,TCLPlatfo_,TCLContex_,TCLLibrar<TCLSystem_,TCLPlatfo_,TCLContex_>> )
     private
       type TCLLibrar_ = TCLLibrar<TCLSystem_,TCLPlatfo_,TCLContex_>;
     protected
     public
       ///// メソッド
       function Add :TCLLibrar_; overload;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLExecuts<TCLSystem_,TCLPlatfo_,TCLContex_>

     TCLExecuts<TCLSystem_,TCLPlatfo_,TCLContex_:class> = class( TCLProgras<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut<TCLSystem_,TCLPlatfo_,TCLContex_>> )
     private
       type TCLExecut_ = TCLExecut<TCLSystem_,TCLPlatfo_,TCLContex_>;
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
     LUX.GPU.OpenCL.Contex;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLBuildr<TCLSystem_,TCLPlatfo_,TCLContex_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

/////////////////////////////////////////////////////////////////////// メソッド

function TCLBuildr<TCLSystem_,TCLPlatfo_,TCLContex_>.GetInfo<_TYPE_>( const Handle_:T_cl_program; const Name_:T_cl_program_build_info ) :_TYPE_;
begin
     AssertCL( clGetProgramBuildInfo( Handle_, Device.Handle, Name_, SizeOf( _TYPE_ ), @Result, nil ), 'TCLBuildr.GetInfo is Error!' );
end;

function TCLBuildr<TCLSystem_,TCLPlatfo_,TCLContex_>.GetInfoSize( const Handle_:T_cl_program; const Name_:T_cl_program_build_info ) :T_size_t;
begin
     AssertCL( clGetProgramBuildInfo( Handle_, Device.Handle, Name_, 0, nil, @Result ), 'TCLBuildr.GetInfoSize is Error!' );
end;

function TCLBuildr<TCLSystem_,TCLPlatfo_,TCLContex_>.GetInfos<_TYPE_>( const Handle_:T_cl_program; const Name_:T_cl_program_build_info ) :TArray<_TYPE_>;
var
   S :T_size_t;
begin
     S := GetInfoSize( Handle_, Name_ );

     SetLength( Result, S div Cardinal( SizeOf( _TYPE_ ) ) );

     AssertCL( clGetProgramBuildInfo( Handle_, Device.Handle, Name_, S, @Result[ 0 ], nil ), 'TCLBuildr.GetInfos is Error!' );
end;

function TCLBuildr<TCLSystem_,TCLPlatfo_,TCLContex_>.GetInfoString( const Handle_:T_cl_program; const Name_:T_cl_program_build_info ) :String;
begin
     Result := TrimRight( String( P_char( GetInfos<T_char>( Handle_, Name_ ) ) ) );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLBuildr<TCLSystem_,TCLPlatfo_,TCLContex_>.GetHandle :T_cl_program;
begin
     if not Assigned( _Handle ) then CreateHandle;

     Result := _Handle;
end;

procedure TCLBuildr<TCLSystem_,TCLPlatfo_,TCLContex_>.SetHandle( const Handle_:T_cl_program );
begin
     if Assigned( _Handle ) then AssertCL( DestroHandle, 'TCLBuildr.DestroHandle is Error!' );

     _Handle := Handle_;
end;

/////////////////////////////////////////////////////////////////////// メソッド

function TCLBuildr<TCLSystem_,TCLPlatfo_,TCLContex_>.Compile :T_cl_int;
var
   DH :T_cl_device_id;
   Os :String;
   LHs :TArray<T_cl_program>;
   LNs :TArray<P_char>;
   Ls :TCLLibrars_;
   L :TCLLibrar_;
begin
     inherited;

     DH := Device.Handle;

     Os := '-cl-kernel-arg-info';
     if Ord( Device.LanVer ) > 100 then Os := Os + ' -cl-std=CL' + Device.LanVer.ToString;

     Ls := TCLLibrars_( TCLContex<TCLSystem_,TCLPlatfo_>( Execut.Contex ).Librars );

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

function TCLBuildr<TCLSystem_,TCLPlatfo_,TCLContex_>.Link :T_cl_int;
var
   DH :T_cl_device_id;
   EH :T_cl_program;
begin
     DH := Device.Handle;
     EH := Execut.Handle;

     _Handle := clLinkProgram( TCLContex<TCLSystem_,TCLPlatfo_>( Execut.Contex ).Handle,
                               1, @DH,
                               nil,
                               1, @EH,
                               nil, nil,
                               @Result );
end;

//------------------------------------------------------------------------------

function TCLBuildr<TCLSystem_,TCLPlatfo_,TCLContex_>.CreateHandle :T_cl_int;
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
          end;
     end;
end;

function TCLBuildr<TCLSystem_,TCLPlatfo_,TCLContex_>.DestroHandle :T_cl_int;
begin
     Result := clReleaseProgram( _Handle );

     _Handle := nil;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLBuildr<TCLSystem_,TCLPlatfo_,TCLContex_>.Create;
begin
     inherited;

     _Handle := nil;

     _CompileStatus := CL_BUILD_NONE;
     _CompileLog    := '';
     _LinkStatus    := CL_BUILD_NONE;
     _LinkLog       := '';
end;

constructor TCLBuildr<TCLSystem_,TCLPlatfo_,TCLContex_>.Create( const Buildrs_:TCLBuildrs_; const Device_:TCLDevice_ );
begin
     inherited Create( Buildrs_ );

     _Device := Device_;
end;

destructor TCLBuildr<TCLSystem_,TCLPlatfo_,TCLContex_>.Destroy;
begin
      Handle := nil;

     inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLBuildrs<TCLSystem_,TCLPlatfo_,TCLContex_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLBuildrs<TCLSystem_,TCLPlatfo_,TCLContex_>.GetBuildrs( const Device_:TCLDevice_ ) :TCLBuildr_;
begin
     if _DevBuis.ContainsKey( Device_ ) then Result := _DevBuis[ Device_ ]
                                        else Result := TCLBuildr_.Create( Self, Device_ );
end;

/////////////////////////////////////////////////////////////////////// イベント

procedure TCLBuildrs<TCLSystem_,TCLPlatfo_,TCLContex_>.OnInsertChild( const Childr_:TCLBuildr_ );
begin
     inherited;

     _DevBuis.Add( Childr_.Device, Childr_ );
end;

procedure TCLBuildrs<TCLSystem_,TCLPlatfo_,TCLContex_>.OnRemoveChild( const Childr_:TCLBuildr_ );
begin
     inherited;

     _DevBuis.Remove( Childr_.Device );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLBuildrs<TCLSystem_,TCLPlatfo_,TCLContex_>.Create;
begin
     inherited;

     _DevBuis := TCLDevBuis_.Create;
end;

destructor TCLBuildrs<TCLSystem_,TCLPlatfo_,TCLContex_>.Destroy;
begin
     Clear;

     _DevBuis.Free;

     inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLSource<TCLSystem_,TCLPlatfo_,TCLContex_,TCLProgras_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLSource<TCLSystem_,TCLPlatfo_,TCLContex_,TCLProgras_>.Changed;
begin
     inherited;

     _Progra.Handle := nil;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLSource<TCLSystem_,TCLPlatfo_,TCLContex_,TCLProgras_>.Create;
begin
     inherited;

end;

constructor TCLSource<TCLSystem_,TCLPlatfo_,TCLContex_,TCLProgras_>.Create( const Progra_:TCLProgra_ );
begin
     Create;

     _Progra := Progra_;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLSource<TCLSystem_,TCLPlatfo_,TCLContex_,TCLProgras_>.LoadFromFile( const FileName_:String );
begin
     inherited;

     Progra.Name := TPath.GetFileName( FileName_ );
end;

procedure TCLSource<TCLSystem_,TCLPlatfo_,TCLContex_,TCLProgras_>.LoadFromFile( const FileName_:String; Encoding_:TEncoding );
begin
     inherited;

     Progra.Name := TPath.GetFileName( FileName_ );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLProgra<TCLSystem_,TCLPlatfo_,TCLContex_,TCLProgras_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

/////////////////////////////////////////////////////////////////////// メソッド

function TCLProgra<TCLSystem_,TCLPlatfo_,TCLContex_,TCLProgras_>.GetInfo<_TYPE_>( const Name_:T_cl_program_info ) :_TYPE_;
begin
     AssertCL( clGetProgramInfo( Handle, Name_, SizeOf( _TYPE_ ), @Result, nil ), 'TCLProgra.GetInfo is Error!' );
end;

function TCLProgra<TCLSystem_,TCLPlatfo_,TCLContex_,TCLProgras_>.GetInfoSize( const Name_:T_cl_program_info ) :T_size_t;
begin
     AssertCL( clGetProgramInfo( Handle, Name_, 0, nil, @Result ), 'TCLProgra.GetInfoSize is Error!' );
end;

function TCLProgra<TCLSystem_,TCLPlatfo_,TCLContex_,TCLProgras_>.GetInfos<_TYPE_>( const Name_:T_cl_program_info ) :TArray<_TYPE_>;
var
   S :T_size_t;
begin
     S := GetInfoSize( Name_ );

     SetLength( Result, S div Cardinal( SizeOf( _TYPE_ ) ) );

     AssertCL( clGetProgramInfo( Handle, Name_, S, @Result[ 0 ], nil ), 'TCLProgra.GetInfos is Error!' );
end;

function TCLProgra<TCLSystem_,TCLPlatfo_,TCLContex_,TCLProgras_>.GetInfoString( const Name_:T_cl_program_info ) :String;
begin
     Result := TrimRight( String( P_char( GetInfos<T_char>( Name_ ) ) ) );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLProgra<TCLSystem_,TCLPlatfo_,TCLContex_,TCLProgras_>.GetHandle :T_cl_program;
begin
     if not Assigned( _Handle ) then CreateHandle;

     Result := _Handle;
end;

procedure TCLProgra<TCLSystem_,TCLPlatfo_,TCLContex_,TCLProgras_>.SetHandle( const Handle_:T_cl_program );
begin
     if Assigned( _Handle ) then AssertCL( DestroHandle, 'TCLProgra.DestroHandle is Error!' );

     _Handle := Handle_;
end;

//---------------------------------------------------------(* cl_program_info *)

function TCLProgra<TCLSystem_,TCLPlatfo_,TCLContex_,TCLProgras_>.GetPROGRAM_REFERENCE_COUNT :T_cl_uint; begin Result := GetInfo<T_cl_uint>( CL_PROGRAM_REFERENCE_COUNT ); end;
function TCLProgra<TCLSystem_,TCLPlatfo_,TCLContex_,TCLProgras_>.GetPROGRAM_CONTEXT :T_cl_context; begin Result := GetInfo<T_cl_context>( CL_PROGRAM_CONTEXT ); end;
function TCLProgra<TCLSystem_,TCLPlatfo_,TCLContex_,TCLProgras_>.GetPROGRAM_NUM_DEVICES :T_cl_uint; begin Result := GetInfo<T_cl_uint>( CL_PROGRAM_NUM_DEVICES ); end;
function TCLProgra<TCLSystem_,TCLPlatfo_,TCLContex_,TCLProgras_>.GetPROGRAM_DEVICES :TArray<T_cl_device_id>; begin Result := GetInfos<T_cl_device_id>( CL_PROGRAM_DEVICES ); end;
function TCLProgra<TCLSystem_,TCLPlatfo_,TCLContex_,TCLProgras_>.GetPROGRAM_SOURCE :String; begin Result := GetInfoString( CL_PROGRAM_SOURCE ); end;
function TCLProgra<TCLSystem_,TCLPlatfo_,TCLContex_,TCLProgras_>.GetPROGRAM_BINARY_SIZES :TArray<T_size_t>; begin Result := GetInfos<T_size_t>( CL_PROGRAM_BINARY_SIZES ); end;
function TCLProgra<TCLSystem_,TCLPlatfo_,TCLContex_,TCLProgras_>.GetPROGRAM_BINARIES :TArray<P_unsigned_char>; begin Result := GetInfos<P_unsigned_char>( CL_PROGRAM_BINARIES ); end;
{$IF CL_VERSION_1_2 <> 0 }
function TCLProgra<TCLSystem_,TCLPlatfo_,TCLContex_,TCLProgras_>.GetPROGRAM_NUM_KERNELS :T_size_t; begin Result := GetInfo<T_size_t>( CL_PROGRAM_NUM_KERNELS ); end;
function TCLProgra<TCLSystem_,TCLPlatfo_,TCLContex_,TCLProgras_>.GetPROGRAM_KERNEL_NAMES :String; begin Result := GetInfoString( CL_PROGRAM_KERNEL_NAMES ); end;
{$ENDIF}
{$IF CL_VERSION_2_1 <> 0 }
function TCLProgra<TCLSystem_,TCLPlatfo_,TCLContex_,TCLProgras_>.GetPROGRAM_IL :String; begin Result := GetInfoString( CL_PROGRAM_IL ); end;
{$ENDIF}
{$IF CL_VERSION_2_2 <> 0 }
function TCLProgra<TCLSystem_,TCLPlatfo_,TCLContex_,TCLProgras_>.GetPROGRAM_SCOPE_GLOBAL_CTORS_PRESENT :T_cl_bool; begin Result := GetInfo<T_cl_bool>( CL_PROGRAM_SCOPE_GLOBAL_CTORS_PRESENT ); end;
function TCLProgra<TCLSystem_,TCLPlatfo_,TCLContex_,TCLProgras_>.GetPROGRAM_SCOPE_GLOBAL_DTORS_PRESENT :T_cl_bool; begin Result := GetInfo<T_cl_bool>( CL_PROGRAM_SCOPE_GLOBAL_DTORS_PRESENT ); end;
{$ENDIF}

/////////////////////////////////////////////////////////////////////// メソッド

function TCLProgra<TCLSystem_,TCLPlatfo_,TCLContex_,TCLProgras_>.CreateHandle :T_cl_int;
var
   C :P_char;
begin
     C := P_char( AnsiString( _Source.Text ) );

     _Handle := clCreateProgramWithSource( TCLContex<TCLSystem_,TCLPlatfo_>( Contex ).Handle, 1, @C, nil, @Result );
end;

function TCLProgra<TCLSystem_,TCLPlatfo_,TCLContex_,TCLProgras_>.DestroHandle :T_cl_int;
begin
     Result := clReleaseProgram( _Handle );

     _Handle := nil;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLProgra<TCLSystem_,TCLPlatfo_,TCLContex_,TCLProgras_>.Create;
begin
     inherited;

     _Source := TCLSource_.Create( Self );

     _Handle := nil;
end;

destructor TCLProgra<TCLSystem_,TCLPlatfo_,TCLContex_,TCLProgras_>.Destroy;
begin
      Handle := nil;

     _Source.Free;

     inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLLibrar<TCLSystem_,TCLPlatfo_,TCLContex_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLLibrar<TCLSystem_,TCLPlatfo_,TCLContex_>.Create( const Contex_:TCLContex_ );
begin
     inherited Create( TCLContex<TCLSystem_,TCLPlatfo_>( Contex_ ).Librars );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLExecut<TCLSystem_,TCLPlatfo_,TCLContex_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// メソッド

function TCLExecut<TCLSystem_,TCLPlatfo_,TCLContex_>.DestroHandle :T_cl_int;
begin
     _Buildrs.Clear;

     inherited;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLExecut<TCLSystem_,TCLPlatfo_,TCLContex_>.Create;
begin
     inherited;

     _Buildrs := TCLBuildrs_.Create( Self );
     _Kernels := TCLKernels_.Create( Self );
end;

constructor TCLExecut<TCLSystem_,TCLPlatfo_,TCLContex_>.Create( const Contex_:TCLContex_ );
begin
     inherited Create( TCLContex<TCLSystem_,TCLPlatfo_>( Contex_ ).Executs );
end;

destructor TCLExecut<TCLSystem_,TCLPlatfo_,TCLContex_>.Destroy;
begin
     _Kernels.Free;
     _Buildrs.Free;

     inherited;
end;

/////////////////////////////////////////////////////////////////////// メソッド

function TCLExecut<TCLSystem_,TCLPlatfo_,TCLContex_>.BuildTo( const Device_:TCLDevice_ ) :TCLBuildr_;
begin
     Result := Buildrs[ Device_ ];
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLProgras<TCLSystem_,TCLPlatfo_,TCLContex_,TCLProgra_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLLibrars<TCLSystem_,TCLPlatfo_,TCLContex_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

function TCLLibrars<TCLSystem_,TCLPlatfo_,TCLContex_>.Add :TCLLibrar_;
begin
     Result := TCLLibrar_.Create( Contex );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLExecuts<TCLSystem_,TCLPlatfo_,TCLContex_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

function TCLExecuts<TCLSystem_,TCLPlatfo_,TCLContex_>.Add :TCLExecut_;
begin
     Result := TCLExecut_.Create( Contex );
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

end. //######################################################################### ■
