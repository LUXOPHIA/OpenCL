program LUX.GPU.OpenCL.Tests;

// LUX.GPU.OpenCL の試験
//
// ・実際の OpenCL のデバイス（先頭のプラットフォームの、先頭のデバイス）の上で、ライブラリを動かして確かめる。
//   OpenCL が使えない機械では、試験を走らせずに、その旨を出して、成功として終わる。
// ・作って走らせる手順は、同じフォルダーの test.bat。失敗は、終了コード（1：試験の失敗・2：試験を動かせなかった）に出す。
// ・ライブラリと LUX のユニットは、test.bat が渡す検索の道から読む。

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  Winapi.Windows,
  DUnitX.TestFramework,
  DUnitX.Loggers.Console,
  LUX.GPU.OpenCL,
  Tests.Base in 'Tests.Base.pas',
  Tests.Handle in 'Tests.Handle.pas',
  Tests.Build in 'Tests.Build.pas',
  Tests.Member in 'Tests.Member.pas',
  Tests.Seeder in 'Tests.Seeder.pas',
  Tests.Stream in 'Tests.Stream.pas',
  Tests.Random in 'Tests.Random.pas';

var
   Runner  :ITestRunner;
   Results :IRunResults;

begin
     SetConsoleOutputCP( CP_UTF8 );

     if not TOpenCL.Available or ( TOpenCL.Platfos.Count = 0 ) or ( TOpenCL.Platfos[ 0 ].Devices.Count = 0 ) then
     begin
          Writeln( 'OpenCL のデバイスが無いので、試験を走らせていません。' );

          Exit;
     end;

     try
          TDUnitX.CheckCommandLine;

          Runner := TDUnitX.CreateRunner;
          Runner.UseRTTI := True;
          Runner.AddLogger( TDUnitXConsoleLogger.Create( True ) );
          Runner.FailsOnNoAsserts := False;

          Results := Runner.Execute;

          if not Results.AllPassed then ExitCode := 1;
     except
          on E:Exception do
          begin
               Writeln( E.ClassName, ': ', E.Message );

               ExitCode := 2;
          end;
     end;
end.
