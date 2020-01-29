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
  LUX.GPU.OpenCL.TContext in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\LUX.GPU.OpenCL.TContext.pas',
  LUX.GPU.OpenCL.TCommand in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\LUX.GPU.OpenCL.TCommand.pas',
  LUX.GPU.OpenCL.TDevice in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\LUX.GPU.OpenCL.TDevice.pas',
  LUX.GPU.OpenCL.root in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\LUX.GPU.OpenCL.root.pas',
  LUX.GPU.OpenCL.TPlatform in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\LUX.GPU.OpenCL.TPlatform.pas',
  LUX.GPU.OpenCL.TProgram in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\LUX.GPU.OpenCL.TProgram.pas',
  LUX.GPU.OpenCL.TKernel in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\LUX.GPU.OpenCL.TKernel.pas',
  LUX.GPU.OpenCL.TMemory in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\LUX.GPU.OpenCL.TMemory.pas',
  LUX.GPU.OpenCL.TBuffer in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\LUX.GPU.OpenCL.TBuffer.pas',
  LUX.GPU.OpenCL.TBuffer.TIter in '_LIBRARY\LUXOPHIA\LUX.GPU.OpenCL\LUX.GPU.OpenCL.TBuffer.TIter.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

