﻿unit LUX.GPU.OpenCL.Stream.FMX.D1;

interface //#################################################################### ■

uses System.UITypes,
     FMX.Graphics,
     LUX.Color,
     LUX.GPU.OpenCL;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 T Y P E 】

     TCLStream1D_FMX<TCLImager_:class> = class;
       TCLStream1DxBGRAxUInt8_FMX      = class;
       TCLStream1DxBGRAxUFix8_FMX      = class;
       TCLStream1DxRGBAxUInt32_FMX     = class;
       TCLStream1DxRGBAxSFlo32_FMX     = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R E C O R D 】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C L A S S 】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLStream1D_FMX<TCLImager_>

     ICLStream1D_FMX<TCLImager_:class> = interface
     ['{E73175E6-01E1-48AD-9660-5DD2EC6FE3F8}']
     {protected}
       function GetImage :TCLImager_;
       procedure SetImage( const Imager_:TCLImager_ );
     {public}
       ///// P R O P E R T Y
       property Imager :TCLImager_ read GetImage write SetImage;
       ///// M E T H O D
       procedure CopyTo( const Bitmap_:TBitmap ); overload;
       procedure CopyFrom( const Bitmap_:TBitmap ); overload;
       procedure SaveToFile( const FileName_:String );
       procedure LoadFromFile( const FileName_:String );
     end;

     TCLStream1D_FMX<TCLImager_:class> = class( TInterfacedObject, ICLStream1D_FMX<TCLImager_> )
     private
     protected
       _Imager :TCLImager_;
       ///// A C C E S S O R
       function GetImage :TCLImager_;
       procedure SetImage( const Imager_:TCLImager_ );
     public
       constructor Create; overload;
       constructor Create( const Imager_:TCLImager_ ); overload;
       ///// P R O P E R T Y
       property Imager :TCLImager_ read GetImage write SetImage;
       ///// M E T H O D
       procedure CopyTo( const Bitmap_:TBitmap ); overload; virtual; abstract;
       procedure CopyFrom( const Bitmap_:TBitmap ); overload; virtual; abstract;
       procedure SaveToFile( const FileName_:String ); virtual;
       procedure LoadFromFile( const FileName_:String ); virtual;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLStream1DxBGRAxUInt8_FMX

     ICLStream1DxBGRAxUInt8_FMX = ICLStream1D_FMX<TCLImager1DxBGRAxUInt8>;

     TCLStream1DxBGRAxUInt8_FMX = class( TCLStream1D_FMX<TCLImager1DxBGRAxUInt8>, ICLStream1DxBGRAxUInt8_FMX )
     private
     protected
     public
       ///// M E T H O D
       procedure CopyTo( const Bitmap_:TBitmap ); override;
       procedure CopyFrom( const Bitmap_:TBitmap ); override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLStream1DxBGRAxUFix8_FMX

     ICLStream1DxBGRAxUFix8_FMX = ICLStream1D_FMX<TCLImager1DxBGRAxUFix8>;

     TCLStream1DxBGRAxUFix8_FMX = class( TCLStream1D_FMX<TCLImager1DxBGRAxUFix8>, ICLStream1DxBGRAxUFix8_FMX )
     private
     protected
     public
       ///// M E T H O D
       procedure CopyTo( const Bitmap_:TBitmap ); override;
       procedure CopyFrom( const Bitmap_:TBitmap ); override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLStream1DxRGBAxUInt32_FMX

     ICLStream1DxRGBAxUInt32_FMX = ICLStream1D_FMX<TCLImager1DxRGBAxUInt32>;

     TCLStream1DxRGBAxUInt32_FMX = class( TCLStream1D_FMX<TCLImager1DxRGBAxUInt32>, ICLStream1DxRGBAxUInt32_FMX )
     private
     protected
     public
       ///// M E T H O D
       procedure CopyTo( const Bitmap_:TBitmap ); override;
       procedure CopyFrom( const Bitmap_:TBitmap ); override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLStream1DxRGBAxSFlo32_FMX

     ICLStream1DxRGBAxSFlo32_FMX = ICLStream1D_FMX<TCLImager1DxRGBAxSFlo32>;

     TCLStream1DxRGBAxSFlo32_FMX = class( TCLStream1D_FMX<TCLImager1DxRGBAxSFlo32>, ICLStream1DxRGBAxSFlo32_FMX )
     private
     protected
     public
       ///// M E T H O D
       procedure CopyTo( const Bitmap_:TBitmap ); override;
       procedure CopyFrom( const Bitmap_:TBitmap ); override;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C O N S T A N T 】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 V A R I A B L E 】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

implementation //############################################################### ■

uses System.Threading;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R E C O R D 】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C L A S S 】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLStream1D_FMX<TCLImager_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//////////////////////////////////////////////////////////////// A C C E S S O R

function TCLStream1D_FMX<TCLImager_>.GetImage :TCLImager_;
begin
     Result := _Imager;
end;

procedure TCLStream1D_FMX<TCLImager_>.SetImage( const Imager_:TCLImager_ );
begin
     _Imager := Imager_;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLStream1D_FMX<TCLImager_>.Create;
begin
     inherited;

end;

constructor TCLStream1D_FMX<TCLImager_>.Create( const Imager_:TCLImager_ );
begin
     Create;

     Imager := Imager_;
