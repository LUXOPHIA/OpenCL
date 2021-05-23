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

     TCLMemDat<TCLSystem_,TCLPlatfo_,TCLContex_:class> = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLMemory<TCLSystem_,TCLPlatfo_,TCLContex_>

     TCLMemory<TCLSystem_,TCLPlatfo_,TCLContex_:class> = class( TCLArgume<TCLSystem_,TCLPlatfo_,TCLContex_> )
     private
       type TCLQueuer_  = TCLQueuer <TCLSystem_,TCLPlatfo_,TCLContex_>;
            TCLArgumes_ = TCLArgumes<TCLSystem_,TCLPlatfo_,TCLContex_>;
            TCLMemDat_  = TCLMemDat <TCLSystem_,TCLPlatfo_,TCLContex_>;
     protected
       _Handle :T_cl_mem;
       _Kind   :T_cl_mem_flags;
       _Data   :TCLMemDat_;
       _Queuer :TCLQueuer_;
       ///// アクセス
       function GetHanPtr :P_void; override;
       function GetHanSiz :T_size_t; override;
       function GetHandle :T_cl_mem; virtual;
       procedure SetHandle( const Handle_:T_cl_mem ); virtual;
       function GetKind :T_cl_mem_flags; virtual;
       procedure SetKind( const Kind_:T_cl_mem_flags ); virtual;
       function GetData :TCLMemDat_; virtual;
       procedure SetData( const Data_:TCLMemDat_ ); virtual;
       function GetSize :T_size_t; virtual; abstract;
       ///// メソッド
       function DestroHandle :T_cl_int; override;
       function NewData :TObject; virtual; abstract;
     public
       constructor Create; override;
       constructor Create( const Contex_:TCLContex_; const Queuer_:TCLQueuer_ ); overload; virtual;
       destructor Destroy; override;
       ///// プロパティ
       property Handle :T_cl_mem       read GetHandle write SetHandle;
       property Kind   :T_cl_mem_flags read GetKind   write SetKind  ;
       property Data   :TCLMemDat_     read GetData   write SetData  ;
       property Size   :T_size_t       read GetSize                  ;
       property Queuer :TCLQueuer_     read   _Queuer write   _Queuer;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLMemDat<TCLSystem_,TCLPlatfo_,TCLContex_>

     TCLMemDat<TCLSystem_,TCLPlatfo_,TCLContex_:class> = class
     private
       type TCLQueuer_ = TCLQueuer<TCLSystem_,TCLPlatfo_,TCLContex_>;
            TCLMemory_ = TCLMemory<TCLSystem_,TCLPlatfo_,TCLContex_>;
     protected
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

function TCLMemory<TCLSystem_,TCLPlatfo_,TCLContex_>.GetData :TCLMemDat_;
begin
     Result := _Data;
end;

procedure TCLMemory<TCLSystem_,TCLPlatfo_,TCLContex_>.SetData( const Data_:TCLMemDat_ );
begin
     _Data := Data_;

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
     _Data   := TCLMemDat_( NewData );
     _Queuer := nil;
end;

constructor TCLMemory<TCLSystem_,TCLPlatfo_,TCLContex_>.Create( const Contex_:TCLContex_; const Queuer_:TCLQueuer_ );
begin
     Create( Contex_ );

     _Queuer := Queuer_;
end;

destructor TCLMemory<TCLSystem_,TCLPlatfo_,TCLContex_>.Destroy;
begin
     _Data.Free;

      Handle := nil;

     inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLMemDat<TCLSystem_,TCLPlatfo_,TCLContex_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

/////////////////////////////////////////////////////////////////////// アクセス

function TCLMemDat<TCLSystem_,TCLPlatfo_,TCLContex_>.GetQueuer :TCLQueuer_;
begin
     Result := Memory.Queuer;
end;

//------------------------------------------------------------------------------

function TCLMemDat<TCLSystem_,TCLPlatfo_,TCLContex_>.GetHandle :P_void;
begin
     if not Assigned( _Handle ) then CreateHandle;

     Result := _Handle;
end;

procedure TCLMemDat<TCLSystem_,TCLPlatfo_,TCLContex_>.SetHandle( const Handle_:P_void );
begin
     if Assigned( _Handle ) then AssertCL( DestroHandle, 'TCLMemoryIter.DestroHandle is Error!' );

     _Handle := Handle_;
end;

/////////////////////////////////////////////////////////////////////// メソッド

function TCLMemDat<TCLSystem_,TCLPlatfo_,TCLContex_>.DestroHandle :T_cl_int;
begin
     Result := clEnqueueUnmapMemObject( Queuer.Handle, Memory.Handle, _Handle, 0, nil, nil );

     _Handle := nil;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLMemDat<TCLSystem_,TCLPlatfo_,TCLContex_>.Create;
begin
     inherited;

     _Handle := nil;

     _Memory := nil;
     _Mode   := CL_MAP_READ or CL_MAP_WRITE;
end;

constructor TCLMemDat<TCLSystem_,TCLPlatfo_,TCLContex_>.Create( const Memory_:TCLMemory_; const Mode_:T_cl_map_flags = CL_MAP_READ or CL_MAP_WRITE );
begin
     Create;

     _Memory := Memory_;
     _Mode   := Mode_;
end;

destructor TCLMemDat<TCLSystem_,TCLPlatfo_,TCLContex_>.Destroy;
begin
      Handle := nil;

     inherited;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLMemDat<TCLSystem_,TCLPlatfo_,TCLContex_>.Map;
begin
     Handle;
end;

procedure TCLMemDat<TCLSystem_,TCLPlatfo_,TCLContex_>.Unmap;
begin
     Handle := nil;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

end. //######################################################################### ■
