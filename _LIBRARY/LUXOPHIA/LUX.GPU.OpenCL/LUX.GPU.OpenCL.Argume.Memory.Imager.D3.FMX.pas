unit LUX.GPU.OpenCL.Argume.Memory.Imager.D3.FMX;

interface //#################################################################### ■

uses System.UITypes,
     FMX.Graphics,
     LUX.Color, LUX.Color.Grid.D2.Preset,
     cl_version, cl_platform, cl,
     LUX.GPU.OpenCL.Argume.Memory.Imager.D3;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TCLDevIma3DFMX<TCLContex_,TCLPlatfo_:class;TValue_:record> = class;
     TCLHosIma3DFMX<TCLContex_,TCLPlatfo_:class;TValue_:record> = class;

     TCLDevIma3DxBGRAxUInt8<TCLContex_,TCLPlatfo_:class> = class;
     TCLHosIma3DxBGRAxUInt8<TCLContex_,TCLPlatfo_:class> = class;

     TCLDevIma3DxBGRAxUFix8<TCLContex_,TCLPlatfo_:class> = class;
     TCLHosIma3DxBGRAxUFix8<TCLContex_,TCLPlatfo_:class> = class;

     TCLDevIma3DxRGBAxSFlo32<TCLContex_,TCLPlatfo_:class> = class;
     TCLHosIma3DxRGBAxSFlo32<TCLContex_,TCLPlatfo_:class> = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDevIma3DFMX<TCLContex_,TCLPlatfo_,TValue_>

     TCLDevIma3DFMX<TCLContex_,TCLPlatfo_:class;TValue_:record> = class( TCLDevIma3D<TCLContex_,TCLPlatfo_,TValue_> )
     private
     protected
     public
       ///// メソッド
       procedure CopyTo( const Z_:Integer; const Bitmap_:TBitmap ); overload; virtual; abstract;
       procedure CopyFrom( const Z_:Integer; const Bitmap_:TBitmap ); overload; virtual; abstract;
       procedure SaveToFile( const Z_:Integer; const FileName_:String ); virtual;
       procedure LoadFromFile( const Z_:Integer; const FileName_:String ); virtual;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLHosIma3DFMX<TCLContex_,TCLPlatfo_,TValue_>

     TCLHosIma3DFMX<TCLContex_,TCLPlatfo_:class;TValue_:record> = class( TCLHosIma3D<TCLContex_,TCLPlatfo_,TValue_> )
     private
     protected
     public
       ///// メソッド
       procedure CopyTo( const Z_:Integer; const Bitmap_:TBitmap ); overload; virtual; abstract;
       procedure CopyFrom( const Z_:Integer; const Bitmap_:TBitmap ); overload; virtual; abstract;
       procedure SaveToFile( const Z_:Integer; const FileName_:String ); virtual;
       procedure LoadFromFile( const Z_:Integer; const FileName_:String ); virtual;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDevIma3DxBGRAxUInt8<TCLContex_,TCLPlatfo_>

     TCLDevIma3DxBGRAxUInt8<TCLContex_,TCLPlatfo_:class> = class( TCLDevIma3DFMX<TCLContex_,TCLPlatfo_,TByteRGBA> )
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

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLHosIma3DxBGRAxUInt8<TCLContex_,TCLPlatfo_>

     TCLHosIma3DxBGRAxUInt8<TCLContex_,TCLPlatfo_:class> = class( TCLHosIma3DFMX<TCLContex_,TCLPlatfo_,TByteRGBA> )
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

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDevIma3DxBGRAxUFix8<TCLContex_,TCLPlatfo_>

     TCLDevIma3DxBGRAxUFix8<TCLContex_,TCLPlatfo_:class> = class( TCLDevIma3DFMX<TCLContex_,TCLPlatfo_,TByteRGBA> )
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

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLHosIma3DxBGRAxUFix8<TCLContex_,TCLPlatfo_>

     TCLHosIma3DxBGRAxUFix8<TCLContex_,TCLPlatfo_:class> = class( TCLHosIma3DFMX<TCLContex_,TCLPlatfo_,TByteRGBA> )
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

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDevIma3DxRGBAxSFlo32<TCLContex_,TCLPlatfo_>

     TCLDevIma3DxRGBAxSFlo32<TCLContex_,TCLPlatfo_:class> = class( TCLDevIma3DFMX<TCLContex_,TCLPlatfo_,TSingleRGBA> )
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

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLHosIma3DxRGBAxSFlo32<TCLContex_,TCLPlatfo_>

     TCLHosIma3DxRGBAxSFlo32<TCLContex_,TCLPlatfo_:class> = class( TCLHosIma3DFMX<TCLContex_,TCLPlatfo_,TSingleRGBA> )
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

uses System.Threading,
     LUX.GPU.OpenCL;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDevIma3DFMX<TCLContex_,TCLPlatfo_,TValue_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLDevIma3DFMX<TCLContex_,TCLPlatfo_,TValue_>.SaveToFile( const Z_:Integer; const FileName_:String );
var
   B :TBitmap;
begin
     B := TBitmap.Create;

     CopyTo( Z_, B );

     B.SaveToFile( FileName_ );

     B.Free;
end;

procedure TCLDevIma3DFMX<TCLContex_,TCLPlatfo_,TValue_>.LoadFromFile( const Z_:Integer; const FileName_:String );
var
   B :TBitmap;
