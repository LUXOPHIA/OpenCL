unit LUX.GPU.OpenCL.Platfo;

interface //#################################################################### ■

uses System.Classes, System.Generics.Collections,
     cl_version,
     cl_platform,
     cl,
     LUX.Code.C,
     LUX.GPU.OpenCL.root,
     LUX.GPU.OpenCL.Device,
     LUX.GPU.OpenCL.Contex;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDevice<_TOpenCL_>

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLPlatfo<_TOpenCL_>

     TCLPlatfo<_TOpenCL_:class> = class
     private
       type TCLDevice = TCLDevice<TCLPlatfo<_TOpenCL_>>;
       type TCLContex = TCLContex<TCLPlatfo<_TOpenCL_>,TCLDevice>;
       ///// メソッド
       function GetPlatformInfo<_TYPE_>( const Name_:T_cl_platform_info ) :_TYPE_;
       function GetPlatformInfoSize( const Name_:T_cl_platform_info ) :T_size_t;
       function GetPlatformInfos<_TYPE_>( const Name_:T_cl_platform_info ) :TArray<_TYPE_>;
       function GetPlatformInfoString( const Name_:T_cl_platform_info ) :String;
     protected
       _Parent  :_TOpenCL_;
       _Handle  :T_cl_platform_id;
       _Extenss :TStringList;
       _Devices :TObjectList<TCLDevice>;
       _Contexs :TObjectList<TCLContex>;
       ///// アクセス
       function GetProfile :String;
       function GetVersion :String;
       function GetName :String;
       function GetVendor :String;
       function GetHostTimerResolution :T_cl_ulong;
       ///// メソッド
       procedure MakeDevices;
     public
       constructor Create( const Parent_:_TOpenCL_; const ID_:T_cl_platform_id );
       destructor Destroy; override;
       ///// プロパティ
       property OpenCL              :_TOpenCL_              read   _Parent             ;
       property Handle              :T_cl_platform_id       read   _Handle             ;
       property Profile             :String                 read GetProfile            ;
       property Version             :String                 read GetVersion            ;
       property Name                :String                 read GetName               ;
       property Vendor              :String                 read GetVendor             ;
       property Extenss             :TStringList            read   _Extenss            ;
       property HostTimerResolution :T_cl_ulong             read GetHostTimerResolution;  { OpenCL 2.1 }
       property Devices             :TObjectList<TCLDevice> read   _Devices            ;
       property Contexs             :TObjectList<TCLContex> read   _Contexs            ;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses System.SysUtils;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLPlatfo<_TOpenCL_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

/////////////////////////////////////////////////////////////////////// メソッド

function TCLPlatfo<_TOpenCL_>.GetPlatformInfo<_TYPE_>( const Name_:T_cl_platform_info ) :_TYPE_;
begin
     AssertCL( clGetPlatformInfo( _Handle, Name_, SizeOf( _TYPE_ ), @Result, nil ) );
end;

//------------------------------------------------------------------------------

function TCLPlatfo<_TOpenCL_>.GetPlatformInfoSize( const Name_:T_cl_platform_info ) :T_size_t;
begin
     AssertCL( clGetPlatformInfo( _Handle, Name_, 0, nil, @Result ) );
end;

//------------------------------------------------------------------------------

function TCLPlatfo<_TOpenCL_>.GetPlatformInfos<_TYPE_>( const Name_:T_cl_platform_info ) :TArray<_TYPE_>;
var
   S :T_size_t;
begin
     S := GetPlatformInfoSize( Name_ );

     SetLength( Result, S div Cardinal( SizeOf( _TYPE_ ) ) );

     AssertCL( clGetPlatformInfo( _Handle, Name_, S, @Result[ 0 ], nil ) );
end;

//------------------------------------------------------------------------------

function TCLPlatfo<_TOpenCL_>.GetPlatformInfoString( const Name_:T_cl_platform_info ) :String;
begin
     Result := String( P_char( GetPlatformInfos<T_char>( Name_ ) ) );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLPlatfo<_TOpenCL_>.GetProfile :String;
begin
     Result := GetPlatformInfoString( CL_PLATFORM_PROFILE );
end;

function TCLPlatfo<_TOpenCL_>.GetVersion :String;
begin
     Result := GetPlatformInfoString( CL_PLATFORM_VERSION );
end;

function TCLPlatfo<_TOpenCL_>.GetName :String;
begin
     Result := GetPlatformInfoString( CL_PLATFORM_NAME );
end;

function TCLPlatfo<_TOpenCL_>.GetVendor :String;
begin
     Result := GetPlatformInfoString( CL_PLATFORM_VENDOR );
end;

function TCLPlatfo<_TOpenCL_>.GetHostTimerResolution :T_cl_ulong;
begin
     {$IF CL_VERSION_2_1 <> 0 }
     Result := GetPlatformInfo<T_cl_ulong>( CL_PLATFORM_HOST_TIMER_RESOLUTION );
     {$ELSE}
     Result := 0;
     {$ENDIF}
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLPlatfo<_TOpenCL_>.MakeDevices;
const
     DEVICETYPE = CL_DEVICE_TYPE_ALL;
var
   DsN :T_cl_uint;
   Ds :TArray<T_cl_device_id>;
   D :T_cl_device_id;
begin
     AssertCL( clGetDeviceIDs( _Handle, DEVICETYPE, 0, nil, @DsN ) );

     SetLength( Ds, DsN );

     AssertCL( clGetDeviceIDs( _Handle, DEVICETYPE, DsN, @Ds[0], nil ) );

     for D in Ds do _Devices.Add( TCLDevice.Create( Self, D ) );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLPlatfo<_TOpenCL_>.Create( const Parent_:_TOpenCL_; const ID_:T_cl_platform_id );
var
   E :String;
begin
     inherited Create;

     _Extenss := TStringList.Create;
     _Devices := TObjectList<TCLDevice>.Create;
     _Contexs := TObjectList<TCLContex>.Create;

     _Parent := Parent_;
     _Handle := ID_;

     for E in GetPlatformInfoString( CL_PLATFORM_EXTENSIONS ).Split( [ ' ' ] )
     do _Extenss.Add( E );

     MakeDevices;
end;

destructor TCLPlatfo<_TOpenCL_>.Destroy;
begin
     _Extenss.Free;
     _Devices.Free;
     _Contexs.Free;

     inherited;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

//############################################################################## □

initialization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 初期化

finalization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 最終化

end. //######################################################################### ■
