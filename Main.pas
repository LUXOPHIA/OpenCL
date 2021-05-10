unit Main;

interface //#################################################################### ■

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Objects, FMX.Memo.Types, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, FMX.TabControl,
  cl_version, cl_platform, cl,
  LUX,
  LUX.Complex,
  LUX.GPU.OpenCL,
  LUX.GPU.OpenCL.FMX;

type
  TForm1 = class(TForm)
    TabControl1: TTabControl;
      TabItemS: TTabItem;
        MemoS: TMemo;
      TabItemP: TTabItem;
        TabControlP: TTabControl;
          TabItemC: TTabItem;
            MemoC: TMemo;
          TabItemL: TTabItem;
            MemoL: TMemo;
      TabItemR: TTabItem;
        Image1: TImage;
    Timer1: TTimer;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Image1MouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
  private
    { private 宣言 }
    _AreaC :TDoubleAreaC;
  public
    { public 宣言 }
    _Platfo :TCLPlatfo;
    _Device :TCLDevice;
    _Contex :TCLContex;
    _Queuer :TCLQueuer;
    _Buffer :TCLDevBuf<Double>;
    _Imager :TCLDevImaRGBA;
    _Progra :TCLProgra;
    _Deploy :TCLDeploy;
    _Kernel :TCLKernel;
    ///// メソッド
    function ShowDeploys :Boolean;
  end;

var
  Form1: TForm1;

implementation //############################################################### ■

{$R *.fmx}

uses System.Math;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

function TForm1.ShowDeploys :Boolean;
var
   L :TCLDeploy;
begin
     Result := True;

     for L in _Progra.Deploys do
     begin
          if L.State <> CL_BUILD_SUCCESS then
          begin
               Result := False;

               with MemoL.Lines do
               begin
                    Add( '▼ Platfo[' + L.Device.Platfo.Order.ToString + ']'
                         + '.Device[' + L.Device       .Order.ToString + ']' );
                    Add( L.Log );
                    Add( '' );
               end;
          end;
     end;

     if not Result then
     begin
          TabControl1.ActiveTab := TabItemP;
          TabControlP.ActiveTab := TabItemL;
     end;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

procedure TForm1.FormCreate(Sender: TObject);
begin
     ///// プラットフォーム
     _Platfo := TOpenCL.Platfos[ 0 ];                                           // 選択

     ///// デバイス
     _Device := _Platfo.Devices[ 0 ];                                           // 選択

     ///// コンテキスト
   { _Contex := TCLContex.Create( _Platfo ); }
     _Contex := _Platfo.Contexs.Add;                                            // 生成

     ///// コマンドキュー
   { _Queuer := TCLQueuer.Create( _Contex, _Device ); }
     _Queuer := _Contex.Queuers.Add( _Device );                                 // 生成

     ///// バッファー
     _Buffer := TCLDevBuf<Double>.Create( _Contex, _Queuer );                   // 生成
     _Buffer.Count := 4;                                                        // 要素数の設定

     _AreaC := TDoubleAreaC.Create( -2, -2, +2, +2 );

     _Buffer.Storag.Map;                                                        // マップ
     _Buffer.Storag[ 0 ] := _AreaC.Min.R;                                       // 書き込み
     _Buffer.Storag[ 1 ] := _AreaC.Min.I;                                       // 書き込み
     _Buffer.Storag[ 2 ] := _AreaC.Max.R;                                       // 書き込み
     _Buffer.Storag[ 3 ] := _AreaC.Max.I;                                       // 書き込み
     _Buffer.Storag.Unmap;                                                      // アンマップ

     ///// イメージ
     _Imager := TCLDevImaRGBA.Create( _Contex, _Queuer );                       // 生成
     _Imager.CountX := 500;                                                     // ピクセル数の設定
     _Imager.CountY := 500;                                                     // ピクセル数の設定

     ///// プログラム
   { _Progra := TCLProgra.Create( _Contex ); }
     _Progra := _Contex.Progras.Add;                                            // 生成
     _Progra.Source.LoadFromFile( '..\..\_DATA\Source.cl' );                    // ソースコードのロード

     MemoC.Lines.Assign( _Progra.Source );                                      // ソースコードの表示

     ///// ビルド
   { _Deploy := _Progra.Deploys.Add( _Device ); }
     _Deploy := _Progra.BuildTo( _Device );                                     // 生成

     if ShowDeploys then                                                        // ビルド情報の表示
     begin
          ///// カーネル
        { _Kernel := TCLKernel.Create( _Progra, 'Main', _Queuer ); }
          _Kernel := _Progra.Kernels.Add( 'Main', _Queuer );                    // 生成
          _Kernel.Argumes['Buffer'] := _Buffer;                                 // バッファの接続
          _Kernel.Argumes['Imager'] := _Imager;                                 // イメージの接続
          _Kernel.GlobWorkSize := [ _Imager.CountX, _Imager.CountY ];           // ループ回数の設定

          if _Kernel.Argumes.BindsOK then Timer1.Enabled := True                // 描画ループ開始
                                     else TabControl1.ActiveTab := TabItemS;    // 引数のバインドエラー
     end;

     TOpenCL.Show( MemoS.Lines );                                               // システム情報の表示
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
     MemoS.Lines.SaveToFile( 'System.txt', TEncoding.UTF8 );

     Image1.Bitmap.SaveToFile( 'Imager.png' )
end;

////////////////////////////////////////////////////////////////////////////////

procedure TForm1.Timer1Timer(Sender: TObject);
begin
     ///// カーネル
     _Kernel.Run;                                                               // 実行

     ///// イメージ
     _Imager.CopyTo( Image1.Bitmap );                                           // 画像表示
end;

procedure TForm1.Image1MouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
var
   P :TPointF;
   C :TDoubleC;
   S :Double;
begin
     P := Image1.AbsoluteToLocal( ScreenToClient( Screen.MousePos ) );

     C.R := _AreaC.Min.R + _AreaC.SizeR * P.X / Image1.Width ;
     C.I := _AreaC.Max.I - _AreaC.SizeI * P.Y / Image1.Height;

     S := Power( 1.1, WheelDelta / 120 );

     _AreaC.Min := ( _AreaC.Min - C ) * S + C;
     _AreaC.Max := ( _AreaC.Max - C ) * S + C;

     ///// バッファー
     _Buffer.Storag.Map;                                                        // マップ
     _Buffer.Storag[ 0 ] := _AreaC.Min.R;                                       // 書き込み
     _Buffer.Storag[ 1 ] := _AreaC.Min.I;                                       // 書き込み
     _Buffer.Storag[ 2 ] := _AreaC.Max.R;                                       // 書き込み
     _Buffer.Storag[ 3 ] := _AreaC.Max.I;                                       // 書き込み
     _Buffer.Storag.Unmap;                                                      // アンマップ
end;

end. //######################################################################### ■
