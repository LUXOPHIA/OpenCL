unit LUX.GPU.OpenCL.Memory;

interface //#################################################################### ■

uses cl_version, cl_platform, cl,
     LUX.Data.List,
     LUX.Code.C,
     LUX.GPU.OpenCL.root,
     LUX.GPU.OpenCL.Queuer;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TCLMemorys <TCLContex_,TCLPlatfo_:class> = class;
       TCLMemory<TCLContex_,TCLPlatfo_:class> = class;

     TCLMemoryIter<TCLContex_,TCLPlatfo_:class> = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLMemory<TCLContex_,TCLPlatfo_>

     TCLMemory<TCLContex_,TCLPlatfo_:class> = class( TListChildr<TCLContex_,TCLMemorys<TCLContex_,TCLPlatfo_>> )
     private
       type TCLQueuer_  = TCLQueuer <TCLContex_,TCLPlatfo_>;
            TCLMemorys_ = TCLMemorys<TCLContex_,TCLPlatfo_>;
            TCLStorag_  = TCLMemoryIter<TCLContex_,TCLPlatfo_>;
     protected
       _Handle :T_cl_mem;
       _Kind   :T_cl_mem_flags;
       _Storag :TCLStorag_;
       _Queuer :TCLQueuer_;
       ///// アクセス
       function GetHandle :T_cl_mem; virtual;
       procedure SetHandle( const Handle_:T_cl_mem ); virtual;
       function GetStorag :TCLStorag_; virtual;
       procedure SetStorag( const Storag_:TCLStorag_ ); virtual;
       function GetSize :T_size_t; virtual; abstract;
       ///// メソッド
       procedure CreateHandle; virtual; abstract;
       procedure DestroHandle; virtual;
     public
       constructor Create; override;
       constructor Create( const Contex_:TCLContex_ ); overload; virtual;
       constructor Create( const Contex_:TCLContex_; const Queuer_:TCLQueuer_ ); overload; virtual;
       destructor Destroy; override;
       ///// プロパティ
       property Contex  :TCLContex_     read GetOwnere                ;
       property Memorys :TCLMemorys_    read GetParent                ;
       property Handle  :T_cl_mem       read GetHandle write SetHandle;
       property Kind    :T_cl_mem_flags read   _Kind                  ;
       property Storag  :TCLStorag_     read GetStorag write SetStorag;
       property Size    :T_size_t       read GetSize                  ;
       property Queuer  :TCLQueuer_     read   _Queuer write   _Queuer;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLMemorys<TCLContex_,TCLPlatfo_>

     TCLMemorys<TCLContex_,TCLPlatfo_:class> = class( TListParent<TCLContex_,TCLMemory<TCLContex_,TCLPlatfo_>> )
     private
     protected
     public
       ///// プロパティ
       property Contex :TCLContex_ read GetOwnere;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLMemoryIter<TCLContex_,TCLPlatfo_>

     TCLMemoryIter<TCLContex_,TCLPlatfo_:class> = class
     private
       type TCLQueuer_ = TCLQueuer<TCLContex_,TCLPlatfo_>;
            TCLMemory_ = TCLMemory<TCLContex_,TCLPlatfo_>;
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
       procedure CreateHandle; virtual; abstract;
       procedure DestroHandle; virtual;
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

uses LUX.GPU.OpenCL;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLMemory<TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLMemory<TCLContex_,TCLPlatfo_>.GetHandle :T_cl_mem;
begin
     if not Assigned( _Handle ) then CreateHandle;

     Result := _Handle;
end;

procedure TCLMemory<TCLContex_,TCLPlatfo_>.SetHandle( const Handle_:T_cl_mem );
begin
     if Assigned( _Handle ) then DestroHandle;

     _Handle := Handle_;
end;

//------------------------------------------------------------------------------

function TCLMemory<TCLContex_,TCLPlatfo_>.GetStorag :TCLStorag_;
begin
     Result := _Storag;
end;

procedure TCLMemory<TCLContex_,TCLPlatfo_>.SetStorag( const Storag_:TCLStorag_ );
begin
     _Storag := Storag_;

     Handle := nil;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLMemory<TCLContex_,TCLPlatfo_>.DestroHandle;
begin
     clReleaseMemObject( _Handle );

     _Handle := nil;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLMemory<TCLContex_,TCLPlatfo_>.Create;
begin
     inherited;

     _Handle := nil;

     _Kind   := CL_MEM_READ_WRITE;
     _Storag := nil;
     _Queuer := nil;
end;

constructor TCLMemory<TCLContex_,TCLPlatfo_>.Create( const Contex_:TCLContex_ );
begin
     inherited Create( TCLContex( Contex_ ).Memorys );
end;

constructor TCLMemory<TCLContex_,TCLPlatfo_>.Create( const Contex_:TCLContex_; const Queuer_:TCLQueuer_ );
begin
     Create( Contex_ );

     _Queuer := Queuer_;
end;

destructor TCLMemory<TCLContex_,TCLPlatfo_>.Destroy;
begin
      Handle := nil;

     if Assigned( _Storag ) then _Storag.Free;

     inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLMemorys<TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLMemoryIter<TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

/////////////////////////////////////////////////////////////////////// アクセス

function TCLMemoryIter<TCLContex_,TCLPlatfo_>.GetQueuer :TCLQueuer_;
begin
     Result := Memory.Queuer;
end;

//------------------------------------------------------------------------------

function TCLMemoryIter<TCLContex_,TCLPlatfo_>.GetHandle :P_void;
begin
     if not Assigned( _Handle ) then CreateHandle;

     Result := _Handle;
end;

procedure TCLMemoryIter<TCLContex_,TCLPlatfo_>.SetHandle( const Handle_:P_void );
begin
     if Assigned( _Handle ) then DestroHandle;

     _Handle := Handle_;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLMemoryIter<TCLContex_,TCLPlatfo_>.DestroHandle;
begin
     AssertCL( clEnqueueUnmapMemObject( Queuer.Handle, Memory.Handle, _Handle, 0, nil, nil ) );

     _Handle := nil;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLMemoryIter<TCLContex_,TCLPlatfo_>.Create;
begin
     inherited;

     _Handle := nil;

     _Queuer := nil;
     _Memory := nil;
     _Mode   := CL_MAP_READ or CL_MAP_WRITE;
end;

constructor TCLMemoryIter<TCLContex_,TCLPlatfo_>.Create( const Memory_:TCLMemory_; const Mode_:T_cl_map_flags = CL_MAP_READ or CL_MAP_WRITE );
begin
     Create;

     _Memory := Memory_;
     _Mode   := Mode_;
end;

destructor TCLMemoryIter<TCLContex_,TCLPlatfo_>.Destroy;
begin
      Handle := nil;

     inherited;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLMemoryIter<TCLContex_,TCLPlatfo_>.Map;
begin
     Handle;
end;

procedure TCLMemoryIter<TCLContex_,TCLPlatfo_>.Unmap;
begin
     Handle := nil;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

end. //######################################################################### ■
