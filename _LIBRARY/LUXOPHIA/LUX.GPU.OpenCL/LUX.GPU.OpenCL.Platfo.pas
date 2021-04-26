unit LUX.GPU.OpenCL.Platfo;

interface //#################################################################### ■

uses System.Classes, System.Generics.Collections,
     cl_version,
     cl_platform,
     cl,
     LUX.Data.List,
     LUX.Code.C,
     LUX.GPU.OpenCL.root,
     LUX.GPU.OpenCL.Device,
     LUX.GPU.OpenCL.Contex;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TCLPlatfos<TOpenCL_:class>  = class;
       TCLPlatfo<TOpenCL_:class> = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLPlatfo<TOpenCL_>

     TCLPlatfo<TOpenCL_:class> = class( TListChildr<TOpenCL_,TCLPlatfos<TOpenCL_>> )
     private
       type TCLPlatfos_ = TCLPlatfos<TOpenCL_>;
            TCLPlatfo_  = TCLPlatfo <TOpenCL_>;
            TCLDevices_ = TCLDevices<TCLPlatfo_>;
            TCLDevice_  = TCLDevice <TCLPlatfo_>;
            TCLContex_  = TCLContex<TCLPlatfo_,TCLDevice_>;
       ///// メソッド
       function GetInfo<_TYPE_>( const Name_:T_cl_platform_info ) :_TYPE_;
       function GetInfoSize( const Name_:T_cl_platform_info ) :T_size_t;
       function GetInfos<_TYPE_>( const Name_:T_cl_platform_info ) :TArray<_TYPE_>;
       function GetInfoString( const Name_:T_cl_platform_info ) :String;
     protected
       _Handle  :T_cl_platform_id;
       _Extenss :TStringList;
       _Devices :TCLDevices_;
       _Contexs :TObjectList<TCLContex_>;
       ///// アクセス
       function GetProfile :String;
       function GetVersion :String;
       function GetName :String;
       function GetVendor :String;
       function GetHostTimerResolution :T_cl_ulong;
     public
       constructor Create; override;
       constructor Create( const Parent_:TCLPlatfos_; const Handle_:T_cl_platform_id ); overload; virtual;
       destructor Destroy; override;
       ///// プロパティ
       property OpenCL              :TOpenCL_                read GetOwnere             ;
       property Platfos             :TCLPlatfos_             read GetParent             ;
       property Handle              :T_cl_platform_id        read   _Handle             ;
       property Profile             :String                  read GetProfile            ;
       property Version             :String                  read GetVersion            ;
       property Name                :String                  read GetName               ;
       property Vendor              :String                  read GetVendor             ;
       property Extenss             :TStringList             read   _Extenss            ;
       property HostTimerResolution :T_cl_ulong              read GetHostTimerResolution;  { OpenCL 2.1 }
       property Devices             :TCLDevices_             read   _Devices            ;
       property Contexs             :TObjectList<TCLContex_> read   _Contexs            ;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLPlatfos<TOpenCL_>

     TCLPlatfos<TOpenCL_:class> = class( TListParent<TOpenCL_,TCLPlatfo<TOpenCL_>> )
     private
       type TCLPlatfo_ = TCLPlatfo<TOpenCL_>;
     protected
       ///// メソッド
       procedure FindPlatfos;
       ///// イベント
       procedure OnInit; override;
     public
       ///// プロパティ
       property OpenCL :TOpenCL_ read GetOwnere;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses System.SysUtils,
     LUX.GPU.OpenCL;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLPlatfo<TOpenCL_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

/////////////////////////////////////////////////////////////////////// メソッド

function TCLPlatfo<TOpenCL_>.GetInfo<_TYPE_>( const Name_:T_cl_platform_info ) :_TYPE_;
begin
     AssertCL( clGetPlatformInfo( _Handle, Name_, SizeOf( _TYPE_ ), @Result, nil ) );
end;

//------------------------------------------------------------------------------

function TCLPlatfo<TOpenCL_>.GetInfoSize( const Name_:T_cl_platform_info ) :T_size_t;
begin
     AssertCL( clGetPlatformInfo( _Handle, Name_, 0, nil, @Result ) );
end;

//------------------------------------------------------------------------------

function TCLPlatfo<TOpenCL_>.GetInfos<_TYPE_>( const Name_:T_cl_platform_info ) :TArray<_TYPE_>;
var
   S :T_size_t;
begin
     S := GetInfoSize( Name_ );

     SetLength( Result, S div Cardinal( SizeOf( _TYPE_ ) ) );

     AssertCL( clGetPlatformInfo( _Handle, Name_, S, @Result[ 0 ], nil ) );
end;

//------------------------------------------------------------------------------

function TCLPlatfo<TOpenCL_>.GetInfoString( const Name_:T_cl_platform_info ) :String;
begin
     Result := String( P_char( GetInfos<T_char>( Name_ ) ) );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLPlatfo<TOpenCL_>.GetProfile :String;
begin
     Result := GetInfoString( CL_PLATFORM_PROFILE );
end;

function TCLPlatfo<TOpenCL_>.GetVersion :String;
begin
     Result := GetInfoString( CL_PLATFORM_VERSION );
end;

function TCLPlatfo<TOpenCL_>.GetName :String;
begin
     Result := GetInfoString( CL_PLATFORM_NAME );
end;

function TCLPlatfo<TOpenCL_>.GetVendor :String;
begin
     Result := GetInfoString( CL_PLATFORM_VENDOR );
end;

function TCLPlatfo<TOpenCL_>.GetHostTimerResolution :T_cl_ulong;
begin
     {$IF CL_VERSION_2_1 <> 0 }
     Result := GetInfo<T_cl_ulong>( CL_PLATFORM_HOST_TIMER_RESOLUTION );
     {$ELSE}
     Result := 0;
     {$ENDIF}
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLPlatfo<TOpenCL_>.Create;
begin
     inherited;

     _Extenss := TStringList.Create;
     _Devices := TCLDevices_.Create( Self );
     _Contexs := TObjectList<TCLContex_>.Create;
end;

constructor TCLPlatfo<TOpenCL_>.Create( const Parent_:TCLPlatfos_; const Handle_:T_cl_platform_id );
var
   E :String;
begin
     Create( Parent_ );

     _Handle := Handle_;

     for E in GetInfoString( CL_PLATFORM_EXTENSIONS ).Split( [ ' ' ] )
     do _Extenss.Add( E );
end;

destructor TCLPlatfo<TOpenCL_>.Destroy;
begin
     _Extenss.Free;
     _Devices.Free;
     _Contexs.Free;

     inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLPlatfos<TOpenCL_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLPlatfos<TOpenCL_>.FindPlatfos;
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

procedure TCLPlatfos<TOpenCL_>.OnInit;
begin
     FindPlatfos;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

end. //######################################################################### ■
