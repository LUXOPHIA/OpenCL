program OpenCL;

uses
  System.StartUpCopy,
  FMX.Forms,
  Main in 'Main.pas' {Form1},
  LUX in '_LIBRARY\LUXOPHIA\LUX\LUX.pas',
  LUX.Code.C in '_LIBRARY\LUXOPHIA\LUX\Code\LUX.Code.C.pas',
  LUX.Data.List.core in '_LIBRARY\LUXOPHIA\LUX\Data\List\LUX.Data.List.core.pas',
  LUX.Data.List in '_LIBRARY\LUXOPHIA\LUX\Data\List\LUX.Data.List.pas',
  LUX.Color in '_LIBRARY\LUXOPHIA\LUX\Color\LUX.Color.pas',
  LUX.Complex in '_LIBRARY\LUXOPHIA\LUX\Complex\LUX.Complex.pas',
  LUX.D1 in '_LIBRARY\LUXOPHIA\LUX\LUX.D1.pas',
  LUX.D2 in '_LIBRARY\LUXOPHIA\LUX\LUX.D2.pas',
  LUX.D3 in '_LIBRARY\LUXOPHIA\LUX\LUX.D3.pas',
  LUX.D4 in '_LIBRARY\LUXOPHIA\LUX\LUX.D4.pas',
  cl in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\CL\cl.pas',
  cl_version in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\CL\cl_version.pas',
  cl_platform in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\CL\cl_platform.pas',
  LUX.GPU.OpenCL.Argume.Memory.Buffer in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\Core\LUX.GPU.OpenCL.Argume.Memory.Buffer.pas',
  LUX.GPU.OpenCL.Argume.Memory.Imager.D1 in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\Core\LUX.GPU.OpenCL.Argume.Memory.Imager.D1.pas',
  LUX.GPU.OpenCL.Argume.Memory.Imager.D2 in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\Core\LUX.GPU.OpenCL.Argume.Memory.Imager.D2.pas',
  LUX.GPU.OpenCL.Argume.Memory.Imager.D3 in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\Core\LUX.GPU.OpenCL.Argume.Memory.Imager.D3.pas',
  LUX.GPU.OpenCL.Argume.Memory.Imager in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\Core\LUX.GPU.OpenCL.Argume.Memory.Imager.pas',
  LUX.GPU.OpenCL.Argume.Memory in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\Core\LUX.GPU.OpenCL.Argume.Memory.pas',
  LUX.GPU.OpenCL.Argume in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\Core\LUX.GPU.OpenCL.Argume.pas',
  LUX.GPU.OpenCL.Argume.Samplr in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\Core\LUX.GPU.OpenCL.Argume.Samplr.pas',
  LUX.GPU.OpenCL.Contex in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\Core\LUX.GPU.OpenCL.Contex.pas',
  LUX.GPU.OpenCL.core in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\Core\LUX.GPU.OpenCL.core.pas',
  LUX.GPU.OpenCL.Device in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\Core\LUX.GPU.OpenCL.Device.pas',
  LUX.GPU.OpenCL.Kernel in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\Core\LUX.GPU.OpenCL.Kernel.pas',
  LUX.GPU.OpenCL.Platfo in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\Core\LUX.GPU.OpenCL.Platfo.pas',
  LUX.GPU.OpenCL.Progra in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\Core\LUX.GPU.OpenCL.Progra.pas',
  LUX.GPU.OpenCL.Queuer in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\Core\LUX.GPU.OpenCL.Queuer.pas',
  LUX.GPU.OpenCL.Show in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\Core\LUX.GPU.OpenCL.Show.pas',
  LUX.GPU.OpenCL in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\LUX.GPU.OpenCL.pas',
  LUX.GPU.OpenCL.Stream.FMX.D1 in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\Stream\LUX.GPU.OpenCL.Stream.FMX.D1.pas',
  LUX.GPU.OpenCL.Stream.FMX.D2 in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\Stream\LUX.GPU.OpenCL.Stream.FMX.D2.pas',
  LUX.GPU.OpenCL.Stream.FMX.D3 in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\Stream\LUX.GPU.OpenCL.Stream.FMX.D3.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

