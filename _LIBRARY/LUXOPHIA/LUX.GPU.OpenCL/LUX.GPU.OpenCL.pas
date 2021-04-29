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

     TOpenCL                   = class;
       TCLPlatfos              = TCLPlatfos<TOpenCL>;
         TCLPlatfo             = TCLPlatfo <TOpenCL>;
           TCLDevices          = TCLDevices<TCLPlatfo>;
             TCLDevice         = TCLDevice <TCLPlatfo>;
           TCLContexs          = TCLContexs<TCLPlatfo>;
             TCLContex         = TCLContex <TCLPlatfo>;
               TCLCommans      = TCLCommans<TCLContex,TCLDevice>;
                 TCLComman     = TCLComman <TCLContex,TCLDevice>;
               TCLProgras      = TCLProgras<TCLContex>;
                 TCLProgra     = TCLProgra <TCLContex>;
                   TCLKernels  = TCLKernels<TCLContex,TCLProgra>;
                     TCLKernel = TCLKernel <TCLContex,TCLProgra>;

     TCLMemory = TCLMemory<TCLContex>;

     TCLDeviceBuffer<_TValue_:record> = class( TCLDeviceBuffer<TCLContex,_TValue_> );
     TCLHostBuffer  <_TValue_:record> = class( TCLHostBuffer  <TCLContex,_TValue_> );

     TCLBufferIter<_TValue_:record> = class( TCLBufferIter<TCLContex,TCLDevice,_TValue_> );

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TOpenCL

     TOpenCL = class
     private
       _Platfos :TCLPlatfos;
     protected
       ///// アクセス
       function GetPlatfo0 :TCLPlatfo;
       function GetDevice0 :TCLDevice;
     public
       constructor Create;
       destructor Destroy; override;
       ///// プロパティ
       property Platfos :TCLPlatfos read   _Platfos;
       property Platfo0 :TCLPlatfo  read GetPlatfo0;
       property Device0 :TCLDevice  read GetDevice0;
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

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TOpenCL.GetPlatfo0 :TCLPlatfo;
begin
     Result := Platfos[ 0 ];
end;

function TOpenCL.GetDevice0 :TCLDevice;
begin
     Result := Platfo0.Devices[ 0 ];
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TOpenCL.Create;
begin
     inherited;

     _Platfos := TCLPlatfos.Create( Self );
end;

destructor TOpenCL.Destroy;
begin
     _Platfos.Free;

     inherited;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

//############################################################################## □

initialization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 初期化

     _OpenCL_ := TOpenCL.Create;

finalization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 最終化

     _OpenCL_.Free;

end. //######################################################################### ■
