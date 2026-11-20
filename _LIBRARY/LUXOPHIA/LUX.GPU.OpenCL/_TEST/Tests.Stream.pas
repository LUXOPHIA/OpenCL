unit Tests.Stream;

// 画像と、FMX の Stream（ビットマップとの読み書き）の試験
//
//【確かめること】
// ・画像に書いた画素が、マップを解除した後も読める（1・2・3 次元）。
// ・ビットマップ → 画像 → ビットマップ で、画素が元に戻る。画像は、ビットマップの大きさになる。
// ・ファイルへの読み書きができ、無いファイルは例外になる（その後も Stream は使える）。
// ・3 次元の Stream は、層を指定しなければ、Z = 0 の層を読み書きする。

interface //#################################################################### ■

uses DUnitX.TestFramework,
     Tests.Base;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 T Y P E 】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R E C O R D 】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C L A S S 】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TStreamTests

     [TestFixture]
     TStreamTests = class( TCLTests )
     private
       ///// M E T H O D
       function PixelOf( const Bitmap_:TObject; const X_,Y_:Integer ) :Cardinal;
     public
       [Test] procedure ImagePixels;
       [Test] procedure BitmapRoundTrip1D;
       [Test] procedure BitmapRoundTrip2D;
       [Test] procedure FileRoundTrip;
       [Test] procedure MissingFileRaises;
       [Test] procedure Stream3DLayers;
     end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

implementation //############################################################### ■

uses System.SysUtils, System.UITypes, System.IOUtils,
     FMX.Graphics,
     LUX.Color,
     LUX.GPU.OpenCL,
     LUX.GPU.OpenCL.Stream.FMX.D1,
     LUX.GPU.OpenCL.Stream.FMX.D2,
     LUX.GPU.OpenCL.Stream.FMX.D3;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R E C O R D 】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C L A S S 】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TStreamTests

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//////////////////////////////////////////////////////////////////// M E T H O D

function TStreamTests.PixelOf( const Bitmap_:TObject; const X_,Y_:Integer ) :Cardinal;
var
   D :TBitmapData;
begin
     TBitmap( Bitmap_ ).Map( TMapAccess.Read, D );

     Result := D.GetPixel( X_, Y_ );

     TBitmap( Bitmap_ ).Unmap( D );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

// 画像に書いた画素が、マップを解除した後も読める
procedure TStreamTests.ImagePixels;
var
   M1 :TCLImager1DxRGBAxSFlo32;
   M2 :TCLImager2DxRGBAxSFlo32;
   M3 :TCLImager3DxRGBAxSFlo32;
begin
     M1 := TCLImager1DxRGBAxSFlo32.Create( _Queuer );
     M1.CountX := 5;
     M1.Data[ 4 ] := TSingleRGBA.Create( 0.25, 0.5, 0.75, 1 );
     M1.Data.Unmap;

     Assert.AreEqual( Single( 0.75 ), M1.Data[ 4 ].B );

     M1.Data.Unmap;

     M2 := TCLImager2DxRGBAxSFlo32.Create( _Queuer );
     M2.CountX := 5;
     M2.CountY := 4;
     M2.Data[ 4, 3 ] := TSingleRGBA.Create( 0.25, 0.5, 0.75, 1 );
     M2.Data.Unmap;

     Assert.AreEqual( Single( 0.5 ), M2.Data[ 4, 3 ].G );

     M2.Data.Unmap;

     M3 := TCLImager3DxRGBAxSFlo32.Create( _Queuer );
     M3.CountX := 5;
     M3.CountY := 4;
     M3.CountZ := 3;
     M3.Data[ 4, 3, 2 ] := TSingleRGBA.Create( 0.25, 0.5, 0.75, 1 );
     M3.Data[ 0, 0, 0 ] := TSingleRGBA.Create( 1, 0, 0, 1 );
     M3.Data.Unmap;

     Assert.AreEqual( Single( 0.25 ), M3.Data[ 4, 3, 2 ].R );
     Assert.AreEqual( Single( 1    ), M3.Data[ 0, 0, 0 ].R );

     M3.Data.Unmap;
end;

// 1 次元：ビットマップ → 画像 → ビットマップ
procedure TStreamTests.BitmapRoundTrip1D;
var
   M :TCLImager1DxBGRAxUFix8;
   S :ICLStream1DxBGRAxUFix8_FMX;
   A, B :TBitmap;
begin
     M := TCLImager1DxBGRAxUFix8.Create( _Queuer );
     S := TCLStream1DxBGRAxUFix8_FMX.Create( M );

     A := TBitmap.Create( 7, 1 );
     B := TBitmap.Create;
     try
        A.Clear( TAlphaColors.Blue );

        S.CopyFrom( A );

        Assert.AreEqual( 7, M.CountX );

        S.CopyTo( B );

        Assert.AreEqual( 7, B.Width );
        Assert.AreEqual( Cardinal( TAlphaColors.Blue ), PixelOf( B, 6, 0 ) );
     finally
        A.Free;
        B.Free;
     end;
end;

// 2 次元：ビットマップ → 画像 → ビットマップ（画素ごとに違う色で、位置が合うことも見る）
procedure TStreamTests.BitmapRoundTrip2D;
var
   M :TCLImager2DxBGRAxUFix8;
   S :ICLStream2DxBGRAxUFix8_FMX;
   A, B :TBitmap;
   D :TBitmapData;
   X, Y :Integer;
