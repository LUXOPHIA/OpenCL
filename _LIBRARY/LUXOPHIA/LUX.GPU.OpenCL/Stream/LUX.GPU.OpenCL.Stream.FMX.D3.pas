unit LUX.GPU.OpenCL.Stream.FMX.D3;

interface //#################################################################### ■

uses System.UITypes,
     FMX.Graphics,
     LUX.Color,
     LUX.GPU.OpenCL,
     LUX.GPU.OpenCL.Stream.FMX.D2;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TCLStream3D_FMX<TCLImager_:class> = class;
       TCLStream3DxBGRAxUInt8_FMX      = class;
       TCLStream3DxBGRAxUFix8_FMX      = class;
       TCLStream3DxRGBAxUInt32_FMX     = class;
       TCLStream3DxRGBAxSFlo32_FMX     = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLStream3D_FMX<TCLImager_>

     ICLStream3D_FMX<TCLImager_:class> = interface( ICLStream2D_FMX<TCLImager_> )
     ['{C78BBF2F-7207-49D2-BA4D-B5B955687593}']
     {protected}
     {public}
       ///// メソッド
       procedure CopyTo( const Z_:Integer; const Bitmap_:TBitmap );
       procedure CopyFrom( const Z_:Integer; const Bitmap_:TBitmap );
     end;

     TCLStream3D_FMX<TCLImager_:class> = class( TCLStream2D_FMX<TCLImager_>, ICLStream3D_FMX<TCLImager_> )
     private
     protected
     public
       ///// メソッド
       procedure CopyTo( const Z_:Integer; const Bitmap_:TBitmap ); overload; virtual; abstract;
       procedure CopyFrom( const Z_:Integer; const Bitmap_:TBitmap ); overload; virtual; abstract;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLStream3DxBGRAxUInt8_FMX

     ICLStream3DxBGRAxUInt8_FMX = ICLStream3D_FMX<TCLImager3DxBGRAxUInt8>;

     TCLStream3DxBGRAxUInt8_FMX = class( TCLStream3D_FMX<TCLImager3DxBGRAxUInt8>, ICLStream3DxBGRAxUInt8_FMX )
     private
     protected
     public
       ///// メソッド
       procedure CopyTo( const Z_:Integer; const Bitmap_:TBitmap ); override;
       procedure CopyFrom( const Z_:Integer; const Bitmap_:TBitmap ); override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLStream3DxBGRAxUFix8_FMX

     ICLStream3DxBGRAxUFix8_FMX = ICLStream3D_FMX<TCLImager3DxBGRAxUFix8>;

     TCLStream3DxBGRAxUFix8_FMX = class( TCLStream3D_FMX<TCLImager3DxBGRAxUFix8>, ICLStream3DxBGRAxUFix8_FMX )
     private
     protected
     public
       ///// メソッド
       procedure CopyTo( const Z_:Integer; const Bitmap_:TBitmap ); override;
       procedure CopyFrom( const Z_:Integer; const Bitmap_:TBitmap ); override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLStream3DxRGBAxUInt32_FMX

     ICLStream3DxRGBAxUInt32_FMX = ICLStream3D_FMX<TCLImager3DxRGBAxUInt32>;

     TCLStream3DxRGBAxUInt32_FMX = class( TCLStream3D_FMX<TCLImager3DxRGBAxUInt32>, ICLStream3DxRGBAxUInt32_FMX )
     private
     protected
     public
       ///// メソッド
       procedure CopyTo( const Z_:Integer; const Bitmap_:TBitmap ); override;
       procedure CopyFrom( const Z_:Integer; const Bitmap_:TBitmap ); override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLStream3DxRGBAxSFlo32_FMX

     ICLStream3DxRGBAxSFlo32_FMX = ICLStream3D_FMX<TCLImager3DxRGBAxSFlo32>;

     TCLStream3DxRGBAxSFlo32_FMX = class( TCLStream3D_FMX<TCLImager3DxRGBAxSFlo32>, ICLStream3DxRGBAxSFlo32_FMX )
     private
     protected
     public
       ///// メソッド
       procedure CopyTo( const Z_:Integer; const Bitmap_:TBitmap ); override;
       procedure CopyFrom( const Z_:Integer; const Bitmap_:TBitmap ); override;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses System.Threading;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLStream3D_FMX<TCLImager_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLStream3DxBGRAxUInt8_FMX

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLStream3DxBGRAxUInt8_FMX.CopyTo( const Z_:Integer; const Bitmap_:TBitmap );
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
               Move( Data.ValueP[ 0, Y, Z_ ]^,
                     B.GetScanline( Y )^,
                     B.BytesPerLine );
          end );

          Bitmap_.Unmap( B );

          Data.Unmap;
     end;
end;

procedure TCLStream3DxBGRAxUInt8_FMX.CopyFrom( const Z_:Integer; const Bitmap_:TBitmap );
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
                     Data.ValueP[ 0, Y, Z_ ]^,
                     B.BytesPerLine );
          end );

          Data.Unmap;

          Bitmap_.Unmap( B );
     end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLStream3DxBGRAxUFix8_FMX

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLStream3DxBGRAxUFix8_FMX.CopyTo( const Z_:Integer; const Bitmap_:TBitmap );
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
               Move( Data.ValueP[ 0, Y, Z_ ]^,
                     B.GetScanline( Y )^,
                     B.BytesPerLine );
          end );

          Bitmap_.Unmap( B );

          Data.Unmap;
     end;
end;

procedure TCLStream3DxBGRAxUFix8_FMX.CopyFrom( const Z_:Integer; const Bitmap_:TBitmap );
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
                     Data.ValueP[ 0, Y, Z_ ]^,
                     B.BytesPerLine );
          end );

          Data.Unmap;

          Bitmap_.Unmap( B );
     end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLStream3DxRGBAxUInt32_FMX

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLStream3DxRGBAxUInt32_FMX.CopyTo( const Z_:Integer; const Bitmap_:TBitmap );
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
                    B.SetPixel( X, Y, TByteRGBA( Data[ X, Y, Z_ ] ) );
               end;
          end );

          Bitmap_.Unmap( B );

          Data.Unmap;
     end;
end;

procedure TCLStream3DxRGBAxUInt32_FMX.CopyFrom( const Z_:Integer; const Bitmap_:TBitmap );
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
                    Data[ X, Y, Z_ ] := B.GetPixel( X, Y );
               end;
          end );

          Data.Unmap;

          Bitmap_.Unmap( B );
     end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLStream3DxRGBAxSFlo32_FMX

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLStream3DxRGBAxSFlo32_FMX.CopyTo( const Z_:Integer; const Bitmap_:TBitmap );
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
                    B.SetPixel( X, Y, TAlphaColor( TByteRGBA( Data[ X, Y, Z_ ] ) ) );
               end;
          end );

          Bitmap_.Unmap( B );

          Data.Unmap;
     end;
end;

procedure TCLStream3DxRGBAxSFlo32_FMX.CopyFrom( const Z_:Integer; const Bitmap_:TBitmap );
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
                    Data[ X, Y, Z_ ] := B.GetPixel( X, Y );
               end;
          end );

          Data.Unmap;

          Bitmap_.Unmap( B );
     end;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

end. //######################################################################### ■
