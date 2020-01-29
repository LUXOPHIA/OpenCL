unit LUX.GPU.OpenCL.TPlatform;

interface //#################################################################### ■

uses System.Classes, System.Generics.Collections,
     cl_version,
     cl_platform,
     cl,
     LUX.Code.C,
     LUX.GPU.OpenCL.root,
     LUX.GPU.OpenCL.TDevice,
     LUX.GPU.OpenCL.TContext;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDevice<_TOpenCL_>

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLPlatform<_TOpenCL_>

     TCLPlatform<_TOpenCL_:class> = class
     private
       type TCLDevice  = TCLDevice<TCLPlatform<_TOpenCL_>>;
       type TCLContext = TCLContext<TCLPlatform<_TOpenCL_>,TCLDevice>;
       ///// メソッド
       function GetPlatformInfo<_TYPE_>( const Name_:T_cl_platform_info ) :_TYPE_;
       function GetPlatformInfoSize( const Name_:T_cl_platform_info ) :T_size_t;
       function GetPlatformInfos<_TYPE_>( const Name_:T_cl_platform_info ) :TArray<_TYPE_>;
       function GetPlatformInfoString( const Name_:T_cl_platform_info ) :String;
     protected
       _Parent     :_TOpenCL_;
       _Handle     :T_cl_platform_id;
       _Extensions :TStringList;
       _Devices    :TObjectList<TCLDevice>;
       _Contexts   :TObjectList<TCLContext>;
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
       property Parent              :_TOpenCL_               read   _Parent             ;
       property Handle              :T_cl_platform_id        read   _Handle             ;
       property Profile             :String                  read GetProfile            ;
       property Version             :String                  read GetVersion            ;
       property Name                :String                  read GetName               ;
       property Vendor              :String                  read GetVendor             ;
       property Extensions          :TStringList             read   _Extensions         ;
       property HostTimerResolution :T_cl_ulong              read GetHostTimerResolution;  { OpenCL 2.1 }
       property Devices             :TObjectList<TCLDevice>  read   _Devices            ;
       property Contexts            :TObjectList<TCLContext> read   _Contexts           ;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses System.SysUtils;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLPlatform<_TOpenCL_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

/////////////////////////////////////////////////////////////////////// メソッド

function TCLPlatform<_TOpenCL_>.GetPlatformInfo<_TYPE_>( const Name_:T_cl_platform_info ) :_TYPE_;
begin
     AssertCL( clGetPlatformInfo( _Handle, Name_, SizeOf( _TYPE_ ), @Result, nil ) );
end;

//------------------------------------------------------------------------------

function TCLPlatform<_TOpenCL_>.GetPlatformInfoSize( const Name_:T_cl_platform_info ) :T_size_t;
begin
     AssertCL( clGetPlatformInfo( _Handle, Name_, 0, nil, @Result ) );
end;

//------------------------------------------------------------------------------

function TCLPlatform<_TOpenCL_>.GetPlatformInfos<_TYPE_>( const Name_:T_cl_platform_info ) :TArray<_TYPE_>;
var
   S :T_size_t;
begin
     S := GetPlatformInfoSize( Name_ );

     SetLength( Result, S div Cardinal( SizeOf( _TYPE_ ) ) );

     AssertCL( clGetPlatformInfo( _Handle, Name_, S, @Result[ 0 ], nil ) );
end;

//------------------------------------------------------------------------------

function TCLPlatform<_TOpenCL_>.GetPlatformInfoString( const Name_:T_cl_platform_info ) :String;
begin
     Result := String( P_char( GetPlatformInfos<T_char>( Name_ ) ) );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLPlatform<_TOpenCL_>.GetProfile :String;
begin
     Result := GetPlatformInfoString( CL_PLATFORM_PROFILE );
end;

function TCLPlatform<_TOpenCL_>.GetVersion :String;
begin
     Result := GetPlatformInfoString( CL_PLATFORM_VERSION );
end;

function TCLPlatform<_TOpenCL_>.GetName :String;
begin
     Result := GetPlatformInfoString( CL_PLATFORM_NAME );
end;

function TCLPlatform<_TOpenCL_>.GetVendor :String;
begin
     Result := GetPlatformInfoString( CL_PLATFORM_VENDOR );
end;

function TCLPlatform<_TOpenCL_>.GetHostTimerResolution :T_cl_ulong;
begin
     {$IF CL_VERSION_2_1 <> 0 }
     Result := GetPlatformInfo<T_cl_ulong>( CL_PLATFORM_HOST_TIMER_RESOLUTION );
     {$ELSE}
     Result := 0;
     {$ENDIF}
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLPlatform<_TOpenCL_>.MakeDevices;
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

constructor TCLPlatform<_TOpenCL_>.Create( const Parent_:_TOpenCL_; const ID_:T_cl_platform_id );
var
   E :String;
begin
     inherited Create;

     _Extensions := TStringList.Create;
     _Devices    := TObjectList<TCLDevice>.Create;
     _Contexts   := TObjectList<TCLContext>.Create;

     _Parent := Parent_;
     _Handle := ID_;

     for E in GetPlatformInfoString( CL_PLATFORM_EXTENSIONS ).Split( [ ' ' ] )
     do _Extensions.Add( E );

     MakeDevices;
end;

destructor TCLPlatform<_TOpenCL_>.Destroy;
begin
     _Extensions.Free;
     _Devices   .Free;
     _Contexts  .Free;

     inherited;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

//############################################################################## □

initialization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 初期化

finalization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 最終化

end. //######################################################################### ■
