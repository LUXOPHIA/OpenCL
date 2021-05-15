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
        ImageR: TImage;
    ImageT: TImage;
    Timer1: TTimer;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ImageRMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
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
    _Imager :TCLDevIma2DxBGRAxUFix8;
    _Textur :TCLDevIma1DxBGRAxUFix8;
    _Samplr :TCLSamplr;
    _Librar :TCLLibrar;
    _Execut :TCLExecut;
    _Buildr :TCLBuildr;
    _Kernel :TCLKernel;
    ///// メソッド
    procedure MakeContex;
    procedure MakeArgumes;
    procedure MakeProgras;
    procedure ShowBuildr;
  end;

var
  Form1: TForm1;

implementation //############################################################### ■

{$R *.fmx}

uses System.Math;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TForm1.MakeContex;
begin
     ////////// プラットフォーム

     _Platfo := TOpenCL.Platfos[ 0 ];                                           // 選択

     ////////// デバイス

     _Device := _Platfo.Devices[ 0 ];                                           // 選択

     ////////// コンテキスト

   { _Contex := TCLContex.Create( _Platfo ); }                                  // 生成
     _Contex := _Platfo.Contexs.Add;                                            // 生成

     ////////// コマンドキュー

   { _Queuer := TCLQueuer.Create( _Contex, _Device ); }                         // 生成
     _Queuer := _Contex.Queuers.Add( _Device );                                 // 生成

     Assert( Assigned( _Contex.Handle ), '_Contex is Error!' );
     Assert( Assigned( _Queuer.Handle ), '_Queuer is Error!' );
end;

//------------------------------------------------------------------------------

procedure TForm1.MakeArgumes;
begin
     ////////// バッファー

     _Buffer := TCLDevBuf<TDoubleC>.Create( _Contex, _Queuer );                 // 生成

     Assert( Assigned( _Buffer.Handle ), '_Buffer is Error!' );

     _Buffer.Count := 2;                                                        // 要素数の設定

     _AreaC := TDoubleAreaC.Create( -2, -2, +2, +2 );

     _Buffer.Storag.Map;                                                        // 展開
     _Buffer.Storag[ 0 ] := _AreaC.Min;                                         // 書き込み
     _Buffer.Storag[ 1 ] := _AreaC.Max;                                         // 書き込み
     _Buffer.Storag.Unmap;                                                      // 同期

     ////////// イメージ

     _Imager := TCLDevIma2DxBGRAxUFix8.Create( _Contex, _Queuer );              // 生成

     Assert( Assigned( _Imager.Handle ), '_Imager is Error!' );

     _Imager.CountX := 500;                                                     // 横ピクセル数の設定
     _Imager.CountY := 500;                                                     // 縦ピクセル数の設定

     ////////// テクスチャ

     _Textur := TCLDevIma1DxBGRAxUFix8.Create( _Contex, _Queuer );              // 生成

     Assert( Assigned( _Textur.Handle ), '_Textur is Error!' );

     _Textur.LoadFromFile( '..\..\_DATA\Textur.png' );                          // 画像のロード

     _Textur.CopyTo( ImageT.Bitmap );                                           // 画像の表示

     ////////// サンプラー

     _Samplr := TCLSamplr.Create( _Contex );                                    // 生成

     Assert( Assigned( _Samplr.Handle ), '_Samplr is Error!' );
end;

//------------------------------------------------------------------------------