begin
     M := TCLImager2DxBGRAxUFix8.Create( _Queuer );
     S := TCLStream2DxBGRAxUFix8_FMX.Create( M );

     A := TBitmap.Create( 5, 3 );
     B := TBitmap.Create;
     try
        A.Map( TMapAccess.Write, D );

        for Y := 0 to 3-1 do
        begin
             for X := 0 to 5-1 do D.SetPixel( X, Y, $FF000000 or Cardinal( ( 40 * X ) shl 16 ) or Cardinal( ( 70 * Y ) shl 8 ) or 9 );
        end;

        A.Unmap( D );

        S.CopyFrom( A );

        Assert.AreEqual( 5, M.CountX );
        Assert.AreEqual( 3, M.CountY );

        S.CopyTo( B );

        for Y := 0 to 3-1 do
        begin
             for X := 0 to 5-1 do Assert.AreEqual( PixelOf( A, X, Y ), PixelOf( B, X, Y ) );
        end;
     finally
        A.Free;
        B.Free;
     end;
end;

// ファイルへ書いて、読み戻す
procedure TStreamTests.FileRoundTrip;
var
   M :TCLImager2DxBGRAxUFix8;
   S :ICLStream2DxBGRAxUFix8_FMX;
   A, B :TBitmap;
   F :String;
begin
     F := TPath.Combine( TPath.GetTempPath, 'lux-opencl-test.png' );

     M := TCLImager2DxBGRAxUFix8.Create( _Queuer );
     S := TCLStream2DxBGRAxUFix8_FMX.Create( M );

     A := TBitmap.Create( 6, 4 );
     B := TBitmap.Create;
     try
        A.Clear( TAlphaColors.Red );

        S.CopyFrom( A );
        S.SaveToFile( F );
        try
           M.CountX := 1;

           S.LoadFromFile( F );
        finally
           TFile.Delete( F );
        end;

        Assert.AreEqual( 6, M.CountX );
        Assert.AreEqual( 4, M.CountY );

        S.CopyTo( B );

        Assert.AreEqual( Cardinal( TAlphaColors.Red ), PixelOf( B, 5, 3 ) );
     finally
        A.Free;
        B.Free;
     end;
end;

// 無いファイルを読むと、例外になる。その後も、Stream は使える
procedure TStreamTests.MissingFileRaises;
var
   M :TCLImager2DxBGRAxUFix8;
   S :ICLStream2DxBGRAxUFix8_FMX;
   A :TBitmap;
   R :Boolean;
begin
     M := TCLImager2DxBGRAxUFix8.Create( _Queuer );
     S := TCLStream2DxBGRAxUFix8_FMX.Create( M );

     R := False;
     try
        S.LoadFromFile( TPath.Combine( TPath.GetTempPath, 'lux-opencl-no-such-file.png' ) );
     except
        R := True;
     end;

     Assert.IsTrue( R, '無いファイルなのに、例外が出ない' );

     A := TBitmap.Create( 2, 2 );
     try
        S.CopyFrom( A );
     finally
        A.Free;
     end;

     Assert.AreEqual( 2, M.CountX );
end;

// 3 次元：層を指定しなければ Z = 0。層ごとに、別の絵を読み書きできる
procedure TStreamTests.Stream3DLayers;
var
   M :TCLImager3DxBGRAxUFix8;
   C :TCLStream3DxBGRAxUFix8_FMX;
   S :ICLStream3DxBGRAxUFix8_FMX;
   R, G, O :TBitmap;
   F :String;
begin
     F := TPath.Combine( TPath.GetTempPath, 'lux-opencl-test-3d.png' );

     M := TCLImager3DxBGRAxUFix8.Create( _Queuer );
     M.CountZ := 2;

     C := TCLStream3DxBGRAxUFix8_FMX.Create( M );
     S := C;

     R := TBitmap.Create( 4, 3 );
     G := TBitmap.Create( 4, 3 );
     O := TBitmap.Create;
     try
        R.Clear( TAlphaColors.Red   );
        G.Clear( TAlphaColors.Green );

        S.CopyFrom( R );
        S.CopyFrom( 1, G );

        Assert.AreEqual( 4, M.CountX );
        Assert.AreEqual( 3, M.CountY );
        Assert.AreEqual( 2, M.CountZ );

        S.CopyTo( O );
        Assert.AreEqual( Cardinal( TAlphaColors.Red   ), PixelOf( O, 1, 1 ) );

        S.CopyTo( 1, O );
        Assert.AreEqual( Cardinal( TAlphaColors.Green ), PixelOf( O, 1, 1 ) );

        C.CopyTo( O );  // クラスの型からも、層を指定しない版が呼べる
        Assert.AreEqual( Cardinal( TAlphaColors.Red   ), PixelOf( O, 1, 1 ) );

        S.SaveToFile( F );
        try
           S.CopyFrom( G );

           S.LoadFromFile( F );
        finally
           TFile.Delete( F );
        end;

        S.CopyTo( O );
        Assert.AreEqual( Cardinal( TAlphaColors.Red   ), PixelOf( O, 1, 1 ) );
     finally
        R.Free;
        G.Free;
        O.Free;
     end;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

initialization //############################################################### ■

     TDUnitX.RegisterTestFixture( TStreamTests );

end. //######################################################################### ■
