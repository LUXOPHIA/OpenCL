unit LUX.GPU.OpenCL.Argume.Memory.Imager.D3;

interface //#################################################################### ■

uses cl_version, cl_platform, cl,
     LUX,
     LUX.Code.C,
     LUX.GPU.OpenCL.core,
     LUX.GPU.OpenCL.Argume.Memory.Imager.D2;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TCLImager3D<TCLContex_,TCLPlatfo_:class;TValue_:record> = class;

     TCLImagerIter3D<TCLContex_,TCLPlatfo_:class;TValue_:record> = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImager3D<TCLContex_,TCLPlatfo_,TValue_>

     TCLImager3D<TCLContex_,TCLPlatfo_:class;TValue_:record> = class( TCLImager2D<TCLContex_,TCLPlatfo_,TValue_> )
     private
       type TCLStorag_ = TCLImagerIter3D<TCLContex_,TCLPlatfo_,TValue_>;
     protected
       _CountZ :Integer;
       ///// アクセス
       function GetStorag :TCLStorag_; reintroduce; virtual;
       procedure SetStorag( const Storag_:TCLStorag_ ); reintroduce; virtual;
       function GetMemTyp :T_cl_mem_object_type; override;
       function GetCountZ :Integer; override;
       procedure SetCountZ( const CountZ_:Integer ); override;
       ///// メソッド
       function NewStorag :TObject; override;
     public
       constructor Create; override;
       ///// プロパティ
       property Storag :TCLStorag_ read GetStorag write SetStorag;
       property CountZ :Integer    read GetCountZ write SetCountZ;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImagerIter3D<TCLContex_,TCLPlatfo_,TValue_>

     TCLImagerIter3D<TCLContex_,TCLPlatfo_:class;TValue_:record> = class( TCLImagerIter2D<TCLContex_,TCLPlatfo_,TValue_> )
     private
       type TCLImager_ = TCLImager3D<TCLContex_,TCLPlatfo_,TValue_>;
            PValue_    = ^TValue_;
     protected
       ///// アクセス
       function GetImager :TCLImager_; reintroduce; virtual;
       function GetValueP( const X_,Y_,Z_:Integer ) :PByte;
       function GetValues( const X_,Y_,Z_:Integer ) :TValue_;
       procedure SetValues( const X_,Y_,Z_:Integer; const Values_:TValue_ );
     public
       ///// プロパティ
       property Imager                           :TCLImager_ read GetImager                ;
       property ValueP[ const X_,Y_,Z_:Integer ] :PByte      read GetValueP                ;
       property Values[ const X_,Y_,Z_:Integer ] :TValue_    read GetValues write SetValues; default;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses LUX.GPU.OpenCL;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImager3D<TCLContex_,TCLPlatfo_,TValue_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLImager3D<TCLContex_,TCLPlatfo_,TValue_>.GetStorag :TCLStorag_;
begin
     Result := TCLStorag_( inherited Storag );
end;

procedure TCLImager3D<TCLContex_,TCLPlatfo_,TValue_>.SetStorag( const Storag_:TCLStorag_ );
begin
     inherited Storag := Storag_;
end;

//------------------------------------------------------------------------------

function TCLImager3D<TCLContex_,TCLPlatfo_,TValue_>.GetMemTyp :T_cl_mem_object_type;
begin
     Result := CL_MEM_OBJECT_IMAGE3D;
end;

//------------------------------------------------------------------------------

function TCLImager3D<TCLContex_,TCLPlatfo_,TValue_>.GetCountZ :Integer;
begin
     Result := _CountZ;
end;

procedure TCLImager3D<TCLContex_,TCLPlatfo_,TValue_>.SetCountZ( const CountZ_:Integer );
begin
     inherited;

     _CountZ := CountZ_;
end;

/////////////////////////////////////////////////////////////////////// メソッド

function TCLImager3D<TCLContex_,TCLPlatfo_,TValue_>.NewStorag :TObject;
begin
     Result := TCLStorag_.Create( Self );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLImager3D<TCLContex_,TCLPlatfo_,TValue_>.Create;
begin
     inherited;

     _CountZ := 1;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImagerIter3D<TCLContex_,TCLPlatfo_,TValue_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLImagerIter3D<TCLContex_,TCLPlatfo_,TValue_>.GetImager :TCLImager_;
begin
     Result := TCLImager_( Imager );
end;

//------------------------------------------------------------------------------

function TCLImagerIter3D<TCLContex_,TCLPlatfo_,TValue_>.GetValueP( const X_,Y_,Z_:Integer ) :PByte;
begin
     Result := inherited GetValueP( X_, Y_ );

     Inc( Result, _PitchZ * Z_ );
end;

function TCLImagerIter3D<TCLContex_,TCLPlatfo_,TValue_>.GetValues( const X_,Y_,Z_:Integer ) :TValue_;
begin
     Result := PValue_( ValueP[ X_, Y_, Z_ ] )^;
end;

procedure TCLImagerIter3D<TCLContex_,TCLPlatfo_,TValue_>.SetValues( const X_,Y_,Z_:Integer; const Values_:TValue_ );
begin
     PValue_( ValueP[ X_, Y_, Z_ ] )^ := Values_;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

end. //######################################################################### ■
