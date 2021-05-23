unit LUX.GPU.OpenCL.Argume.Memory.Imager;

interface //#################################################################### ■

uses cl_version, cl_platform, cl,
     LUX,
     LUX.Code.C,
     LUX.GPU.OpenCL.core,
     LUX.GPU.OpenCL.Queuer,
     LUX.GPU.OpenCL.Argume.Memory;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TCLImager<TCLSystem_,TCLPlatfo_,TCLContex_:class;TValue_:record> = class;

     TCLImaDat<TCLSystem_,TCLPlatfo_,TCLContex_:class;TValue_:record> = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImager<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>

     TCLImager<TCLSystem_,TCLPlatfo_,TCLContex_:class;TValue_:record> = class( TCLMemory<TCLSystem_,TCLPlatfo_,TCLContex_> )
     private
       type TCLImaDat_ = TCLImaDat<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>;
     protected
       ///// アクセス
       function GetKind :T_cl_mem_flags; override;
       function GetData :TCLImaDat_; reintroduce; virtual;
       procedure SetData( const Data_:TCLImaDat_ ); reintroduce; virtual;
       function GetSize :T_size_t; override;
       function GetPixChan :T_cl_channel_order; virtual; abstract;
       function GetPixType :T_cl_channel_type; virtual; abstract;
       function GetFormat :T_cl_image_format; virtual;
       function GetMemTyp :T_cl_mem_object_type; virtual; abstract;
       function GetCountX :Integer; virtual;
       procedure SetCountX( const CountX_:Integer ); virtual;
       function GetCountY :Integer; virtual;
       procedure SetCountY( const CountY_:Integer ); virtual;
       function GetCountZ :Integer; virtual;
       procedure SetCountZ( const CountZ_:Integer ); virtual;
       function GetDescri :T_cl_image_desc; virtual;
       ///// メソッド
       function CreateHandle :T_cl_int; override;
     public
       ///// プロパティ
       property Data    :TCLImaDat_           read GetData   write SetData  ;
       property PixChan :T_cl_channel_order   read GetPixChan               ;
       property PixType :T_cl_channel_type    read GetPixType               ;
       property Format  :T_cl_image_format    read GetFormat                ;
       property MemTyp  :T_cl_mem_object_type read GetMemTyp                ;
       property CountX  :Integer              read GetCountX write SetCountX;
       property CountY  :Integer              read GetCountY write SetCountY;
       property CountZ  :Integer              read GetCountZ write SetCountZ;
       property Descri  :T_cl_image_desc      read GetDescri                ;
       ///// メソッド
       procedure Fill( const Value_:TValue_ );
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImaDat<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>

     TCLImaDat<TCLSystem_,TCLPlatfo_,TCLContex_:class;TValue_:record> = class( TCLMemDat<TCLSystem_,TCLPlatfo_,TCLContex_> )
     private
       type TCLImager_ = TCLImager<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>;
            PValue_    = ^TValue_;
     protected
       _PitchX :Integer;
       _PitchY :Integer;
       _PitchZ :Integer;
       ///// アクセス
       function GetImager :TCLImager_; virtual;
       function GetValueP :PByte;
       ///// メソッド
       function CreateHandle :T_cl_int; override;
     public
       ///// プロパティ
       property Imager :TCLImager_ read GetImager;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses LUX.GPU.OpenCL.Contex;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImager<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLImager<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.GetKind :T_cl_mem_flags;
begin
     Result := _Kind or CL_MEM_ALLOC_HOST_PTR;
end;

//------------------------------------------------------------------------------

function TCLImager<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.GetData :TCLImaDat_;
begin
     Result := TCLImaDat_( inherited Data );
end;

procedure TCLImager<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.SetData( const Data_:TCLImaDat_ );
begin
     inherited Data := Data_;
end;

//------------------------------------------------------------------------------

function TCLImager<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.GetSize :T_size_t;
begin
     Result := SizeOf( TValue_ ) * CountX * CountY * CountZ;
end;

//------------------------------------------------------------------------------

function TCLImager<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.GetFormat :T_cl_image_format;
begin
     with Result do
     begin
          image_channel_order     := GetPixChan;
          image_channel_data_type := GetPixType;
     end;
end;

//------------------------------------------------------------------------------

function TCLImager<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.GetCountX :Integer;
begin
     Result := 1;
end;

procedure TCLImager<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.SetCountX( const CountX_:Integer );
begin
     Handle := nil;
end;

function TCLImager<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.GetCountY :Integer;
begin
     Result := 1;
end;

procedure TCLImager<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.SetCountY( const CountY_:Integer );
begin
     Handle := nil;
end;

function TCLImager<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.GetCountZ :Integer;
begin
     Result := 1;
end;

procedure TCLImager<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.SetCountZ( const CountZ_:Integer );
begin
     Handle := nil;
end;

//------------------------------------------------------------------------------

function TCLImager<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.GetDescri :T_cl_image_desc;
begin
     with Result do
     begin
          image_type        := MemTyp;
          image_width       := CountX;
          image_height      := CountY;
          image_depth       := CountZ;
          image_array_size  := 0;
          image_row_pitch   := 0;
          image_slice_pitch := 0;
          num_mip_levels    := 0;
          num_samples       := 0;
          buffer            := nil;
     end;
end;

/////////////////////////////////////////////////////////////////////// メソッド

function TCLImager<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.CreateHandle :T_cl_int;
var
   F :T_cl_image_format;
   D :T_cl_image_desc;
begin
     inherited;

     F := Format;
     D := Descri;

     _Handle := clCreateImage( TCLContex<TCLSystem_,TCLPlatfo_>( Contex ).Handle, Kind, @F, @D, nil, @Result );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLImager<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.Fill( const Value_:TValue_ );
var
   O, R :record
           X, Y, Z :T_size_t;
         end;
begin
     O.X := 0;  R.X := CountX;
     O.Y := 0;  R.Y := CountY;
     O.Z := 0;  R.Z := CountZ;

     AssertCL( clEnqueueFillImage( Queuer.Handle, Handle,
                                   @Value_, @O, @R,
                                   0, nil, nil ), 'TCLImager.Fill is Error!' );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImaDat<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLImaDat<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.GetImager :TCLImager_;
begin
     Result := TCLImager_( Memory );
end;

function TCLImaDat<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.GetValueP :PByte;
begin
     Result := Handle;
end;

/////////////////////////////////////////////////////////////////////// メソッド

function TCLImaDat<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.CreateHandle :T_cl_int;
var
   O, R :record
           X, Y, Z :T_size_t;
         end;
   V :T_cl_event;
begin
     inherited;

     O.X := 0;
     O.Y := 0;
     O.Z := 0;

     R.X := Imager.CountX;
     R.Y := Imager.CountY;
     R.Z := Imager.CountZ;

     _PitchX := SizeOf( TValue_ );

     _Handle := clEnqueueMapImage( Queuer.Handle, Imager.Handle, CL_TRUE, Mode, @O, @R, @_PitchY, @_PitchZ, 0, nil, @V, @Result );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

end. //######################################################################### ■
