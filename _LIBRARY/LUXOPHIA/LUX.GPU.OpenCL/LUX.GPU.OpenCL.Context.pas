unit LUX.GPU.OpenCL.Context;

interface //#################################################################### ■

uses System.Generics.Collections,
     cl_version, cl_platform, cl,
     LUX.Code.C,
     LUX.GPU.OpenCL.root,
     LUX.GPU.OpenCL.Command;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLContext<_TDevice_>

     TCLContext<_TDevice_:class> = class
     private
       type TCLCommand = TCLCommand<TCLContext<_TDevice_>,_TDevice_>;
     protected
       _Commands :TObjectList<TCLCommand>;
       _Handle   :T_cl_context;
       ///// アクセス
       function GetHandle :T_cl_context;
       function GetavHandle :Boolean;
       procedure SetavHandle( const avHandle_:Boolean );
       ///// メソッド
       procedure BeginHandle;
       procedure EndHandle;
     public
       constructor Create; overload;
       constructor Create( const Devices_:TArray<_TDevice_> ); overload;
       destructor Destroy; override;
       ///// プロパティ
       property Commands :TObjectList<TCLCommand> read   _Commands;
       property Handle   :T_cl_context            read GetHandle  ;  property avHandle :Boolean read GetavHandle write SetavHandle;
       ///// メソッド
       procedure Add( const Device_:_TDevice_ );
       procedure Remove( const Device_:_TDevice_ );
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses LUX.GPU.OpenCL;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLContext<_TDevice_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLContext<_TDevice_>.GetHandle :T_cl_context;
begin
     if not avHandle then BeginHandle;

     Result := _Handle;
end;

function TCLContext<_TDevice_>.GetavHandle :Boolean;
begin
     Result := Assigned( _Handle );
end;

procedure TCLContext<_TDevice_>.SetavHandle( const avHandle_:Boolean );
begin
     if avHandle  then EndHandle;

     if avHandle_ then BeginHandle;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLContext<_TDevice_>.BeginHandle;
var
   Ds :TArray<T_cl_device_id>;
   I :Integer;
begin
     with _Commands do
     begin
          SetLength( Ds, Count );

          for I := 0 to Count-1 do Ds[ I ] := TCLDevice( Items[ I ].Device ).ID;

          _Handle := clCreateContext( nil, Count, @Ds[0], nil, nil, nil );
     end;
end;

procedure TCLContext<_TDevice_>.EndHandle;
begin
     clReleaseContext( _Handle );

     _Handle := nil;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLContext<_TDevice_>.Create;
begin
     inherited;

     _Commands := TObjectList<TCLCommand>.Create;

     _Handle := nil;
end;

constructor TCLContext<_TDevice_>.Create( const Devices_:TArray<_TDevice_> );
var
   D :_TDevice_;
begin
     Create;

     for D in Devices_ do Add( D );
end;

destructor TCLContext<_TDevice_>.Destroy;
begin
     if avHandle then EndHandle;

     _Commands.Free;

     inherited;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLContext<_TDevice_>.Add( const Device_:_TDevice_ );
begin
     _Commands.Add( TCLCommand.Create( Self, Device_ ) );

     avHandle := False;
end;

procedure TCLContext<_TDevice_>.Remove( const Device_:_TDevice_ );
var
   C :TCLCommand;
begin
     for C in _Commands do
     begin
          if C.Device = Device_ then C.Free;
     end;

     avHandle := False;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

//############################################################################## □

initialization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 初期化

finalization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 最終化

end. //######################################################################### ■
