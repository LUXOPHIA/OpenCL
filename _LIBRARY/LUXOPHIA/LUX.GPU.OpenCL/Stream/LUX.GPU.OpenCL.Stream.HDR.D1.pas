unit LUX.GPU.OpenCL.Stream.HDR.D1;

interface //#################################################################### ■

uses LUX.Color, LUX.Color.Grid.D2.Preset,
     LUX.GPU.OpenCL;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 T Y P E 】

     TCLStream1D_HDR<TCLImager_:class> = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R E C O R D 】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C L A S S 】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLStream1D_HDR<TCLImager_>

     ICLStream1D_HDR<TCLImager_:class> = interface
     ['{BE5886F8-7F3C-4460-829B-9756F3808B6E}']
     {protected}
       function GetImage :TCLImager_;
       procedure SetImage( const Imager_:TCLImager_ );
     {public}
       ///// P R O P E R T Y
       property Imager :TCLImager_ read GetImage write SetImage;
       ///// M E T H O D
       procedure CopyFrom( const Grid_:TCellColorGrid2D_TByteRGBE );
       procedure LoadFromFile( const FileName_:String );
     end;

     TCLStream1D_HDR<TCLImager_:class> = class( TInterfacedObject, ICLStream1D_HDR<TCLImager_> )
     private
     protected
       _Imager :TCLImager_;
       ///// A C C E S S O R
       function GetImage :TCLImager_;
       procedure SetImage( const Imager_:TCLImager_ );
     public
       constructor Create; overload;
       constructor Create( const Imager_:TCLImager_ ); overload;
       ///// P R O P E R T Y
       property Imager :TCLImager_ read GetImage write SetImage;
       ///// M E T H O D
       procedure CopyFrom( const Grid_:TCellColorGrid2D_TByteRGBE ); overload; virtual; abstract;
       procedure LoadFromFile( const FileName_:String ); virtual; abstract;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C O N S T A N T 】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 V A R I A B L E 】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

implementation //############################################################### ■

uses LUX.Color.Format.HDR;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R E C O R D 】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C L A S S 】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLStream1D_HDR<TCLImager_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//////////////////////////////////////////////////////////////// A C C E S S O R

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

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

end. //######################################################################### ■
