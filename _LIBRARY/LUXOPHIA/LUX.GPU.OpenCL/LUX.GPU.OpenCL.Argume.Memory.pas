unit LUX.GPU.OpenCL.Argume.Memory;

interface //#################################################################### ■

uses cl_version, cl_platform, cl,
     LUX.Data.List,
     LUX.Code.C,
     LUX.GPU.OpenCL.core,
     LUX.GPU.OpenCL.Queuer,
     LUX.GPU.OpenCL.Argume;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TCLMemory<TCLSystem_,TCLPlatfo_,TCLContex_:class> = class;

     TCLMemoryIter<TCLSystem_,TCLPlatfo_,TCLContex_:class> = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLMemory<TCLSystem_,TCLPlatfo_,TCLContex_>

     TCLMemory<TCLSystem_,TCLPlatfo_,TCLContex_:class> = class( TCLArgume<TCLSystem_,TCLPlatfo_,TCLContex_> )
     private
       type TCLQueuer_  = TCLQueuer <TCLSystem_,TCLPlatfo_,TCLContex_>;
            TCLArgumes_ = TCLArgumes<TCLSystem_,TCLPlatfo_,TCLContex_>;
            TCLStorag_  = TCLMemoryIter<TCLSystem_,TCLPlatfo_,TCLContex_>;
     protected
       _Handle :T_cl_mem;
       _Kind   :T_cl_mem_flags;
       _Storag :TCLStorag_;
       _Queuer :TCLQueuer_;
       ///// アクセス
       function GetHanPtr :P_void; override;
       function GetHanSiz :T_size_t; override;
       function GetHandle :T_cl_mem; virtual;
       procedure SetHandle( const Handle_:T_cl_mem ); virtual;
       function GetKind :T_cl_mem_flags; virtual;
       procedure SetKind( const Kind_:T_cl_mem_flags ); virtual;
       function GetStorag :TCLStorag_; virtual;
       procedure SetStorag( const Storag_:TCLStorag_ ); virtual;
       function GetSize :T_size_t; virtual; abstract;
       ///// メソッド
       function DestroHandle :T_cl_int; override;
       function NewStorag :TObject; virtual; abstract;
     public
       constructor Create; override;
       constructor Create( const Contex_:TCLContex_; const Queuer_:TCLQueuer_ ); overload; virtual;
       destructor Destroy; override;
       ///// プロパティ
       property Handle  :T_cl_mem       read GetHandle write SetHandle;
       property Kind    :T_cl_mem_flags read GetKind   write SetKind  ;
       property Storag  :TCLStorag_     read GetStorag write SetStorag;
       property Size    :T_size_t       read GetSize                  ;
       property Queuer  :TCLQueuer_     read   _Queuer write   _Queuer;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLMemoryIter<TCLSystem_,TCLPlatfo_,TCLContex_>

     TCLMemoryIter<TCLSystem_,TCLPlatfo_,TCLContex_:class> = class
     private
       type TCLQueuer_ = TCLQueuer<TCLSystem_,TCLPlatfo_,TCLContex_>;
            TCLMemory_ = TCLMemory<TCLSystem_,TCLPlatfo_,TCLContex_>;
     protected
       _Queuer :TCLQueuer_;
       _Memory :TCLMemory_;
       _Mode   :T_cl_map_flags;
       _Handle :P_void;
       ///// アクセス
       function GetQueuer :TCLQueuer_; virtual;
       function GetHandle :P_void; virtual;
       procedure SetHandle( const Handle_:P_void ); virtual;
       ///// メソッド
       function CreateHandle :T_cl_int; virtual; abstract;
       function DestroHandle :T_cl_int; virtual;
     public
       constructor Create; overload; virtual;
       constructor Create( const Memory_:TCLMemory_; const Mode_:T_cl_map_flags = CL_MAP_READ or CL_MAP_WRITE ); overload; virtual;
       destructor Destroy; override;
       ///// プロパティ
       property Queuer :TCLQueuer_     read GetQueuer                ;
       property Memory :TCLMemory_     read   _Memory                ;
       property Mode   :T_cl_map_flags read   _Mode                  ;
       property Handle :P_void         read GetHandle write SetHandle;
       ///// メソッド
       procedure Map; virtual;
       procedure Unmap; virtual;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLMemory<TCLSystem_,TCLPlatfo_,TCLContex_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLMemory<TCLSystem_,TCLPlatfo_,TCLContex_>.GetHanPtr :P_void;
begin
     Result := Handle;
end;

function TCLMemory<TCLSystem_,TCLPlatfo_,TCLContex_>.GetHanSiz :T_size_t;
begin
     Result := SizeOf( T_cl_mem );
end;

