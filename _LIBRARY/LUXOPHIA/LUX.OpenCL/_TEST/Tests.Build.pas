unit Tests.Build;

// ビルド（TCLBuildr）と、仮引数（TCLParames）の試験
//
//【確かめること】
// ・利用者が与える文字列（ソース・仮引数の名前）で決まる結果は、BuildOK・FindsOK・BindsOK で、例外なしに尋ねられる。
// ・失敗したビルドのハンドルを読むか、カーネルを走らせると、ECLError になる。
// ・ソースを直せば、次に使うときに、ビルドし直される。

interface //#################################################################### ■

uses DUnitX.TestFramework,
     Tests.Base;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 T Y P E 】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R E C O R D 】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C L A S S 】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TBuildTests

     [TestFixture]
     TBuildTests = class( TCLTests )
     public
       [Test] procedure BuildOKIsTrue;
       [Test] procedure BrokenSourceIsReported;
       [Test] procedure BrokenSourceRaisesOnUse;
       [Test] procedure UnknownIncludeIsReported;
       [Test] procedure SourceFixed;
       [Test] procedure VersionChanged;
       [Test] procedure BuildrSurvivesSourceChange;
       [Test] procedure BuildrDeviceChanged;
       [Test] procedure UnknownKernelNameRaises;
       [Test] procedure ParameterMissing;
       [Test] procedure ParameterRenamed;
       [Test] procedure RunWithoutArgumentRaises;
     end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

implementation //############################################################### ■

uses System.SysUtils,
     cl_version, cl_platform, cl,
     LUX.OpenCL,
     LUX.OpenCL.core;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R E C O R D 】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C L A S S 】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TBuildTests

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

// 正しいソースは、BuildOK が True で、仮引数の照合と接続もできる
procedure TBuildTests.BuildOKIsTrue;
begin
     Assert.IsTrue( _Execut.BuildTo( _Device ).BuildOK );
     Assert.IsTrue( _Kernel.Parames.FindsOK );
     Assert.IsTrue( _Kernel.Parames.BindsOK );
end;

// 壊れたソースは、例外を出さずに、BuildOK が False になり、ログに理由が残る
procedure TBuildTests.BrokenSourceIsReported;
var
   B :TCLBuildr;
begin
     _Execut.Source.Text := 'kernel void Fill( global float* Buffer ) { syntax error';

     B := _Execut.BuildTo( _Device );

     Assert.IsFalse( B.BuildOK );
     Assert.IsTrue( B.BuildLog <> '' );
     Assert.IsFalse( B.BuildOK, '2 度目に尋ねても、結果は同じ' );
end;

// 壊れたソースのビルドのハンドルを読むか、カーネルを走らせると、ECLError になる
procedure TBuildTests.BrokenSourceRaisesOnUse;
begin
     _Execut.Source.Text := 'kernel void Fill( global float* Buffer ) { syntax error';

     Assert.IsTrue( Raises( procedure begin _Execut.BuildTo( _Device ).Handle; end ) );
     Assert.IsTrue( Raises( procedure begin _Kernel.Run;                       end ) );
end;

// 無いライブラリを #include したソースも、BuildOK が False になる
procedure TBuildTests.UnknownIncludeIsReported;
var
   B :TCLBuildr;
begin
     _Execut.Source.Text := '#include "nothing.cl"' + sLineBreak
                          + 'kernel void Fill( global float* Buffer ) { Buffer[ 0 ] = 1.0f; }';

     B := _Execut.BuildTo( _Device );

     Assert.IsFalse( B.BuildOK );
     Assert.IsTrue( B.BuildLog <> '' );
end;

// 壊れたソースを直すと、ビルドし直されて、走る
procedure TBuildTests.SourceFixed;
begin
     _Execut.Source.Text := 'kernel void Fill( global float* Buffer ) { syntax error';

     Assert.IsFalse( _Execut.BuildTo( _Device ).BuildOK );

     SetSource( '5.0f' );

     Assert.IsTrue( _Execut.BuildTo( _Device ).BuildOK );
     Assert.IsTrue( RunIs( 5 ) );
