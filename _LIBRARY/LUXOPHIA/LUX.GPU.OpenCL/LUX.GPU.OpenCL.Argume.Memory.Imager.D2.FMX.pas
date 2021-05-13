unit LUX.GPU.OpenCL.Argume.Memory.Imager.D2.FMX;

interface //#################################################################### ■

uses System.UITypes,
     FMX.Graphics,
     cl_version, cl_platform, cl,
     LUX.GPU.OpenCL.Argume.Memory.Imager.D2;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TCLDevIma2DFMX<TCLContex_,TCLPlatfo_:class;TValue_:record> = class;
     TCLHosIma2DFMX<TCLContex_,TCLPlatfo_:class;TValue_:record> = class;

     TCLDevIma2DxBGRAxUInt8<TCLContex_,TCLPlatfo_:class> = class;
     TCLHosIma2DxBGRAxUInt8<TCLContex_,TCLPlatfo_:class> = class;

     TCLDevIma2DxBGRAxNormUInt8<TCLContex_,TCLPlatfo_:class> = class;
     TCLHosIma2DxBGRAxNormUInt8<TCLContex_,TCLPlatfo_:class> = class;

     TCLDevIma2DxRGBAxSFlo32<TCLContex_,TCLPlatfo_:class> = class;
     TCLHosIma2DxRGBAxSFlo32<TCLContex_,TCLPlatfo_:class> = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDevIma2DFMX<TCLContex_,TCLPlatfo_,TValue_>

     TCLDevIma2DFMX<TCLContex_,TCLPlatfo_:class;TValue_:record> = class( TCLDevIma2D<TCLContex_,TCLPlatfo_,TValue_> )
     private
     protected
     public
       ///// メソッド
       procedure CopyTo( const Bitmap_:TBitmap ); virtual; abstract;
       procedure CopyFrom( const Bitmap_:TBitmap ); virtual; abstract;
       procedure SaveToFile( const FileName_:String ); virtual;
       procedure LoadFromFile( const FileName_:String ); virtual;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLHosIma2DFMX<TCLContex_,TCLPlatfo_,TValue_>

     TCLHosIma2DFMX<TCLContex_,TCLPlatfo_:class;TValue_:record> = class( TCLHosIma2D<TCLContex_,TCLPlatfo_,TValue_> )
     private
     protected
     public
       ///// メソッド
       procedure CopyTo( const Bitmap_:TBitmap ); virtual; abstract;
       procedure CopyFrom( const Bitmap_:TBitmap ); virtual; abstract;
       procedure SaveToFile( const FileName_:String ); virtual;
       procedure LoadFromFile( const FileName_:String ); virtual;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDevIma2DxBGRAxUInt8<TCLContex_,TCLPlatfo_>

     TCLDevIma2DxBGRAxUInt8<TCLContex_,TCLPlatfo_:class> = class( TCLDevIma2DFMX<TCLContex_,TCLPlatfo_,TAlphaColor> )
     private
     protected
       ///// アクセス
       function GetPixChan :T_cl_channel_order; override;
       function GetPixType :T_cl_channel_type; override;
     public
       ///// メソッド
       procedure CopyTo( const Bitmap_:TBitmap ); override;
       procedure CopyFrom( const Bitmap_:TBitmap ); override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLHosIma2DxBGRAxUInt8<TCLContex_,TCLPlatfo_>

     TCLHosIma2DxBGRAxUInt8<TCLContex_,TCLPlatfo_:class> = class( TCLHosIma2DFMX<TCLContex_,TCLPlatfo_,TAlphaColor> )
     private
     protected
       ///// アクセス
       function GetPixChan :T_cl_channel_order; override;
       function GetPixType :T_cl_channel_type; override;
     public
       ///// メソッド
       procedure CopyTo( const Bitmap_:TBitmap ); override;
       procedure CopyFrom( const Bitmap_:TBitmap ); override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDevIma2DxBGRAxNormUInt8<TCLContex_,TCLPlatfo_>

     TCLDevIma2DxBGRAxNormUInt8<TCLContex_,TCLPlatfo_:class> = class( TCLDevIma2DFMX<TCLContex_,TCLPlatfo_,TAlphaColor> )
     private
     protected
       ///// アクセス
       function GetPixChan :T_cl_channel_order; override;
       function GetPixType :T_cl_channel_type; override;
     public
       ///// メソッド
       procedure CopyTo( const Bitmap_:TBitmap ); override;
       procedure CopyFrom( const Bitmap_:TBitmap ); override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLHosIma2DxBGRAxNormUInt8<TCLContex_,TCLPlatfo_>

     TCLHosIma2DxBGRAxNormUInt8<TCLContex_,TCLPlatfo_:class> = class( TCLHosIma2DFMX<TCLContex_,TCLPlatfo_,TAlphaColor> )
     private
     protected
       ///// アクセス
       function GetPixChan :T_cl_channel_order; override;
       function GetPixType :T_cl_channel_type; override;
     public
       ///// メソッド
       procedure CopyTo( const Bitmap_:TBitmap ); override;
       procedure CopyFrom( const Bitmap_:TBitmap ); override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDevIma2DxRGBAxSFlo32<TCLContex_,TCLPlatfo_>

     TCLDevIma2DxRGBAxSFlo32<TCLContex_,TCLPlatfo_:class> = class( TCLDevIma2DFMX<TCLContex_,TCLPlatfo_,TAlphaColorF> )
     private
     protected
       ///// アクセス
       function GetPixChan :T_cl_channel_order; override;
       function GetPixType :T_cl_channel_type; override;
     public
       ///// メソッド
       procedure CopyTo( const Bitmap_:TBitmap ); override;
       procedure CopyFrom( const Bitmap_:TBitmap ); override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLHosIma2DxRGBAxSFlo32<TCLContex_,TCLPlatfo_>

     TCLHosIma2DxRGBAxSFlo32<TCLContex_,TCLPlatfo_:class> = class( TCLHosIma2DFMX<TCLContex_,TCLPlatfo_,TAlphaColorF> )
     private
     protected
       ///// アクセス
       function GetPixChan :T_cl_channel_order; override;
       function GetPixType :T_cl_channel_type; override;
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

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDevIma2DFMX<TCLContex_,TCLPlatfo_,TValue_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLDevIma2DFMX<TCLContex_,TCLPlatfo_,TValue_>.SaveToFile( const FileName_:String );
var
   B :TBitmap;
