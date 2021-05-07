unit LUX.GPU.OpenCL.Memory.Imager;

interface //#################################################################### ■

uses System.UITypes,
     FMX.Graphics,
     cl_version, cl_platform, cl,
     LUX,
     LUX.Code.C,
     LUX.GPU.OpenCL.root,
     LUX.GPU.OpenCL.Queuer,
     LUX.GPU.OpenCL.Memory;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TCLImager  <TCLContex_,TCLPlatfo_:class;TValue_:record> = class;
       TCLDevIma<TCLContex_,TCLPlatfo_:class;TValue_:record> = class;
       TCLHosIma<TCLContex_,TCLPlatfo_:class;TValue_:record> = class;

     TCLImagerIter<TCLContex_,TCLPlatfo_:class;TValue_:record> = class;

     TCLDevImaRGBA<TCLContex_,TCLPlatfo_:class> = class;

     TCLImagerIterRGBA<TCLContex_,TCLPlatfo_:class> = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImager<TCLContex_,TCLPlatfo_,TValue_>

     TCLImager<TCLContex_,TCLPlatfo_:class;TValue_:record> = class( TCLMemory<TCLContex_,TCLPlatfo_> )
     private
     protected
       _Format :T_cl_image_format;
       _Descri :T_cl_image_desc;
       _CountX :Integer;
       _CountY :Integer;
       ///// アクセス
       function GetCountX :Integer; virtual;
       procedure SetCountX( const CountX_:Integer ); virtual;
       function GetCountY :Integer; virtual;
       procedure SetCountY( const CountY_:Integer ); virtual;
       function GetSize :T_size_t; override;
     public
       constructor Create; override;
       ///// プロパティ
       property CountX :Integer read GetCountX write SetCountX;
       property CountY :Integer read GetCountY write SetCountY;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDevIma<TCLContex_,TCLPlatfo_,TValue_>

     TCLDevIma<TCLContex_,TCLPlatfo_:class;TValue_:record> = class( TCLImager<TCLContex_,TCLPlatfo_,TValue_> )
     private
     protected
       ///// メソッド
       procedure CreateHandle; override;
     public
       constructor Create; override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLHosIma<TCLContex_,TCLPlatfo_,TValue_>

     TCLHosIma<TCLContex_,TCLPlatfo_:class;TValue_:record> = class( TCLImager<TCLContex_,TCLPlatfo_,TValue_> )
     private
     protected
       _Data :P_void;
       ///// メソッド
       procedure CreateHandle; override;
       procedure DestroHandle; override;
     public
       constructor Create; override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImagerIter<TCLContex_,TCLPlatfo_,TValue_>

     TCLImagerIter<TCLContex_,TCLPlatfo_:class;TValue_:record> = class( TCLMemoryIter<TCLContex_,TCLPlatfo_> )
     private
       type TCLQueuer_ = TCLQueuer<TCLContex_,TCLPlatfo_>;
            TCLImager_ = TCLImager<TCLContex_,TCLPlatfo_,TValue_>;
            PValue_    = ^TValue_;
     protected
       _RowPit :Integer;
       ///// アクセス
       function GetImager :TCLImager_; virtual;
       function GetValues( const X_,Y_:Integer ) :TValue_; virtual;
       procedure SetValues( const X_,Y_:Integer; const Values_:TValue_ ); virtual;
       ///// メソッド
       procedure CreateHandle; override;
     public
       ///// プロパティ
       property Imager                        :TCLImager_ read GetImager                ;
       property Values[ const X_,Y_:Integer ] :TValue_    read GetValues write SetValues; default;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDevImaRGBA<TCLContex_,TCLPlatfo_>

     TCLDevImaRGBA<TCLContex_,TCLPlatfo_:class> = class( TCLDevIma<TCLContex_,TCLPlatfo_,TAlphaColorF> )
     private
       type TCLImagerIter_ = TCLImagerIterRGBA<TCLContex_,TCLPlatfo_>;
     protected
     public
       ///// メソッド
       procedure DrawTo( const Bitmap_:TBitmap );
       procedure SaveToFile( const FileName_:String );
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLHosImaRGBA<TCLContex_,TCLPlatfo_>

     TCLHosImaRGBA<TCLContex_,TCLPlatfo_:class> = class( TCLHosIma<TCLContex_,TCLPlatfo_,TAlphaColorF> )
     private
       type TCLImagerIter_ = TCLImagerIterRGBA<TCLContex_,TCLPlatfo_>;
     protected
     public
       ///// メソッド
       procedure DrawTo( const Bitmap_:TBitmap );
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

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImager<TCLContex_,TCLPlatfo_,TValue_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLImager<TCLContex_,TCLPlatfo_,TValue_>.GetCountX :Integer;
begin
     Result := _CountX;
end;

procedure TCLImager<TCLContex_,TCLPlatfo_,TValue_>.SetCountX( const CountX_:Integer );
begin
     Handle := nil;

     _CountX := CountX_;
end;

function TCLImager<TCLContex_,TCLPlatfo_,TValue_>.GetCountY :Integer;
begin
     Result := _CountX;
end;

