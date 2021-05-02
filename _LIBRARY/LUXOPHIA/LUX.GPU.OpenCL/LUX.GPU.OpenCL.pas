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
     LUX.GPU.OpenCL.Comman,
     LUX.GPU.OpenCL.Progra,
     LUX.GPU.OpenCL.Kernel,
     LUX.GPU.OpenCL.Memory,
     LUX.GPU.OpenCL.Buffer,
     LUX.GPU.OpenCL.Buffer.TIter;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TOpenCL                      = class;
       TCLPlatfos                 = TCLPlatfos<TOpenCL>;
         TCLPlatfo                = TCLPlatfo <TOpenCL>;
           TCLExtenss             = TCLExtenss<TCLPlatfo>;
           TCLDevices             = TCLDevices<TCLPlatfo>;
             TCLDevice            = TCLDevice <TCLPlatfo>;
           TCLContexs             = TCLContexs<TCLPlatfo>;
             TCLContex            = TCLContex <TCLPlatfo>;
               TCLCommans         = TCLCommans<TCLContex,TCLPlatfo>;
                 TCLComman        = TCLComman <TCLContex,TCLPlatfo>;
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
       ///// メソッド
       procedure Show( const Strings_:TStrings );
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

/////////////////////////////////////////////////////////////////////// メソッド

procedure TOpenCL.Show( const Strings_:TStrings );
begin
     ShowSystem( Strings_ );
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

//############################################################################## □

initialization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 初期化

     _OpenCL_ := TOpenCL.Create;

finalization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 最終化

     _OpenCL_.Free;

end. //######################################################################### ■
