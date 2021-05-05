unit LUX.GPU.OpenCL.Platfo;

interface //#################################################################### ■

uses System.Classes,
     cl_version, cl_platform, cl,
     LUX.Data.List,
     LUX.Code.C,
     LUX.GPU.OpenCL.root,
     LUX.GPU.OpenCL.Device,
     LUX.GPU.OpenCL.Contex;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TCLPlatfos    <TCLOpenCL_:class> = class;
       TCLPlatfo   <TCLOpenCL_:class> = class;
         TCLExtenss<TCLPlatfo_:class> = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLExtenss<TCLPlatfo_>

     TCLExtenss<TCLPlatfo_:class> = class( TStringList )
     private
     protected
     public
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLPlatfo<TCLOpenCL_>

     TCLPlatfo<TCLOpenCL_:class> = class( TListChildr<TCLOpenCL_,TCLPlatfos<TCLOpenCL_>> )
     private
       type TCLPlatfos_ = TCLPlatfos<TCLOpenCL_>;
            TCLPlatfo_  = TCLPlatfo <TCLOpenCL_>;
            TCLExtenss_ = TCLExtenss<TCLPlatfo_>;
            TCLDevices_ = TCLDevices<TCLPlatfo_>;
            TCLContexs_ = TCLContexs<TCLPlatfo_>;
       ///// メソッド
       function GetInfo<_TYPE_>( const Name_:T_cl_platform_info ) :_TYPE_;
       function GetInfoSize( const Name_:T_cl_platform_info ) :T_size_t;
       function GetInfos<_TYPE_>( const Name_:T_cl_platform_info ) :TArray<_TYPE_>;
       function GetInfoString( const Name_:T_cl_platform_info ) :String;
     protected
       _Handle  :T_cl_platform_id;
       _Extenss :TCLExtenss_;
       _Devices :TCLDevices_;
       _Contexs :TCLContexs_;
       ///// アクセス
       function GetProfile :String;
       function GetVersion :String;
       function GetName :String;
       function GetVendor :String;
       {$IF CL_VERSION_2_1 <> 0 }
       function GetHostTimerResolution :T_cl_ulong;
       {$ENDIF}
       {$IF CL_VERSION_3_0 <> 0 }
       function GetNumericVersion :T_cl_version;
       function GetExtensionsWithVersion :TArray<T_cl_name_version>;
       {$ENDIF}
     public
       constructor Create; override;
       constructor Create( const Platfos_:TCLPlatfos_; const Handle_:T_cl_platform_id ); overload; virtual;
       destructor Destroy; override;
       ///// プロパティ
       property OpenCL                :TCLOpenCL_                read GetOwnere               ;
       property Platfos               :TCLPlatfos_               read GetParent               ;
       property Handle                :T_cl_platform_id          read   _Handle               ;
       property Profile               :String                    read GetProfile              ;
       property Version               :String                    read GetVersion              ;
       property Name                  :String                    read GetName                 ;
       property Vendor                :String                    read GetVendor               ;
       property Extenss               :TCLExtenss_               read   _Extenss              ;
       {$IF CL_VERSION_2_1 <> 0 }
       property HostTimerResolution   :T_cl_ulong                read GetHostTimerResolution  ;
       {$ENDIF}
       {$IF CL_VERSION_3_0 <> 0 }
       property NumericVersion        :T_cl_version              read GetNumericVersion       ;
       property ExtensionsWithVersion :TArray<T_cl_name_version> read GetExtensionsWithVersion;
       {$ENDIF}
       property Devices               :TCLDevices_               read   _Devices              ;
       property Contexs               :TCLContexs_               read   _Contexs              ;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLPlatfos<TCLOpenCL_>

     TCLPlatfos<TCLOpenCL_:class> = class( TListParent<TCLOpenCL_,TCLPlatfo<TCLOpenCL_>> )
     private
       type TCLPlatfo_ = TCLPlatfo<TCLOpenCL_>;
     protected
       ///// メソッド
       procedure FindPlatfos;
       ///// イベント
       procedure OnInit; override;
     public
       ///// プロパティ
       property OpenCL :TCLOpenCL_ read GetOwnere;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses System.SysUtils,
     LUX.GPU.OpenCL;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLPlatfo<TCLOpenCL_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

