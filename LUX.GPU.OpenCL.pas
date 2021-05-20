unit LUX.GPU.OpenCL;

interface //#################################################################### ■

uses System.Classes,
     LUX.GPU.OpenCL.core,
     LUX.GPU.OpenCL.Show,
     LUX.GPU.OpenCL.Platfo,
     LUX.GPU.OpenCL.Device,
     LUX.GPU.OpenCL.Contex,
     LUX.GPU.OpenCL.Queuer,
     LUX.GPU.OpenCL.Argume,
     LUX.GPU.OpenCL.Argume.Samplr,
     LUX.GPU.OpenCL.Argume.Memory,
     LUX.GPU.OpenCL.Argume.Memory.Buffer,
     LUX.GPU.OpenCL.Argume.Memory.Imager,
     LUX.GPU.OpenCL.Argume.Memory.Imager.D1,
     LUX.GPU.OpenCL.Argume.Memory.Imager.D1.Seeder,
     LUX.GPU.OpenCL.Argume.Memory.Imager.D2,
     LUX.GPU.OpenCL.Argume.Memory.Imager.D2.Seeder,
     LUX.GPU.OpenCL.Argume.Memory.Imager.D3,
     LUX.GPU.OpenCL.Argume.Memory.Imager.D3.Seeder,
     LUX.GPU.OpenCL.Progra,
     LUX.GPU.OpenCL.Kernel;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TOpenCL                       = class;

     TCLSystem                     = class;
       TCLPlatfos                  = TCLPlatfos<TCLSystem>;
         TCLPlatfo                 = TCLPlatfo <TCLSystem>;
           TCLExtenss              = TCLExtenss<TCLPlatfo>;
           TCLDevices              = TCLDevices<TCLPlatfo>;
             TCLDevice             = TCLDevice <TCLPlatfo>;
           TCLContexs              = TCLContexs<TCLPlatfo>;
             TCLContex             = TCLContex <TCLPlatfo>;
               TCLQueuers          = TCLQueuers<TCLContex,TCLPlatfo>;
                 TCLQueuer         = TCLQueuer <TCLContex,TCLPlatfo>;
               TCLArgumes          = TCLArgumes<TCLContex,TCLPlatfo>;
                 TCLArgume         = TCLArgume <TCLContex,TCLPlatfo>;
                 TCLSamplr         = TCLSamplr <TCLContex,TCLPlatfo>;
                 TCLMemory         = TCLMemory <TCLContex,TCLPlatfo>;
               TCLLibrars          = TCLLibrars<TCLContex,TCLPlatfo>;
                 TCLLibrar         = TCLLibrar <TCLContex,TCLPlatfo>;
               TCLExecuts          = TCLExecuts<TCLContex,TCLPlatfo>;
                 TCLExecut         = TCLExecut <TCLContex,TCLPlatfo>;
                   TCLBuildrs      = TCLBuildrs<TCLContex,TCLPlatfo>;
                     TCLBuildr     = TCLBuildr <TCLContex,TCLPlatfo>;
                   TCLKernels      = TCLKernels<TCLExecut,TCLContex,TCLPlatfo>;
                     TCLKernel     = TCLKernel <TCLExecut,TCLContex,TCLPlatfo>;
                       TCLParames  = TCLParames<TCLExecut,TCLContex,TCLPlatfo>;
                         TCLParame = TCLParame <TCLExecut,TCLContex,TCLPlatfo>;

     TCLDevBuf<TValue_:record> = class( TCLDevBuf<TCLContex,TCLPlatfo,TValue_> );
     TCLHosBuf<TValue_:record> = class( TCLHosBuf<TCLContex,TCLPlatfo,TValue_> );

     TCLBufferIter<TValue_:record> = class( TCLBufferIter<TCLContex,TCLPlatfo,TValue_> );

     TCLSeeder1D = TCLSeeder1D<TCLContex,TCLPlatfo>;
     TCLSeeder2D = TCLSeeder2D<TCLContex,TCLPlatfo>;
     TCLSeeder3D = TCLSeeder3D<TCLContex,TCLPlatfo>;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLSystem

     TCLSystem = class
     private
     protected
       _Platfos :TCLPlatfos;
       ///// アクセス
       function GetPlatfos :TCLPlatfos;
     public
       constructor Create;
       destructor Destroy; override;
       ///// プロパティ
       property Platfos :TCLPlatfos read GetPlatfos;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TOpenCL

     TOpenCL = class
     private
       class var _System :TCLSystem;
     protected
       ///// アクセス
       class function GetPlatfos :TCLPlatfos; static;
     public
       class constructor Create;
       class destructor Destroy;
       ///// プロパティ
       class property Platfos :TCLPlatfos read GetPlatfos;
       ///// メソッド
       class procedure Show( const Strings_:TStrings );
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLSystem

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLSystem.GetPlatfos :TCLPlatfos;
begin
     Result := _Platfos;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLSystem.Create;
begin
     inherited;

     _Platfos := TCLPlatfos.Create( Self );
end;

destructor TCLSystem.Destroy;
begin
     _Platfos.Free;

     inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TOpenCL

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

class function TOpenCL.GetPlatfos :TCLPlatfos;
begin
     Result := _System.Platfos;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

class constructor TOpenCL.Create;
begin
     _System := TCLSystem.Create;
end;

class destructor TOpenCL.Destroy;
begin
     _System.Free;
end;

/////////////////////////////////////////////////////////////////////// メソッド

class procedure TOpenCL.Show( const Strings_:TStrings );
begin
     ShowSystem( Strings_ );
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

end. //######################################################################### ■
