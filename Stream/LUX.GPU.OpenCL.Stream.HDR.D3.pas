unit LUX.GPU.OpenCL.Stream.HDR.D3;

interface //#################################################################### ■

uses LUX.Color, LUX.Color.Grid.D2.Preset,
     LUX.GPU.OpenCL,
     LUX.GPU.OpenCL.Stream.HDR.D2;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TCLStream3D_HDR<TCLImager_:class> = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLStream3D_HDR<TCLImager_>

     ICLStream3D_HDR<TCLImager_:class> = interface( ICLStream2D_HDR<TCLImager_> )
     ['{519564A2-6DEB-407F-B078-5147AD141A1A}']
     {protected}
     {public}
       ///// メソッド
       procedure CopyFrom( const Z_:Integer; const Grider_:TCellColorGrid2D_TByteRGBE );
     end;

     TCLStream3D_HDR<TCLImager_:class> = class( TCLStream2D_HDR<TCLImager_>, ICLStream3D_HDR<TCLImager_> )
     private
     protected
     public
       ///// メソッド
       procedure CopyFrom( const Z_:Integer; const Grider_:TCellColorGrid2D_TByteRGBE ); overload; virtual; abstract;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLStream3DxRGBAxSFlo32_HDR

     ICLStream3DxRGBAxSFlo32_HDR = ICLStream3D_HDR<TCLImager3DxRGBAxSFlo32>;

     TCLStream3DxRGBAxSFlo32_HDR = class( TCLStream3D_HDR<TCLImager3DxRGBAxSFlo32>, ICLStream3DxRGBAxSFlo32_HDR )
     private
     protected
     public
       ///// メソッド
       procedure CopyFrom( const Z_:Integer; const Grider_:TCellColorGrid2D_TByteRGBE ); override;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses System.Threading;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLStream3D_HDR<TCLImager_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLStream3DxRGBAxSFlo32_HDR

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

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

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

end. //######################################################################### ■