procedure TForm1.MakeProgras;
begin
     ////////// ライブラリ

   { _Librar := TCLLibrar.Create( _Contex ); }                                  // 生成
     _Librar := _Contex.Librars.Add;                                            // 生成

     Assert( Assigned( _Librar.Handle ), '_Librar is Error!' );

     _Librar.Source.LoadFromFile( '..\..\_DATA\Librar.cl' );                    // ソースコードのロード

     MemoPL.Lines.Assign( _Librar.Source );                                     // ソースコードの表示

     ////////// プログラム

   { _Execut := TCLExecut.Create( _Contex ); }                                  // 生成
     _Execut := _Contex.Executs.Add;                                            // 生成

     Assert( Assigned( _Execut.Handle ), '_Execut is Error!' );

     _Execut.Source.LoadFromFile( '..\..\_DATA\Execut.cl' );                    // ソースコードのロード

     MemoPE.Lines.Assign( _Execut.Source );                                     // ソースコードの表示

     ////////// ビルド

   { _Buildr := _Execut.Buildrs.Add( _Device ); }                               // 生成
     _Buildr := _Execut.BuildTo( _Device );                                     // 生成

     if Assigned( _Buildr.Handle ) then
     begin
          ////////// カーネル

        { _Kernel := TCLKernel.Create( _Execut, 'Main', _Queuer ); }            // 生成
          _Kernel := _Execut.Kernels.Add( 'Main', _Queuer );                    // 生成

          Assert( Assigned( _Kernel.Handle ), '_Kernel is Error!' );

          _Kernel.Parames['Buffer'] := _Buffer;                                 // バッファーの接続
          _Kernel.Parames['Imager'] := _Imager;                                 // イメージの接続
          _Kernel.Parames['Textur'] := _Textur;                                 // テクスチャの接続
          _Kernel.Parames['Samplr'] := _Samplr;                                 // サンプラーの接続

          _Kernel.GloSizX := _Imager.CountX;                                    // 横ループ回数の設定
          _Kernel.GloSizY := _Imager.CountY;                                    // 縦ループ回数の設定

          if _Kernel.Parames.BindsOK then Timer1.Enabled := True                // 描画開始
                                     else TabControl1.ActiveTab := TabItemS;    // 引数のバインドエラー
     end
     else ShowBuildr; { _Buildr is Error! }                                     // ビルド情報の表示
end;

procedure TForm1.ShowBuildr;
begin
     with MemoPB.Lines do
     begin
          if _Buildr.CompileStatus = CL_BUILD_ERROR then
          begin
               Add( '▼ Compile' );
               Add( _Buildr.CompileLog );
               Add( '' );
          end;

          if _Buildr.LinkStatus = CL_BUILD_ERROR then
          begin
               Add( '▼ Link' );
               Add( _Buildr.LinkLog );
               Add( '' );
          end;
     end;

     TabControl1.ActiveTab := TabItemP;
     TabControlP.ActiveTab := TabItemPB;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

procedure TForm1.FormCreate(Sender: TObject);
begin
     MakeContex;                                                                // コンテキストの生成

     MakeArgumes;                                                               // 実引数の生成

     MakeProgras;                                                               // プログラムの生成

     TOpenCL.Show( MemoS.Lines );                                               // システム情報の表示
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
     MemoS.Lines.SaveToFile( 'System.txt', TEncoding.UTF8 );

     ImageR.Bitmap.SaveToFile( 'Imager.png' )
end;

////////////////////////////////////////////////////////////////////////////////

procedure TForm1.Timer1Timer(Sender: TObject);
begin
     ////////// カーネル

     _Kernel.Run;                                                               // 実行

     ////////// イメージ

     _Imager.CopyTo( ImageR.Bitmap );                                           // 画像表示
end;

procedure TForm1.ImageRMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
var
   P :TPointF;
   C :TDoubleC;
   S :Double;
begin
     P := ImageR.AbsoluteToLocal( ScreenToClient( Screen.MousePos ) );

     C.R := _AreaC.Min.R + _AreaC.SizeR * P.X / ImageR.Width ;
     C.I := _AreaC.Max.I - _AreaC.SizeI * P.Y / ImageR.Height;

     S := Power( 1.1, WheelDelta / 120 );

     _AreaC.Min := ( _AreaC.Min - C ) * S + C;
     _AreaC.Max := ( _AreaC.Max - C ) * S + C;

     ////////// バッファー

     _Buffer.Storag.Map;                                                        // 展開
     _Buffer.Storag[ 0 ] := _AreaC.Min;                                         // 書き込み
     _Buffer.Storag[ 1 ] := _AreaC.Max;                                         // 書き込み
     _Buffer.Storag.Unmap;                                                      // 同期
end;

end. //######################################################################### ■
