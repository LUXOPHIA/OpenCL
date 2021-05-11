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
          TabItemPL: TTabItem;
            MemoPL: TMemo;
          TabItemPE: TTabItem;
            MemoPE: TMemo;
          TabItemPB: TTabItem;
            MemoPB: TMemo;
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
    _Buffer :TCLDevBuf<TDoubleC>;
    _Imager :TCLDevImaBGRAxUInt8;
    _Librar :TCLLibrar;
    _Execut :TCLExecut;
    _Buildr :TCLBuildr;
    _Kernel :TCLKernel;
    ///// メソッド
    function ShowBuildrs :Boolean;
  end;

var
  Form1: TForm1;

implementation //############################################################### ■

{$R *.fmx}

uses System.Math;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

function TForm1.ShowBuildrs :Boolean;
var
   B :TCLBuildr;
begin
     Result := True;

     for B in _Execut.Buildrs do
     begin
          if ( B.CompileStatus <> CL_BUILD_SUCCESS ) or
             ( B.   LinkStatus <> CL_BUILD_SUCCESS ) then
          begin
               Result := False;

               with MemoPB.Lines do
               begin
                    Add( '▼ Platfo[' + B.Device.Platfo.Order.ToString + ']'
                         + '.Device[' + B.Device       .Order.ToString + ']' );
                    Add( '▽ Compile' );
                    Add( B.CompileLog );
                    Add( '▽ Link' );
                    Add( B.LinkLog );
                    Add( '' );
               end;
          end;
     end;

     if not Result then
     begin
          TabControl1.ActiveTab := TabItemP;
          TabControlP.ActiveTab := TabItemPB;
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
     _Buffer := TCLDevBuf<TDoubleC>.Create( _Contex, _Queuer );                 // 生成
     _Buffer.Count := 2;                                                        // 要素数の設定

     _AreaC := TDoubleAreaC.Create( -2, -2, +2, +2 );

     _Buffer.Storag.Map;                                                        // マップ
     _Buffer.Storag[ 0 ] := _AreaC.Min;                                         // 書き込み
     _Buffer.Storag[ 1 ] := _AreaC.Max;                                         // 書き込み
     _Buffer.Storag.Unmap;                                                      // アンマップ

     ///// イメージ
     _Imager := TCLDevImaBGRAxUInt8.Create( _Contex, _Queuer );                 // 生成
     _Imager.CountX := 500;                                                     // ピクセル数の設定
     _Imager.CountY := 500;                                                     // ピクセル数の設定

     ////////// プログラム

     ///// ライブラリ
   { _Librar := TCLLibrar.Create( _Contex ); }
     _Librar := _Contex.Librars.Add;                                            // 生成
     _Librar.Source.LoadFromFile( '..\..\_DATA\Librar.cl' );                    // ソースコードのロード

     MemoPL.Lines.Assign( _Librar.Source );                                     // ソースコードの表示

     ///// 実行形式
   { _Execut := TCLExecut.Create( _Contex ); }
     _Execut := _Contex.Executs.Add;                                            // 生成
     _Execut.Source.LoadFromFile( '..\..\_DATA\Execut.cl' );                    // ソースコードのロード

     MemoPE.Lines.Assign( _Execut.Source );                                     // ソースコードの表示

     ///// ビルド
   { _Buildr := _Execut.Buildrs.Add( _Device ); }
     _Buildr := _Execut.BuildTo( _Device );                                     // 生成

     if ShowBuildrs then                                                        // ビルド情報の表示
     begin
          ///// カーネル
        { _Kernel := TCLKernel.Create( _Execut, 'Main', _Queuer ); }
          _Kernel := _Execut.Kernels.Add( 'Main', _Queuer );                    // 生成
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
     _Buffer.Storag[ 0 ] := _AreaC.Min;                                         // 書き込み
     _Buffer.Storag[ 1 ] := _AreaC.Max;                                         // 書き込み
     _Buffer.Storag.Unmap;                                                      // アンマップ
end;

end. //######################################################################### ■
