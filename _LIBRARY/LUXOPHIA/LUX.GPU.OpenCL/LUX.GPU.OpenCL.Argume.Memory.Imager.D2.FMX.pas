unit LUX.GPU.OpenCL.Argume.Memory.Imager.D2.FMX;

interface //#################################################################### ■

uses System.UITypes,
     FMX.Graphics,
     LUX.Color, LUX.Color.Grid.D2.Preset,
     cl_version, cl_platform, cl,
     LUX.GPU.OpenCL.Argume.Memory.Imager.D2;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TCLImager2DFMX<TCLSystem_,TCLPlatfo_,TCLContex_:class;TValue_:record> = class;

     TCLImager2DxBGRAxUInt8 <TCLSystem_,TCLPlatfo_,TCLContex_:class> = class;
     TCLImager2DxBGRAxUFix8 <TCLSystem_,TCLPlatfo_,TCLContex_:class> = class;
     TCLImager2DxRGBAxUInt32<TCLSystem_,TCLPlatfo_,TCLContex_:class> = class;
     TCLImager2DxRGBAxSFlo32<TCLSystem_,TCLPlatfo_,TCLContex_:class> = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImager2DFMX<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>

     TCLImager2DFMX<TCLSystem_,TCLPlatfo_,TCLContex_:class;TValue_:record> = class( TCLImager2D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_> )
     private
     protected
     public
       ///// メソッド
       procedure CopyTo( const Bitmap_:TBitmap ); overload; virtual; abstract;
       procedure CopyFrom( const Bitmap_:TBitmap ); overload; virtual; abstract;
       procedure SaveToFile( const FileName_:String ); virtual;
       procedure LoadFromFile( const FileName_:String ); virtual;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImager2DxBGRAxUInt8<TCLSystem_,TCLPlatfo_,TCLContex_>

     TCLImager2DxBGRAxUInt8<TCLSystem_,TCLPlatfo_,TCLContex_:class> = class( TCLImager2DFMX<TCLSystem_,TCLPlatfo_,TCLContex_,TByteRGBA> )
     private
     protected
       ///// アクセス
       function GetPixCha :T_cl_channel_order; override;
       function GetPixTyp :T_cl_channel_type; override;
     public
       ///// メソッド
       procedure CopyTo( const Bitmap_:TBitmap ); override;
       procedure CopyFrom( const Bitmap_:TBitmap ); override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImager2DxBGRAxUFix8<TCLSystem_,TCLPlatfo_,TCLContex_>

     TCLImager2DxBGRAxUFix8<TCLSystem_,TCLPlatfo_,TCLContex_:class> = class( TCLImager2DFMX<TCLSystem_,TCLPlatfo_,TCLContex_,TByteRGBA> )
     private
     protected
       ///// アクセス
       function GetPixCha :T_cl_channel_order; override;
       function GetPixTyp :T_cl_channel_type; override;
     public
       ///// メソッド
       procedure CopyTo( const Bitmap_:TBitmap ); override;
       procedure CopyFrom( const Bitmap_:TBitmap ); override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImager2DxRGBAxUInt32<TCLSystem_,TCLPlatfo_,TCLContex_>

     TCLImager2DxRGBAxUInt32<TCLSystem_,TCLPlatfo_,TCLContex_:class> = class( TCLImager2DFMX<TCLSystem_,TCLPlatfo_,TCLContex_,TUInt32xRGBA> )
     private
     protected
       ///// アクセス
       function GetPixCha :T_cl_channel_order; override;
       function GetPixTyp :T_cl_channel_type; override;
     public
       ///// メソッド
       procedure CopyTo( const Bitmap_:TBitmap ); override;
       procedure CopyFrom( const Bitmap_:TBitmap ); override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImager2DxRGBAxSFlo32<TCLSystem_,TCLPlatfo_,TCLContex_>

     TCLImager2DxRGBAxSFlo32<TCLSystem_,TCLPlatfo_,TCLContex_:class> = class( TCLImager2DFMX<TCLSystem_,TCLPlatfo_,TCLContex_,TSingleRGBA> )
     private
     protected
       ///// アクセス
       function GetPixCha :T_cl_channel_order; override;
       function GetPixTyp :T_cl_channel_type; override;
     public
       ///// メソッド
       procedure CopyTo( const Bitmap_:TBitmap ); override;
       procedure CopyFrom( const Bitmap_:TBitmap ); override;
       procedure CopyFrom( const Grid_:TCellColorGrid2D_TByteRGBE ); overload; virtual;
       procedure LoadFromFileHDR( const FileName_:String );
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses System.Threading,
     LUX.Color.Format.HDR;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImager2DFMX<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLImager2DFMX<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.SaveToFile( const FileName_:String );
var
   B :TBitmap;
begin
     B := TBitmap.Create;

     CopyTo( B );

     B.SaveToFile( FileName_ );

     B.Free;
end;

