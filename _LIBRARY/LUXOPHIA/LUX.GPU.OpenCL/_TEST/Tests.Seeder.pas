unit Tests.Seeder;

// 乱数の種（TCLSeeder1D・2D・3D）の試験
//
//【確かめること】
// ・種の画像が作れ、どの画素も 0 でない状態を持ち、画素ごとに状態が違う。
// ・作れない大きさ（0）は、ECLError になり、直せば作れる。
// ・種を解放すると、種が作った実行プログラムも、コンテキストから無くなる。
// ・種をカーネルに渡して乱数を引くと、値が [ 0, 1 ) に入り、走らせるたびに変わる。

interface //#################################################################### ■

uses DUnitX.TestFramework,
     LUX.Color,
     Tests.Base;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 T Y P E 】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R E C O R D 】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C L A S S 】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TSeederTests

     [TestFixture]
     TSeederTests = class( TCLTests )
     private
       ///// M E T H O D
       function IsZero( const S_:TUInt32xRGBA ) :Boolean;
       function IsSame( const S0_,S1_:TUInt32xRGBA ) :Boolean;
     public
       [Test] procedure Seeder1D;
       [Test] procedure Seeder2D;
       [Test] procedure Seeder3D;
       [Test] procedure ZeroSizeRaises;
       [Test] procedure FreedSeederLeavesNoProgram;
       [Test] procedure RandomNumbers;
     end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

implementation //############################################################### ■

uses System.SysUtils,
     LUX.OpenCL,
     LUX.OpenCL.Argume.Seeder;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R E C O R D 】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C L A S S 】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TSeederTests

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//////////////////////////////////////////////////////////////////// M E T H O D

function TSeederTests.IsZero( const S_:TUInt32xRGBA ) :Boolean;
begin
     Result := ( S_.C.R = 0 ) and ( S_.C.G = 0 ) and ( S_.C.B = 0 ) and ( S_.A = 0 );
end;

function TSeederTests.IsSame( const S0_,S1_:TUInt32xRGBA ) :Boolean;
begin
     Result := ( S0_.C.R = S1_.C.R ) and ( S0_.C.G = S1_.C.G ) and ( S0_.C.B = S1_.C.B ) and ( S0_.A = S1_.A );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

// 1 次元：どの画素も 0 でなく、隣どうしで違う
procedure TSeederTests.Seeder1D;
var
   S :TCLSeeder1D;
   X :Integer;
   A, B :TUInt32xRGBA;
begin
     S := TCLSeeder1D.Create( _Queuer );
     S.CountX := 16;

     Assert.IsTrue( Assigned( S.Handle ) );

     for X := 0 to S.CountX-1 do
     begin
          A := S.Data[ X ];

          Assert.IsTrue( not IsZero( A ) );

          if X > 0 then
          begin
               B := S.Data[ X-1 ];

               Assert.IsTrue( not IsSame( A, B ) );
          end;
     end;

     S.Data.Unmap;

     Assert.IsTrue( RunIs( 1 ), '種がコンテキストに加わっても、ほかのカーネルは走る' );
end;

// 2 次元：横の隣とも、縦の隣とも違う
procedure TSeederTests.Seeder2D;
var
   S :TCLSeeder2D;
   A, B, C :TUInt32xRGBA;
begin
     S := TCLSeeder2D.Create( _Queuer );
     S.CountX := 8;
     S.CountY := 6;

     A := S.Data[ 3, 2 ];
     B := S.Data[ 4, 2 ];
     C := S.Data[ 3, 3 ];

     S.Data.Unmap;

     Assert.IsTrue( not IsZero( A ) );
     Assert.IsTrue( not IsSame( A, B ) );
     Assert.IsTrue( not IsSame( A, C ) );
end;

// 3 次元：層の隣とも違う
procedure TSeederTests.Seeder3D;
var
   S :TCLSeeder3D;
   A, B :TUInt32xRGBA;
begin
     S := TCLSeeder3D.Create( _Queuer );
     S.CountX := 4;
     S.CountY := 4;
     S.CountZ := 3;

     A := S.Data[ 1, 2, 0 ];
     B := S.Data[ 1, 2, 1 ];

     S.Data.Unmap;

     Assert.IsTrue( not IsZero( A ) );
     Assert.IsTrue( not IsSame( A, B ) );
end;

// 幅 0 の種は、ECLError になる。幅を直せば、作れる
procedure TSeederTests.ZeroSizeRaises;
var
   S :TCLSeeder1D;
