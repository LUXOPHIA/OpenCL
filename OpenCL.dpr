program OpenCL;

uses
  System.StartUpCopy,
  FMX.Forms,
  Main in 'Main.pas' {Form1},
  LUX.Code.C in '_LIBRARY\LUXOPHIA\LUX\Code\LUX.Code.C.pas',
  LUX in '_LIBRARY\LUXOPHIA\LUX\LUX.pas',
  cl_platform in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\CL\cl_platform.pas',
  cl_version in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\CL\cl_version.pas',
  cl in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\CL\cl.pas',
  LUX.GPU.OpenCL in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\LUX.GPU.OpenCL.pas',
  LUX.GPU.OpenCL.Contex in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\LUX.GPU.OpenCL.Contex.pas',
  LUX.GPU.OpenCL.Queuer in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\LUX.GPU.OpenCL.Queuer.pas',
  LUX.GPU.OpenCL.Device in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\LUX.GPU.OpenCL.Device.pas',
  LUX.GPU.OpenCL.root in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\LUX.GPU.OpenCL.root.pas',
  LUX.GPU.OpenCL.Platfo in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\LUX.GPU.OpenCL.Platfo.pas',
  LUX.GPU.OpenCL.Progra in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\LUX.GPU.OpenCL.Progra.pas',
  LUX.GPU.OpenCL.Kernel in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\LUX.GPU.OpenCL.Kernel.pas',
  LUX.GPU.OpenCL.Memory in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\LUX.GPU.OpenCL.Memory.pas',
  LUX.GPU.OpenCL.Memory.Buffer in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\LUX.GPU.OpenCL.Memory.Buffer.pas',
  LUX.Data.List.core in '_LIBRARY\LUXOPHIA\LUX\Data\List\LUX.Data.List.core.pas',
  LUX.Data.List in '_LIBRARY\LUXOPHIA\LUX\Data\List\LUX.Data.List.pas',
  LUX.GPU.OpenCL.Show in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\LUX.GPU.OpenCL.Show.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

