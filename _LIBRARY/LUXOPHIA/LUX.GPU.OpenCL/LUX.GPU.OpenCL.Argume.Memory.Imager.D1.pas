unit LUX.GPU.OpenCL.Argume.Memory.Imager.D1;

interface //#################################################################### ■

uses cl_version, cl_platform, cl,
     LUX,
     LUX.Code.C,
     LUX.GPU.OpenCL.core,
     LUX.GPU.OpenCL.Argume.Memory.Imager;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TCLImager1D<TCLSystem_,TCLPlatfo_,TCLContex_:class;TValue_:record> = class;

     TCLImagerIter1D<TCLSystem_,TCLPlatfo_,TCLContex_:class;TValue_:record> = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImager1D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>

     TCLImager1D<TCLSystem_,TCLPlatfo_,TCLContex_:class;TValue_:record> = class( TCLImager<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_> )
     private
       type TCLData_ = TCLImagerIter1D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>;
     protected
       _CountX :Integer;
       ///// アクセス
       function GetData :TCLData_; reintroduce; virtual;
       procedure SetData( const Data_:TCLData_ ); reintroduce; virtual;
       function GetMemTyp :T_cl_mem_object_type; override;
       function GetCountX :Integer; override;
       procedure SetCountX( const CountX_:Integer ); override;
       ///// メソッド
       function NewData :TObject; override;
     public
       constructor Create; override;
       ///// プロパティ
       property Data   :TCLData_ read GetData   write SetData  ;
       property CountX :Integer  read GetCountX write SetCountX;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImagerIter1D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>

     TCLImagerIter1D<TCLSystem_,TCLPlatfo_,TCLContex_:class;TValue_:record> = class( TCLImagerIter<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_> )
     private
       type TCLImager_ = TCLImager1D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>;
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

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImager1D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLImager1D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.GetData :TCLData_;
begin
     Result := TCLData_( inherited Data );
end;

procedure TCLImager1D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.SetData( const Data_:TCLData_ );
begin
     inherited Data := Data_;
end;

//------------------------------------------------------------------------------

function TCLImager1D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.GetMemTyp :T_cl_mem_object_type;
begin
     Result := CL_MEM_OBJECT_IMAGE1D;
end;

//------------------------------------------------------------------------------

function TCLImager1D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.GetCountX :Integer;
begin
     Result := _CountX;
end;

procedure TCLImager1D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.SetCountX( const CountX_:Integer );
begin
     inherited;

     _CountX := CountX_;
end;

/////////////////////////////////////////////////////////////////////// メソッド

function TCLImager1D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.NewData :TObject;
begin
     Result := TCLData_.Create( Self );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLImager1D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.Create;
begin
     inherited;

     _CountX := 1;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImagerIter1D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLImagerIter1D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.GetImager :TCLImager_;
begin
     Result := TCLImager_( Imager );
end;

//------------------------------------------------------------------------------

function TCLImagerIter1D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.GetValueP( const X_:Integer ) :PByte;
begin
     Result := inherited GetValueP;

     Inc( Result, _PitchX * X_ );
end;

function TCLImagerIter1D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.GetValues( const X_:Integer ) :TValue_;
begin
     Result := PValue_( ValueP[ X_ ] )^;
end;

procedure TCLImagerIter1D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.SetValues( const X_:Integer; const Values_:TValue_ );
begin
     PValue_( ValueP[ X_ ] )^ := Values_;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

end. //######################################################################### ■