begin
     S := TCLSeeder1D.Create( _Queuer );
     S.CountX := 0;

     Assert.IsTrue( Raises( procedure begin S.Handle; end ) );

     S.CountX := 16;

     Assert.IsTrue( Assigned( S.Handle ) );
end;

// 種を解放すると、種が作った実行プログラムも、コンテキストの一覧から無くなる
procedure TSeederTests.FreedSeederLeavesNoProgram;
var
   N :Integer;
   S :TCLSeeder2D;
begin
     N := _Contex.Executs.ChildrsN;

     S := TCLSeeder2D.Create( _Queuer );
     S.CountX := 8;
     S.CountY := 8;

     Assert.IsTrue( Assigned( S.Handle ) );
     Assert.AreEqual( N + 1, _Contex.Executs.ChildrsN );

     S.Free;

     Assert.AreEqual( N, _Contex.Executs.ChildrsN );
     Assert.IsTrue( RunIs( 1 ) );
end;

// 種から乱数を引くと、[ 0, 1 ) に入り、平均が 0.5 に近く、走らせるたびに値が変わる
procedure TSeederTests.RandomNumbers;
var
   E :TCLExecut;
   K :TCLKernel;
   M :TCLImager2DxRGBAxSFlo32;
   S :TCLSeeder2D;
   X, Y, N, D :Integer;
   A, V :Single;
   L :TArray<Single>;
begin
     E := TCLExecut.Create( _Contex );
     with E.Source do
     begin
          Add( 'uint rotl( const uint x, const int k )' );
          Add( '{' );
          Add( '  return ( x << k ) | ( x >> ( 32 - k ) );' );
          Add( '}' );
          Add( 'float Rand( uint4* const S )' );
          Add( '{' );
          Add( '  const uint R = rotl( S->x + S->w, 7 ) + S->x;' );
          Add( '  const uint T = S->y << 9;' );
          Add( '  S->z ^= S->x;  S->w ^= S->y;  S->y ^= S->z;  S->x ^= S->w;' );
          Add( '  S->z ^= T;' );
          Add( '  S->w = rotl( S->w, 11 );' );
          Add( '  return ( R >> 8 ) / 16777216.0f;' );
          Add( '}' );
          Add( 'kernel void Noise( read_write image2d_t Seeder, write_only image2d_t Imager )' );
          Add( '{' );
          Add( '  const int2 P = { get_global_id( 0 ), get_global_id( 1 ) };' );
          Add( '  uint4 Seed = read_imageui( Seeder, P );' );
          Add( '  const float L = Rand( &Seed );' );
          Add( '  write_imagef( Imager, P, (float4)( L, L, L, 1 ) );' );
          Add( '  write_imageui( Seeder, P, Seed );' );
          Add( '}' );
     end;

     M := TCLImager2DxRGBAxSFlo32.Create( _Queuer );
     M.CountX := 64;
     M.CountY := 48;

     S := TCLSeeder2D.Create( _Queuer );
     S.CountX := M.CountX;
     S.CountY := M.CountY;

     K := TCLKernel.Create( E, 'Noise', _Queuer );
     K.Parames[ 'Seeder' ] := S;
     K.Parames[ 'Imager' ] := M;
     K.GloSizX := M.CountX;
     K.GloSizY := M.CountY;
     K.Run;

     N := M.CountX * M.CountY;

     SetLength( L, N );

     A := 0;
     for Y := 0 to M.CountY-1 do
     begin
          for X := 0 to M.CountX-1 do
          begin
               V := M.Data[ X, Y ].R;

               Assert.IsTrue( ( 0 <= V ) and ( V < 1 ) );

               L[ Y * M.CountX + X ] := V;

               A := A + V;
          end;
     end;

     M.Data.Unmap;

     Assert.IsTrue( Abs( A / N - 0.5 ) < 0.05, '平均が 0.5 から遠い' );

     K.Run;

     D := 0;
     for Y := 0 to M.CountY-1 do
     begin
          for X := 0 to M.CountX-1 do
          begin
               if M.Data[ X, Y ].R <> L[ Y * M.CountX + X ] then Inc( D );
          end;
     end;

     M.Data.Unmap;

     Assert.IsTrue( D > 0.99 * N, '2 度目の実行で、値が変わっていない' );
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

initialization //############################################################### ■

     TDUnitX.RegisterTestFixture( TSeederTests );

end. //######################################################################### ■
