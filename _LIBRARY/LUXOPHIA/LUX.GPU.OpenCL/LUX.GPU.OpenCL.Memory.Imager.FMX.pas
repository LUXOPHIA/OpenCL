unit LUX.GPU.OpenCL.Memory.Imager.FMX;

interface //#################################################################### ■

uses System.UITypes,
     FMX.Graphics,
     LUX.GPU.OpenCL.Memory.Imager;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TCLDevImaRGBA<TCLContex_,TCLPlatfo_:class> = class;
     TCLHosImaRGBA<TCLContex_,TCLPlatfo_:class> = class;

     TCLDevImaRGBAxSFlo32<TCLContex_,TCLPlatfo_:class> = class;
     TCLHosImaRGBAxSFlo32<TCLContex_,TCLPlatfo_:class> = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDevImaRGBA<TCLContex_,TCLPlatfo_>

     TCLDevImaRGBA<TCLContex_,TCLPlatfo_:class> = class( TCLDevIma<TCLContex_,TCLPlatfo_,TAlphaColorF> )
     private
     protected
     public
       ///// メソッド
       procedure CopyTo( const Bitmap_:TBitmap ); virtual; abstract;
       procedure CopyFrom( const Bitmap_:TBitmap ); virtual; abstract;
       procedure SaveToFile( const FileName_:String ); virtual;
       procedure LoadFromFile( const FileName_:String ); virtual;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLHosImaRGBA<TCLContex_,TCLPlatfo_>

     TCLHosImaRGBA<TCLContex_,TCLPlatfo_:class> = class( TCLHosIma<TCLContex_,TCLPlatfo_,TAlphaColorF> )
     private
     protected
     public
       ///// メソッド
       procedure CopyTo( const Bitmap_:TBitmap ); virtual; abstract;
       procedure CopyFrom( const Bitmap_:TBitmap ); virtual; abstract;
       procedure SaveToFile( const FileName_:String ); virtual;
       procedure LoadFromFile( const FileName_:String ); virtual;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDevImaRGBAxSFlo32<TCLContex_,TCLPlatfo_>

     TCLDevImaRGBAxSFlo32<TCLContex_,TCLPlatfo_:class> = class( TCLDevImaRGBA<TCLContex_,TCLPlatfo_> )
     private
     protected
     public
       ///// メソッド
       procedure CopyTo( const Bitmap_:TBitmap ); override;
       procedure CopyFrom( const Bitmap_:TBitmap ); override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLHosImaRGBAxSFlo32<TCLContex_,TCLPlatfo_>

     TCLHosImaRGBAxSFlo32<TCLContex_,TCLPlatfo_:class> = class( TCLHosImaRGBA<TCLContex_,TCLPlatfo_> )
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

uses LUX.GPU.OpenCL;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDevImaRGBA<TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLDevImaRGBA<TCLContex_,TCLPlatfo_>.SaveToFile( const FileName_:String );
var
   B :TBitmap;
begin
     B := TBitmap.Create;

     CopyTo( B );

     B.SaveToFile( FileName_ );

     B.Free;
end;

procedure TCLDevImaRGBA<TCLContex_,TCLPlatfo_>.LoadFromFile( const FileName_:String );
var
   B :TBitmap;
begin
     B := TBitmap.Create;

     B.LoadFromFile( FileName_ );

     CopyFrom( B );

     B.Free;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLHosImaRGBA<TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLHosImaRGBA<TCLContex_,TCLPlatfo_>.SaveToFile( const FileName_:String );
var
   B :TBitmap;
begin
     B := TBitmap.Create;

     CopyTo( B );

     B.SaveToFile( FileName_ );

     B.Free;
end;

procedure TCLHosImaRGBA<TCLContex_,TCLPlatfo_>.LoadFromFile( const FileName_:String );
var
   B :TBitmap;
begin
     B := TBitmap.Create;

     B.LoadFromFile( FileName_ );

     CopyFrom( B );

     B.Free;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDevImaRGBAxSFlo32<TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLDevImaRGBAxSFlo32<TCLContex_,TCLPlatfo_>.CopyTo( const Bitmap_:TBitmap );
var
   B :TBitmapData;
   X, Y :Integer;
begin
     Bitmap_.SetSize( CountX, CountY );

     Bitmap_.Map( TMapAccess.Write, B );

     for Y := 0 to CountY-1 do
     begin
          for X := 0 to CountX-1 do
          begin
               B.SetPixel( X, Y, Storag[ X, Y ].ToAlphaColor );
          end;
     end;

     Storag.Unmap;

     Bitmap_.Unmap( B );
end;

procedure TCLDevImaRGBAxSFlo32<TCLContex_,TCLPlatfo_>.CopyFrom( const Bitmap_:TBitmap );
var
   B :TBitmapData;
   X, Y :Integer;
begin
     Bitmap_.SetSize( CountX, CountY );

     Bitmap_.Map( TMapAccess.Read, B );

     for Y := 0 to CountY-1 do
     begin
          for X := 0 to CountX-1 do
          begin
               Storag[ X, Y ] := TAlphaColorF.Create( B.GetPixel( X, Y ) );
          end;
     end;

     Storag.Unmap;

     Bitmap_.Unmap( B );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLHosImaRGBAxSFlo32<TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLHosImaRGBAxSFlo32<TCLContex_,TCLPlatfo_>.CopyTo( const Bitmap_:TBitmap );
var
   B :TBitmapData;
   X, Y :Integer;
begin
     Bitmap_.SetSize( CountX, CountY );

     Bitmap_.Map( TMapAccess.Write, B );

     for Y := 0 to CountY-1 do
     begin
          for X := 0 to CountX-1 do
          begin
               B.SetPixel( X, Y, Storag[ X, Y ].ToAlphaColor );
          end;
     end;

     Storag.Unmap;

     Bitmap_.Unmap( B );
end;

procedure TCLHosImaRGBAxSFlo32<TCLContex_,TCLPlatfo_>.CopyFrom( const Bitmap_:TBitmap );
var
   B :TBitmapData;
   X, Y :Integer;
begin
     Bitmap_.SetSize( CountX, CountY );

     Bitmap_.Map( TMapAccess.Read, B );

     for Y := 0 to CountY-1 do
     begin
          for X := 0 to CountX-1 do
          begin
               Storag[ X, Y ] := TAlphaColorF.Create( B.GetPixel( X, Y ) );
          end;
     end;

     Storag.Unmap;

     Bitmap_.Unmap( B );
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

end. //######################################################################### ■
