unit LUX.GPU.OpenCL.Progra;

interface //#################################################################### ■

uses System.Classes, System.Generics.Collections,
     cl_version, cl_platform, cl,
     LUX.Code.C,
     LUX.GPU.OpenCL.root,
     LUX.GPU.OpenCL.Kernel;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLProgra<TCLContex_>

     TCLProgra<TCLContex_:class> = class
     private
       type TCLKernel = TCLKernel<TCLContex_,TCLProgra<TCLContex_>>;
     protected
       _Contex  :TCLContex_;
       _Handle  :T_cl_program;
       _Source  :TStringList;
       _LangVer :TCLVersion;
       _Kernels :TObjectList<TCLKernel>;
       ///// アクセス
       procedure SetContex( const Contex_:TCLContex_ );
       function GetHandle :T_cl_program;
       procedure SetHandle( const Handle_:T_cl_program );
       ///// メソッド
       procedure CreateHandle;
       procedure DestroHandle;
     public
       constructor Create; overload;
       constructor Create( const Contex_:TCLContex_ ); overload;
       destructor Destroy; override;
       ///// プロパティ
       property Contex  :TCLContex_             read   _Contex  write SetContex;
       property Handle  :T_cl_program           read GetHandle  write SetHandle;
       property Source  :TStringList            read   _Source                 ;
       property LangVer :TCLVersion             read   _LangVer                ;
       property Kernels :TObjectList<TCLKernel> read   _Kernels                ;
       ///// メソッド
       procedure Build;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses LUX.GPU.OpenCL;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLProgra<TCLContex_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

procedure TCLProgra<TCLContex_>.SetContex( const Contex_:TCLContex_ );
begin
     if Assigned( _Contex ) then TCLContex( _Contex ).Progras.Remove( TCLProgra( Self ) );

                  _Contex := Contex_;

     if Assigned( _Contex ) then TCLContex( _Contex ).Progras.Add   ( TCLProgra( Self ) );
end;

//------------------------------------------------------------------------------

function TCLProgra<TCLContex_>.GetHandle :T_cl_program;
begin
     if not Assigned( _Handle ) then CreateHandle;

     Result := _Handle;
end;

procedure TCLProgra<TCLContex_>.SetHandle( const Handle_:T_cl_program );
begin
     if Assigned( _Handle ) then DestroHandle;

     _Handle := Handle_;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLProgra<TCLContex_>.CreateHandle;
var
   C :P_char;
   E :T_cl_int;
begin
     C := P_char( AnsiString( _Source.Text ) );

     _Handle := clCreateProgramWithSource( TCLContex( Contex ).Handle, 1, @C, nil, @E );

     AssertCL( E );
end;

procedure TCLProgra<TCLContex_>.DestroHandle;
begin
     clReleaseProgram( _Handle );

     _Handle := nil;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLProgra<TCLContex_>.Create;
begin
     inherited;

     _Handle := nil;

     _Source  := TStringList           .Create;
     _Kernels := TObjectList<TCLKernel>.Create;

     _Contex  := nil;
     _LangVer := TCLVersion.From( '2.0' );
end;

constructor TCLProgra<TCLContex_>.Create( const Contex_:TCLContex_ );
begin
     Create;

     Contex := Contex_;
end;

destructor TCLProgra<TCLContex_>.Destroy;
begin
     _Source .Free;
     _Kernels.Free;

      Handle := nil;

     inherited;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLProgra<TCLContex_>.Build;
var
   Ds :TArray<T_cl_device_id>;
   Os :String;
begin
     Ds :=  TCLContex( Contex ).GetDeviceIDs;

     if Ord( _LangVer ) > 100 then Os := '-cl-std=CL' + _LangVer.ToString
                              else Os := '';

     AssertCL( clBuildProgram( Handle, Length( Ds ), @Ds[0], P_char( AnsiString( Os ) ), nil, nil ) );
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

//############################################################################## □

initialization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 初期化

finalization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 最終化

end. //######################################################################### ■
