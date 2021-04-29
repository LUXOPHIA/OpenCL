unit LUX.GPU.OpenCL.Buffer.TIter;

interface //#################################################################### ■

uses cl_version, cl_platform, cl,
     LUX,
     LUX.Code.C,
     LUX.GPU.OpenCL.root,
     LUX.GPU.OpenCL.Comman,
     LUX.GPU.OpenCL.Buffer;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLBufferIter<TCLContex_,TCLPlatfo_,TValue_>

     TCLBufferIter<TCLContex_,TCLPlatfo_:class;TValue_:record> = class
     private
       type TCLComman_ = TCLComman<TCLContex_,TCLPlatfo_>;
            TCLBuffer_ = TCLBuffer<TCLContex_,TValue_>;
            PValue_    = ^TValue_;
     private
       _Comman :TCLComman_;
       _Buffer :TCLBuffer_;
       _Mode   :T_cl_map_flags;
       _Head   :PValue_;
       ///// アクセス
       function GetValues( const I_:Integer ) :TValue_;
       procedure SetValues( const I_:Integer; const Values_:TValue_ );
     public
       constructor Create( const Comman_:TCLComman_; const Buffer_:TCLBuffer_; const Mode_:T_cl_map_flags = CL_MAP_READ or CL_MAP_WRITE );
       destructor Destroy; override;
       ///// プロパティ
       property Comman                     :TCLComman_     read   _Comman                ;
       property Buffer                     :TCLBuffer_     read   _Buffer                ;
       property Mode                       :T_cl_map_flags read   _Mode                  ;
       property Values[ const I_:Integer ] :TValue_        read GetValues write SetValues; default;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses LUX.GPU.OpenCL;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLBufferIter<TCLContex_,TCLPlatfo_,TValue_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

/////////////////////////////////////////////////////////////////////// アクセス

function TCLBufferIter<TCLContex_,TCLPlatfo_,TValue_>.GetValues( const I_:Integer ) :TValue_;
var
   P :PValue_;
begin
     P := _Head;  Inc( P, I_ );  Result := P^;
end;

procedure TCLBufferIter<TCLContex_,TCLPlatfo_,TValue_>.SetValues( const I_:Integer; const Values_:TValue_ );
var
   P :PValue_;
begin
     P := _Head;  Inc( P, I_ );  P^ := Values_;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLBufferIter<TCLContex_,TCLPlatfo_,TValue_>.Create( const Comman_:TCLComman_; const Buffer_:TCLBuffer_; const Mode_:T_cl_map_flags = CL_MAP_READ or CL_MAP_WRITE );
var
   E :T_cl_int;
begin
     inherited Create;

     _Comman := Comman_;
     _Buffer := Buffer_;
     _Mode   := Mode_;

     _Head := clEnqueueMapBuffer( Comman_.Handle, Buffer_.Handle, CL_TRUE, Mode_, 0, Buffer_.Size, 0, nil, nil, @E );

     AssertCL( E );
end;

destructor TCLBufferIter<TCLContex_,TCLPlatfo_,TValue_>.Destroy;
begin
     AssertCL( clEnqueueUnmapMemObject( _Comman.Handle, _Buffer.Handle, _Head, 0, nil, nil ) );

     inherited;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

end. //######################################################################### ■
