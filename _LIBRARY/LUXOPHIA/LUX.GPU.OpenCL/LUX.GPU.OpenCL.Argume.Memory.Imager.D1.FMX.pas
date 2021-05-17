unit LUX.GPU.OpenCL.Argume.Memory.Imager.D1.FMX;

interface //#################################################################### ■

uses System.UITypes,
     FMX.Graphics,
     LUX.Color, LUX.Color.Grid.D2.Preset,
     cl_version, cl_platform, cl,
     LUX.GPU.OpenCL.Argume.Memory.Imager.D1;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TCLDevIma1DFMX<TCLContex_,TCLPlatfo_:class;TValue_:record> = class;
     TCLHosIma1DFMX<TCLContex_,TCLPlatfo_:class;TValue_:record> = class;

     TCLDevIma1DxBGRAxUInt8<TCLContex_,TCLPlatfo_:class> = class;
     TCLHosIma1DxBGRAxUInt8<TCLContex_,TCLPlatfo_:class> = class;

     TCLDevIma1DxBGRAxUFix8<TCLContex_,TCLPlatfo_:class> = class;
     TCLHosIma1DxBGRAxUFix8<TCLContex_,TCLPlatfo_:class> = class;

     TCLDevIma1DxRGBAxSFlo32<TCLContex_,TCLPlatfo_:class> = class;
     TCLHosIma1DxRGBAxSFlo32<TCLContex_,TCLPlatfo_:class> = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDevIma1DFMX<TCLContex_,TCLPlatfo_,TValue_>

     TCLDevIma1DFMX<TCLContex_,TCLPlatfo_:class;TValue_:record> = class( TCLDevIma1D<TCLContex_,TCLPlatfo_,TValue_> )
     private
     protected
     public
       ///// メソッド
       procedure CopyTo( const Bitmap_:TBitmap ); overload; virtual; abstract;
       procedure CopyFrom( const Bitmap_:TBitmap ); overload; virtual; abstract;
       procedure SaveToFile( const FileName_:String ); virtual;
       procedure LoadFromFile( const FileName_:String ); virtual;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLHosIma1DFMX<TCLContex_,TCLPlatfo_,TValue_>

     TCLHosIma1DFMX<TCLContex_,TCLPlatfo_:class;TValue_:record> = class( TCLHosIma1D<TCLContex_,TCLPlatfo_,TValue_> )
     private
     protected
     public
       ///// メソッド
       procedure CopyTo( const Bitmap_:TBitmap ); overload; virtual; abstract;
       procedure CopyFrom( const Bitmap_:TBitmap ); overload; virtual; abstract;
       procedure SaveToFile( const FileName_:String ); virtual;
       procedure LoadFromFile( const FileName_:String ); virtual;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDevIma1DxBGRAxUInt8<TCLContex_,TCLPlatfo_>

     TCLDevIma1DxBGRAxUInt8<TCLContex_,TCLPlatfo_:class> = class( TCLDevIma1DFMX<TCLContex_,TCLPlatfo_,TByteRGBA> )
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

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLHosIma1DxBGRAxUInt8<TCLContex_,TCLPlatfo_>

     TCLHosIma1DxBGRAxUInt8<TCLContex_,TCLPlatfo_:class> = class( TCLHosIma1DFMX<TCLContex_,TCLPlatfo_,TByteRGBA> )
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

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDevIma1DxBGRAxUFix8<TCLContex_,TCLPlatfo_>

     TCLDevIma1DxBGRAxUFix8<TCLContex_,TCLPlatfo_:class> = class( TCLDevIma1DFMX<TCLContex_,TCLPlatfo_,TByteRGBA> )
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

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLHosIma1DxBGRAxUFix8<TCLContex_,TCLPlatfo_>

     TCLHosIma1DxBGRAxUFix8<TCLContex_,TCLPlatfo_:class> = class( TCLHosIma1DFMX<TCLContex_,TCLPlatfo_,TByteRGBA> )
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

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDevIma1DxRGBAxSFlo32<TCLContex_,TCLPlatfo_>

     TCLDevIma1DxRGBAxSFlo32<TCLContex_,TCLPlatfo_:class> = class( TCLDevIma1DFMX<TCLContex_,TCLPlatfo_,TSingleRGBA> )
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

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLHosIma1DxRGBAxSFlo32<TCLContex_,TCLPlatfo_>

     TCLHosIma1DxRGBAxSFlo32<TCLContex_,TCLPlatfo_:class> = class( TCLHosIma1DFMX<TCLContex_,TCLPlatfo_,TSingleRGBA> )
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

uses System.Threading,
     LUX.GPU.OpenCL;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDevIma1DFMX<TCLContex_,TCLPlatfo_,TValue_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLDevIma1DFMX<TCLContex_,TCLPlatfo_,TValue_>.SaveToFile( const FileName_:String );
var
   B :TBitmap;
begin
     B := TBitmap.Create;

     CopyTo( B );

     B.SaveToFile( FileName_ );

     B.Free;
