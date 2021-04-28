unit LUX.GPU.OpenCL.Memory;

interface //#################################################################### ■

uses cl_version, cl_platform, cl,
     LUX.Code.C,
     LUX.GPU.OpenCL.root;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLMemory<TCLContex_>

     TCLMemory<TCLContex_:class> = class
     private
     protected
       _Contex :TCLContex_;
       _Handle :T_cl_mem;
       _Kind   :T_cl_mem_flags;
       ///// アクセス
       procedure SetContex( const Contex_:TCLContex_ );
       function GetHandle :T_cl_mem;
       procedure SetHandle( const Handle_:T_cl_mem );
       ///// メソッド
       procedure CreateHandle; virtual; abstract;
       procedure DestroHandle; virtual;
     public
       constructor Create; overload; virtual;
       constructor Create( const Contex_:TCLContex_ ); overload; virtual;
       destructor Destroy; override;
       ///// プロパティ
       property Contex :TCLContex_ read   _Contex write SetContex;
       property Handle :T_cl_mem   read GetHandle write SetHandle;
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

procedure TCLMemory<TCLContex_>.SetContex( const Contex_:TCLContex_ );
begin
     if Assigned( _Contex ) then TCLContex( _Contex ).Memorys.Remove( TCLMemory( Self ) );

                  _Contex := Contex_;

     if Assigned( _Contex ) then TCLContex( _Contex ).Memorys.Add   ( TCLMemory( Self ) );
end;

//------------------------------------------------------------------------------

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

     _Contex := nil;
     _Kind   := CL_MEM_READ_WRITE;
end;

constructor TCLMemory<TCLContex_>.Create( const Contex_:TCLContex_ );
begin
     Create;

     Contex := Contex_;
end;

destructor TCLMemory<TCLContex_>.Destroy;
begin
      Handle := nil;

     inherited;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

end. //######################################################################### ■
