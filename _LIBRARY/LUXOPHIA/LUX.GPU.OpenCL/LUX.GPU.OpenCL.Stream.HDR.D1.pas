unit LUX.GPU.OpenCL.Stream.HDR.D1;

interface //#################################################################### ■

uses LUX.Color, LUX.Color.Grid.D2.Preset,
     LUX.GPU.OpenCL;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TCLStream1D_HDR<TCLImager_:class> = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLStream1D_HDR<TCLImager_>

     ICLStream1D_HDR<TCLImager_:class> = interface
     ['{BE5886F8-7F3C-4460-829B-9756F3808B6E}']
     {protected}
       function GetImage :TCLImager_;
       procedure SetImage( const Imager_:TCLImager_ );
     {public}
       ///// プロパティ
       property Imager :TCLImager_ read GetImage write SetImage;
       ///// メソッド
       procedure CopyFrom( const Grid_:TCellColorGrid2D_TByteRGBE );
       procedure LoadFromFile( const FileName_:String );
     end;

     TCLStream1D_HDR<TCLImager_:class> = class( TInterfacedObject, ICLStream1D_HDR<TCLImager_> )
     private
     protected
       _Imager :TCLImager_;
       ///// アクセス
       function GetImage :TCLImager_;
       procedure SetImage( const Imager_:TCLImager_ );
     public
       constructor Create; overload;
       constructor Create( const Imager_:TCLImager_ ); overload;
       ///// プロパティ
       property Imager :TCLImager_ read GetImage write SetImage;
       ///// メソッド
       procedure CopyFrom( const Grid_:TCellColorGrid2D_TByteRGBE ); overload; virtual; abstract;
       procedure LoadFromFile( const FileName_:String ); virtual; abstract;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses LUX.Color.Format.HDR;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLStream1D_HDR<TCLImager_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLStream1D_HDR<TCLImager_>.GetImage :TCLImager_;
begin
     Result := _Imager;
end;

procedure TCLStream1D_HDR<TCLImager_>.SetImage( const Imager_:TCLImager_ );
begin
     _Imager := Imager_;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLStream1D_HDR<TCLImager_>.Create;
begin
     inherited;

end;

constructor TCLStream1D_HDR<TCLImager_>.Create( const Imager_:TCLImager_ );
begin
     Create;

     Imager := Imager_;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

end. //######################################################################### ■
