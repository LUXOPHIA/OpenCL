unit LUX.GPU.OpenCL.Argume.Memory.Buffer;

interface //#################################################################### ■

uses cl_version, cl_platform, cl,
     LUX,
     LUX.Code.C,
     LUX.GPU.OpenCL.core,
     LUX.GPU.OpenCL.Queuer,
     LUX.GPU.OpenCL.Argume.Memory;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TCLBuffer<TCLSystem_,TCLContex_,TCLPlatfo_:class;TValue_:record> = class;
     TCLDevBuf<TCLSystem_,TCLContex_,TCLPlatfo_:class;TValue_:record> = class;
     TCLHosBuf<TCLSystem_,TCLContex_,TCLPlatfo_:class;TValue_:record> = class;
     
     TCLBufferIter<TCLSystem_,TCLContex_,TCLPlatfo_:class;TValue_:record> = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLBuffer<TCLSystem_,TCLContex_,TCLPlatfo_,TValue_>

     TCLBuffer<TCLSystem_,TCLContex_,TCLPlatfo_:class;TValue_:record> = class( TCLMemory<TCLSystem_,TCLContex_,TCLPlatfo_> )
     private
       type TCLStorag_ = TCLBufferIter<TCLSystem_,TCLContex_,TCLPlatfo_,TValue_>;
     protected
       _Count :Integer;
       ///// アクセス
       function GetStorag :TCLStorag_; reintroduce; virtual;
       procedure SetStorag( const Storag_:TCLStorag_ ); reintroduce; virtual;
       function GetSize :T_size_t; override;
       function GetCount :Integer; virtual;
       procedure SetCount( const Count_:Integer ); virtual;
       ///// メソッド
       function NewStorag :TObject; override;
     public
       constructor Create; override;
       destructor Destroy; override;
       ///// プロパティ
       property Storag :TCLStorag_ read GetStorag write SetStorag;
       property Count  :Integer    read GetCount  write SetCount ;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDevBuf<TCLSystem_,TCLContex_,TCLPlatfo_,TValue_>

     TCLDevBuf<TCLSystem_,TCLContex_,TCLPlatfo_:class;TValue_:record> = class( TCLBuffer<TCLSystem_,TCLContex_,TCLPlatfo_,TValue_> )
     private
     protected
       ///// メソッド
       function CreateHandle :T_cl_int; override;
     public
       constructor Create; override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLHosBuf<TCLSystem_,TCLContex_,TCLPlatfo_,TValue_>

     TCLHosBuf<TCLSystem_,TCLContex_,TCLPlatfo_:class;TValue_:record> = class( TCLBuffer<TCLSystem_,TCLContex_,TCLPlatfo_,TValue_> )
     private
     protected
       _Data :P_void;
       ///// メソッド
       function CreateHandle :T_cl_int; override;
       function DestroHandle :T_cl_int; override;
     public
       constructor Create; override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLBufferIter<TCLSystem_,TCLContex_,TCLPlatfo_,TValue_>

     TCLBufferIter<TCLSystem_,TCLContex_,TCLPlatfo_:class;TValue_:record> = class( TCLMemoryIter<TCLSystem_,TCLContex_,TCLPlatfo_> )
     private
       type TCLQueuer_ = TCLQueuer<TCLSystem_,TCLContex_,TCLPlatfo_>;
            TCLBuffer_ = TCLBuffer<TCLSystem_,TCLContex_,TCLPlatfo_,TValue_>;
            PValue_    = ^TValue_;
     protected
       ///// アクセス
       function GetBuffer :TCLBuffer_; virtual;
       function GetValues( const I_:Integer ) :TValue_; virtual;
       procedure SetValues( const I_:Integer; const Values_:TValue_ ); virtual;
       ///// メソッド
       function CreateHandle :T_cl_int; override;
     public
       ///// プロパティ
       property Buffer                     :TCLBuffer_ read GetBuffer                ;
       property Values[ const I_:Integer ] :TValue_    read GetValues write SetValues; default;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses LUX.GPU.OpenCL;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLBuffer<TCLSystem_,TCLContex_,TCLPlatfo_,TValue_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLBuffer<TCLSystem_,TCLContex_,TCLPlatfo_,TValue_>.GetStorag :TCLStorag_;
begin
     Result := TCLStorag_( inherited Storag );