end;

procedure TCLDevIma1DFMX<TCLContex_,TCLPlatfo_,TValue_>.LoadFromFile( const FileName_:String );
var
   B :TBitmap;
begin
     B := TBitmap.Create;

     B.LoadFromFile( FileName_ );

     CopyFrom( B );

     B.Free;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLHosIma1DFMX<TCLContex_,TCLPlatfo_,TValue_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLHosIma1DFMX<TCLContex_,TCLPlatfo_,TValue_>.SaveToFile( const FileName_:String );
var
   B :TBitmap;
begin
     B := TBitmap.Create;

     CopyTo( B );

     B.SaveToFile( FileName_ );

     B.Free;
end;

procedure TCLHosIma1DFMX<TCLContex_,TCLPlatfo_,TValue_>.LoadFromFile( const FileName_:String );
var
   B :TBitmap;
begin
     B := TBitmap.Create;

     B.LoadFromFile( FileName_ );

     CopyFrom( B );

     B.Free;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDevIma1DxBGRAxUInt8<TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLDevIma1DxBGRAxUInt8<TCLContex_,TCLPlatfo_>.GetPixChan :T_cl_channel_order;
begin
     Result := CL_BGRA;
end;

function TCLDevIma1DxBGRAxUInt8<TCLContex_,TCLPlatfo_>.GetPixType :T_cl_channel_type;
begin
     Result := CL_UNSIGNED_INT8;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLDevIma1DxBGRAxUInt8<TCLContex_,TCLPlatfo_>.CopyTo( const Bitmap_:TBitmap );
var
   B :TBitmapData;
begin
     Bitmap_.SetSize( CountX, CountY );

     Storag.Map;

     Bitmap_.Map( TMapAccess.Write, B );

     Move( Storag.ValueP[ 0 ]^,
           B.GetScanline( 0 )^,
           B.BytesPerLine );

     Bitmap_.Unmap( B );

     Storag.Unmap;
end;

procedure TCLDevIma1DxBGRAxUInt8<TCLContex_,TCLPlatfo_>.CopyFrom( const Bitmap_:TBitmap );
var
   B :TBitmapData;
begin
     CountX := Bitmap_.Width;

     Bitmap_.Map( TMapAccess.Read, B );

     Storag.Map;

     Move( B.GetScanline( 0 )^,
           Storag.ValueP[ 0 ]^,
           B.BytesPerLine );

     Storag.Unmap;

     Bitmap_.Unmap( B );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLHosIma1DxBGRAxUInt8<TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLHosIma1DxBGRAxUInt8<TCLContex_,TCLPlatfo_>.GetPixChan :T_cl_channel_order;
begin
     Result := CL_BGRA;
end;

function TCLHosIma1DxBGRAxUInt8<TCLContex_,TCLPlatfo_>.GetPixType :T_cl_channel_type;
begin
     Result := CL_UNSIGNED_INT8;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLHosIma1DxBGRAxUInt8<TCLContex_,TCLPlatfo_>.CopyTo( const Bitmap_:TBitmap );
var
   B :TBitmapData;
begin
     Bitmap_.SetSize( CountX, CountY );

     Storag.Map;

     Bitmap_.Map( TMapAccess.Write, B );

     Move( Storag.ValueP[ 0 ]^,
           B.GetScanline( 0 )^,
           B.BytesPerLine );

     Bitmap_.Unmap( B );

     Storag.Unmap;
end;

procedure TCLHosIma1DxBGRAxUInt8<TCLContex_,TCLPlatfo_>.CopyFrom( const Bitmap_:TBitmap );
var
   B :TBitmapData;
begin
     CountX := Bitmap_.Width;

     Bitmap_.Map( TMapAccess.Read, B );

     Storag.Map;

     Move( B.GetScanline( 0 )^,
           Storag.ValueP[ 0 ]^,
           B.BytesPerLine );

     Storag.Unmap;

     Bitmap_.Unmap( B );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDevIma1DxBGRAxUFix8<TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLDevIma1DxBGRAxUFix8<TCLContex_,TCLPlatfo_>.GetPixChan :T_cl_channel_order;
begin
     Result := CL_BGRA;
end;

function TCLDevIma1DxBGRAxUFix8<TCLContex_,TCLPlatfo_>.GetPixType :T_cl_channel_type;
begin
     Result := CL_UNORM_INT8;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLDevIma1DxBGRAxUFix8<TCLContex_,TCLPlatfo_>.CopyTo( const Bitmap_:TBitmap );
var
   B :TBitmapData;
begin
     Bitmap_.SetSize( CountX, CountY );

     Storag.Map;

     Bitmap_.Map( TMapAccess.Write, B );

     Move( Storag.ValueP[ 0 ]^,
           B.GetScanline( 0 )^,
           B.BytesPerLine );

     Bitmap_.Unmap( B );

     Storag.Unmap;
end;

procedure TCLDevIma1DxBGRAxUFix8<TCLContex_,TCLPlatfo_>.CopyFrom( const Bitmap_:TBitmap );
var
   B :TBitmapData;
