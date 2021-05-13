unit LUX.GPU.OpenCL.Argume.Memory.Imager.D1;

interface //#################################################################### ■

uses cl_version, cl_platform, cl,
     LUX,
     LUX.Code.C,
     LUX.GPU.OpenCL.core,
     LUX.GPU.OpenCL.Argume.Memory.Imager;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TCLImager1D  <TCLContex_,TCLPlatfo_:class;TValue_:record> = class;
       TCLDevIma1D<TCLContex_,TCLPlatfo_:class;TValue_:record> = class;
       TCLHosIma1D<TCLContex_,TCLPlatfo_:class;TValue_:record> = class;

     TCLImagerIter1D<TCLContex_,TCLPlatfo_:class;TValue_:record> = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImager1D<TCLContex_,TCLPlatfo_,TValue_>

     TCLImager1D<TCLContex_,TCLPlatfo_:class;TValue_:record> = class( TCLImager<TCLContex_,TCLPlatfo_,TValue_> )
     private
       type TCLStorag_ = TCLImagerIter1D<TCLContex_,TCLPlatfo_,TValue_>;
     protected
       _CountX :Integer;
       ///// アクセス
       function GetStorag :TCLStorag_; reintroduce; virtual;
       procedure SetStorag( const Storag_:TCLStorag_ ); reintroduce; virtual;
       function GetMemTyp :T_cl_mem_object_type; override;
       function GetCountX :Integer; override;
       procedure SetCountX( const CountX_:Integer ); override;
       ///// メソッド
       function NewStorag :TObject; override;
     public
       constructor Create; override;
       ///// プロパティ
       property Storag :TCLStorag_ read GetStorag write SetStorag;
       property CountX :Integer    read GetCountX write SetCountX;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDevIma1D<TCLContex_,TCLPlatfo_,TValue_>

     TCLDevIma1D<TCLContex_,TCLPlatfo_:class;TValue_:record> = class( TCLImager1D<TCLContex_,TCLPlatfo_,TValue_> )
     private
     protected
       ///// メソッド
       function CreateHandle :T_cl_int; override;
     public
       constructor Create; override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLHosIma1D<TCLContex_,TCLPlatfo_,TValue_>

     TCLHosIma1D<TCLContex_,TCLPlatfo_:class;TValue_:record> = class( TCLImager1D<TCLContex_,TCLPlatfo_,TValue_> )
     private
     protected
       _Data :P_void;
       ///// メソッド
       function CreateHandle :T_cl_int; override;
       function DestroHandle :T_cl_int; override;
     public
       constructor Create; override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImagerIter1D<TCLContex_,TCLPlatfo_,TValue_>

     TCLImagerIter1D<TCLContex_,TCLPlatfo_:class;TValue_:record> = class( TCLImagerIter<TCLContex_,TCLPlatfo_,TValue_> )
     private
       type TCLImager_ = TCLImager1D<TCLContex_,TCLPlatfo_,TValue_>;
            PValue_    = ^TValue_;
     protected
       ///// アクセス
       function GetImager :TCLImager_; reintroduce; virtual;
       function GetValueP( const X_:Integer ) :PByte;
       function GetValues( const X_:Integer ) :TValue_;
       procedure SetValues( const X_:Integer; const Values_:TValue_ );
     public
       ///// プロパティ
       property Imager                     :TCLImager_ read GetImager                ;
       property ValueP[ const X_:Integer ] :PByte      read GetValueP                ;
       property Values[ const X_:Integer ] :TValue_    read GetValues write SetValues; default;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses LUX.GPU.OpenCL;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImager1D<TCLContex_,TCLPlatfo_,TValue_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLImager1D<TCLContex_,TCLPlatfo_,TValue_>.GetStorag :TCLStorag_;
begin
     Result := TCLStorag_( inherited Storag );
end;

procedure TCLImager1D<TCLContex_,TCLPlatfo_,TValue_>.SetStorag( const Storag_:TCLStorag_ );
begin
     inherited Storag := Storag_;
end;

//------------------------------------------------------------------------------

function TCLImager1D<TCLContex_,TCLPlatfo_,TValue_>.GetMemTyp :T_cl_mem_object_type;
begin
     Result := CL_MEM_OBJECT_IMAGE1D;
end;

//------------------------------------------------------------------------------

function TCLImager1D<TCLContex_,TCLPlatfo_,TValue_>.GetCountX :Integer;
begin
     Result := _CountX;
end;

procedure TCLImager1D<TCLContex_,TCLPlatfo_,TValue_>.SetCountX( const CountX_:Integer );
begin
     inherited;

     _CountX := CountX_;
end;

/////////////////////////////////////////////////////////////////////// メソッド

function TCLImager1D<TCLContex_,TCLPlatfo_,TValue_>.NewStorag :TObject;
begin
     Result := TCLStorag_.Create( Self );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLImager1D<TCLContex_,TCLPlatfo_,TValue_>.Create;
begin
     inherited;

     _CountX := 1;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDevIma1D<TCLContex_,TCLPlatfo_,TValue_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// メソッド

function TCLDevIma1D<TCLContex_,TCLPlatfo_,TValue_>.CreateHandle :T_cl_int;
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

constructor TCLDevIma1D<TCLContex_,TCLPlatfo_,TValue_>.Create;
begin
     inherited;

     _Kind := CL_MEM_READ_WRITE or CL_MEM_ALLOC_HOST_PTR;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLHosIma1D<TCLContex_,TCLPlatfo_,TValue_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// メソッド

function TCLHosIma1D<TCLContex_,TCLPlatfo_,TValue_>.CreateHandle :T_cl_int;
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

function TCLHosIma1D<TCLContex_,TCLPlatfo_,TValue_>.DestroHandle :T_cl_int;
begin
     FreeMemAligned( _Data );

     inherited;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLHosIma1D<TCLContex_,TCLPlatfo_,TValue_>.Create;
begin
     inherited;

     _Kind := CL_MEM_READ_WRITE or CL_MEM_USE_HOST_PTR;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImagerIter1D<TCLContex_,TCLPlatfo_,TValue_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLImagerIter1D<TCLContex_,TCLPlatfo_,TValue_>.GetImager :TCLImager_;
begin
     Result := TCLImager_( Imager );
end;

//------------------------------------------------------------------------------

function TCLImagerIter1D<TCLContex_,TCLPlatfo_,TValue_>.GetValueP( const X_:Integer ) :PByte;
begin
     Result := inherited GetValueP;

     Inc( Result, _PitchX * X_ );
end;

function TCLImagerIter1D<TCLContex_,TCLPlatfo_,TValue_>.GetValues( const X_:Integer ) :TValue_;
begin
     Result := PValue_( ValueP[ X_ ] )^;
end;

procedure TCLImagerIter1D<TCLContex_,TCLPlatfo_,TValue_>.SetValues( const X_:Integer; const Values_:TValue_ );
begin
     PValue_( ValueP[ X_ ] )^ := Values_;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

end. //######################################################################### ■