begin
     B := TBitmap.Create;

     CopyTo( B );

     B.SaveToFile( FileName_ );

     B.Free;
end;

procedure TCLDevIma2DFMX<TCLContex_,TCLPlatfo_,TValue_>.LoadFromFile( const FileName_:String );
var
   B :TBitmap;
begin
     B := TBitmap.Create;

     B.LoadFromFile( FileName_ );

     CopyFrom( B );

     B.Free;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLHosIma2DFMX<TCLContex_,TCLPlatfo_,TValue_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLHosIma2DFMX<TCLContex_,TCLPlatfo_,TValue_>.SaveToFile( const FileName_:String );
var
   B :TBitmap;
begin
     B := TBitmap.Create;

     CopyTo( B );

     B.SaveToFile( FileName_ );

     B.Free;
end;

procedure TCLHosIma2DFMX<TCLContex_,TCLPlatfo_,TValue_>.LoadFromFile( const FileName_:String );
var
   B :TBitmap;
begin
     B := TBitmap.Create;

     B.LoadFromFile( FileName_ );

     CopyFrom( B );

     B.Free;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDevIma2DxBGRAxUInt8<TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLDevIma2DxBGRAxUInt8<TCLContex_,TCLPlatfo_>.GetPixChan :T_cl_channel_order;
begin
     Result := CL_BGRA;
end;

