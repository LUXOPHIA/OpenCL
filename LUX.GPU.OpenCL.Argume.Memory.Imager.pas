unit LUX.GPU.OpenCL.Argume.Memory.Imager;

interface //#################################################################### ■

uses cl_version, cl_platform, cl,
     LUX,
     LUX.Code.C,
     LUX.GPU.OpenCL.core,
     LUX.GPU.OpenCL.Queuer,
     LUX.GPU.OpenCL.Argume.Memory;

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
       ///// アクセス
       function GetStorag :TCLStorag_; reintroduce; virtual;
       procedure SetStorag( const Storag_:TCLStorag_ ); reintroduce; virtual;
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
     public
       ///// プロパティ
       property Storag  :TCLStorag_           read GetStorag write SetStorag;
       property PixChan :T_cl_channel_order   read GetPixChan               ;
       property PixType :T_cl_channel_type    read GetPixType               ;
       property Format  :T_cl_image_format    read GetFormat                ;
       property MemTyp  :T_cl_mem_object_type read GetMemTyp                ;
       property CountX  :Integer              read GetCountX write SetCountX;
       property CountY  :Integer              read GetCountY write SetCountY;
       property CountZ  :Integer              read GetCountZ write SetCountZ;
       property Descri  :T_cl_image_desc      read GetDescri                ;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDevIma<TCLContex_,TCLPlatfo_,TValue_>

     TCLDevIma<TCLContex_,TCLPlatfo_:class;TValue_:record> = class( TCLImager<TCLContex_,TCLPlatfo_,TValue_> )
     private
     protected
       ///// メソッド
       function CreateHandle :T_cl_int; override;
     public
       constructor Create; override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLHosIma<TCLContex_,TCLPlatfo_,TValue_>

     TCLHosIma<TCLContex_,TCLPlatfo_:class;TValue_:record> = class( TCLImager<TCLContex_,TCLPlatfo_,TValue_> )
     private
     protected
       _Data :P_void;
       ///// メソッド
       function CreateHandle :T_cl_int; override;
       function DestroHandle :T_cl_int; override;
     public
       constructor Create; override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImagerIter<TCLContex_,TCLPlatfo_,TValue_>

     TCLImagerIter<TCLContex_,TCLPlatfo_:class;TValue_:record> = class( TCLMemoryIter<TCLContex_,TCLPlatfo_> )
     private
       type TCLImager_ = TCLImager<TCLContex_,TCLPlatfo_,TValue_>;
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
     Result := SizeOf( TValue_ ) * CountX * CountY * CountZ;
end;

//------------------------------------------------------------------------------

function TCLImager<TCLContex_,TCLPlatfo_,TValue_>.GetFormat :T_cl_image_format;
begin
     with Result do
     begin
          image_channel_order     := GetPixChan;
          image_channel_data_type := GetPixType;
     end;
end;

//------------------------------------------------------------------------------

function TCLImager<TCLContex_,TCLPlatfo_,TValue_>.GetCountX :Integer;
begin
     Result := 1;
end;

procedure TCLImager<TCLContex_,TCLPlatfo_,TValue_>.SetCountX( const CountX_:Integer );
begin
     Handle := nil;
end;

function TCLImager<TCLContex_,TCLPlatfo_,TValue_>.GetCountY :Integer;
begin
     Result := 1;
end;

procedure TCLImager<TCLContex_,TCLPlatfo_,TValue_>.SetCountY( const CountY_:Integer );
begin
     Handle := nil;
end;

function TCLImager<TCLContex_,TCLPlatfo_,TValue_>.GetCountZ :Integer;
begin
     Result := 1;
end;

procedure TCLImager<TCLContex_,TCLPlatfo_,TValue_>.SetCountZ( const CountZ_:Integer );
begin
     Handle := nil;
end;

//------------------------------------------------------------------------------

function TCLImager<TCLContex_,TCLPlatfo_,TValue_>.GetDescri :T_cl_image_desc;
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

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDevIma<TCLContex_,TCLPlatfo_,TValue_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// メソッド

function TCLDevIma<TCLContex_,TCLPlatfo_,TValue_>.CreateHandle :T_cl_int;
var
   F :T_cl_image_format;
   D :T_cl_image_desc;
begin
     inherited;

     F := Format;
     D := Descri;

     _Handle := clCreateImage( TCLContex( Contex ).Handle, Kind, @F, @D, nil, @Result );
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

function TCLHosIma<TCLContex_,TCLPlatfo_,TValue_>.CreateHandle :T_cl_int;
var
   F :T_cl_image_format;
   D :T_cl_image_desc;
begin
     inherited;

     F := Format;
     D := Descri;

     GetMemAligned( _Data, Ceil2N( Size, 64{Byte} ), 4096{Byte} );

     _Handle := clCreateImage( TCLContex( Contex ).Handle, Kind, @F, @D, _Data, @Result );
end;

function TCLHosIma<TCLContex_,TCLPlatfo_,TValue_>.DestroHandle :T_cl_int;
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

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLImagerIter<TCLContex_,TCLPlatfo_,TValue_>.GetImager :TCLImager_;
begin
     Result := TCLImager_( Memory );
end;

function TCLImagerIter<TCLContex_,TCLPlatfo_,TValue_>.GetValueP :PByte;
begin
     Result := Handle;
end;

/////////////////////////////////////////////////////////////////////// メソッド

function TCLImagerIter<TCLContex_,TCLPlatfo_,TValue_>.CreateHandle :T_cl_int;
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
