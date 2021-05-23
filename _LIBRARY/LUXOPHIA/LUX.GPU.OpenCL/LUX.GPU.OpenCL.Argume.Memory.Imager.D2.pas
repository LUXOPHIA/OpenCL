﻿unit LUX.GPU.OpenCL.Argume.Memory.Imager.D2;

interface //#################################################################### ■

uses cl_version, cl_platform, cl,
     LUX,
     LUX.Code.C,
     LUX.GPU.OpenCL.core,
     LUX.GPU.OpenCL.Argume.Memory.Imager.D1;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TCLImager2D<TCLSystem_,TCLPlatfo_,TCLContex_:class;TValue_:record> = class;

     TCLImagerIter2D<TCLSystem_,TCLPlatfo_,TCLContex_:class;TValue_:record> = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImager2D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>

     TCLImager2D<TCLSystem_,TCLPlatfo_,TCLContex_:class;TValue_:record> = class( TCLImager1D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_> )
     private
       type TCLData_ = TCLImagerIter2D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>;
     protected
       _CountY :Integer;
       ///// アクセス
       function GetData :TCLData_; reintroduce; virtual;
       procedure SetData( const Data_:TCLData_ ); reintroduce; virtual;
       function GetMemTyp :T_cl_mem_object_type; override;
       function GetCountY :Integer; override;
       procedure SetCountY( const CountY_:Integer ); override;
       ///// メソッド
       function NewData :TObject; override;
     public
       constructor Create; override;
       ///// プロパティ
       property Data   :TCLData_ read GetData   write SetData  ;
       property CountY :Integer  read GetCountY write SetCountY;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImagerIter2D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>

     TCLImagerIter2D<TCLSystem_,TCLPlatfo_,TCLContex_:class;TValue_:record> = class( TCLImagerIter1D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_> )
     private
       type TCLImager_ = TCLImager2D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>;
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

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImager2D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLImager2D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.GetData :TCLData_;
begin
     Result := TCLData_( inherited Data );
end;

procedure TCLImager2D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.SetData( const Data_:TCLData_ );
begin
     inherited Data := Data_;
end;

//------------------------------------------------------------------------------

function TCLImager2D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.GetMemTyp :T_cl_mem_object_type;
begin
     Result := CL_MEM_OBJECT_IMAGE2D;
end;

//------------------------------------------------------------------------------

function TCLImager2D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.GetCountY :Integer;
begin
     Result := _CountY;
end;

procedure TCLImager2D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.SetCountY( const CountY_:Integer );
begin
     inherited;

     _CountY := CountY_;
end;

/////////////////////////////////////////////////////////////////////// メソッド

function TCLImager2D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.NewData :TObject;
begin
     Result := TCLData_.Create( Self );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLImager2D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.Create;
begin
     inherited;

     _CountY := 1;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLImagerIter2D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLImagerIter2D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.GetImager :TCLImager_;
begin
     Result := TCLImager_( Imager );
end;

//------------------------------------------------------------------------------

function TCLImagerIter2D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.GetValueP( const X_,Y_:Integer ) :PByte;
begin
     Result := inherited GetValueP( X_ );

     Inc( Result, _PitchY * Y_ );
end;

function TCLImagerIter2D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.GetValues( const X_,Y_:Integer ) :TValue_;
begin
     Result := PValue_( ValueP[ X_, Y_ ] )^;
end;

procedure TCLImagerIter2D<TCLSystem_,TCLPlatfo_,TCLContex_,TValue_>.SetValues( const X_,Y_:Integer; const Values_:TValue_ );
begin
     PValue_( ValueP[ X_, Y_ ] )^ := Values_;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

end. //######################################################################### ■