procedure TCLImager2DFMX<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.LoadFromFile( const FileName_:String );
var
   B :TBitmap;
begin
     B := TBitmap.Create;

     B.LoadFromFile( FileName_ );

     CopyFrom( B );

     B.Free;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImager2DxBGRAxUInt8<TCLSystem_,TCLPlatfo_,TCLContex_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLImager2DxBGRAxUInt8<TCLSystem_,TCLPlatfo_,TCLContex_>.GetPixCha :T_cl_channel_order;
begin
     Result := CL_BGRA;
end;

function TCLImager2DxBGRAxUInt8<TCLSystem_,TCLPlatfo_,TCLContex_>.GetPixTyp :T_cl_channel_type;
begin
     Result := CL_UNSIGNED_INT8;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLImager2DxBGRAxUInt8<TCLSystem_,TCLPlatfo_,TCLContex_>.CopyTo( const Bitmap_:TBitmap );
var
   B :TBitmapData;
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

procedure TCLImager2DxBGRAxUInt8<TCLSystem_,TCLPlatfo_,TCLContex_>.CopyFrom( const Bitmap_:TBitmap );
var
   B :TBitmapData;
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

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImager2DxBGRAxUFix8<TCLSystem_,TCLPlatfo_,TCLContex_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLImager2DxBGRAxUFix8<TCLSystem_,TCLPlatfo_,TCLContex_>.GetPixCha :T_cl_channel_order;
begin
     Result := CL_BGRA;
end;

function TCLImager2DxBGRAxUFix8<TCLSystem_,TCLPlatfo_,TCLContex_>.GetPixTyp :T_cl_channel_type;
begin
     Result := CL_UNORM_INT8;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLImager2DxBGRAxUFix8<TCLSystem_,TCLPlatfo_,TCLContex_>.CopyTo( const Bitmap_:TBitmap );
var
   B :TBitmapData;
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

procedure TCLImager2DxBGRAxUFix8<TCLSystem_,TCLPlatfo_,TCLContex_>.CopyFrom( const Bitmap_:TBitmap );
var
   B :TBitmapData;
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

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImager2DxRGBAxUInt32<TCLSystem_,TCLPlatfo_,TCLContex_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLImager2DxRGBAxUInt32<TCLSystem_,TCLPlatfo_,TCLContex_>.GetPixCha :T_cl_channel_order;
begin
     Result := CL_RGBA;
end;

function TCLImager2DxRGBAxUInt32<TCLSystem_,TCLPlatfo_,TCLContex_>.GetPixTyp :T_cl_channel_type;
begin
     Result := CL_UNSIGNED_INT32;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLImager2DxRGBAxUInt32<TCLSystem_,TCLPlatfo_,TCLContex_>.CopyTo( const Bitmap_:TBitmap );
var
   B :TBitmapData;
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

procedure TCLImager2DxRGBAxUInt32<TCLSystem_,TCLPlatfo_,TCLContex_>.CopyFrom( const Bitmap_:TBitmap );
var
   B :TBitmapData;
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

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImager2DxRGBAxSFlo32<TCLSystem_,TCLPlatfo_,TCLContex_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLImager2DxRGBAxSFlo32<TCLSystem_,TCLPlatfo_,TCLContex_>.GetPixCha :T_cl_channel_order;
begin
     Result := CL_RGBA;
end;

function TCLImager2DxRGBAxSFlo32<TCLSystem_,TCLPlatfo_,TCLContex_>.GetPixTyp :T_cl_channel_type;
begin
     Result := CL_FLOAT;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLImager2DxRGBAxSFlo32<TCLSystem_,TCLPlatfo_,TCLContex_>.CopyTo( const Bitmap_:TBitmap );
var
   B :TBitmapData;
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

procedure TCLImager2DxRGBAxSFlo32<TCLSystem_,TCLPlatfo_,TCLContex_>.CopyFrom( const Bitmap_:TBitmap );
var
   B :TBitmapData;
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

//------------------------------------------------------------------------------

procedure TCLImager2DxRGBAxSFlo32<TCLSystem_,TCLPlatfo_,TCLContex_>.CopyFrom( const Grid_:TCellColorGrid2D_TByteRGBE );
begin
     CountX := Grid_.CellsX;
     CountY := Grid_.CellsY;

     Data.Map;

     TParallel.For( 0, CountY-1, procedure( Y:Integer )
     var
        X :Integer;
     begin
          for X := 0 to CountX-1 do
          begin
               Data[ X, Y ] := TSingleRGBA( TSingleRGB( Grid_[ X, Y ] ) );
          end;
     end );

     Data.Unmap;
end;

procedure TCLImager2DxRGBAxSFlo32<TCLSystem_,TCLPlatfo_,TCLContex_>.LoadFromFileHDR( const FileName_:String );
var
   F :TFileHDR;
begin
     F := TFileHDR.Create;
     F.LoadFromFile( FileName_ );

     CopyFrom( F.Grid );

     F.Free;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

end. //######################################################################### ■
