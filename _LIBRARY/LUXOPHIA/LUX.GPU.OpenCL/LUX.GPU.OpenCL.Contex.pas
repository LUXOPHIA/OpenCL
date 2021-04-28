unit LUX.GPU.OpenCL.Contex;

interface //#################################################################### ■

uses System.Generics.Collections,
     cl_version, cl_platform, cl,
     LUX.Data.List,
     LUX.Code.C,
     LUX.GPU.OpenCL.root,
     LUX.GPU.OpenCL.Device,
     LUX.GPU.OpenCL.Comman,
     LUX.GPU.OpenCL.Progra,
     LUX.GPU.OpenCL.Memory;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TCLContexs<TCLPlatfo_:class> = class;
       TCLContex<TCLPlatfo_:class> = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLContex<TCLPlatfo_>

     TCLContex<TCLPlatfo_:class> = class( TListChildr<TCLPlatfo_,TCLContexs<TCLPlatfo_>> )
     private
       type TCLContexs_ = TCLContexs<TCLPlatfo_>;
            TCLDevice_  = TCLDevice <TCLPlatfo_>;
            TCLContex_  = TCLContex <TCLPlatfo_>;
            TCLComman_  = TCLComman <TCLContex_,TCLDevice_>;
            TCLProgra_  = TCLProgra <TCLContex_>;
            TCLMemory_  = TCLMemory <TCLContex_>;
     protected
       _Commans :TObjectList<TCLComman_>;
       _Handle  :T_cl_context;
       _Progras :TObjectList<TCLProgra_>;
       _Memorys :TObjectList<TCLMemory_>;
       ///// アクセス
       function GetHandle :T_cl_context;
       procedure SetHandle( const Handle_:T_cl_context );
       ///// メソッド
       procedure CreateHandle;
       procedure DestroHandle;
     public
       constructor Create; override;
       constructor Create( const Platfo_:TCLPlatfo_ ); overload; virtual;
       constructor Create( const Platfo_:TCLPlatfo_; const Devices_:TArray<TCLDevice_> ); overload; virtual;
       destructor Destroy; override;
       ///// プロパティ
       property Platfo  :TCLPlatfo_              read GetOwnere                 ;
       property Contexs :TCLContexs_             read GetParent                 ;
       property Commans :TObjectList<TCLComman_> read   _Commans                ;
       property Handle  :T_cl_context            read GetHandle  write SetHandle;
       property Progras :TObjectList<TCLProgra_> read   _Progras                ;
       property Memorys :TObjectList<TCLMemory_> read   _Memorys                ;
       ///// メソッド
       procedure Add( const Device_:TCLDevice_ );
       procedure Remove( const Device_:TCLDevice_ );
       function GetDevices :TArray<T_cl_device_id>;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLContexs<TCLPlatfo_>

     TCLContexs<TCLPlatfo_:class> = class( TListParent<TCLPlatfo_,TCLContex<TCLPlatfo_>> )
     private
     protected
     public
       ///// プロパティ
       property Platfo :TCLPlatfo_ read GetOwnere;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses LUX.GPU.OpenCL;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLContex<TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLContex<TCLPlatfo_>.GetHandle :T_cl_context;
begin
     if not Assigned( _Handle ) then CreateHandle;

     Result := _Handle;
end;

procedure TCLContex<TCLPlatfo_>.SetHandle( const Handle_:T_cl_context );
begin
     if Assigned( _Handle ) then DestroHandle;

     _Handle := Handle_;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLContex<TCLPlatfo_>.CreateHandle;
var
   Ps :array [ 0..2 ] of T_cl_context_properties;
   Ds :TArray<T_cl_device_id>;
begin
     Ps[ 0 ] := CL_CONTEXT_PLATFORM;
     Ps[ 1 ] := T_cl_context_properties( TCLPlatfo( Platfo ).Handle );
     Ps[ 2 ] := 0;

     Ds := GetDevices;

     _Handle := clCreateContext( @Ps[0], Length( Ds ), @Ds[0], nil, nil, nil );
end;

procedure TCLContex<TCLPlatfo_>.DestroHandle;
begin
     clReleaseContext( _Handle );

     _Handle := nil;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLContex<TCLPlatfo_>.Create;
begin
     inherited;

     _Handle := nil;

     _Commans := TObjectList<TCLComman_>.Create;
     _Progras := TObjectList<TCLProgra_>.Create;
     _Memorys := TObjectList<TCLMemory_>.Create;
end;

constructor TCLContex<TCLPlatfo_>.Create( const Platfo_:TCLPlatfo_ );
begin
     Create( TCLContexs_( TCLPlatfo( Platfo_ ).Contexs ) );
end;

constructor TCLContex<TCLPlatfo_>.Create( const Platfo_:TCLPlatfo_; const Devices_:TArray<TCLDevice_> );
var
   D :TCLDevice_;
begin
     Create( Platfo_ );

     for D in Devices_ do Add( D );
end;

destructor TCLContex<TCLPlatfo_>.Destroy;
begin
     _Commans.Free;
     _Progras.Free;
     _Memorys.Free;

      Handle := nil;

     inherited;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLContex<TCLPlatfo_>.Add( const Device_:TCLDevice_ );
begin
     _Commans.Add( TCLComman_.Create( Self, Device_ ) );

     Handle := nil;
end;

procedure TCLContex<TCLPlatfo_>.Remove( const Device_:TCLDevice_ );
var
   C :TCLComman_;
begin
     for C in _Commans do
     begin
          if C.Device = Device_ then C.Free;
     end;

     Handle := nil;
end;

//------------------------------------------------------------------------------

function TCLContex<TCLPlatfo_>.GetDevices :TArray<T_cl_device_id>;
var
   I :Integer;
begin
     with _Commans do
     begin
          SetLength( Result, Count );

          for I := 0 to Count-1 do Result[ I ] := TCLDevice( Items[ I ].Device ).Handle;
     end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLContexs<TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

end. //######################################################################### ■
