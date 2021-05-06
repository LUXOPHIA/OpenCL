unit LUX.GPU.OpenCL.Memory.Buffer;

interface //#################################################################### ■

uses cl_version, cl_platform, cl,
     LUX,
     LUX.Code.C,
     LUX.GPU.OpenCL.root,
     LUX.GPU.OpenCL.Queuer,
     LUX.GPU.OpenCL.Memory;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TCLBuffer    <TCLContex_:class;TValue_:record> = class;
     TCLBufferIter<TCLContex_,TCLPlatfo_:class;TValue_:record> = class;
     TCLDeviceBuffer<TCLContex_:class;TValue_:record> = class;
     TCLHostBuffer<TCLContex_:class;TValue_:record> = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLBuffer<TCLContex_,TValue_>

     TCLBuffer<TCLContex_:class;TValue_:record> = class( TCLMemory<TCLContex_> )
     private
     protected
       _Count :Integer;
       ///// アクセス
       function GetCount :Integer;
       procedure SetCount( const Count_:Integer );
       function GetSize :T_size_t; override;
     public
       constructor Create; override;
       ///// プロパティ
       property Count :Integer  read GetCount write SetCount;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDeviceBuffer<TCLContex_,TValue_>

     TCLDeviceBuffer<TCLContex_:class;TValue_:record> = class( TCLBuffer<TCLContex_,TValue_> )
     private
     protected
       ///// メソッド
       procedure CreateHandle; override;
     public
       constructor Create; override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLHostBuffer<TCLContex_,TValue_>

     TCLHostBuffer<TCLContex_:class;TValue_:record> = class( TCLBuffer<TCLContex_,TValue_> )
     private
     protected
       _Data :P_void;
       ///// メソッド
       procedure CreateHandle; override;
       procedure DestroHandle; override;
     public
       constructor Create; override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLBufferIter<TCLContex_,TCLPlatfo_,TValue_>

     TCLBufferIter<TCLContex_,TCLPlatfo_:class;TValue_:record> = class
     private
       type TCLQueuer_ = TCLQueuer<TCLContex_,TCLPlatfo_>;
            TCLBuffer_ = TCLBuffer<TCLContex_,TValue_>;
            PValue_    = ^TValue_;
     private
       _Queuer :TCLQueuer_;
       _Buffer :TCLBuffer_;
       _Mode   :T_cl_map_flags;
       _Head   :PValue_;
       ///// アクセス
       function GetValues( const I_:Integer ) :TValue_;
       procedure SetValues( const I_:Integer; const Values_:TValue_ );
     public
       constructor Create( const Queuer_:TCLQueuer_; const Buffer_:TCLBuffer_; const Mode_:T_cl_map_flags = CL_MAP_READ or CL_MAP_WRITE );
       destructor Destroy; override;
       ///// プロパティ
       property Queuer                     :TCLQueuer_     read   _Queuer                ;
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

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLBuffer<TCLContex_,TValue_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLBuffer<TCLContex_,TValue_>.GetCount :Integer;
begin
     Result := _Count;
end;

procedure TCLBuffer<TCLContex_,TValue_>.SetCount( const Count_:Integer );
begin
     Handle := nil;

     _Count := Count_;
end;

//------------------------------------------------------------------------------

function TCLBuffer<TCLContex_,TValue_>.GetSize :T_size_t;
begin
     Result := SizeOf( TValue_ ) * _Count;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLBuffer<TCLContex_,TValue_>.Create;
begin
     inherited;

     _Count := 1;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDeviceBuffer<TCLContex_,TValue_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLDeviceBuffer<TCLContex_,TValue_>.CreateHandle;
var
   E :T_cl_int;
begin
     _Handle := clCreateBuffer( TCLContex( Contex ).Handle, _Kind, Size, nil, @E );

     AssertCL( E );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLDeviceBuffer<TCLContex_,TValue_>.Create;
begin
     inherited;

     _Kind := CL_MEM_READ_WRITE or CL_MEM_ALLOC_HOST_PTR;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLHostBuffer<TCLContex_,TValue_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLHostBuffer<TCLContex_,TValue_>.CreateHandle;
var
   E :T_cl_int;
begin
     inherited;

     GetMemAligned( _Data, Ceil2N( Size, 64{Byte} ), 4096{Byte} );

     _Handle := clCreateBuffer( TCLContex( Contex ).Handle, _Kind, Size, _Data, @E );

     AssertCL( E );
end;

procedure TCLHostBuffer<TCLContex_,TValue_>.DestroHandle;
begin
     FreeMemAligned( _Data );

     inherited;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLHostBuffer<TCLContex_,TValue_>.Create;
begin
     inherited;

     _Kind := CL_MEM_READ_WRITE or CL_MEM_USE_HOST_PTR;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

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

constructor TCLBufferIter<TCLContex_,TCLPlatfo_,TValue_>.Create( const Queuer_:TCLQueuer_; const Buffer_:TCLBuffer_; const Mode_:T_cl_map_flags = CL_MAP_READ or CL_MAP_WRITE );
var
   E :T_cl_int;
begin
     inherited Create;

     _Queuer := Queuer_;
     _Buffer := Buffer_;
     _Mode   := Mode_;

     _Head := clEnqueueMapBuffer( Queuer_.Handle, Buffer_.Handle, CL_TRUE, Mode_, 0, Buffer_.Size, 0, nil, nil, @E );

     AssertCL( E );
end;

destructor TCLBufferIter<TCLContex_,TCLPlatfo_,TValue_>.Destroy;
begin
     AssertCL( clEnqueueUnmapMemObject( _Queuer.Handle, _Buffer.Handle, _Head, 0, nil, nil ) );

     inherited;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

end. //######################################################################### ■
