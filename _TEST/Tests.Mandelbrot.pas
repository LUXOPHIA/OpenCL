unit Tests.Mandelbrot;

// アプリのカーネル（_DATA の Librar.cl・Execut.cl と、色のテクスチャ Textur.png）の試験
//
//【確かめること】
// ・アプリが読み込むソースが、そのままビルドでき、アプリが渡す 4 つの引数（Buffer・Textur・Samplr・Imager）が
//   カーネル Main の引数と合う。
// ・描かれる絵が、マンデルブロ集合の性質を満たす：集合の中の点はどれも同じ色、遠くの点は違う色、
//   実軸について上下が対称、表示の領域を変えると絵が変わる。
//
//【やり方】
// ・Main.pas の MakeContext・MakeArguments・MakePrograms と同じ組み立てを、窓なしで行う（絵は 64 × 64）。
// ・ファイルは、このフォルダーの隣の _DATA から読む（test.bat が、このフォルダーを作業フォルダーにする）。

interface //#################################################################### ■

uses DUnitX.TestFramework,
     LUX.Complex,
     LUX.Color,
     LUX.OpenCL,
     LUX.OpenCL.Stream.FMX.D1;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 T Y P E 】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R E C O R D 】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C L A S S 】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TMandelbrotTests

     [TestFixture]
     TMandelbrotTests = class
     private
       _Platfo :TCLPlatfo;
       _Device :TCLDevice;
       _Contex :TCLContex;
       _Queuer :TCLQueuer;
       _Buffer :TCLBuffer<TSingleC>;
       _Textur :TCLImager1DxBGRAxUFix8;
       _TexFMX :ICLStream1DxBGRAxUFix8_FMX;
       _Samplr :TCLSamplr;
       _Imager :TCLImager2DxBGRAxUFix8;
       _Librar :TCLLibrar;
       _Execut :TCLExecut;
       _Kernel :TCLKernel;
       ///// M E T H O D
       procedure Render( const Cent_,Size_:TSingleC );
       function Pixel( const X_,Y_:Integer ) :Cardinal;
     public
       [Setup]    procedure Setup;
       [TearDown] procedure TearDown;
       /////
       [Test] procedure SourcesBuild;
       [Test] procedure ArgumentsMatch;
       [Test] procedure InsideIsOneColor;
       [Test] procedure OutsideDiffersFromInside;
       [Test] procedure SymmetricAboutRealAxis;
       [Test] procedure ViewChangesPicture;
     end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

implementation //############################################################### ■

uses System.SysUtils;

const SIZE = 64;  // 絵の 1 辺の画素の数

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R E C O R D 】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C L A S S 】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TMandelbrotTests

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//////////////////////////////////////////////////////////////////// M E T H O D

// 中心 Cent_・半分の大きさ Size_ の領域を描く
procedure TMandelbrotTests.Render( const Cent_,Size_:TSingleC );
begin
     _Buffer.Data[ 0 ] := Cent_;
     _Buffer.Data[ 1 ] := Size_;
     _Buffer.Data.Unmap;

     _Kernel.Run;
end;

function TMandelbrotTests.Pixel( const X_,Y_:Integer ) :Cardinal;
begin
     Result := PCardinal( _Imager.Data.ValueP[ X_, Y_ ] )^;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

procedure TMandelbrotTests.Setup;
begin
     _Platfo := TOpenCL.Platfos[ 0 ];
     _Device := _Platfo.Devices[ 0 ];

     _Contex := TCLContex.Create( _Platfo );
     _Queuer := TCLQueuer.Create( _Contex, _Device );

     _Buffer := TCLBuffer<TSingleC>.Create( _Queuer );
     _Buffer.Count := 2;

     _Textur := TCLImager1DxBGRAxUFix8.Create( _Queuer );
     _TexFMX := TCLStream1DxBGRAxUFix8_FMX.Create( _Textur );
     _TexFMX.LoadFromFile( '..\_DATA\Textur.png' );

     _Samplr := TCLSamplr.Create( _Contex );

     _Imager := TCLImager2DxBGRAxUFix8.Create( _Queuer );
     _Imager.CountX := SIZE;
     _Imager.CountY := SIZE;

     _Librar := TCLLibrar.Create( _Contex );
     _Librar.Source.LoadFromFile( '..\_DATA\Librar.cl' );

     _Execut := TCLExecut.Create( _Contex );
     _Execut.Source.LoadFromFile( '..\_DATA\Execut.cl' );

     _Kernel := TCLKernel.Create( _Execut, 'Main', _Queuer );
     _Kernel.GloSizX := SIZE;
     _Kernel.GloSizY := SIZE;

     _Kernel.Parames[ 'Buffer' ] := _Buffer;
     _Kernel.Parames[ 'Textur' ] := _Textur;
     _Kernel.Parames[ 'Samplr' ] := _Samplr;
     _Kernel.Parames[ 'Imager' ] := _Imager;
