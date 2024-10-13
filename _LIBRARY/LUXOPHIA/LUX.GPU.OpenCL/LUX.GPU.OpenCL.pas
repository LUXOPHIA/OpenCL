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
     LUX.GPU.OpenCL.Argume.Memory.Imager.D2,
     LUX.GPU.OpenCL.Argume.Memory.Imager.D3,
     LUX.GPU.OpenCL.Progra,
     LUX.GPU.OpenCL.Kernel;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 T Y P E 】

     TOpenCL                       = class;

     TCLSystem                     = class;
       TCLPlatfos                  = TCLPlatfos<TCLSystem>;
         TCLPlatfo                 = TCLPlatfo <TCLSystem>;
           TCLExtenss              = TCLExtenss<TCLSystem,TCLPlatfo>;
           TCLDevices              = TCLDevices<TCLSystem,TCLPlatfo>;
             TCLDevice             = TCLDevice <TCLSystem,TCLPlatfo>;
           TCLContexs              = TCLContexs<TCLSystem,TCLPlatfo>;
             TCLContex             = TCLContex <TCLSystem,TCLPlatfo>;
               TCLQueuers          = TCLQueuers<TCLSystem,TCLPlatfo,TCLContex>;
                 TCLQueuer         = TCLQueuer <TCLSystem,TCLPlatfo,TCLContex>;
               TCLArgumes          = TCLArgumes<TCLSystem,TCLPlatfo,TCLContex>;
                 TCLArgume         = TCLArgume <TCLSystem,TCLPlatfo,TCLContex>;
                 TCLSamplr         = TCLSamplr <TCLSystem,TCLPlatfo,TCLContex>;
                 TCLMemory         = TCLMemory <TCLSystem,TCLPlatfo,TCLContex>;
               TCLLibrars          = TCLLibrars<TCLSystem,TCLPlatfo,TCLContex>;
                 TCLLibrar         = TCLLibrar <TCLSystem,TCLPlatfo,TCLContex>;
               TCLExecuts          = TCLExecuts<TCLSystem,TCLPlatfo,TCLContex>;
                 TCLExecut         = TCLExecut <TCLSystem,TCLPlatfo,TCLContex>;
                   TCLBuildrs      = TCLBuildrs<TCLSystem,TCLPlatfo,TCLContex>;
                     TCLBuildr     = TCLBuildr <TCLSystem,TCLPlatfo,TCLContex>;
                   TCLKernels      = TCLKernels<TCLSystem,TCLPlatfo,TCLContex,TCLExecut>;
                     TCLKernel     = TCLKernel <TCLSystem,TCLPlatfo,TCLContex,TCLExecut>;
                       TCLParames  = TCLParames<TCLSystem,TCLPlatfo,TCLContex,TCLExecut>;
                         TCLParame = TCLParame <TCLSystem,TCLPlatfo,TCLContex,TCLExecut>;

     TCLBuffer<TValue_:record> = class( TCLBuffer<TCLSystem,TCLPlatfo,TCLContex,TValue_> );

     TCLImager1DxBGRAxUInt8  = TCLImager1DxBGRAxUInt8 <TCLSystem,TCLPlatfo,TCLContex>;
     TCLImager1DxBGRAxUFix8  = TCLImager1DxBGRAxUFix8 <TCLSystem,TCLPlatfo,TCLContex>;
     TCLImager1DxRGBAxUInt32 = TCLImager1DxRGBAxUInt32<TCLSystem,TCLPlatfo,TCLContex>;
     TCLImager1DxRGBAxSFlo32 = TCLImager1DxRGBAxSFlo32<TCLSystem,TCLPlatfo,TCLContex>;

     TCLImager2DxBGRAxUInt8  = TCLImager2DxBGRAxUInt8 <TCLSystem,TCLPlatfo,TCLContex>;
     TCLImager2DxBGRAxUFix8  = TCLImager2DxBGRAxUFix8 <TCLSystem,TCLPlatfo,TCLContex>;
     TCLImager2DxRGBAxUInt32 = TCLImager2DxRGBAxUInt32<TCLSystem,TCLPlatfo,TCLContex>;
     TCLImager2DxRGBAxSFlo32 = TCLImager2DxRGBAxSFlo32<TCLSystem,TCLPlatfo,TCLContex>;

     TCLImager3DxBGRAxUInt8  = TCLImager3DxBGRAxUInt8 <TCLSystem,TCLPlatfo,TCLContex>;
     TCLImager3DxBGRAxUFix8  = TCLImager3DxBGRAxUFix8 <TCLSystem,TCLPlatfo,TCLContex>;
     TCLImager3DxRGBAxUInt32 = TCLImager3DxRGBAxUInt32<TCLSystem,TCLPlatfo,TCLContex>;
     TCLImager3DxRGBAxSFlo32 = TCLImager3DxRGBAxSFlo32<TCLSystem,TCLPlatfo,TCLContex>;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R E C O R D 】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C L A S S 】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLSystem

     TCLSystem = class
     private
     protected
       _Platfos :TCLPlatfos;
       ///// A C C E S S O R
       function GetPlatfos :TCLPlatfos;
     public
       constructor Create;
       destructor Destroy; override;
       ///// P R O P E R T Y
       property Platfos :TCLPlatfos read GetPlatfos;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TOpenCL

     TOpenCL = class
     private
       class var _System :TCLSystem;
     protected
       ///// A C C E S S O R
       class function GetPlatfos :TCLPlatfos; static;
     public
       class constructor Create;
       class destructor Destroy;
       ///// P R O P E R T Y
       class property Platfos :TCLPlatfos read GetPlatfos;
       ///// M E T H O D
       class procedure Show( const Strings_:TStrings );
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C O N S T A N T 】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 V A R I A B L E 】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

implementation //############################################################### ■

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R E C O R D 】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C L A S S 】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLSystem

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//////////////////////////////////////////////////////////////// A C C E S S O R

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

//////////////////////////////////////////////////////////////// A C C E S S O R

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

//////////////////////////////////////////////////////////////////// M E T H O D

class procedure TOpenCL.Show( const Strings_:TStrings );
begin
     ShowSystem( Strings_ );
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

end. //######################################################################### ■