begin
     B := TBitmap.Create;

     B.LoadFromFile( FileName_ );

     CopyFrom( Z_, B );

     B.Free;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLHosIma3DFMX<TCLContex_,TCLPlatfo_,TValue_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLHosIma3DFMX<TCLContex_,TCLPlatfo_,TValue_>.SaveToFile( const Z_:Integer; const FileName_:String );
var
   B :TBitmap;
begin
     B := TBitmap.Create;

     CopyTo( Z_, B );

     B.SaveToFile( FileName_ );

     B.Free;
end;

procedure TCLHosIma3DFMX<TCLContex_,TCLPlatfo_,TValue_>.LoadFromFile( const Z_:Integer; const FileName_:String );
var
   B :TBitmap;
begin
     B := TBitmap.Create;

     B.LoadFromFile( FileName_ );

     CopyFrom( Z_, B );

     B.Free;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDevIma3DxBGRAxUInt8<TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLDevIma3DxBGRAxUInt8<TCLContex_,TCLPlatfo_>.GetPixChan :T_cl_channel_order;
begin
     Result := CL_BGRA;
end;

function TCLDevIma3DxBGRAxUInt8<TCLContex_,TCLPlatfo_>.GetPixType :T_cl_channel_type;
begin
     Result := CL_UNSIGNED_INT8;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLDevIma3DxBGRAxUInt8<TCLContex_,TCLPlatfo_>.CopyTo( const Z_:Integer; const Bitmap_:TBitmap );
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

procedure TCLDevIma3DxBGRAxUInt8<TCLContex_,TCLPlatfo_>.CopyFrom( const Z_:Integer; const Bitmap_:TBitmap );
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

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLHosIma3DxBGRAxUInt8<TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLHosIma3DxBGRAxUInt8<TCLContex_,TCLPlatfo_>.GetPixChan :T_cl_channel_order;
begin
     Result := CL_BGRA;
end;

function TCLHosIma3DxBGRAxUInt8<TCLContex_,TCLPlatfo_>.GetPixType :T_cl_channel_type;
begin
     Result := CL_UNSIGNED_INT8;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLHosIma3DxBGRAxUInt8<TCLContex_,TCLPlatfo_>.CopyTo( const Z_:Integer; const Bitmap_:TBitmap );
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

procedure TCLHosIma3DxBGRAxUInt8<TCLContex_,TCLPlatfo_>.CopyFrom( const Z_:Integer; const Bitmap_:TBitmap );
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

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDevIma3DxBGRAxUFix8<TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLDevIma3DxBGRAxUFix8<TCLContex_,TCLPlatfo_>.GetPixChan :T_cl_channel_order;
begin
     Result := CL_BGRA;
end;

function TCLDevIma3DxBGRAxUFix8<TCLContex_,TCLPlatfo_>.GetPixType :T_cl_channel_type;
begin
     Result := CL_UNORM_INT8;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLDevIma3DxBGRAxUFix8<TCLContex_,TCLPlatfo_>.CopyTo( const Z_:Integer; const Bitmap_:TBitmap );
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

procedure TCLDevIma3DxBGRAxUFix8<TCLContex_,TCLPlatfo_>.CopyFrom( const Z_:Integer; const Bitmap_:TBitmap );
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

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLHosIma3DxBGRAxUFix8<TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLHosIma3DxBGRAxUFix8<TCLContex_,TCLPlatfo_>.GetPixChan :T_cl_channel_order;
begin
     Result := CL_BGRA;
end;

function TCLHosIma3DxBGRAxUFix8<TCLContex_,TCLPlatfo_>.GetPixType :T_cl_channel_type;
begin
     Result := CL_UNORM_INT8;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLHosIma3DxBGRAxUFix8<TCLContex_,TCLPlatfo_>.CopyTo( const Z_:Integer; const Bitmap_:TBitmap );
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

procedure TCLHosIma3DxBGRAxUFix8<TCLContex_,TCLPlatfo_>.CopyFrom( const Z_:Integer; const Bitmap_:TBitmap );
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

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDevIma3DxRGBAxSFlo32<TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLDevIma3DxRGBAxSFlo32<TCLContex_,TCLPlatfo_>.GetPixChan :T_cl_channel_order;
begin
     Result := CL_RGBA;
end;

function TCLDevIma3DxRGBAxSFlo32<TCLContex_,TCLPlatfo_>.GetPixType :T_cl_channel_type;
begin
     Result := CL_FLOAT;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLDevIma3DxRGBAxSFlo32<TCLContex_,TCLPlatfo_>.CopyTo( const Z_:Integer; const Bitmap_:TBitmap );
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

procedure TCLDevIma3DxRGBAxSFlo32<TCLContex_,TCLPlatfo_>.CopyFrom( const Z_:Integer; const Bitmap_:TBitmap );
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

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLHosIma3DxRGBAxSFlo32<TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLHosIma3DxRGBAxSFlo32<TCLContex_,TCLPlatfo_>.GetPixChan :T_cl_channel_order;
begin
     Result := CL_RGBA;
end;

function TCLHosIma3DxRGBAxSFlo32<TCLContex_,TCLPlatfo_>.GetPixType :T_cl_channel_type;
begin
     Result := CL_FLOAT;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLHosIma3DxRGBAxSFlo32<TCLContex_,TCLPlatfo_>.CopyTo( const Z_:Integer; const Bitmap_:TBitmap );
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

procedure TCLHosIma3DxRGBAxSFlo32<TCLContex_,TCLPlatfo_>.CopyFrom( const Z_:Integer; const Bitmap_:TBitmap );
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
