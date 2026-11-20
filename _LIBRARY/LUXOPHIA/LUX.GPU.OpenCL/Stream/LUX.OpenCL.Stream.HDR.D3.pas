unit LUX.OpenCL.Stream.HDR.D3;

interface //#################################################################### ■

uses LUX.Color, LUX.Color.Grid.D2.Preset,
     LUX.OpenCL,
     LUX.OpenCL.Stream.HDR.D2;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 T Y P E 】

     TCLStream3D_HDR<TCLImager_:class> = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R E C O R D 】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C L A S S 】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLStream3D_HDR<TCLImager_>

     ICLStream3D_HDR<TCLImager_:class> = interface( ICLStream2D_HDR<TCLImager_> )
     ['{519564A2-6DEB-407F-B078-5147AD141A1A}']
     {protected}
     {public}
       ///// M E T H O D
       procedure CopyFrom( const Z_:Integer; const Grider_:TCellColorGrid2D_TByteRGBE );
     end;

     TCLStream3D_HDR<TCLImager_:class> = class( TCLStream2D_HDR<TCLImager_>, ICLStream3D_HDR<TCLImager_> )
     private
     protected
     public
       ///// M E T H O D
       procedure CopyFrom( const Z_:Integer; const Grider_:TCellColorGrid2D_TByteRGBE ); overload; virtual; abstract;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLStream3DxRGBAxSFlo32_HDR

     ICLStream3DxRGBAxSFlo32_HDR = ICLStream3D_HDR<TCLImager3DxRGBAxSFlo32>;

     TCLStream3DxRGBAxSFlo32_HDR = class( TCLStream3D_HDR<TCLImager3DxRGBAxSFlo32>, ICLStream3DxRGBAxSFlo32_HDR )
     private
     protected
     public
       ///// M E T H O D
       procedure CopyFrom( const Z_:Integer; const Grider_:TCellColorGrid2D_TByteRGBE ); override;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C O N S T A N T 】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 V A R I A B L E 】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

implementation //############################################################### ■

uses System.Threading;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R E C O R D 】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C L A S S 】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLStream3D_HDR<TCLImager_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLStream3DxRGBAxSFlo32_HDR

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//////////////////////////////////////////////////////////////////// M E T H O D

procedure TCLStream3DxRGBAxSFlo32_HDR.CopyFrom( const Z_:Integer; const Grider_:TCellColorGrid2D_TByteRGBE );
begin
     with _Imager do
     begin
          CountX := Grider_.CellsX;
          CountY := Grider_.CellsY;

          Data.Map;

          TParallel.For( 0, CountY-1, procedure( Y:Integer )
          var
             X :Integer;
          begin
               for X := 0 to CountX-1 do
               begin
                    Data[ X, Y, Z_ ] := TSingleRGBA( TSingleRGB( Grider_[ X, Y ] ) );
               end;
          end );

          Data.Unmap;
     end;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

end. //######################################################################### ■