begin
     CountX := Bitmap_.Width;

     Bitmap_.Map( TMapAccess.Read, B );

     Storag.Map;

     Move( B.GetScanline( 0 )^,
           Storag.ValueP[ 0 ]^,
           B.BytesPerLine );

     Storag.Unmap;

     Bitmap_.Unmap( B );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLHosIma1DxBGRAxUFix8<TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLHosIma1DxBGRAxUFix8<TCLContex_,TCLPlatfo_>.GetPixChan :T_cl_channel_order;
begin
     Result := CL_BGRA;
end;

function TCLHosIma1DxBGRAxUFix8<TCLContex_,TCLPlatfo_>.GetPixType :T_cl_channel_type;
begin
     Result := CL_UNORM_INT8;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLHosIma1DxBGRAxUFix8<TCLContex_,TCLPlatfo_>.CopyTo( const Bitmap_:TBitmap );
var
   B :TBitmapData;
begin
     Bitmap_.SetSize( CountX, CountY );

     Storag.Map;

     Bitmap_.Map( TMapAccess.Write, B );

     Move( Storag.ValueP[ 0 ]^,
           B.GetScanline( 0 )^,
           B.BytesPerLine );

     Bitmap_.Unmap( B );

     Storag.Unmap;
end;

procedure TCLHosIma1DxBGRAxUFix8<TCLContex_,TCLPlatfo_>.CopyFrom( const Bitmap_:TBitmap );
var
   B :TBitmapData;
begin
     CountX := Bitmap_.Width;

     Bitmap_.Map( TMapAccess.Read, B );

     Storag.Map;

     Move( B.GetScanline( 0 )^,
           Storag.ValueP[ 0 ]^,
           B.BytesPerLine );

     Storag.Unmap;

     Bitmap_.Unmap( B );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDevIma1DxRGBAxSFlo32<TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLDevIma1DxRGBAxSFlo32<TCLContex_,TCLPlatfo_>.GetPixChan :T_cl_channel_order;
begin
     Result := CL_RGBA;
end;

function TCLDevIma1DxRGBAxSFlo32<TCLContex_,TCLPlatfo_>.GetPixType :T_cl_channel_type;
begin
     Result := CL_FLOAT;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLDevIma1DxRGBAxSFlo32<TCLContex_,TCLPlatfo_>.CopyTo( const Bitmap_:TBitmap );
var
   B :TBitmapData;
   X :Integer;
begin
     Bitmap_.SetSize( CountX, CountY );

     Storag.Map;

     Bitmap_.Map( TMapAccess.Write, B );

     for X := 0 to CountX-1 do
     begin
          B.SetPixel( X, 0, TAlphaColor( TByteRGBA( Storag[ X ] ) ) );
     end;

     Bitmap_.Unmap( B );

     Storag.Unmap;
end;

procedure TCLDevIma1DxRGBAxSFlo32<TCLContex_,TCLPlatfo_>.CopyFrom( const Bitmap_:TBitmap );
var
   B :TBitmapData;
   X :Integer;
begin
     CountX := Bitmap_.Width;

     Bitmap_.Map( TMapAccess.Read, B );

     Storag.Map;

     for X := 0 to CountX-1 do
     begin
          Storag[ X ] := B.GetPixel( X, 0 );
     end;

     Storag.Unmap;

     Bitmap_.Unmap( B );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLHosIma1DxRGBAxSFlo32<TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLHosIma1DxRGBAxSFlo32<TCLContex_,TCLPlatfo_>.GetPixChan :T_cl_channel_order;
begin
     Result := CL_RGBA;
end;

function TCLHosIma1DxRGBAxSFlo32<TCLContex_,TCLPlatfo_>.GetPixType :T_cl_channel_type;
begin
     Result := CL_FLOAT;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLHosIma1DxRGBAxSFlo32<TCLContex_,TCLPlatfo_>.CopyTo( const Bitmap_:TBitmap );
var
   B :TBitmapData;
   X :Integer;
begin
     Bitmap_.SetSize( CountX, CountY );

     Storag.Map;

     Bitmap_.Map( TMapAccess.Write, B );

     for X := 0 to CountX-1 do
     begin
          B.SetPixel( X, 0, TAlphaColor( TByteRGBA( Storag[ X ] ) ) );
     end;

     Bitmap_.Unmap( B );

     Storag.Unmap;
end;

procedure TCLHosIma1DxRGBAxSFlo32<TCLContex_,TCLPlatfo_>.CopyFrom( const Bitmap_:TBitmap );
var
   B :TBitmapData;
   X :Integer;
begin
     CountX := Bitmap_.Width;

     Bitmap_.Map( TMapAccess.Read, B );

     Storag.Map;

     for X := 0 to CountX-1 do
     begin
          Storag[ X ] := B.GetPixel( X, 0 );
     end;

     Storag.Unmap;

     Bitmap_.Unmap( B );
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

end. //######################################################################### ■
