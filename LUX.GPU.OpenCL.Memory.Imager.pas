unit LUX.GPU.OpenCL.Memory.Imager;

interface //#################################################################### ■

uses cl_version, cl_platform, cl,
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

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImager<TCLContex_,TCLPlatfo_,TValue_>

     TCLImager<TCLContex_,TCLPlatfo_:class;TValue_:record> = class( TCLMemory<TCLContex_,TCLPlatfo_> )
     private
       type TCLStorag_ = TCLImagerIter<TCLContex_,TCLPlatfo_,TValue_>;
     protected
       _Format :T_cl_image_format;
       _Descri :T_cl_image_desc;
       _CountX :Integer;
       _CountY :Integer;
       ///// アクセス
       function GetPixChan :T_cl_channel_order; virtual; abstract;
       function GetPixType :T_cl_channel_type; virtual; abstract;
       function GetStorag :TCLStorag_; reintroduce; virtual;
       procedure SetStorag( const Storag_:TCLStorag_ ); reintroduce; virtual;
       function GetSize :T_size_t; override;
       function GetCountX :Integer; virtual;
       procedure SetCountX( const CountX_:Integer ); virtual;
       function GetCountY :Integer; virtual;
       procedure SetCountY( const CountY_:Integer ); virtual;
     public
       constructor Create; override;
       ///// プロパティ
       property Storag :TCLStorag_ read GetStorag write SetStorag;
       property CountX :Integer    read GetCountX write SetCountX;
       property CountY :Integer    read GetCountY write SetCountY;
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
       _PitchX :Integer;
       _PitchY :Integer;
       _PitchZ :Integer;
       ///// アクセス
       function GetImager :TCLImager_; virtual;
       function GetValueP( const X_,Y_:Integer ) :PValue_; virtual;
       function GetValues( const X_,Y_:Integer ) :TValue_; virtual;
       procedure SetValues( const X_,Y_:Integer; const Values_:TValue_ ); virtual;
       ///// メソッド
       procedure CreateHandle; override;
     public
       ///// プロパティ
       property Imager                        :TCLImager_ read GetImager                ;
       property ValueP[ const X_,Y_:Integer ] :PValue_    read GetValueP                ;
       property Values[ const X_,Y_:Integer ] :TValue_    read GetValues write SetValues; default;
     end;

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

function TCLImager<TCLContex_,TCLPlatfo_,TValue_>.GetStorag :TCLStorag_;
begin
     Result := TCLStorag_( inherited Storag );
end;

procedure TCLImager<TCLContex_,TCLPlatfo_,TValue_>.SetStorag( const Storag_:TCLStorag_ );
begin
     inherited Storag := Storag_;
end;

//------------------------------------------------------------------------------

function TCLImager<TCLContex_,TCLPlatfo_,TValue_>.GetSize :T_size_t;
begin
     Result := SizeOf( TValue_ ) * _CountX * _CountY;
end;

//------------------------------------------------------------------------------

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

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLImager<TCLContex_,TCLPlatfo_,TValue_>.Create;
begin
     inherited;

     _Storag := TCLStorag_.Create( Self );

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
          image_channel_order     := GetPixChan;
          image_channel_data_type := GetPixType;
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
          image_channel_order     := GetPixChan;
          image_channel_data_type := GetPixType;
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

function TCLImagerIter<TCLContex_,TCLPlatfo_,TValue_>.GetValueP( const X_,Y_:Integer ) :PValue_;
var
   P :PByte;
begin
     P := Handle;  Inc( P, _PitchY * Y_ + _PitchX * X_ );  Result := PValue_( P );
end;

function TCLImagerIter<TCLContex_,TCLPlatfo_,TValue_>.GetValues( const X_,Y_:Integer ) :TValue_;
begin
     Result := ValueP[ X_, Y_ ]^;
end;

procedure TCLImagerIter<TCLContex_,TCLPlatfo_,TValue_>.SetValues( const X_,Y_:Integer; const Values_:TValue_ );
begin
     ValueP[ X_, Y_ ]^ := Values_;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLImagerIter<TCLContex_,TCLPlatfo_,TValue_>.CreateHandle;
var
   O, R :record
           X, Y, Z :T_size_t;
         end;
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

     _PitchX := SizeOf( TValue_ );

     _Handle := clEnqueueMapImage( Queuer.Handle, Imager.Handle, CL_TRUE, Mode, @O, @R, @_PitchY, @_PitchZ, 0, nil, @V, @E );

     AssertCL( E );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

end. //######################################################################### ■