end;

procedure TMandelbrotTests.TearDown;
begin
     _TexFMX := nil;

     _Contex.Free;
end;

// アプリのソースが、そのままビルドできる
procedure TMandelbrotTests.SourcesBuild;
begin
     Assert.IsTrue( _Execut.BuildTo( _Device ).BuildOK, _Execut.BuildTo( _Device ).BuildLog );
end;

// アプリが渡す 4 つの引数が、カーネル Main の引数と合い、渡せる
procedure TMandelbrotTests.ArgumentsMatch;
begin
     Assert.AreEqual( 4, Integer( _Kernel.KERNEL_NUM_ARGS ) );
     Assert.IsTrue( _Kernel.Parames.FindsOK );
     Assert.IsTrue( _Kernel.Parames.BindsOK );
end;

// 集合の中の点（原点の近くと、-1 の近く）は、どれも同じ色になる（反復が上限まで続くので）
procedure TMandelbrotTests.InsideIsOneColor;
var
   A, B, C :Cardinal;
begin
     Render( TSingleC.Create( 0, 0 ), TSingleC.Create( 2, 2 ) );

     A := Pixel( SIZE div 2    , SIZE div 2 );  // 0 の近く
     B := Pixel( SIZE div 2 - 1, SIZE div 2 );
     C := Pixel( SIZE div 4    , SIZE div 2 );  // -1 の近く

     _Imager.Data.Unmap;

     Assert.AreEqual( A, B );
     Assert.AreEqual( A, C );
end;

// 集合から遠い点（隅）は、中の点と違う色になる
procedure TMandelbrotTests.OutsideDiffersFromInside;
var
   A, B :Cardinal;
begin
     Render( TSingleC.Create( 0, 0 ), TSingleC.Create( 2, 2 ) );

     A := Pixel( SIZE div 2, SIZE div 2 );
     B := Pixel( 0, 0 );

     _Imager.Data.Unmap;

     Assert.AreNotEqual( A, B );
end;

// 実軸について、上下が対称になる（中心が実軸の上にあるとき）
procedure TMandelbrotTests.SymmetricAboutRealAxis;
var
   X, Y :Integer;
begin
     Render( TSingleC.Create( -0.5, 0 ), TSingleC.Create( 1.5, 1.5 ) );

     for Y := 0 to SIZE div 2 - 1 do
     begin
          for X := 0 to SIZE-1 do Assert.AreEqual( Pixel( X, Y ), Pixel( X, SIZE-1 - Y ) );
     end;

     _Imager.Data.Unmap;
end;

// 表示の領域を変えると、絵が変わる（バッファの値が、カーネルに届いている）
procedure TMandelbrotTests.ViewChangesPicture;
var
   A :TArray<Cardinal>;
   X, Y, N :Integer;
begin
     Render( TSingleC.Create( 0, 0 ), TSingleC.Create( 2, 2 ) );

     SetLength( A, SIZE * SIZE );

     for Y := 0 to SIZE-1 do
     begin
          for X := 0 to SIZE-1 do A[ Y * SIZE + X ] := Pixel( X, Y );
     end;

     _Imager.Data.Unmap;

     Render( TSingleC.Create( -0.75, 0.1 ), TSingleC.Create( 0.1, 0.1 ) );

     N := 0;
     for Y := 0 to SIZE-1 do
     begin
          for X := 0 to SIZE-1 do
          begin
               if A[ Y * SIZE + X ] <> Pixel( X, Y ) then Inc( N );
          end;
     end;

     _Imager.Data.Unmap;

     Assert.IsTrue( N > SIZE, '領域を変えても、絵がほとんど変わらない' );
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

initialization //############################################################### ■

     TDUnitX.RegisterTestFixture( TMandelbrotTests );

end. //######################################################################### ■
