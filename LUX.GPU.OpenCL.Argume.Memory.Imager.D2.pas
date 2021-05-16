unit LUX.GPU.OpenCL.Argume.Memory.Imager.D2;

interface //#################################################################### ■

uses cl_version, cl_platform, cl,
     LUX,
     LUX.Code.C,
     LUX.GPU.OpenCL.core,
     LUX.GPU.OpenCL.Argume.Memory.Imager.D1;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TCLImager2D  <TCLContex_,TCLPlatfo_:class;TValue_:record> = class;
       TCLDevIma2D<TCLContex_,TCLPlatfo_:class;TValue_:record> = class;
       TCLHosIma2D<TCLContex_,TCLPlatfo_:class;TValue_:record> = class;

     TCLImagerIter2D<TCLContex_,TCLPlatfo_:class;TValue_:record> = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImager2D<TCLContex_,TCLPlatfo_,TValue_>

     TCLImager2D<TCLContex_,TCLPlatfo_:class;TValue_:record> = class( TCLImager1D<TCLContex_,TCLPlatfo_,TValue_> )
     private
       type TCLStorag_ = TCLImagerIter2D<TCLContex_,TCLPlatfo_,TValue_>;
     protected
       _CountY :Integer;
       ///// アクセス
       function GetStorag :TCLStorag_; reintroduce; virtual;
       procedure SetStorag( const Storag_:TCLStorag_ ); reintroduce; virtual;
       function GetMemTyp :T_cl_mem_object_type; override;
       function GetCountY :Integer; override;
       procedure SetCountY( const CountY_:Integer ); override;
       ///// メソッド
       function NewStorag :TObject; override;
     public
       constructor Create; override;
       ///// プロパティ
       property Storag :TCLStorag_ read GetStorag write SetStorag;
       property CountY :Integer    read GetCountY write SetCountY;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDevIma2D<TCLContex_,TCLPlatfo_,TValue_>

     TCLDevIma2D<TCLContex_,TCLPlatfo_:class;TValue_:record> = class( TCLImager2D<TCLContex_,TCLPlatfo_,TValue_> )
     private
     protected
       ///// メソッド
       function CreateHandle :T_cl_int; override;
     public
       constructor Create; override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLHosIma2D<TCLContex_,TCLPlatfo_,TValue_>

     TCLHosIma2D<TCLContex_,TCLPlatfo_:class;TValue_:record> = class( TCLImager2D<TCLContex_,TCLPlatfo_,TValue_> )
     private
     protected
       _Data :P_void;
       ///// メソッド
       function CreateHandle :T_cl_int; override;
       function DestroHandle :T_cl_int; override;
     public
       constructor Create; override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImagerIter2D<TCLContex_,TCLPlatfo_,TValue_>

     TCLImagerIter2D<TCLContex_,TCLPlatfo_:class;TValue_:record> = class( TCLImagerIter1D<TCLContex_,TCLPlatfo_,TValue_> )
     private
       type TCLImager_ = TCLImager2D<TCLContex_,TCLPlatfo_,TValue_>;
            PValue_    = ^TValue_;
     protected
       ///// アクセス
       function GetImager :TCLImager_; reintroduce; virtual;
       function GetValueP( const X_,Y_:Integer ) :PByte;
       function GetValues( const X_,Y_:Integer ) :TValue_;
       procedure SetValues( const X_,Y_:Integer; const Values_:TValue_ );
     public
       ///// プロパティ
       property Imager                        :TCLImager_ read GetImager                ;
       property ValueP[ const X_,Y_:Integer ] :PByte      read GetValueP                ;
       property Values[ const X_,Y_:Integer ] :TValue_    read GetValues write SetValues; default;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses LUX.GPU.OpenCL;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImager2D<TCLContex_,TCLPlatfo_,TValue_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLImager2D<TCLContex_,TCLPlatfo_,TValue_>.GetStorag :TCLStorag_;
begin
     Result := TCLStorag_( inherited Storag );
end;

procedure TCLImager2D<TCLContex_,TCLPlatfo_,TValue_>.SetStorag( const Storag_:TCLStorag_ );
begin
     inherited Storag := Storag_;
end;

//------------------------------------------------------------------------------

function TCLImager2D<TCLContex_,TCLPlatfo_,TValue_>.GetMemTyp :T_cl_mem_object_type;
begin
     Result := CL_MEM_OBJECT_IMAGE2D;
end;

//------------------------------------------------------------------------------

function TCLImager2D<TCLContex_,TCLPlatfo_,TValue_>.GetCountY :Integer;
begin
     Result := _CountY;
end;

procedure TCLImager2D<TCLContex_,TCLPlatfo_,TValue_>.SetCountY( const CountY_:Integer );
begin
     inherited;

     _CountY := CountY_;
end;

/////////////////////////////////////////////////////////////////////// メソッド

function TCLImager2D<TCLContex_,TCLPlatfo_,TValue_>.NewStorag :TObject;
begin
     Result := TCLStorag_.Create( Self );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLImager2D<TCLContex_,TCLPlatfo_,TValue_>.Create;
begin
     inherited;

     _CountY := 1;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDevIma2D<TCLContex_,TCLPlatfo_,TValue_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// メソッド

function TCLDevIma2D<TCLContex_,TCLPlatfo_,TValue_>.CreateHandle :T_cl_int;
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

constructor TCLDevIma2D<TCLContex_,TCLPlatfo_,TValue_>.Create;
begin
     inherited;

     _Kind := CL_MEM_READ_WRITE or CL_MEM_ALLOC_HOST_PTR;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLHosIma2D<TCLContex_,TCLPlatfo_,TValue_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// メソッド

function TCLHosIma2D<TCLContex_,TCLPlatfo_,TValue_>.CreateHandle :T_cl_int;
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

function TCLHosIma2D<TCLContex_,TCLPlatfo_,TValue_>.DestroHandle :T_cl_int;
begin
     FreeMemAligned( _Data );

     inherited;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLHosIma2D<TCLContex_,TCLPlatfo_,TValue_>.Create;
begin
     inherited;

     _Kind := CL_MEM_READ_WRITE or CL_MEM_USE_HOST_PTR;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImagerIter2D<TCLContex_,TCLPlatfo_,TValue_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLImagerIter2D<TCLContex_,TCLPlatfo_,TValue_>.GetImager :TCLImager_;
begin
     Result := TCLImager_( Imager );
end;

//------------------------------------------------------------------------------

function TCLImagerIter2D<TCLContex_,TCLPlatfo_,TValue_>.GetValueP( const X_,Y_:Integer ) :PByte;
begin
     Result := inherited GetValueP( X_ );

     Inc( Result, _PitchY * Y_ );
end;

function TCLImagerIter2D<TCLContex_,TCLPlatfo_,TValue_>.GetValues( const X_,Y_:Integer ) :TValue_;
begin
     Result := PValue_( ValueP[ X_, Y_ ] )^;
end;

procedure TCLImagerIter2D<TCLContex_,TCLPlatfo_,TValue_>.SetValues( const X_,Y_:Integer; const Values_:TValue_ );
begin
     PValue_( ValueP[ X_, Y_ ] )^ := Values_;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

end. //######################################################################### ■
