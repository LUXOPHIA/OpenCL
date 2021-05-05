unit LUX.GPU.OpenCL;

interface //#################################################################### ■

uses System.Classes,
     cl_version,
     cl_platform,
     cl,
     LUX.Code.C,
     LUX.GPU.OpenCL.root,
     LUX.GPU.OpenCL.Show,
     LUX.GPU.OpenCL.Device,
     LUX.GPU.OpenCL.Platfo,
     LUX.GPU.OpenCL.Contex,
     LUX.GPU.OpenCL.Queuer,
     LUX.GPU.OpenCL.Progra,
     LUX.GPU.OpenCL.Kernel,
     LUX.GPU.OpenCL.Memory,
     LUX.GPU.OpenCL.Buffer,
     LUX.GPU.OpenCL.Buffer.TIter;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TCLOpenCL                    = class;
       TCLPlatfos                 = TCLPlatfos<TCLOpenCL>;
         TCLPlatfo                = TCLPlatfo <TCLOpenCL>;
           TCLExtenss             = TCLExtenss<TCLPlatfo>;
           TCLDevices             = TCLDevices<TCLPlatfo>;
             TCLDevice            = TCLDevice <TCLPlatfo>;
           TCLContexs             = TCLContexs<TCLPlatfo>;
             TCLContex            = TCLContex <TCLPlatfo>;
               TCLQueuers         = TCLQueuers<TCLContex,TCLPlatfo>;
                 TCLQueuer        = TCLQueuer <TCLContex,TCLPlatfo>;
               TCLMemorys         = TCLMemorys<TCLContex>;
                 TCLMemory        = TCLMemory <TCLContex>;
               TCLProgras         = TCLProgras<TCLContex,TCLPlatfo>;
                 TCLProgra        = TCLProgra <TCLContex,TCLPlatfo>;
                   TCLDeploys     = TCLDeploys<TCLContex,TCLPlatfo>;
                     TCLDeploy    = TCLDeploy <TCLContex,TCLPlatfo>;
                   TCLKernels     = TCLKernels<TCLProgra,TCLContex,TCLPlatfo>;
                     TCLKernel    = TCLKernel <TCLProgra,TCLContex,TCLPlatfo>;
                       TCLArgumes = TCLArgumes<TCLKernel,TCLContex,TCLPlatfo>;

     TCLDeviceBuffer<TValue_:record> = class( TCLDeviceBuffer<TCLContex,TValue_> );
     TCLHostBuffer  <TValue_:record> = class( TCLHostBuffer  <TCLContex,TValue_> );

     TCLBufferIter<TValue_:record> = class( TCLBufferIter<TCLContex,TCLPlatfo,TValue_> );

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLOpenCL

     TCLOpenCL = class
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
       ///// メソッド
       procedure Show( const Strings_:TStrings );
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

    _OpenCL_ :TCLOpenCL;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLOpenCL

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLOpenCL.GetPlatfo0 :TCLPlatfo;
begin
     Result := Platfos[ 0 ];
end;

function TCLOpenCL.GetDevice0 :TCLDevice;
begin
     Result := Platfo0.Devices[ 0 ];
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLOpenCL.Create;
begin
     inherited;

     _Platfos := TCLPlatfos.Create( Self );
end;

destructor TCLOpenCL.Destroy;
begin
     _Platfos.Free;

     inherited;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLOpenCL.Show( const Strings_:TStrings );
begin
     ShowSystem( Strings_ );
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

//############################################################################## □

initialization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 初期化

     _OpenCL_ := TCLOpenCL.Create;

finalization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 最終化

     _OpenCL_.Free;

end. //######################################################################### ■
