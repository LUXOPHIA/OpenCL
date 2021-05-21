unit LUX.GPU.OpenCL.Argume.Memory.Imager.D3.FMX;

interface //#################################################################### ■

uses System.UITypes,
     FMX.Graphics,
     LUX.Color, LUX.Color.Grid.D2.Preset,
     cl_version, cl_platform, cl,
     LUX.GPU.OpenCL.Argume.Memory.Imager.D3;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TCLImager3DFMX<TCLSystem_,TCLPlatfo_,TCLContex_:class;TValue_:record> = class;

     TCLImager3DxBGRAxUInt8 <TCLSystem_,TCLPlatfo_,TCLContex_:class> = class;
     TCLImager3DxBGRAxUFix8 <TCLSystem_,TCLPlatfo_,TCLContex_:class> = class;
     TCLImager3DxRGBAxSFlo32<TCLSystem_,TCLPlatfo_,TCLContex_:class> = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImager3DFMX<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>

     TCLImager3DFMX<TCLSystem_,TCLPlatfo_,TCLContex_:class;TValue_:record> = class( TCLImager3D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_> )
     private
     protected
     public
       ///// メソッド
       procedure CopyTo( const Z_:Integer; const Bitmap_:TBitmap ); overload; virtual; abstract;
       procedure CopyFrom( const Z_:Integer; const Bitmap_:TBitmap ); overload; virtual; abstract;
       procedure SaveToFile( const Z_:Integer; const FileName_:String ); virtual;
       procedure LoadFromFile( const Z_:Integer; const FileName_:String ); virtual;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImager3DxBGRAxUInt8<TCLSystem_,TCLPlatfo_,TCLContex_>

     TCLImager3DxBGRAxUInt8<TCLSystem_,TCLPlatfo_,TCLContex_:class> = class( TCLImager3DFMX<TCLSystem_,TCLPlatfo_,TCLContex_,TByteRGBA> )
     private
     protected
       ///// アクセス
       function GetPixChan :T_cl_channel_order; override;
       function GetPixType :T_cl_channel_type; override;
     public
       ///// メソッド
       procedure CopyTo( const Z_:Integer; const Bitmap_:TBitmap ); override;
       procedure CopyFrom( const Z_:Integer; const Bitmap_:TBitmap ); override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImager3DxBGRAxUFix8<TCLSystem_,TCLPlatfo_,TCLContex_>

     TCLImager3DxBGRAxUFix8<TCLSystem_,TCLPlatfo_,TCLContex_:class> = class( TCLImager3DFMX<TCLSystem_,TCLPlatfo_,TCLContex_,TByteRGBA> )
     private
     protected
       ///// アクセス
       function GetPixChan :T_cl_channel_order; override;
       function GetPixType :T_cl_channel_type; override;
     public
       ///// メソッド
       procedure CopyTo( const Z_:Integer; const Bitmap_:TBitmap ); override;
       procedure CopyFrom( const Z_:Integer; const Bitmap_:TBitmap ); override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImager3DxRGBAxSFlo32<TCLSystem_,TCLPlatfo_,TCLContex_>

     TCLImager3DxRGBAxSFlo32<TCLSystem_,TCLPlatfo_,TCLContex_:class> = class( TCLImager3DFMX<TCLSystem_,TCLPlatfo_,TCLContex_,TSingleRGBA> )
     private
     protected
       ///// アクセス
       function GetPixChan :T_cl_channel_order; override;
       function GetPixType :T_cl_channel_type; override;
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

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImager3DFMX<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLImager3DFMX<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.SaveToFile( const Z_:Integer; const FileName_:String );
var
   B :TBitmap;
begin
     B := TBitmap.Create;

     CopyTo( Z_, B );

     B.SaveToFile( FileName_ );

     B.Free;
end;

procedure TCLImager3DFMX<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.LoadFromFile( const Z_:Integer; const FileName_:String );
var
   B :TBitmap;
begin
     B := TBitmap.Create;

     B.LoadFromFile( FileName_ );

     CopyFrom( Z_, B );

     B.Free;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImager3DxBGRAxUInt8<TCLSystem_,TCLPlatfo_,TCLContex_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLImager3DxBGRAxUInt8<TCLSystem_,TCLPlatfo_,TCLContex_>.GetPixChan :T_cl_channel_order;
begin
     Result := CL_BGRA;
end;

function TCLImager3DxBGRAxUInt8<TCLSystem_,TCLPlatfo_,TCLContex_>.GetPixType :T_cl_channel_type;
begin
     Result := CL_UNSIGNED_INT8;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLImager3DxBGRAxUInt8<TCLSystem_,TCLPlatfo_,TCLContex_>.CopyTo( const Z_:Integer; const Bitmap_:TBitmap );
var
   B :TBitmapData;
