﻿unit LUX.GPU.OpenCL.TCommand;

interface //#################################################################### ■

uses System.Generics.Collections,
     cl_version, cl_platform, cl,
     LUX.Code.C,
     LUX.GPU.OpenCL.root;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLCommand<_TContext_,_TDevice_>

     TCLCommand<_TContext_,_TDevice_:class> = class
     private
     protected
       _Parent :_TContext_;
       _Device :_TDevice_;
       _Handle :T_cl_command_queue;
       ///// アクセス
       function GetHandle :T_cl_command_queue;
       function GetavHandle :Boolean;
       procedure SetavHandle( const avHandle_:Boolean );
       ///// メソッド
       procedure BeginHandle;
       procedure EndHandle;
     public
       constructor Create( const Parent_:_TContext_; const Device_:_TDevice_ );
       destructor Destroy; override;
       ///// プロパティ
       property Parent   :_TContext_         read   _Parent                    ;
       property Device   :_TDevice_          read   _Device                    ;
       property Handle   :T_cl_command_queue read GetHandle                    ;
       property avHandle :Boolean            read GetavHandle write SetavHandle;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses LUX.GPU.OpenCL;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLCommand<_TContext_,_TDevice_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLCommand<_TContext_,_TDevice_>.GetHandle :T_cl_command_queue;
begin
     if not avHandle then BeginHandle;

     Result := _Handle;
end;

function TCLCommand<_TContext_,_TDevice_>.GetavHandle :Boolean;
begin
     Result := TCLContext( _Parent ).avHandle and Assigned( _Handle );
end;

procedure TCLCommand<_TContext_,_TDevice_>.SetavHandle( const avHandle_:Boolean );
begin
     if avHandle  then EndHandle;

     if avHandle_ then BeginHandle;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLCommand<_TContext_,_TDevice_>.BeginHandle;
begin
     {$IF CL_VERSION_2_0 <> 0 }
     _Handle := clCreateCommandQueueWithProperties( TCLContext( _Parent ).Handle, TCLDevice( _Device ).Handle, nil, nil );
     {$ELSE}
     _Handle := clCreateCommandQueue              ( TCLContext( _Parent ).Handle, TCLDevice( _Device ).Handle, nil, nil );
     {$ENDIF}
end;

procedure TCLCommand<_TContext_,_TDevice_>.EndHandle;
begin
     clReleaseCommandQueue( _Handle );

     _Handle := nil;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLCommand<_TContext_,_TDevice_>.Create( const Parent_:_TContext_; const Device_:_TDevice_ );
begin
     inherited Create;

     _Parent := Parent_;
     _Device := Device_;
     _Handle := nil;
end;

destructor TCLCommand<_TContext_,_TDevice_>.Destroy;
begin
     if avHandle then EndHandle;

     TCLContext( _Parent ).avHandle := False;

     inherited;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

//############################################################################## □

initialization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 初期化

finalization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 最終化

end. //######################################################################### ■