unit LUX.GPU.OpenCL;

interface //#################################################################### ■

uses System.Classes, System.Generics.Collections,
     cl_version,
     cl_platform,
     cl,
     LUX.Code.C,
     LUX.GPU.OpenCL.root,
     LUX.GPU.OpenCL.Device;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TOpenCL     = class;
     TCLPlatform = class;

     TCLDevice   = TCLDevice<TCLPlatform>;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

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

implementation //############################################################### ■

uses System.SysUtils;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

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

//############################################################################## □

initialization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 初期化

     _OpenCL_ := TOpenCL.Create;

finalization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 最終化

     _OpenCL_.Free;

end. //######################################################################### ■