end;

// 言語の版を変えると、ビルドし直されて、走る
procedure TBuildTests.VersionChanged;
var
   B :TCLBuildr;
begin
     Assert.IsTrue( RunIs( 1 ) );

     B := _Execut.BuildTo( _Device );
     B.Version := TCLVersion.CL120;

     Assert.IsTrue( RunIs( 1 ) );
     Assert.AreEqual( Ord( TCLVersion.CL120 ), Ord( _Execut.BuildTo( _Device ).Version ) );
end;

// 手に持っているビルドのオブジェクトは、ソースを変えても、同じものが残る
procedure TBuildTests.BuildrSurvivesSourceChange;
var
   B :TCLBuildr;
begin
     B := _Execut.BuildTo( _Device );
     B.Version := TCLVersion.CL120;

     SetSource( '6.0f' );

     Assert.IsTrue( _Execut.Buildrs.Contains( _Device ) );
     Assert.AreSame( B, _Execut.BuildTo( _Device ) );
     Assert.AreEqual( Ord( TCLVersion.CL120 ), Ord( B.Version ) );
     Assert.IsTrue( RunIs( 6 ) );
end;

// ビルドのデバイスを変えると、デバイスからビルドを引く対応も、付いて変わる
procedure TBuildTests.BuildrDeviceChanged;
var
   B :TCLBuildr;
begin
     B := _Execut.BuildTo( _Device );

     B.Device := nil;

     Assert.IsFalse( _Execut.Buildrs.Contains( _Device ) );

     B.Device := _Device;

     Assert.IsTrue( _Execut.Buildrs.Contains( _Device ) );
     Assert.AreSame( B, _Execut.BuildTo( _Device ) );
     Assert.IsTrue( RunIs( 1 ) );
end;

// ソースに無い名前のカーネルは、ハンドルを読むと ECLError になる
procedure TBuildTests.UnknownKernelNameRaises;
var
   K :TCLKernel;
begin
     K := TCLKernel.Create( _Execut, 'Nothing', _Queuer );

     Assert.IsTrue( Raises( procedure begin K.Handle; end ) );

     Assert.IsTrue( RunIs( 1 ), 'ほかのカーネルは、そのまま走る' );
end;

// カーネルの引数に当たる仮引数が無ければ、FindsOK は False
procedure TBuildTests.ParameterMissing;
var
   K :TCLKernel;
begin
     K := TCLKernel.Create( _Execut, 'Fill', _Queuer );

     Assert.IsFalse( K.Parames.FindsOK );
     Assert.IsFalse( K.Parames.BindsOK );

     K.Parames[ 'Buffer' ] := _Buffer;

     Assert.IsTrue( K.Parames.FindsOK );
     Assert.IsTrue( K.Parames.BindsOK );
end;

// 仮引数の名前を直すと、新しい名前で照合される
procedure TBuildTests.ParameterRenamed;
var
   K :TCLKernel;
   P :TCLParame;
begin
     K := TCLKernel.Create( _Execut, 'Fill', _Queuer );

     P := K.Parames.Items[ 'Wrong' ];
     P.Argume := _Buffer;

     Assert.IsFalse( K.Parames.FindsOK );

     P.Name := 'Buffer';

     Assert.IsTrue( K.Parames.FindsOK );
     Assert.IsTrue( K.Parames.Contains( 'Buffer' ) );
     Assert.IsFalse( K.Parames.Contains( 'Wrong' ) );
end;

// 引数を渡せていないカーネルを走らせると、ECLError になる
procedure TBuildTests.RunWithoutArgumentRaises;
var
   K :TCLKernel;
begin
     K := TCLKernel.Create( _Execut, 'Fill', _Queuer );
     K.GloSizX := 1;

     Assert.IsTrue( Raises( procedure begin K.Run; end ) );
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

initialization //############################################################### ■

     TDUnitX.RegisterTestFixture( TBuildTests );

end. //######################################################################### ■