begin
     Bitmap_.SetSize( CountX, CountY );

     Storag.Map;

     Bitmap_.Map( TMapAccess.Write, B );

     TParallel.For( 0, CountY-1, procedure( Y:Integer )
     begin
          Move( Storag.ValueP[ 0, Y, Z_ ]^,
                B.GetScanline( Y )^,
                B.BytesPerLine );
     end );

     Bitmap_.Unmap( B );

     Storag.Unmap;
end;

procedure TCLImager3DxBGRAxUInt8<TCLSystem_,TCLPlatfo_,TCLContex_>.CopyFrom( const Z_:Integer; const Bitmap_:TBitmap );
var
   B :TBitmapData;
begin
     CountX := Bitmap_.Width ;
     CountY := Bitmap_.Height;

     Bitmap_.Map( TMapAccess.Read, B );

     Storag.Map;

     TParallel.For( 0, CountY-1, procedure( Y:Integer )
     begin
          Move( B.GetScanline( Y )^,
                Storag.ValueP[ 0, Y, Z_ ]^,
                B.BytesPerLine );
     end );

     Storag.Unmap;

     Bitmap_.Unmap( B );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImager3DxBGRAxUFix8<TCLSystem_,TCLPlatfo_,TCLContex_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLImager3DxBGRAxUFix8<TCLSystem_,TCLPlatfo_,TCLContex_>.GetPixChan :T_cl_channel_order;
begin
     Result := CL_BGRA;
end;

function TCLImager3DxBGRAxUFix8<TCLSystem_,TCLPlatfo_,TCLContex_>.GetPixType :T_cl_channel_type;
begin
     Result := CL_UNORM_INT8;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLImager3DxBGRAxUFix8<TCLSystem_,TCLPlatfo_,TCLContex_>.CopyTo( const Z_:Integer; const Bitmap_:TBitmap );
var
   B :TBitmapData;
begin
     Bitmap_.SetSize( CountX, CountY );

     Storag.Map;

     Bitmap_.Map( TMapAccess.Write, B );

     TParallel.For( 0, CountY-1, procedure( Y:Integer )
     begin
          Move( Storag.ValueP[ 0, Y, Z_ ]^,
                B.GetScanline( Y )^,
                B.BytesPerLine );
     end );

     Bitmap_.Unmap( B );

     Storag.Unmap;
end;

procedure TCLImager3DxBGRAxUFix8<TCLSystem_,TCLPlatfo_,TCLContex_>.CopyFrom( const Z_:Integer; const Bitmap_:TBitmap );
var
   B :TBitmapData;
begin
     CountX := Bitmap_.Width ;
     CountY := Bitmap_.Height;

     Bitmap_.Map( TMapAccess.Read, B );

     Storag.Map;

     TParallel.For( 0, CountY-1, procedure( Y:Integer )
     begin
          Move( B.GetScanline( Y )^,
                Storag.ValueP[ 0, Y, Z_ ]^,
                B.BytesPerLine );
     end );

     Storag.Unmap;

     Bitmap_.Unmap( B );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImager3DxRGBAxSFlo32<TCLSystem_,TCLPlatfo_,TCLContex_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLImager3DxRGBAxSFlo32<TCLSystem_,TCLPlatfo_,TCLContex_>.GetPixChan :T_cl_channel_order;
begin
     Result := CL_RGBA;
end;

function TCLImager3DxRGBAxSFlo32<TCLSystem_,TCLPlatfo_,TCLContex_>.GetPixType :T_cl_channel_type;
begin
     Result := CL_FLOAT;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLImager3DxRGBAxSFlo32<TCLSystem_,TCLPlatfo_,TCLContex_>.CopyTo( const Z_:Integer; const Bitmap_:TBitmap );
var
   B :TBitmapData;
begin
     Bitmap_.SetSize( CountX, CountY );

     Storag.Map;

     Bitmap_.Map( TMapAccess.Write, B );

     TParallel.For( 0, CountY-1, procedure( Y:Integer )
     var
        X :Integer;
     begin
          for X := 0 to CountX-1 do
          begin
               B.SetPixel( X, Y, TAlphaColor( TByteRGBA( Storag[ X, Y, Z_ ] ) ) );
          end;
     end );

     Bitmap_.Unmap( B );

     Storag.Unmap;
end;

procedure TCLImager3DxRGBAxSFlo32<TCLSystem_,TCLPlatfo_,TCLContex_>.CopyFrom( const Z_:Integer; const Bitmap_:TBitmap );
var
   B :TBitmapData;
begin
     CountX := Bitmap_.Width ;
     CountY := Bitmap_.Height;

     Bitmap_.Map( TMapAccess.Read, B );

     Storag.Map;

     TParallel.For( 0, CountY-1, procedure( Y:Integer )
     var
        X :Integer;
     begin
          for X := 0 to CountX-1 do
          begin
               Storag[ X, Y, Z_ ] := B.GetPixel( X, Y );
          end;
     end );

     Storag.Unmap;

     Bitmap_.Unmap( B );
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

end. //######################################################################### ■
