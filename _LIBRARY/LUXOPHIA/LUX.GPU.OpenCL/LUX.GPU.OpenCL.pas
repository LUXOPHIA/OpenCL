﻿unit LUX.GPU.OpenCL;

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

     TCLSeeder1D = TCLSeeder1D<TCLSystem,TCLPlatfo,TCLContex>;
     TCLSeeder2D = TCLSeeder2D<TCLSystem,TCLPlatfo,TCLContex>;
     TCLSeeder3D = TCLSeeder3D<TCLSystem,TCLPlatfo,TCLContex>;

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
