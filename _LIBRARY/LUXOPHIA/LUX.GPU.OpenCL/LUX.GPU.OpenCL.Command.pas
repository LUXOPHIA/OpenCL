unit LUX.GPU.OpenCL.Command;

interface //#################################################################### ■

uses System.Generics.Collections,
     cl_version, cl_platform, cl,
     LUX.Code.C,
     LUX.GPU.OpenCL;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLCommand

     TCLCommand<_TContext_:class> = class
     private
     protected
       _Context :_TContext_;
       _Device  :TCLDevice;
       _Handle  :T_cl_command_queue;
       ///// アクセス
       function GetHandle :T_cl_command_queue;
       function GetavHandle :Boolean;
       procedure SetavHandle( const avHandle_:Boolean );
       ///// メソッド
       procedure BeginHandle;
       procedure EndHandle;
     public
       constructor Create( const Context_:_TContext_; const Device_:TCLDevice );
       destructor Destroy; override;
       ///// プロパティ
       property Context :_TContext_         read   _Context;
       property Device  :TCLDevice          read   _Device ;
       property Handle  :T_cl_command_queue read GetHandle ;  property avHandle :Boolean read GetavHandle write SetavHandle;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses LUX.GPU.OpenCL.Context;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLCommand

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLCommand<_TContext_>.GetHandle :T_cl_command_queue;
begin
     if not TCLContext( _Context ).avHandle then avHandle := False;

     if not                        avHandle then BeginHandle;

     Result := _Handle;
end;

function TCLCommand<_TContext_>.GetavHandle :Boolean;
begin
     Result := Assigned( _Handle );
end;

procedure TCLCommand<_TContext_>.SetavHandle( const avHandle_:Boolean );
begin
     if avHandle  then EndHandle;

     if avHandle_ then BeginHandle;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLCommand<_TContext_>.BeginHandle;
begin
     {$IF Declared( CL_VERSION_2_0 ) }
     _Handle := clCreateCommandQueueWithProperties( TCLContext( _Context ).Handle, _Device.ID, 0, nil );
     {$ELSE}
     _Handle := clCreateCommandQueue              ( TCLContext( _Context ).Handle, _Device.ID, 0, nil );
     {$ENDIF}
end;

procedure TCLCommand<_TContext_>.EndHandle;
begin
     clReleaseCommandQueue( _Handle );

     _Handle := nil;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLCommand<_TContext_>.Create( const Context_:_TContext_; const Device_:TCLDevice );
begin
     inherited Create;

     _Context := Context_;
     _Device  := Device_;
     _Handle  := nil;
end;

destructor TCLCommand<_TContext_>.Destroy;
begin
     if avHandle then EndHandle;

     TCLContext( _Context ).avHandle := False;

     inherited;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

//############################################################################## □

initialization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 初期化

finalization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 最終化

end. //######################################################################### ■
