unit LUX.GPU.OpenCL.Memory.Imager.FMX;

interface //#################################################################### ■

uses System.UITypes,
     FMX.Graphics,
     LUX.GPU.OpenCL.Memory.Imager;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TCLDevImaRGBA<TCLContex_,TCLPlatfo_:class> = class;
     TCLHosImaRGBA<TCLContex_,TCLPlatfo_:class> = class;

     TCLImagerIterRGBA<TCLContex_,TCLPlatfo_:class> = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDevImaRGBA<TCLContex_,TCLPlatfo_>

     TCLDevImaRGBA<TCLContex_,TCLPlatfo_:class> = class( TCLDevIma<TCLContex_,TCLPlatfo_,TAlphaColorF> )
     private
       type TCLImagerIter_ = TCLImagerIterRGBA<TCLContex_,TCLPlatfo_>;
     protected
     public
       ///// メソッド
       procedure CopyTo( const Bitmap_:TBitmap );
       procedure SaveToFile( const FileName_:String );
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLHosImaRGBA<TCLContex_,TCLPlatfo_>

     TCLHosImaRGBA<TCLContex_,TCLPlatfo_:class> = class( TCLHosIma<TCLContex_,TCLPlatfo_,TAlphaColorF> )
     private
       type TCLImagerIter_ = TCLImagerIterRGBA<TCLContex_,TCLPlatfo_>;
     protected
     public
       ///// メソッド
       procedure CopyTo( const Bitmap_:TBitmap );
       procedure SaveToFile( const FileName_:String );
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImagerIterRGBA<TCLContex_,TCLPlatfo_>

     TCLImagerIterRGBA<TCLContex_,TCLPlatfo_:class> = class( TCLImagerIter<TCLContex_,TCLPlatfo_,TAlphaColorF> );

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

procedure TCLDevImaRGBA<TCLContex_,TCLPlatfo_>.CopyTo( const Bitmap_:TBitmap );
var
   G :TCLImagerIter_;
   B :TBitmapData;
   X, Y :Integer;
begin
     G := TCLImagerIter_.Create( Self );

     Bitmap_.SetSize( CountX, CountY );

     Bitmap_.Map( TMapAccess.Write, B );

     for Y := 0 to CountY-1 do
     begin
          for X := 0 to CountX-1 do
          begin
               B.SetPixel( X, Y, G[ X, Y ].ToAlphaColor );
          end;
     end;

     Bitmap_.Unmap( B );

     G.Free;
end;

procedure TCLDevImaRGBA<TCLContex_,TCLPlatfo_>.SaveToFile( const FileName_:String );
var
   B :TBitmap;
begin
     B := TBitmap.Create;

     CopyTo( B );

     B.SaveToFile( FileName_ );

     B.Free;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLHosImaRGBA<TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLHosImaRGBA<TCLContex_,TCLPlatfo_>.CopyTo( const Bitmap_:TBitmap );
var
   G :TCLImagerIter_;
   B :TBitmapData;
   X, Y :Integer;
begin
     G := TCLImagerIter_.Create( Self );

     Bitmap_.SetSize( CountX, CountY );

     Bitmap_.Map( TMapAccess.Write, B );

     for Y := 0 to CountY-1 do
     begin
          for X := 0 to CountX-1 do
          begin
               B.SetPixel( X, Y, G[ X, Y ].ToAlphaColor );
          end;
     end;

     Bitmap_.Unmap( B );

     G.Free;
end;

procedure TCLHosImaRGBA<TCLContex_,TCLPlatfo_>.SaveToFile( const FileName_:String );
var
   B :TBitmap;
begin
     B := TBitmap.Create;

     CopyTo( B );

     B.SaveToFile( FileName_ );

     B.Free;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImagerIterRGBA<TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

end. //######################################################################### ■
