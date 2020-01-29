unit LUX.GPU.OpenCL.TBuffer.TIter;

interface //#################################################################### ■

uses cl_version, cl_platform, cl,
     LUX,
     LUX.Code.C,
     LUX.GPU.OpenCL.root,
     LUX.GPU.OpenCL.Command,
     LUX.GPU.OpenCL.TBuffer;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLBufferIter<_TContext_,_TDevice_,_TValue_>

     TCLBufferIter<_TContext_,_TDevice_:class;_TValue_:record> = class
     private
       type TCLCommand  = TCLCommand<_TContext_,_TDevice_>;
       type TCLBuffer   = TCLBuffer<_TContext_,_TValue_>;
       type PValue      = ^_TValue_;
     private
       _Command :TCLCommand;
       _Buffer  :TCLBuffer;
       _Mode    :T_cl_map_flags;
       _Head    :PValue;
       ///// アクセス
       function GetValues( const I_:Integer ) :_TValue_;
       procedure SetValues( const I_:Integer; const Values_:_TValue_ );
     public
       constructor Create( const Command_:TCLCommand; const Buffer_:TCLBuffer; const Mode_:T_cl_map_flags = CL_MAP_READ or CL_MAP_WRITE );
       destructor Destroy; override;
       ///// プロパティ
       property Command                    :TCLCommand     read   _Command;
       property Buffer                     :TCLBuffer      read   _Buffer;
       property Mode                       :T_cl_map_flags read   _Mode;
       property Values[ const I_:Integer ] :_TValue_       read GetValues write SetValues;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses LUX.GPU.OpenCL;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLBufferIter<_TContext_,_TDevice_,_TValue_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

/////////////////////////////////////////////////////////////////////// アクセス

function TCLBufferIter<_TContext_,_TDevice_,_TValue_>.GetValues( const I_:Integer ) :_TValue_;
var
   P :PValue;
begin
     P := _Head;  Inc( P, I_ );  Result := P^;
end;

procedure TCLBufferIter<_TContext_,_TDevice_,_TValue_>.SetValues( const I_:Integer; const Values_:_TValue_ );
var
   P :PValue;
begin
     P := _Head;  Inc( P, I_ );  P^ := Values_;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLBufferIter<_TContext_,_TDevice_,_TValue_>.Create( const Command_:TCLCommand; const Buffer_:TCLBuffer; const Mode_:T_cl_map_flags = CL_MAP_READ or CL_MAP_WRITE );
var
   E :T_cl_int;
begin
     inherited Create;

     _Command := Command_;
     _Buffer  := Buffer_;
     _Mode    := Mode_;

     _Head := clEnqueueMapBuffer( Command_.Handle, Buffer_.Handle, CL_TRUE, Mode_, 0, Buffer_.Size, 0, nil, nil, @E );

     AssertCL( E );
end;

destructor TCLBufferIter<_TContext_,_TDevice_,_TValue_>.Destroy;
begin
     AssertCL( clEnqueueUnmapMemObject( _Command.Handle, _Buffer.Handle, _Head, 0, nil, nil ) );

     inherited;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

//############################################################################## □

initialization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 初期化

finalization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 最終化

end. //######################################################################### ■