end;

//////////////////////////////////////////////////////////////////// M E T H O D

procedure TCLStream1D_FMX<TCLImager_>.SaveToFile( const FileName_:String );
var
   B :TBitmap;
begin
     B := TBitmap.Create;

     CopyTo( B );

     B.SaveToFile( FileName_ );

     B.Free;
end;

procedure TCLStream1D_FMX<TCLImager_>.LoadFromFile( const FileName_:String );
var
   B :TBitmap;
begin
     B := TBitmap.Create;

     B.LoadFromFile( FileName_ );

     CopyFrom( B );

     B.Free;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLStream1DxBGRAxUInt8_FMX

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//////////////////////////////////////////////////////////////////// M E T H O D

procedure TCLStream1DxBGRAxUInt8_FMX.CopyTo( const Bitmap_:TBitmap );
var
   B :TBitmapData;
begin
     with _Imager do
     begin
          Bitmap_.SetSize( CountX, CountY );

          Data.Map;

          Bitmap_.Map( TMapAccess.Write, B );

          Move( Data.ValueP[ 0 ]^,
                B.GetScanline( 0 )^,
                B.BytesPerLine );

          Bitmap_.Unmap( B );

          Data.Unmap;
     end;
end;

procedure TCLStream1DxBGRAxUInt8_FMX.CopyFrom( const Bitmap_:TBitmap );
var
   B :TBitmapData;
begin
     with _Imager do
     begin
          CountX := Bitmap_.Width;

          Bitmap_.Map( TMapAccess.Read, B );

          Data.Map;

          Move( B.GetScanline( 0 )^,
                Data.ValueP[ 0 ]^,
                B.BytesPerLine );

          Data.Unmap;

          Bitmap_.Unmap( B );
     end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLStream1DxBGRAxUFix8_FMX

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//////////////////////////////////////////////////////////////////// M E T H O D

procedure TCLStream1DxBGRAxUFix8_FMX.CopyTo( const Bitmap_:TBitmap );
var
   B :TBitmapData;
begin
     with _Imager do
     begin
          Bitmap_.SetSize( CountX, CountY );

          Data.Map;

          Bitmap_.Map( TMapAccess.Write, B );

          Move( Data.ValueP[ 0 ]^,
                B.GetScanline( 0 )^,
                B.BytesPerLine );

          Bitmap_.Unmap( B );

          Data.Unmap;
     end;
end;

procedure TCLStream1DxBGRAxUFix8_FMX.CopyFrom( const Bitmap_:TBitmap );
var
   B :TBitmapData;
begin
     with _Imager do
     begin
          CountX := Bitmap_.Width;

          Bitmap_.Map( TMapAccess.Read, B );

          Data.Map;

          Move( B.GetScanline( 0 )^,
                Data.ValueP[ 0 ]^,
                B.BytesPerLine );

          Data.Unmap;

          Bitmap_.Unmap( B );
     end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLStream1DxRGBAxUInt32_FMX

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//////////////////////////////////////////////////////////////////// M E T H O D

procedure TCLStream1DxRGBAxUInt32_FMX.CopyTo( const Bitmap_:TBitmap );
var
   B :TBitmapData;
   X :Integer;
begin
     with _Imager do
     begin
          Bitmap_.SetSize( CountX, 1 );

          Data.Map;

          Bitmap_.Map( TMapAccess.Write, B );

          for X := 0 to CountX-1 do B.SetPixel( X, 0, TByteRGBA( Data[ X ] ) );

          Bitmap_.Unmap( B );

          Data.Unmap;
     end;
end;

procedure TCLStream1DxRGBAxUInt32_FMX.CopyFrom( const Bitmap_:TBitmap );
var
   B :TBitmapData;
   X :Integer;
begin
     with _Imager do
     begin
          CountX := Bitmap_.Width;

          Bitmap_.Map( TMapAccess.Read, B );

          Data.Map;

          for X := 0 to CountX-1 do Data[ X ] := B.GetPixel( X, 0 );

          Data.Unmap;

          Bitmap_.Unmap( B );
     end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLStream1DxRGBAxSFlo32_FMX

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//////////////////////////////////////////////////////////////////// M E T H O D

procedure TCLStream1DxRGBAxSFlo32_FMX.CopyTo( const Bitmap_:TBitmap );
var
   B :TBitmapData;
   X :Integer;
begin
     with _Imager do
     begin
          Bitmap_.SetSize( CountX, CountY );

          Data.Map;

          Bitmap_.Map( TMapAccess.Write, B );

          for X := 0 to CountX-1 do
          begin
               B.SetPixel( X, 0, TAlphaColor( TByteRGBA( Data[ X ] ) ) );
          end;

          Bitmap_.Unmap( B );

          Data.Unmap;
     end;
end;

procedure TCLStream1DxRGBAxSFlo32_FMX.CopyFrom( const Bitmap_:TBitmap );
var
   B :TBitmapData;
   X :Integer;
begin
     with _Imager do
     begin
          CountX := Bitmap_.Width;

          Bitmap_.Map( TMapAccess.Read, B );

          Data.Map;

          for X := 0 to CountX-1 do
          begin
               Data[ X ] := B.GetPixel( X, 0 );
          end;

          Data.Unmap;

          Bitmap_.Unmap( B );
     end;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

end. //######################################################################### ■
