﻿unit LUX.GPU.OpenCL.Platfo;

interface //#################################################################### ■

uses System.Classes,
     cl_version, cl_platform, cl,
     LUX.Data.List,
     LUX.Code.C,
     LUX.GPU.OpenCL.core,
     LUX.GPU.OpenCL.Device,
     LUX.GPU.OpenCL.Contex;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 T Y P E 】

     TCLPlatfos    <TCLSystem_           :class> = class;
       TCLPlatfo   <TCLSystem_           :class> = class;
         TCLExtenss<TCLSystem_,TCLPlatfo_:class> = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R E C O R D 】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C L A S S 】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLExtenss<TCLSystem_,TCLPlatfo_>

     TCLExtenss<TCLSystem_,TCLPlatfo_:class> = class( TStringList )
     private
     protected
     public
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLPlatfo<TCLSystem_>

     TCLPlatfo<TCLSystem_:class> = class( TListChildr<TCLSystem_,TCLPlatfos<TCLSystem_>> )
     private
       type TCLPlatfos_ = TCLPlatfos<TCLSystem_>;
            TCLPlatfo_  = TCLPlatfo <TCLSystem_>;
            TCLExtenss_ = TCLExtenss<TCLSystem_,TCLPlatfo_>;
            TCLDevices_ = TCLDevices<TCLSystem_,TCLPlatfo_>;
            TCLContexs_ = TCLContexs<TCLSystem_,TCLPlatfo_>;
       ///// M E T H O D
       function GetInfo<_TYPE_>( const Name_:T_cl_platform_info ) :_TYPE_;
       function GetInfoSize( const Name_:T_cl_platform_info ) :T_size_t;
       function GetInfos<_TYPE_>( const Name_:T_cl_platform_info ) :TArray<_TYPE_>;
       function GetInfoString( const Name_:T_cl_platform_info ) :String;
     protected
       _Handle  :T_cl_platform_id;
       _Extenss :TCLExtenss_;
       _Devices :TCLDevices_;
       _Contexs :TCLContexs_;
       ///// A C C E S S O R
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
       ///// P R O P E R T Y
       property System                :TCLSystem_                read GetOwnere               ;
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

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLPlatfos<TCLSystem_>

     TCLPlatfos<TCLSystem_:class> = class( TListParent<TCLSystem_,TCLPlatfo<TCLSystem_>> )
     private
       type TCLPlatfo_ = TCLPlatfo<TCLSystem_>;
     protected
       ///// M E T H O D
       procedure FindPlatfos;
       ///// イベント
       procedure OnInit; override;
     public
       ///// P R O P E R T Y
       property System :TCLSystem_ read GetOwnere;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C O N S T A N T 】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 V A R I A B L E 】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

implementation //############################################################### ■

uses System.SysUtils;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R E C O R D 】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C L A S S 】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLExtenss<TCLSystem_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLPlatfo<TCLSystem_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//////////////////////////////////////////////////////////////////// M E T H O D

function TCLPlatfo<TCLSystem_>.GetInfo<_TYPE_>( const Name_:T_cl_platform_info ) :_TYPE_;
begin
     AssertCL( clGetPlatformInfo( Handle, Name_, SizeOf( _TYPE_ ), @Result, nil ), 'TCLPlatfo.GetInfo is Error!' );
end;

function TCLPlatfo<TCLSystem_>.GetInfoSize( const Name_:T_cl_platform_info ) :T_size_t;
begin
     AssertCL( clGetPlatformInfo( Handle, Name_, 0, nil, @Result ), 'TCLPlatfo.GetInfoSize is Error!' );
end;

function TCLPlatfo<TCLSystem_>.GetInfos<_TYPE_>( const Name_:T_cl_platform_info ) :TArray<_TYPE_>;
var
   S :T_size_t;
begin
     S := GetInfoSize( Name_ );

     SetLength( Result, S div Cardinal( SizeOf( _TYPE_ ) ) );

     AssertCL( clGetPlatformInfo( Handle, Name_, S, @Result[ 0 ], nil ), 'TCLPlatfo.GetInfos is Error!' );
end;

function TCLPlatfo<TCLSystem_>.GetInfoString( const Name_:T_cl_platform_info ) :String;
begin
     Result := TrimRight( String( P_char( GetInfos<T_char>( Name_ ) ) ) );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//////////////////////////////////////////////////////////////// A C C E S S O R

function TCLPlatfo<TCLSystem_>.GetProfile :String;
begin
     Result := GetInfoString( CL_PLATFORM_PROFILE );
end;

function TCLPlatfo<TCLSystem_>.GetVersion :String;
begin
     Result := GetInfoString( CL_PLATFORM_VERSION );
end;

function TCLPlatfo<TCLSystem_>.GetName :String;
begin
     Result := GetInfoString( CL_PLATFORM_NAME );
end;

function TCLPlatfo<TCLSystem_>.GetVendor :String;
begin
     Result := GetInfoString( CL_PLATFORM_VENDOR );
end;

{$IF CL_VERSION_2_1 <> 0 }
function TCLPlatfo<TCLSystem_>.GetHostTimerResolution :T_cl_ulong;
begin
     Result := GetInfo<T_cl_ulong>( CL_PLATFORM_HOST_TIMER_RESOLUTION );
end;
{$ENDIF}
{$IF CL_VERSION_3_0 <> 0 }
function TCLPlatfo<TCLSystem_>.GetNumericVersion :T_cl_version;
begin
     Result := GetInfo<T_cl_version>( CL_PLATFORM_NUMERIC_VERSION );
end;

function TCLPlatfo<TCLSystem_>.GetExtensionsWithVersion :TArray<T_cl_name_version>;
begin
     Result := GetInfos<T_cl_name_version>( CL_PLATFORM_EXTENSIONS_WITH_VERSION );
end;
{$ENDIF}

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLPlatfo<TCLSystem_>.Create;
begin
     inherited;

     _Extenss := TCLExtenss_.Create;
     _Devices := TCLDevices_.Create( Self );
     _Contexs := TCLContexs_.Create( Self );
end;

constructor TCLPlatfo<TCLSystem_>.Create( const Platfos_:TCLPlatfos_; const Handle_:T_cl_platform_id );
var
   E :String;
begin
     Create( Platfos_ );

     _Handle := Handle_;

     for E in GetInfoString( CL_PLATFORM_EXTENSIONS ).Split( [ ' ' ] )
     do _Extenss.Add( E );
end;

destructor TCLPlatfo<TCLSystem_>.Destroy;
begin
     _Extenss.Free;
     _Devices.Free;
     _Contexs.Free;

     inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLPlatfos<TCLSystem_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//////////////////////////////////////////////////////////////////// M E T H O D

procedure TCLPlatfos<TCLSystem_>.FindPlatfos;
var
   PsN :T_cl_uint;
   Ps :TArray<T_cl_platform_id>;
   P :T_cl_platform_id;
begin
     AssertCL( clGetPlatformIDs( 0, nil, @PsN ), 'TCLPlatfos.FindPlatfos is Error!' );

     SetLength( Ps, PsN );

     AssertCL( clGetPlatformIDs( PsN, @Ps[0], nil ), 'TCLPlatfos.FindPlatfos is Error!' );

     for P in Ps do TCLPlatfo_.Create( Self, P );
end;

/////////////////////////////////////////////////////////////////////// イベント

procedure TCLPlatfos<TCLSystem_>.OnInit;
begin
     FindPlatfos;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

end. //######################################################################### ■
