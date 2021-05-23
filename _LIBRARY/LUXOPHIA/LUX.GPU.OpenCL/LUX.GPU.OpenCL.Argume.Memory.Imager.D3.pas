unit LUX.GPU.OpenCL.Argume.Memory.Imager.D3;

interface //#################################################################### ■

uses cl_version, cl_platform, cl,
     LUX,
     LUX.Code.C,
     LUX.GPU.OpenCL.core,
     LUX.GPU.OpenCL.Argume.Memory.Imager.D2;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TCLImager3D<TCLSystem_,TCLPlatfo_,TCLContex_:class;TValue_:record> = class;

     TCLImaDat3D<TCLSystem_,TCLPlatfo_,TCLContex_:class;TValue_:record> = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImager3D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>

     TCLImager3D<TCLSystem_,TCLPlatfo_,TCLContex_:class;TValue_:record> = class( TCLImager2D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_> )
     private
       type TCLImaDat_ = TCLImaDat3D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>;
     protected
       _CountZ :Integer;
       ///// アクセス
       function GetData :TCLImaDat_; reintroduce; virtual;
       procedure SetData( const Data_:TCLImaDat_ ); reintroduce; virtual;
       function GetMemTyp :T_cl_mem_object_type; override;
       function GetCountZ :Integer; override;
       procedure SetCountZ( const CountZ_:Integer ); override;
       ///// メソッド
       function NewData :TObject; override;
     public
       constructor Create; override;
       ///// プロパティ
       property Data   :TCLImaDat_ read GetData   write SetData  ;
       property CountZ :Integer    read GetCountZ write SetCountZ;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImaDat3D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>

     TCLImaDat3D<TCLSystem_,TCLPlatfo_,TCLContex_:class;TValue_:record> = class( TCLImaDat2D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_> )
     private
       type TCLImager_ = TCLImager3D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>;
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

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImager3D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLImager3D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.GetData :TCLImaDat_;
begin
     Result := TCLImaDat_( inherited Data );
end;

procedure TCLImager3D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.SetData( const Data_:TCLImaDat_ );
begin
     inherited Data := Data_;
end;

//------------------------------------------------------------------------------

function TCLImager3D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.GetMemTyp :T_cl_mem_object_type;
begin
     Result := CL_MEM_OBJECT_IMAGE3D;
end;

//------------------------------------------------------------------------------

function TCLImager3D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.GetCountZ :Integer;
begin
     Result := _CountZ;
end;

procedure TCLImager3D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.SetCountZ( const CountZ_:Integer );
begin
     inherited;

     _CountZ := CountZ_;
end;

/////////////////////////////////////////////////////////////////////// メソッド

function TCLImager3D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.NewData :TObject;
begin
     Result := TCLImaDat_.Create( Self );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLImager3D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.Create;
begin
     inherited;

     _CountZ := 1;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImaDat3D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLImaDat3D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.GetImager :TCLImager_;
begin
     Result := TCLImager_( Imager );
end;

//------------------------------------------------------------------------------

function TCLImaDat3D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.GetValueP( const X_,Y_,Z_:Integer ) :PByte;
begin
     Result := inherited GetValueP( X_, Y_ );

     Inc( Result, _PitchZ * Z_ );
end;

function TCLImaDat3D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.GetValues( const X_,Y_,Z_:Integer ) :TValue_;
begin
     Result := PValue_( ValueP[ X_, Y_, Z_ ] )^;
end;

procedure TCLImaDat3D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.SetValues( const X_,Y_,Z_:Integer; const Values_:TValue_ );
begin
     PValue_( ValueP[ X_, Y_, Z_ ] )^ := Values_;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

end. //######################################################################### ■
