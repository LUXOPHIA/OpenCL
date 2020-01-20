﻿unit LUX.GPU.OpenCL.Context;

interface //#################################################################### ■

uses System.Generics.Collections,
     cl_version, cl_platform, cl,
     LUX.Code.C,
     LUX.GPU.OpenCL.root,
     LUX.GPU.OpenCL.Command;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLContext<_TDevice_,_TPlatform_>

     TCLContext<_TDevice_,_TPlatform_:class> = class
     private
       type TCLCommand = TCLCommand<TCLContext<_TDevice_,_TPlatform_>,_TDevice_>;
     protected
       _Parent   :_TPlatform_;
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
       constructor Create( const Parent_:_TPlatform_ ); overload;
       constructor Create( const Parent_:_TPlatform_; const Devices_:TArray<_TDevice_> ); overload;
       destructor Destroy; override;
       ///// プロパティ
       property Parent   :_TPlatform_             read   _Parent  ;
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

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLContext<_TDevice_,_TPlatform_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLContext<_TDevice_,_TPlatform_>.GetHandle :T_cl_context;
begin
     if not avHandle then BeginHandle;

     Result := _Handle;
end;

function TCLContext<_TDevice_,_TPlatform_>.GetavHandle :Boolean;
begin
     Result := Assigned( _Handle );
end;

procedure TCLContext<_TDevice_,_TPlatform_>.SetavHandle( const avHandle_:Boolean );
begin
     if avHandle  then EndHandle;

     if avHandle_ then BeginHandle;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLContext<_TDevice_,_TPlatform_>.BeginHandle;
var
   Ps :array [ 0..2 ] of T_cl_context_properties;
   Ds :TArray<T_cl_device_id>;
   I :Integer;
begin
     Ps[ 0 ] := CL_CONTEXT_PLATFORM;
     Ps[ 1 ] := NativeInt( TCLPlatform( _Parent ).ID );
     Ps[ 2 ] := 0;

     with _Commands do
     begin
          SetLength( Ds, Count );

          for I := 0 to Count-1 do Ds[ I ] := TCLDevice( Items[ I ].Device ).ID;

          _Handle := clCreateContext( @Ps[0], Count, @Ds[0], nil, nil, nil );
     end;
end;

procedure TCLContext<_TDevice_,_TPlatform_>.EndHandle;
begin
     clReleaseContext( _Handle );

     _Handle := nil;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLContext<_TDevice_,_TPlatform_>.Create;
begin
     inherited;

     _Commands := TObjectList<TCLCommand>.Create;

     _Parent := _TPlatform_( _OpenCL_.Platform0 );
     _Handle := nil;
end;

constructor TCLContext<_TDevice_,_TPlatform_>.Create( const Parent_:_TPlatform_ );
begin
     Create;

     _Parent := Parent_;
end;

constructor TCLContext<_TDevice_,_TPlatform_>.Create( const Parent_:_TPlatform_; const Devices_:TArray<_TDevice_> );
var
   D :_TDevice_;
begin
     Create( Parent_ );

     for D in Devices_ do Add( D );
end;

destructor TCLContext<_TDevice_,_TPlatform_>.Destroy;
begin
     if avHandle then EndHandle;

     _Commands.Free;

     inherited;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLContext<_TDevice_,_TPlatform_>.Add( const Device_:_TDevice_ );
begin
     _Commands.Add( TCLCommand.Create( Self, Device_ ) );

     avHandle := False;
end;

procedure TCLContext<_TDevice_,_TPlatform_>.Remove( const Device_:_TDevice_ );
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