function TCLDevIma2DxBGRAxUInt8<TCLContex_,TCLPlatfo_>.GetPixType :T_cl_channel_type;
begin
     Result := CL_UNSIGNED_INT8;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLDevIma2DxBGRAxUInt8<TCLContex_,TCLPlatfo_>.CopyTo( const Bitmap_:TBitmap );
var
   B :TBitmapData;
   X, Y :Integer;
begin
     Bitmap_.SetSize( CountX, CountY );

     Bitmap_.Map( TMapAccess.Write, B );

     for Y := 0 to CountY-1 do Move( Storag.ValueP[ 0, Y ]^,
                                     B.GetScanline( Y )^,
                                     B.BytesPerLine );

     Storag.Unmap;

     Bitmap_.Unmap( B );
end;

procedure TCLDevIma2DxBGRAxUInt8<TCLContex_,TCLPlatfo_>.CopyFrom( const Bitmap_:TBitmap );
var
   B :TBitmapData;
   X, Y :Integer;
begin
     CountX := Bitmap_.Width ;
     CountY := Bitmap_.Height;

     Bitmap_.Map( TMapAccess.Read, B );

     for Y := 0 to CountY-1 do Move( B.GetScanline( Y )^,
                                     Storag.ValueP[ 0, Y ]^,
                                     B.BytesPerLine );

     Storag.Unmap;

     Bitmap_.Unmap( B );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLHosIma2DxBGRAxUInt8<TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLHosIma2DxBGRAxUInt8<TCLContex_,TCLPlatfo_>.GetPixChan :T_cl_channel_order;
begin
     Result := CL_BGRA;
end;

function TCLHosIma2DxBGRAxUInt8<TCLContex_,TCLPlatfo_>.GetPixType :T_cl_channel_type;
begin
     Result := CL_UNSIGNED_INT8;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLHosIma2DxBGRAxUInt8<TCLContex_,TCLPlatfo_>.CopyTo( const Bitmap_:TBitmap );
var
   B :TBitmapData;
   X, Y :Integer;
begin
     Bitmap_.SetSize( CountX, CountY );

     Bitmap_.Map( TMapAccess.Write, B );

     for Y := 0 to CountY-1 do Move( Storag.ValueP[ 0, Y ]^,
                                     B.GetScanline( Y )^,
                                     B.BytesPerLine );

     Storag.Unmap;

     Bitmap_.Unmap( B );
end;

procedure TCLHosIma2DxBGRAxUInt8<TCLContex_,TCLPlatfo_>.CopyFrom( const Bitmap_:TBitmap );
var
   B :TBitmapData;
   X, Y :Integer;
begin
     CountX := Bitmap_.Width ;
     CountY := Bitmap_.Height;

     Bitmap_.Map( TMapAccess.Read, B );

     for Y := 0 to CountY-1 do Move( B.GetScanline( Y )^,
                                     Storag.ValueP[ 0, Y ]^,
                                     B.BytesPerLine );

     Storag.Unmap;

     Bitmap_.Unmap( B );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDevIma2DxBGRAxNormUInt8<TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLDevIma2DxBGRAxNormUInt8<TCLContex_,TCLPlatfo_>.GetPixChan :T_cl_channel_order;
begin
     Result := CL_BGRA;
end;

function TCLDevIma2DxBGRAxNormUInt8<TCLContex_,TCLPlatfo_>.GetPixType :T_cl_channel_type;
begin
     Result := CL_UNORM_INT8;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLDevIma2DxBGRAxNormUInt8<TCLContex_,TCLPlatfo_>.CopyTo( const Bitmap_:TBitmap );
var
   B :TBitmapData;
   X, Y :Integer;
begin
     Bitmap_.SetSize( CountX, CountY );

     Bitmap_.Map( TMapAccess.Write, B );

     for Y := 0 to CountY-1 do Move( Storag.ValueP[ 0, Y ]^,
                                     B.GetScanline( Y )^,
                                     B.BytesPerLine );

     Storag.Unmap;

     Bitmap_.Unmap( B );
end;

