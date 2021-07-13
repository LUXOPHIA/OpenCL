unit LUX.GPU.OpenCL.Stream.HDR.D2;

interface //#################################################################### ■

uses LUX.Color, LUX.Color.Grid.D2.Preset,
     LUX.GPU.OpenCL,
     LUX.GPU.OpenCL.Stream.HDR.D1;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TCLStream2D_HDR<TCLImager_:class> = class;
       TCLStream2DxRGBAxSFlo32_HDR     = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLStream2D_HDR<TCLImager_>

     ICLStream2D_HDR<TCLImager_:class> = interface( ICLStream1D_HDR<TCLImager_> )
     ['{781EDB64-7387-46F8-B6DD-BF3AC19678D9}']
     {protected}
     {public}
     end;

     TCLStream2D_HDR<TCLImager_:class> = class( TCLStream1D_HDR<TCLImager_>, ICLStream2D_HDR<TCLImager_> )
     private
     protected
     public
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLStream2DxRGBAxSFlo32_HDR

     ICLStream2DxRGBAxSFlo32_HDR = ICLStream2D_HDR<TCLImager2DxRGBAxSFlo32>;

     TCLStream2DxRGBAxSFlo32_HDR = class( TCLStream2D_HDR<TCLImager2DxRGBAxSFlo32>, ICLStream2DxRGBAxSFlo32_HDR )
     private
     protected
     public
       ///// メソッド
       procedure CopyFrom( const Grid_:TCellColorGrid2D_TByteRGBE ); override;
       procedure LoadFromFile( const FileName_:String ); override;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses System.Threading,
     LUX.Color.Format.HDR;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLStream2D_HDR<TCLImager_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLStream2DxRGBAxSFlo32_HDR

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLStream2DxRGBAxSFlo32_HDR.CopyFrom( const Grid_:TCellColorGrid2D_TByteRGBE );
begin
     with _Imager do
     begin
          CountX := Grid_.CellsX;
          CountY := Grid_.CellsY;

          Data.Map;

          TParallel.For( 0, CountY-1, procedure( Y:Integer )
          var
             X :Integer;
          begin
               for X := 0 to CountX-1 do
               begin
                    Data[ X, Y ] := TSingleRGBA( TSingleRGB( Grid_[ X, Y ] ) );
               end;
          end );

          Data.Unmap;
     end;
end;

procedure TCLStream2DxRGBAxSFlo32_HDR.LoadFromFile( const FileName_:String );
var
   F :TFileHDR;
begin
     with _Imager do
     begin
          F := TFileHDR.Create;
          F.LoadFromFile( FileName_ );

          CopyFrom( F.Grid );

          F.Free;
     end;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

end. //######################################################################### ■
