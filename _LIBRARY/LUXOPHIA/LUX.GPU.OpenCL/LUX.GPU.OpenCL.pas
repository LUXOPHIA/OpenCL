unit LUX.GPU.OpenCL;

interface //#################################################################### ■

uses System.Generics.Collections,
     cl_version,
     cl_platform,
     cl,
     LUX.Code.C,
     LUX.GPU.OpenCL.root,
     LUX.GPU.OpenCL.Device,
     LUX.GPU.OpenCL.Platfo,
     LUX.GPU.OpenCL.Contex,
     LUX.GPU.OpenCL.Comman,
     LUX.GPU.OpenCL.Progra,
     LUX.GPU.OpenCL.Kernel,
     LUX.GPU.OpenCL.Memory,
     LUX.GPU.OpenCL.Buffer,
     LUX.GPU.OpenCL.Buffer.TIter;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TOpenCL     = class;

     TCLPlatform = TCLPlatform<TOpenCL>;

     TCLDevice   = TCLDevice<TCLPlatform>;

     TCLContex  = TCLContex<TCLPlatform,TCLDevice>;

     TCLComman  = TCLComman<TCLContex,TCLDevice>;

     TCLProgram  = TCLProgram<TCLContex>;

     TCLKernel   = TCLKernel<TCLContex,TCLProgram>;

     TCLMemory   = TCLMemory<TCLContex>;

     TCLDeviceBuffer<_TValue_:record> = class( TCLDeviceBuffer<TCLContex,_TValue_> );
     TCLHostBuffer  <_TValue_:record> = class( TCLHostBuffer  <TCLContex,_TValue_> );

     TCLBufferIter<_TValue_:record> = class( TCLBufferIter<TCLContex,TCLDevice,_TValue_> );

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TOpenCL

     TOpenCL = class
     private
       _Platforms :TObjectList<TCLPlatform>;
       ///// メソッド
       procedure MakePlatforms;
     protected
       ///// アクセス
       function GetPlatform0 :TCLPlatform;
       function GetDevice0 :TCLDevice;
     public
       constructor Create;
       destructor Destroy; override;
       ///// プロパティ
       property Platforms :TObjectList<TCLPlatform> read   _Platforms;
       property Platform0 :TCLPlatform              read GetPlatform0;
       property Device0   :TCLDevice                read GetDevice0  ;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

    _OpenCL_ :TOpenCL;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TOpenCL

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

/////////////////////////////////////////////////////////////////////// メソッド

procedure TOpenCL.MakePlatforms;
var
   PsN :T_cl_uint;
   Ps :TArray<T_cl_platform_id>;
   P :T_cl_platform_id;
begin
     AssertCL( clGetPlatformIDs( 0, nil, @PsN ) );

     SetLength( Ps, PsN );

     AssertCL( clGetPlatformIDs( PsN, @Ps[0], nil ) );

     for P in Ps do _Platforms.Add( TCLPlatform.Create( Self, P ) );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TOpenCL.GetPlatform0 :TCLPlatform;
begin
     Result := Platforms[ 0 ];
end;

function TOpenCL.GetDevice0 :TCLDevice;
begin
     Result := Platform0.Devices[ 0 ];
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TOpenCL.Create;
begin
     inherited;

     _Platforms := TObjectList<TCLPlatform>.Create;

     MakePlatforms;
end;

destructor TOpenCL.Destroy;
begin
     _Platforms.Free;

     inherited;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

//############################################################################## □

initialization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 初期化

     _OpenCL_ := TOpenCL.Create;

finalization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 最終化

     _OpenCL_.Free;

end. //######################################################################### ■