procedure TCLDevIma2DxBGRAxNormUInt8<TCLContex_,TCLPlatfo_>.CopyFrom( const Bitmap_:TBitmap );
var
   B :TBitmapData;
   X, Y :Integer;
begin
     CountX := Bitmap_.Width ;
     CountY := Bitmap_.Height;

     Bitmap_.Map( TMapAccess.Read, B );

     for Y := 0 to CountY-1 do Move( B.GetScanline( Y )^,
                                     Storag.ValueP[ 0, Y ]^,
                                     B.BytesPerLine );

     Storag.Unmap;

     Bitmap_.Unmap( B );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLHosIma2DxBGRAxNormUInt8<TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLHosIma2DxBGRAxNormUInt8<TCLContex_,TCLPlatfo_>.GetPixChan :T_cl_channel_order;
begin
     Result := CL_BGRA;
end;

function TCLHosIma2DxBGRAxNormUInt8<TCLContex_,TCLPlatfo_>.GetPixType :T_cl_channel_type;
begin
     Result := CL_UNORM_INT8;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLHosIma2DxBGRAxNormUInt8<TCLContex_,TCLPlatfo_>.CopyTo( const Bitmap_:TBitmap );
var
   B :TBitmapData;
   X, Y :Integer;
begin
     Bitmap_.SetSize( CountX, CountY );

     Bitmap_.Map( TMapAccess.Write, B );

     for Y := 0 to CountY-1 do Move( Storag.ValueP[ 0, Y ]^,
                                     B.GetScanline( Y )^,
                                     B.BytesPerLine );

     Storag.Unmap;

     Bitmap_.Unmap( B );
end;

procedure TCLHosIma2DxBGRAxNormUInt8<TCLContex_,TCLPlatfo_>.CopyFrom( const Bitmap_:TBitmap );
var
   B :TBitmapData;
   X, Y :Integer;
begin
     CountX := Bitmap_.Width ;
     CountY := Bitmap_.Height;

     Bitmap_.Map( TMapAccess.Read, B );

     for Y := 0 to CountY-1 do Move( B.GetScanline( Y )^,
                                     Storag.ValueP[ 0, Y ]^,
                                     B.BytesPerLine );

     Storag.Unmap;

     Bitmap_.Unmap( B );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDevIma2DxRGBAxSFlo32<TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLDevIma2DxRGBAxSFlo32<TCLContex_,TCLPlatfo_>.GetPixChan :T_cl_channel_order;
begin
     Result := CL_RGBA;
end;

function TCLDevIma2DxRGBAxSFlo32<TCLContex_,TCLPlatfo_>.GetPixType :T_cl_channel_type;
begin
     Result := CL_FLOAT;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLDevIma2DxRGBAxSFlo32<TCLContex_,TCLPlatfo_>.CopyTo( const Bitmap_:TBitmap );
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

procedure TCLDevIma2DxRGBAxSFlo32<TCLContex_,TCLPlatfo_>.CopyFrom( const Bitmap_:TBitmap );
var
   B :TBitmapData;
   X, Y :Integer;
begin
     CountX := Bitmap_.Width ;
     CountY := Bitmap_.Height;

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

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLHosIma2DxRGBAxSFlo32<TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLHosIma2DxRGBAxSFlo32<TCLContex_,TCLPlatfo_>.GetPixChan :T_cl_channel_order;
begin
     Result := CL_RGBA;
end;

function TCLHosIma2DxRGBAxSFlo32<TCLContex_,TCLPlatfo_>.GetPixType :T_cl_channel_type;
begin
     Result := CL_FLOAT;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLHosIma2DxRGBAxSFlo32<TCLContex_,TCLPlatfo_>.CopyTo( const Bitmap_:TBitmap );
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

procedure TCLHosIma2DxRGBAxSFlo32<TCLContex_,TCLPlatfo_>.CopyFrom( const Bitmap_:TBitmap );
var
   B :TBitmapData;
   X, Y :Integer;
begin
     CountX := Bitmap_.Width ;
     CountY := Bitmap_.Height;

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
