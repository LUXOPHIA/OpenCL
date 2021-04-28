unit LUX.GPU.OpenCL.Buffer;

interface //#################################################################### ■

uses cl_version, cl_platform, cl,
     LUX,
     LUX.Code.C,
     LUX.GPU.OpenCL.root,
     LUX.GPU.OpenCL.Memory;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

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
       function GetSize :T_size_t;
     public
       constructor Create; override;
       ///// プロパティ
       property Count :Integer  read GetCount write SetCount;
       property Size  :T_size_t read GetSize                ;
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

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

end. //######################################################################### ■