end;

procedure TCLBuffer<TCLSystem_,TCLContex_,TCLPlatfo_,TValue_>.SetStorag( const Storag_:TCLStorag_ );
begin
     inherited Storag := Storag_;
end;

//------------------------------------------------------------------------------

function TCLBuffer<TCLSystem_,TCLContex_,TCLPlatfo_,TValue_>.GetSize :T_size_t;
begin
     Result := SizeOf( TValue_ ) * _Count;
end;

//------------------------------------------------------------------------------

function TCLBuffer<TCLSystem_,TCLContex_,TCLPlatfo_,TValue_>.GetCount :Integer;
begin
     Result := _Count;
end;

procedure TCLBuffer<TCLSystem_,TCLContex_,TCLPlatfo_,TValue_>.SetCount( const Count_:Integer );
begin
     Handle := nil;

     _Count := Count_;
end;

/////////////////////////////////////////////////////////////////////// メソッド

function TCLBuffer<TCLSystem_,TCLContex_,TCLPlatfo_,TValue_>.NewStorag :TObject;
begin
     Result := TCLStorag_.Create( Self );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLBuffer<TCLSystem_,TCLContex_,TCLPlatfo_,TValue_>.Create;
begin
     inherited;

     _Count := 1;
end;

destructor TCLBuffer<TCLSystem_,TCLContex_,TCLPlatfo_,TValue_>.Destroy;
begin
      Handle := nil;

     inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDevBuf<TCLSystem_,TCLContex_,TCLPlatfo_,TValue_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// メソッド

function TCLDevBuf<TCLSystem_,TCLContex_,TCLPlatfo_,TValue_>.CreateHandle :T_cl_int;
begin
     _Handle := clCreateBuffer( TCLContex( Contex ).Handle, Kind, Size, nil, @Result );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLDevBuf<TCLSystem_,TCLContex_,TCLPlatfo_,TValue_>.Create;
begin
     inherited;

     _Kind := CL_MEM_READ_WRITE or CL_MEM_ALLOC_HOST_PTR;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLHosBuf<TCLSystem_,TCLContex_,TCLPlatfo_,TValue_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// メソッド

function TCLHosBuf<TCLSystem_,TCLContex_,TCLPlatfo_,TValue_>.CreateHandle :T_cl_int;
begin
     inherited;

     GetMemAligned( _Data, Ceil2N( Size, 64{Byte} ), 4096{Byte} );

     _Handle := clCreateBuffer( TCLContex( Contex ).Handle, Kind, Size, _Data, @Result );
end;

function TCLHosBuf<TCLSystem_,TCLContex_,TCLPlatfo_,TValue_>.DestroHandle :T_cl_int;
begin
     FreeMemAligned( _Data );

     inherited;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLHosBuf<TCLSystem_,TCLContex_,TCLPlatfo_,TValue_>.Create;
begin
     inherited;

     _Kind := CL_MEM_READ_WRITE or CL_MEM_USE_HOST_PTR;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLBufferIter<TCLSystem_,TCLContex_,TCLPlatfo_,TValue_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

/////////////////////////////////////////////////////////////////////// アクセス

function TCLBufferIter<TCLSystem_,TCLContex_,TCLPlatfo_,TValue_>.GetBuffer :TCLBuffer_;
begin
     Result := TCLBuffer_( Memory );
end;

function TCLBufferIter<TCLSystem_,TCLContex_,TCLPlatfo_,TValue_>.GetValues( const I_:Integer ) :TValue_;
var
   P :PValue_;
begin
     P := Handle;  Inc( P, I_ );  Result := P^;
end;

procedure TCLBufferIter<TCLSystem_,TCLContex_,TCLPlatfo_,TValue_>.SetValues( const I_:Integer; const Values_:TValue_ );
var
   P :PValue_;
begin
     P := Handle;  Inc( P, I_ );  P^ := Values_;
end;

/////////////////////////////////////////////////////////////////////// メソッド

function TCLBufferIter<TCLSystem_,TCLContex_,TCLPlatfo_,TValue_>.CreateHandle :T_cl_int;
begin
     inherited;

     _Handle := clEnqueueMapBuffer( Queuer.Handle, Buffer.Handle, CL_TRUE, Mode, 0, Buffer.Size, 0, nil, nil, @Result );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

end. //######################################################################### ■
