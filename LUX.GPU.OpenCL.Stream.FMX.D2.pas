unit LUX.GPU.OpenCL.Stream.FMX.D2;

interface //#################################################################### ■

uses System.UITypes,
     FMX.Graphics,
     LUX.Color,
     LUX.GPU.OpenCL,
     LUX.GPU.OpenCL.Stream.FMX.D1;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TCLStream2D_FMX<TCLImager_:class> = class;
       TCLStream2DxBGRAxUInt8_FMX      = class;
       TCLStream2DxBGRAxUFix8_FMX      = class;
       TCLStream2DxRGBAxUInt32_FMX     = class;
       TCLStream2DxRGBAxSFlo32_FMX     = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLStream2D_FMX<TCLImager_>

     ICLStream2D_FMX<TCLImager_:class> = interface( ICLStream1D_FMX<TCLImager_> )
     ['{49DD70F5-843E-4267-B948-8F80034B7567}']
     {protected}
     {public}
     end;

     TCLStream2D_FMX<TCLImager_:class> = class( TCLStream1D_FMX<TCLImager_>, ICLStream2D_FMX<TCLImager_> )
     private
     protected
     public
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLStream2DxBGRAxUInt8_FMX

     ICLStream2DxBGRAxUInt8_FMX = ICLStream2D_FMX<TCLImager2DxBGRAxUInt8>;

     TCLStream2DxBGRAxUInt8_FMX = class( TCLStream2D_FMX<TCLImager2DxBGRAxUInt8>, ICLStream2DxBGRAxUInt8_FMX )
     private
     protected
     public
       ///// メソッド
       procedure CopyTo( const Bitmap_:TBitmap ); override;
       procedure CopyFrom( const Bitmap_:TBitmap ); override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLStream2DxBGRAxUFix8_FMX

     ICLStream2DxBGRAxUFix8_FMX = ICLStream2D_FMX<TCLImager2DxBGRAxUFix8>;

     TCLStream2DxBGRAxUFix8_FMX = class( TCLStream2D_FMX<TCLImager2DxBGRAxUFix8>, ICLStream2DxBGRAxUFix8_FMX )
     private
     protected
     public
       ///// メソッド
       procedure CopyTo( const Bitmap_:TBitmap ); override;
       procedure CopyFrom( const Bitmap_:TBitmap ); override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLStream2DxRGBAxUInt32_FMX

     ICLStream2DxRGBAxUInt32_FMX = ICLStream2D_FMX<TCLImager2DxRGBAxUInt32>;

     TCLStream2DxRGBAxUInt32_FMX = class( TCLStream2D_FMX<TCLImager2DxRGBAxUInt32>, ICLStream2DxRGBAxUInt32_FMX )
     private
     protected
     public
       ///// メソッド
       procedure CopyTo( const Bitmap_:TBitmap ); override;
       procedure CopyFrom( const Bitmap_:TBitmap ); override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLStream2DxRGBAxSFlo32_FMX

     ICLStream2DxRGBAxSFlo32_FMX = ICLStream2D_FMX<TCLImager2DxRGBAxSFlo32>;

     TCLStream2DxRGBAxSFlo32_FMX = class( TCLStream2D_FMX<TCLImager2DxRGBAxSFlo32>, ICLStream2DxRGBAxSFlo32_FMX )
     private
     protected
     public
       ///// メソッド
       procedure CopyTo( const Bitmap_:TBitmap ); override;
       procedure CopyFrom( const Bitmap_:TBitmap ); override;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses System.Threading;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLStream2D_FMX<TCLImager_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLStream2DxBGRAxUInt8_FMX

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLStream2DxBGRAxUInt8_FMX.CopyTo( const Bitmap_:TBitmap );
var
   B :TBitmapData;
begin
     with _Imager do
     begin
          Bitmap_.SetSize( CountX, CountY );

          Data.Map;

          Bitmap_.Map( TMapAccess.Write, B );

          TParallel.For( 0, CountY-1, procedure( Y:Integer )
          begin
               Move( Data.ValueP[ 0, Y ]^,
                     B.GetScanline( Y )^,
                     B.BytesPerLine );
          end );

          Bitmap_.Unmap( B );

          Data.Unmap;
     end;
end;

procedure TCLStream2DxBGRAxUInt8_FMX.CopyFrom( const Bitmap_:TBitmap );
var
   B :TBitmapData;