/////////////////////////////////////////////////////////////////////// メソッド

function TCLPlatfo<TCLOpenCL_>.GetInfo<_TYPE_>( const Name_:T_cl_platform_info ) :_TYPE_;
begin
     AssertCL( clGetPlatformInfo( Handle, Name_, SizeOf( _TYPE_ ), @Result, nil ) );
end;

function TCLPlatfo<TCLOpenCL_>.GetInfoSize( const Name_:T_cl_platform_info ) :T_size_t;
begin
     AssertCL( clGetPlatformInfo( Handle, Name_, 0, nil, @Result ) );
end;

function TCLPlatfo<TCLOpenCL_>.GetInfos<_TYPE_>( const Name_:T_cl_platform_info ) :TArray<_TYPE_>;
var
   S :T_size_t;
begin
     S := GetInfoSize( Name_ );

     SetLength( Result, S div Cardinal( SizeOf( _TYPE_ ) ) );

     AssertCL( clGetPlatformInfo( Handle, Name_, S, @Result[ 0 ], nil ) );
end;

function TCLPlatfo<TCLOpenCL_>.GetInfoString( const Name_:T_cl_platform_info ) :String;
begin
     Result := TrimRight( String( P_char( GetInfos<T_char>( Name_ ) ) ) );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLPlatfo<TCLOpenCL_>.GetProfile :String;
begin
     Result := GetInfoString( CL_PLATFORM_PROFILE );
end;

function TCLPlatfo<TCLOpenCL_>.GetVersion :String;
begin
     Result := GetInfoString( CL_PLATFORM_VERSION );
end;

function TCLPlatfo<TCLOpenCL_>.GetName :String;
begin
     Result := GetInfoString( CL_PLATFORM_NAME );
end;

function TCLPlatfo<TCLOpenCL_>.GetVendor :String;
begin
     Result := GetInfoString( CL_PLATFORM_VENDOR );
end;

{$IF CL_VERSION_2_1 <> 0 }
function TCLPlatfo<TCLOpenCL_>.GetHostTimerResolution :T_cl_ulong;
begin
     Result := GetInfo<T_cl_ulong>( CL_PLATFORM_HOST_TIMER_RESOLUTION );
end;
{$ENDIF}
{$IF CL_VERSION_3_0 <> 0 }
function TCLPlatfo<TCLOpenCL_>.GetNumericVersion :T_cl_version;
begin
     Result := GetInfo<T_cl_version>( CL_PLATFORM_NUMERIC_VERSION );
end;

function TCLPlatfo<TCLOpenCL_>.GetExtensionsWithVersion :TArray<T_cl_name_version>;
begin
     Result := GetInfos<T_cl_name_version>( CL_PLATFORM_EXTENSIONS_WITH_VERSION );
end;
{$ENDIF}

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLPlatfo<TCLOpenCL_>.Create;
begin
     inherited;

     _Extenss := TCLExtenss_.Create;
     _Devices := TCLDevices_.Create( Self );
     _Contexs := TCLContexs_.Create( Self );
end;

constructor TCLPlatfo<TCLOpenCL_>.Create( const Platfos_:TCLPlatfos_; const Handle_:T_cl_platform_id );
var
   E :String;
begin
     Create( Platfos_ );

     _Handle := Handle_;

     for E in GetInfoString( CL_PLATFORM_EXTENSIONS ).Split( [ ' ' ] )
     do _Extenss.Add( E );
end;

destructor TCLPlatfo<TCLOpenCL_>.Destroy;
begin
     _Extenss.Free;
     _Devices.Free;
     _Contexs.Free;

     inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLPlatfos<TCLOpenCL_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLPlatfos<TCLOpenCL_>.FindPlatfos;
var
   PsN :T_cl_uint;
   Ps :TArray<T_cl_platform_id>;
   P :T_cl_platform_id;
begin
     AssertCL( clGetPlatformIDs( 0, nil, @PsN ) );

     SetLength( Ps, PsN );

     AssertCL( clGetPlatformIDs( PsN, @Ps[0], nil ) );

     for P in Ps do TCLPlatfo_.Create( Self, P );
end;

/////////////////////////////////////////////////////////////////////// イベント

procedure TCLPlatfos<TCLOpenCL_>.OnInit;
begin
     FindPlatfos;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

end. //######################################################################### ■
