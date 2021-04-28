unit LUX.GPU.OpenCL.Memory;

interface //#################################################################### ■

uses cl_version, cl_platform, cl,
     LUX.Code.C,
     LUX.GPU.OpenCL.root;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLMemory<_TContext_>

     TCLMemory<_TContext_:class> = class
     private
     protected
       _Parent :_TContext_;
       _Handle :T_cl_mem;
       _Kind   :T_cl_mem_flags;
       ///// アクセス
       procedure SetParent( const Parent_:_TContext_ );
       function GetHandle :T_cl_mem;
       function GetavHandle :Boolean;
       procedure SetavHandle( const avHandle_:Boolean );
       ///// メソッド
       procedure BeginHandle; virtual; abstract;
       procedure EndHandle; virtual;
     public
       constructor Create; overload; virtual;
       constructor Create( const Parent_:_TContext_ ); overload; virtual;
       destructor Destroy; override;
       ///// プロパティ
       property Parent   :_TContext_ read   _Parent   write SetParent  ;
       property Handle   :T_cl_mem   read GetHandle                    ;
       property avHandle :Boolean    read GetavHandle write SetavHandle;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses LUX.GPU.OpenCL;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLMemory<_TContext_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

procedure TCLMemory<_TContext_>.SetParent( const Parent_:_TContext_ );
begin
     if Assigned( _Parent ) then TCLContex( _Parent ).Memorys.Remove( TCLMemory( Self ) );

                  _Parent := Parent_;

     if Assigned( _Parent ) then TCLContex( _Parent ).Memorys.Add   ( TCLMemory( Self ) );
end;

//------------------------------------------------------------------------------

function TCLMemory<_TContext_>.GetHandle :T_cl_mem;
begin
     if not avHandle then BeginHandle;

     Result := _Handle;
end;

function TCLMemory<_TContext_>.GetavHandle :Boolean;
begin
     Result := Assigned( TCLContex( _Parent )._Handle ) and Assigned( _Handle );
end;

procedure TCLMemory<_TContext_>.SetavHandle( const avHandle_:Boolean );
begin
     if avHandle  then EndHandle;

     if avHandle_ then BeginHandle;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLMemory<_TContext_>.EndHandle;
begin
     clReleaseMemObject( _Handle );

     _Handle := nil;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLMemory<_TContext_>.Create;
begin
     inherited;

     _Parent  := nil;
     _Handle  := nil;
     _Kind    := CL_MEM_READ_WRITE;
end;

constructor TCLMemory<_TContext_>.Create( const Parent_:_TContext_ );
begin
     Create;

     Parent := Parent_;
end;

destructor TCLMemory<_TContext_>.Destroy;
begin
     if avHandle then EndHandle;

     inherited;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

//############################################################################## □

initialization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 初期化

finalization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 最終化

end. //######################################################################### ■
