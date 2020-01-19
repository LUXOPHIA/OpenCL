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
  LUX.GPU.OpenCL.Context in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\LUX.GPU.OpenCL.Context.pas',
  LUX.GPU.OpenCL.Command in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\LUX.GPU.OpenCL.Command.pas',
  LUX.GPU.OpenCL.Device in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\LUX.GPU.OpenCL.Device.pas',
  LUX.GPU.OpenCL.root in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\LUX.GPU.OpenCL.root.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