begin
     with _Imager do
     begin
          CountX := Bitmap_.Width ;
          CountY := Bitmap_.Height;

          Bitmap_.Map( TMapAccess.Read, B );

          Data.Map;

          TParallel.For( 0, CountY-1, procedure( Y:Integer )
          begin
               Move( B.GetScanline( Y )^,
                     Data.ValueP[ 0, Y ]^,
                     B.BytesPerLine );
          end );

          Data.Unmap;

          Bitmap_.Unmap( B );
     end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLStream2DxBGRAxUFix8_FMX

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLStream2DxBGRAxUFix8_FMX.CopyTo( const Bitmap_:TBitmap );
var
   B :TBitmapData;
begin
     with _Imager do
     begin
          Bitmap_.SetSize( CountX, CountY );

          Data.Map;

          Bitmap_.Map( TMapAccess.Write, B );

          TParallel.For( 0, CountY-1, procedure( Y:Integer )
          begin
               Move( Data.ValueP[ 0, Y ]^,
                     B.GetScanline( Y )^,
                     B.BytesPerLine );
          end );

          Bitmap_.Unmap( B );

          Data.Unmap;
     end;
end;

procedure TCLStream2DxBGRAxUFix8_FMX.CopyFrom( const Bitmap_:TBitmap );
var
   B :TBitmapData;
begin
     with _Imager do
     begin
          CountX := Bitmap_.Width ;
          CountY := Bitmap_.Height;

          Bitmap_.Map( TMapAccess.Read, B );

          Data.Map;

          TParallel.For( 0, CountY-1, procedure( Y:Integer )
          begin
               Move( B.GetScanline( Y )^,
                     Data.ValueP[ 0, Y ]^,
                     B.BytesPerLine );
          end );

          Data.Unmap;

          Bitmap_.Unmap( B );
     end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLStream2DxRGBAxUInt32_FMX

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLStream2DxRGBAxUInt32_FMX.CopyTo( const Bitmap_:TBitmap );
var
   B :TBitmapData;
begin
     with _Imager do
     begin
          Bitmap_.SetSize( CountX, CountY );

          Data.Map;

          Bitmap_.Map( TMapAccess.Write, B );

          TParallel.For( 0, CountY-1, procedure( Y:Integer )
          var
             X :Integer;
          begin
               for X := 0 to CountX-1 do
               begin
                    B.SetPixel( X, Y, TByteRGBA( Data[ X, Y ] ) );
               end;
          end );

          Bitmap_.Unmap( B );

          Data.Unmap;
     end;
end;

procedure TCLStream2DxRGBAxUInt32_FMX.CopyFrom( const Bitmap_:TBitmap );
var
   B :TBitmapData;
begin
     with _Imager do
     begin
          CountX := Bitmap_.Width ;
          CountY := Bitmap_.Height;

          Bitmap_.Map( TMapAccess.Read, B );

          Data.Map;

          TParallel.For( 0, CountY-1, procedure( Y:Integer )
          var
             X :Integer;
          begin
               for X := 0 to CountX-1 do
               begin
                    Data[ X, Y ] := B.GetPixel( X, Y );
               end;
          end );

          Data.Unmap;

          Bitmap_.Unmap( B );
     end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLStream2DxRGBAxSFlo32_FMX

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLStream2DxRGBAxSFlo32_FMX.CopyTo( const Bitmap_:TBitmap );
var
   B :TBitmapData;
begin
     with _Imager do
     begin
          Bitmap_.SetSize( CountX, CountY );

          Data.Map;

          Bitmap_.Map( TMapAccess.Write, B );

          TParallel.For( 0, CountY-1, procedure( Y:Integer )
          var
             X :Integer;
          begin
               for X := 0 to CountX-1 do
               begin
                    B.SetPixel( X, Y, TByteRGBA( Data[ X, Y ] ) );
               end;
          end );

          Bitmap_.Unmap( B );

          Data.Unmap;
     end;
end;

procedure TCLStream2DxRGBAxSFlo32_FMX.CopyFrom( const Bitmap_:TBitmap );
var
   B :TBitmapData;
begin
     with _Imager do
     begin
          CountX := Bitmap_.Width ;
          CountY := Bitmap_.Height;

          Bitmap_.Map( TMapAccess.Read, B );

          Data.Map;

          TParallel.For( 0, CountY-1, procedure( Y:Integer )
          var
             X :Integer;
          begin
               for X := 0 to CountX-1 do
               begin
                    Data[ X, Y ] := B.GetPixel( X, Y );
               end;
          end );

          Data.Unmap;

          Bitmap_.Unmap( B );
     end;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

end. //######################################################################### ■