procedure TCLImager<TCLContex_,TCLPlatfo_,TValue_>.SetCountY( const CountY_:Integer );
begin
     Handle := nil;

     _CountY := CountY_;
end;

//------------------------------------------------------------------------------

function TCLImager<TCLContex_,TCLPlatfo_,TValue_>.GetSize :T_size_t;
begin
     Result := SizeOf( TValue_ ) * _CountX * _CountY;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLImager<TCLContex_,TCLPlatfo_,TValue_>.Create;
begin
     inherited;

     _CountX := 1;
     _CountY := 1;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDevIma<TCLContex_,TCLPlatfo_,TValue_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLDevIma<TCLContex_,TCLPlatfo_,TValue_>.CreateHandle;
var
   E :T_cl_int;
begin
     inherited;

     with _Format do
     begin
          image_channel_order     := CL_RGBA;
          image_channel_data_type := CL_FLOAT;
     end;

     with _Descri do
     begin
          image_type        := CL_MEM_OBJECT_IMAGE2D;
          image_width       := CountX;
          image_height      := CountY;
          image_depth       := 0;
          image_array_size  := 0;
          image_row_pitch   := 0;
          image_slice_pitch := 0;
          num_mip_levels    := 0;
          num_samples       := 0;
          buffer            := nil;
     end;

     _Handle := clCreateImage( TCLContex( Contex ).Handle, Kind, @_Format, @_Descri, nil, @E );

     AssertCL( E );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLDevIma<TCLContex_,TCLPlatfo_,TValue_>.Create;
begin
     inherited;

     _Kind := CL_MEM_READ_WRITE or CL_MEM_ALLOC_HOST_PTR;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLHosIma<TCLContex_,TCLPlatfo_,TValue_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLHosIma<TCLContex_,TCLPlatfo_,TValue_>.CreateHandle;
var
   E :T_cl_int;
begin
     inherited;

     GetMemAligned( _Data, Ceil2N( Size, 64{Byte} ), 4096{Byte} );

     with _Format do
     begin
          image_channel_order     := CL_RGBA;
          image_channel_data_type := CL_FLOAT;
     end;

     with _Descri do
     begin
          image_type        := CL_MEM_OBJECT_IMAGE2D;
          image_width       := CountX;
          image_height      := CountY;
          image_depth       := 0;
          image_array_size  := 0;
          image_row_pitch   := 0;
          image_slice_pitch := 0;
          num_mip_levels    := 0;
          num_samples       := 0;
          buffer            := nil;
     end;

     _Handle := clCreateImage( TCLContex( Contex ).Handle, Kind, @_Format, @_Descri, _Data, @E );

     AssertCL( E );
end;

procedure TCLHosIma<TCLContex_,TCLPlatfo_,TValue_>.DestroHandle;
begin
     FreeMemAligned( _Data );

     inherited;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLHosIma<TCLContex_,TCLPlatfo_,TValue_>.Create;
begin
     inherited;

     _Kind := CL_MEM_READ_WRITE or CL_MEM_USE_HOST_PTR;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImagerIter<TCLContex_,TCLPlatfo_,TValue_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

/////////////////////////////////////////////////////////////////////// アクセス

function TCLImagerIter<TCLContex_,TCLPlatfo_,TValue_>.GetImager :TCLImager_;
begin
     Result := TCLImager_( Memory );
end;

function TCLImagerIter<TCLContex_,TCLPlatfo_,TValue_>.GetValues( const X_,Y_:Integer ) :TValue_;
var
   P :PValue_;
begin
     P := Handle;  Inc( P, _RowPit * Y_ + X_ );  Result := P^;
end;

procedure TCLImagerIter<TCLContex_,TCLPlatfo_,TValue_>.SetValues( const X_,Y_:Integer; const Values_:TValue_ );
var
   P :PValue_;
begin
     P := Handle;  Inc( P, _RowPit * Y_ + X_ );  P^ := Values_;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLImagerIter<TCLContex_,TCLPlatfo_,TValue_>.CreateHandle;
var
   O, R :record
           X, Y, Z :T_size_t;
         end;
   RP, SP :T_size_t;
   V :T_cl_event;
   E :T_cl_int;
begin
     inherited;

     O.X := 0;
     O.Y := 0;
     O.Z := 0;

     R.X := Imager.CountX;
     R.Y := Imager.CountY;
     R.Z := 1;

     _Handle := clEnqueueMapImage( Queuer.Handle, Imager.Handle, CL_TRUE, Mode, @O, @R, @RP, @SP, 0, nil, @V, @E );

     AssertCL( E );

     _RowPit := Integer( RP ) div SizeOf( TValue_ );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDevImaRGBA<TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLDevImaRGBA<TCLContex_,TCLPlatfo_>.DrawTo( const Bitmap_:TBitmap );
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

     DrawTo( B );

     B.SaveToFile( FileName_ );

     B.Free;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLHosImaRGBA<TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLHosImaRGBA<TCLContex_,TCLPlatfo_>.DrawTo( const Bitmap_:TBitmap );
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

     DrawTo( B );

     B.SaveToFile( FileName_ );

     B.Free;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImagerIterRGBA<TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

end. //######################################################################### ■
