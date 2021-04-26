unit LUX.GPU.OpenCL.Contex;

interface //#################################################################### ■

uses System.Generics.Collections,
     cl_version, cl_platform, cl,
     LUX.Code.C,
     LUX.GPU.OpenCL.root,
     LUX.GPU.OpenCL.Comman,
     LUX.GPU.OpenCL.Progra,
     LUX.GPU.OpenCL.Memory;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLContex<TCLPlatfo_,TCLDevice_>

     TCLContex<TCLPlatfo_,TCLDevice_:class> = class
     private
       type TCLContex_ = TCLContex<TCLPlatfo_,TCLDevice_>;
            TCLComman_ = TCLComman<TCLContex_,TCLDevice_>;
            TCLProgra_ = TCLProgra<TCLContex_>;
            TCLMemory_ = TCLMemory<TCLContex_>;
     protected
       _Parent  :TCLPlatfo_;
       _Commans :TObjectList<TCLComman_>;
       _Handle  :T_cl_context;
       _Progras :TObjectList<TCLProgra_>;
       _Memorys :TObjectList<TCLMemory_>;
       ///// アクセス
       procedure SetParent( const Parent_:TCLPlatfo_ );
       function GetHandle :T_cl_context;
       function GetavHandle :Boolean;
       procedure SetavHandle( const avHandle_:Boolean );
       ///// メソッド
       procedure BeginHandle;
       procedure EndHandle;
     public
       constructor Create; overload;
       constructor Create( const Parent_:TCLPlatfo_ ); overload;
       constructor Create( const Parent_:TCLPlatfo_; const Devices_:TArray<TCLDevice_> ); overload;
       destructor Destroy; override;
       ///// プロパティ
       property Parent   :TCLPlatfo_              read   _Parent   write SetParent  ;
       property Commans  :TObjectList<TCLComman_> read   _Commans                   ;
       property Handle   :T_cl_context            read GetHandle                    ;
       property avHandle :Boolean                 read GetavHandle write SetavHandle;
       property Progras  :TObjectList<TCLProgra_> read   _Progras                   ;
       property Memorys  :TObjectList<TCLMemory_> read   _Memorys                   ;
       ///// メソッド
       procedure Add( const Device_:TCLDevice_ );
       procedure Remove( const Device_:TCLDevice_ );
       function GetDevices :TArray<T_cl_device_id>;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses LUX.GPU.OpenCL;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLContex<TCLPlatfo_,TCLDevice_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

procedure TCLContex<TCLPlatfo_,TCLDevice_>.SetParent( const Parent_:TCLPlatfo_ );
begin
     if Assigned( _Parent ) then TCLPlatfo( _Parent ).Contexs.Remove( TCLContex( Self ) );

                  _Parent := Parent_;

     if Assigned( _Parent ) then TCLPlatfo( _Parent ).Contexs.Add   ( TCLContex( Self ) );
end;

//------------------------------------------------------------------------------

function TCLContex<TCLPlatfo_,TCLDevice_>.GetHandle :T_cl_context;
begin
     if not avHandle then BeginHandle;

     Result := _Handle;
end;

function TCLContex<TCLPlatfo_,TCLDevice_>.GetavHandle :Boolean;
begin
     Result := Assigned( _Handle );
end;

procedure TCLContex<TCLPlatfo_,TCLDevice_>.SetavHandle( const avHandle_:Boolean );
begin
     if avHandle  then EndHandle;

     if avHandle_ then BeginHandle;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLContex<TCLPlatfo_,TCLDevice_>.BeginHandle;
var
   Ps :array [ 0..2 ] of T_cl_context_properties;
   Ds :TArray<T_cl_device_id>;
begin
     Ps[ 0 ] := CL_CONTEXT_PLATFORM;
     Ps[ 1 ] := NativeInt( TCLPlatfo( _Parent ).Handle );
     Ps[ 2 ] := 0;

     Ds := GetDevices;

     _Handle := clCreateContext( @Ps[0], Length( Ds ), @Ds[0], nil, nil, nil );
end;

procedure TCLContex<TCLPlatfo_,TCLDevice_>.EndHandle;
begin
     clReleaseContext( _Handle );

     _Handle := nil;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLContex<TCLPlatfo_,TCLDevice_>.Create;
begin
     inherited;

     _Commans := TObjectList<TCLComman_>.Create;
     _Progras := TObjectList<TCLProgra_>.Create;
     _Memorys := TObjectList<TCLMemory_>.Create;

     _Parent := nil;
     _Handle := nil;
end;

constructor TCLContex<TCLPlatfo_,TCLDevice_>.Create( const Parent_:TCLPlatfo_ );
begin
     Create;

     Parent := Parent_;
end;

constructor TCLContex<TCLPlatfo_,TCLDevice_>.Create( const Parent_:TCLPlatfo_; const Devices_:TArray<TCLDevice_> );
var
   D :TCLDevice_;
begin
     Create( Parent_ );

     for D in Devices_ do Add( D );
end;

destructor TCLContex<TCLPlatfo_,TCLDevice_>.Destroy;
begin
     if avHandle then EndHandle;

     _Commans.Free;
     _Progras.Free;
     _Memorys.Free;

     inherited;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLContex<TCLPlatfo_,TCLDevice_>.Add( const Device_:TCLDevice_ );
begin
     _Commans.Add( TCLComman_.Create( Self, Device_ ) );

     avHandle := False;
end;

procedure TCLContex<TCLPlatfo_,TCLDevice_>.Remove( const Device_:TCLDevice_ );
var
   C :TCLComman_;
begin
     for C in _Commans do
     begin
          if C.Device = Device_ then C.Free;
     end;

     avHandle := False;
end;

//------------------------------------------------------------------------------

function TCLContex<TCLPlatfo_,TCLDevice_>.GetDevices :TArray<T_cl_device_id>;
var
   I :Integer;
begin
     with _Commans do
     begin
          SetLength( Result, Count );

          for I := 0 to Count-1 do Result[ I ] := TCLDevice( Items[ I ].Device ).Handle;
     end;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

//############################################################################## □

initialization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 初期化

finalization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 最終化

end. //######################################################################### ■
