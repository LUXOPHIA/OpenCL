unit LUX.GPU.OpenCL.Memory;

interface //#################################################################### ■

uses cl_version, cl_platform, cl,
     LUX.Data.List,
     LUX.Code.C,
     LUX.GPU.OpenCL.root;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TCLMemorys <TCLContex_:class> = class;
       TCLMemory<TCLContex_:class> = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLMemory<TCLContex_>

     TCLMemory<TCLContex_:class> = class( TListChildr<TCLContex_,TCLMemorys<TCLContex_>> )
     private
       type TCLMemorys_ = TCLMemorys<TCLContex_>;
     protected
       _Handle :T_cl_mem;
       _Kind   :T_cl_mem_flags;
       ///// アクセス
       function GetHandle :T_cl_mem;
       procedure SetHandle( const Handle_:T_cl_mem );
       ///// メソッド
       procedure CreateHandle; virtual; abstract;
       procedure DestroHandle; virtual;
     public
       constructor Create; override;
       constructor Create( const Contex_:TCLContex_ ); overload; virtual;
       destructor Destroy; override;
       ///// プロパティ
       property Contex  :TCLContex_  read GetOwnere                ;
       property Memorys :TCLMemorys_ read GetParent                ;
       property Handle  :T_cl_mem    read GetHandle write SetHandle;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLMemorys<TCLContex_>

     TCLMemorys<TCLContex_:class> = class( TListParent<TCLContex_,TCLMemory<TCLContex_>> )
     private
     protected
     public
       ///// プロパティ
       property Contex :TCLContex_ read GetOwnere;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses LUX.GPU.OpenCL;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLMemory<TCLContex_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLMemory<TCLContex_>.GetHandle :T_cl_mem;
begin
     if not Assigned( _Handle ) then CreateHandle;

     Result := _Handle;
end;

procedure TCLMemory<TCLContex_>.SetHandle( const Handle_:T_cl_mem );
begin
     if Assigned( _Handle ) then DestroHandle;

     _Handle := Handle_;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLMemory<TCLContex_>.DestroHandle;
begin
     clReleaseMemObject( _Handle );

     _Handle := nil;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLMemory<TCLContex_>.Create;
begin
     inherited;

     _Handle := nil;

     _Kind := CL_MEM_READ_WRITE;
end;

constructor TCLMemory<TCLContex_>.Create( const Contex_:TCLContex_ );
begin
     inherited Create( TCLContex( Contex_ ).Memorys );
end;

destructor TCLMemory<TCLContex_>.Destroy;
begin
      Handle := nil;

     inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLMemorys<TCLContex_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

end. //######################################################################### ■