//------------------------------------------------------------------------------

function TCLMemory<TCLSystem_,TCLPlatfo_,TCLContex_>.GetHandle :T_cl_mem;
begin
     if not Assigned( _Handle ) then CreateHandle;

     Result := _Handle;
end;

procedure TCLMemory<TCLSystem_,TCLPlatfo_,TCLContex_>.SetHandle( const Handle_:T_cl_mem );
begin
     if Assigned( _Handle ) then AssertCL( DestroHandle, 'TCLMemory.DestroHandle is Error!' );

     _Handle := Handle_;
end;

//------------------------------------------------------------------------------

function TCLMemory<TCLSystem_,TCLPlatfo_,TCLContex_>.GetKind :T_cl_mem_flags;
begin
     Result := _Kind;
end;

procedure TCLMemory<TCLSystem_,TCLPlatfo_,TCLContex_>.SetKind( const Kind_:T_cl_mem_flags );
begin
     _Kind := Kind_;
end;

//------------------------------------------------------------------------------

function TCLMemory<TCLSystem_,TCLPlatfo_,TCLContex_>.GetStorag :TCLStorag_;
begin
     Result := _Storag;
end;

procedure TCLMemory<TCLSystem_,TCLPlatfo_,TCLContex_>.SetStorag( const Storag_:TCLStorag_ );
begin
     _Storag := Storag_;

     Handle := nil;
end;

/////////////////////////////////////////////////////////////////////// メソッド

function TCLMemory<TCLSystem_,TCLPlatfo_,TCLContex_>.DestroHandle :T_cl_int;
begin
     Result := clReleaseMemObject( _Handle );

     _Handle := nil;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLMemory<TCLSystem_,TCLPlatfo_,TCLContex_>.Create;
begin
     inherited;

     _Handle := nil;

     _Kind   := CL_MEM_READ_WRITE;
     _Storag := TCLStorag_( NewStorag );
     _Queuer := nil;
end;

constructor TCLMemory<TCLSystem_,TCLPlatfo_,TCLContex_>.Create( const Contex_:TCLContex_; const Queuer_:TCLQueuer_ );
begin
     Create( Contex_ );

     _Queuer := Queuer_;
end;

destructor TCLMemory<TCLSystem_,TCLPlatfo_,TCLContex_>.Destroy;
begin
     _Storag.Free;

      Handle := nil;

     inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLMemoryIter<TCLSystem_,TCLPlatfo_,TCLContex_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

/////////////////////////////////////////////////////////////////////// アクセス

function TCLMemoryIter<TCLSystem_,TCLPlatfo_,TCLContex_>.GetQueuer :TCLQueuer_;
begin
     Result := Memory.Queuer;
end;

//------------------------------------------------------------------------------

function TCLMemoryIter<TCLSystem_,TCLPlatfo_,TCLContex_>.GetHandle :P_void;
begin
     if not Assigned( _Handle ) then CreateHandle;

     Result := _Handle;
end;

procedure TCLMemoryIter<TCLSystem_,TCLPlatfo_,TCLContex_>.SetHandle( const Handle_:P_void );
begin
     if Assigned( _Handle ) then AssertCL( DestroHandle, 'TCLMemoryIter.DestroHandle is Error!' );

     _Handle := Handle_;
end;

/////////////////////////////////////////////////////////////////////// メソッド

function TCLMemoryIter<TCLSystem_,TCLPlatfo_,TCLContex_>.DestroHandle :T_cl_int;
begin
     Result := clEnqueueUnmapMemObject( Queuer.Handle, Memory.Handle, _Handle, 0, nil, nil );

     _Handle := nil;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLMemoryIter<TCLSystem_,TCLPlatfo_,TCLContex_>.Create;
begin
     inherited;

     _Handle := nil;

     _Queuer := nil;
     _Memory := nil;
     _Mode   := CL_MAP_READ or CL_MAP_WRITE;
end;

constructor TCLMemoryIter<TCLSystem_,TCLPlatfo_,TCLContex_>.Create( const Memory_:TCLMemory_; const Mode_:T_cl_map_flags = CL_MAP_READ or CL_MAP_WRITE );
begin
     Create;

     _Memory := Memory_;
     _Mode   := Mode_;
end;

destructor TCLMemoryIter<TCLSystem_,TCLPlatfo_,TCLContex_>.Destroy;
begin
      Handle := nil;

     inherited;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLMemoryIter<TCLSystem_,TCLPlatfo_,TCLContex_>.Map;
begin
     Handle;
end;

procedure TCLMemoryIter<TCLSystem_,TCLPlatfo_,TCLContex_>.Unmap;
begin
     Handle := nil;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

end. //######################################################################### ■
