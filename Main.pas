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
  LUX.GPU.OpenCL.Stream.FMX.D1,
  LUX.GPU.OpenCL.Stream.FMX.D2;

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
    ///// メソッド
    procedure ShowBuild;
  public
    { public 宣言 }
    _Platfo :TCLPlatfo;
    _Device :TCLDevice;
    _Contex :TCLContex;
    _Queuer :TCLQueuer;
    _Buffer :TCLBuffer<TDoubleC>;
    _Textur :TCLImager1DxBGRAxUFix8;
    _TexFMX :ICLStream1DxBGRAxUFix8_FMX;
    _Samplr :TCLSamplr;
    _Imager :TCLImager2DxBGRAxUFix8;
    _ImaFMX :ICLStream2DxBGRAxUFix8_FMX;
    _Librar :TCLLibrar;
    _Execut :TCLExecut;
    _Buildr :TCLBuildr;
    _Kernel :TCLKernel;
    ///// メソッド
    procedure MakeContext;
    procedure MakeArguments;
    procedure MakePrograms;
  end;

var
  Form1: TForm1;

implementation //############################################################### ■

{$R *.fmx}

uses System.Math;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

/////////////////////////////////////////////////////////////////////// メソッド

procedure TForm1.ShowBuild;
begin
     with MemoPB.Lines do
     begin
          Add( '▼ Compile' );
          Add( _Buildr.CompileLog );
          Add( '' );
          Add( '▼ Link' );
          Add( _Buildr.LinkLog );
          Add( '' );
     end;

     if ( _Buildr.CompileLog = '' ) and
        ( _Buildr.LinkLog    = '' ) then Exit;

     TabControl1.ActiveTab := TabItemP;
     TabControlP.ActiveTab := TabItemPB;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

procedure TForm1.MakeContext;
begin
     ////////// プラットフォーム

     _Platfo := TOpenCL.Platfos[ 0 ];                                           // 選択

     ////////// デバイス

     _Device := _Platfo.Devices[ 0 ];                                           // 選択

     ////////// コンテキスト

     _Contex := TCLContex.Create( _Platfo );                                    // 生成

     ////////// コマンドキュー

     _Queuer := TCLQueuer.Create( _Contex, _Device );                           // 生成

     Assert( Assigned( _Contex.Handle ), '_Contex is Error!' );                 // 検証
     Assert( Assigned( _Queuer.Handle ), '_Queuer is Error!' );                 // 検証
end;

//------------------------------------------------------------------------------

procedure TForm1.MakeArguments;
begin
     ////////// バッファー

     _Buffer := TCLBuffer<TDoubleC>.Create( _Contex, _Queuer );                 // 生成

     Assert( Assigned( _Buffer.Handle ), '_Buffer is Error!' );                 // 検証

     _Buffer.Count := 2;                                                        // 要素数の設定

     _AreaC := TDoubleAreaC.Create( -2, -2, +2, +2 );

     _Buffer.Data.Map;                                                          // 展開
     _Buffer.Data[ 0 ] := _AreaC.Min;                                           // 書き込み
     _Buffer.Data[ 1 ] := _AreaC.Max;                                           // 書き込み
     _Buffer.Data.Unmap;                                                        // 同期

     ////////// テクスチャ

     _Textur := TCLImager1DxBGRAxUFix8.Create( _Contex, _Queuer );              // 生成

     Assert( Assigned( _Textur.Handle ), '_Textur is Error!' );                 // 検証

     _TexFMX := TCLStream1DxBGRAxUFix8_FMX.Create( _Textur );                   // ストリームの生成

     _TexFMX.LoadFromFile( '..\..\_DATA\Textur.png' );                          // 画像のロード

     _TexFMX.CopyTo( ImageT.Bitmap );                                           // 画像の表示

     ////////// サンプラー

     _Samplr := TCLSamplr.Create( _Contex );                                    // 生成

     Assert( Assigned( _Samplr.Handle ), '_Samplr is Error!' );                 // 検証

     ////////// イメージ

     _Imager := TCLImager2DxBGRAxUFix8.Create( _Contex, _Queuer );              // 生成

     Assert( Assigned( _Imager.Handle ), '_Imager is Error!' );                 // 検証

     _Imager.CountX := 500;                                                     // 横ピクセル数の設定
     _Imager.CountY := 500;                                                     // 縦ピクセル数の設定

     _ImaFMX := TCLStream2DxBGRAxUFix8_FMX.Create( _Imager );                   // ストリームの生成
end;

//------------------------------------------------------------------------------

procedure TForm1.MakePrograms;
begin
     ////////// ライブラリ

     _Librar := TCLLibrar.Create( _Contex );                                    // 生成

     Assert( Assigned( _Librar.Handle ), '_Librar is Error!' );                 // 検証

     _Librar.Source.LoadFromFile( '..\..\_DATA\Librar.cl' );                    // ソースコードのロード

     MemoPL.Lines.Assign( _Librar.Source );                                     // ソースコードの表示

     ////////// プログラム

     _Execut := TCLExecut.Create( _Contex );                                    // 生成

     Assert( Assigned( _Execut.Handle ), '_Execut is Error!' );                 // 検証

     _Execut.Source.LoadFromFile( '..\..\_DATA\Execut.cl' );                    // ソースコードのロード

     MemoPE.Lines.Assign( _Execut.Source );                                     // ソースコードの表示

     ////////// ビルド

     _Buildr := TCLBuildr.Create( _Execut, _Device );                           // 生成

     if not Assigned( _Buildr.Handle ) then Exit; { _Buildr is Error! }         // 検証

     ////////// カーネル

     _Kernel := TCLKernel.Create( _Execut, 'Main', _Queuer );                   // 生成

     Assert( Assigned( _Kernel.Handle ), '_Kernel is Error!' );                 // 検証

     _Kernel.GloSizX := _Imager.CountX;                                         // Ｘ方向ループ回数の設定
     _Kernel.GloSizY := _Imager.CountY;                                         // Ｙ方向ループ回数の設定

     _Kernel.Parames['Buffer'] := _Buffer;                                      // バッファーの登録
     _Kernel.Parames['Textur'] := _Textur;                                      // テクスチャの登録
     _Kernel.Parames['Samplr'] := _Samplr;                                      // サンプラーの登録
     _Kernel.Parames['Imager'] := _Imager;                                      // イメージ　の登録

     Assert( _Kernel.Parames.FindsOK, '_Kernel.Parames.FindsOK is Error!' );    // 仮引数の照合
     Assert( _Kernel.Parames.BindsOK, '_Kernel.Parames.BindsOK is Error!' );    // 実引数の接続

     Timer1.Enabled := True;                                                    // 描画開始
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

procedure TForm1.FormCreate(Sender: TObject);
begin
     MakeContext;                                                               // コンテキストの生成

     MakeArguments;                                                             // 実引数の生成

     MakePrograms;                                                              // プログラムの生成

     ShowBuild;                                                                 // ビルド情報の表示

     TOpenCL.Show( MemoS.Lines );                                               // システム情報の表示
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
     MemoS.Lines.SaveToFile( 'System.txt', TEncoding.UTF8 );

     ImageR.Bitmap.SaveToFile( 'Imager.png' );
end;

////////////////////////////////////////////////////////////////////////////////

procedure TForm1.Timer1Timer(Sender: TObject);
begin
     ////////// カーネル

     _Kernel.Run;                                                               // 実行

     ////////// イメージ

     _ImaFMX.CopyTo( ImageR.Bitmap );                                           // 画像の表示
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

     _Buffer.Data.Map;                                                          // 展開
     _Buffer.Data[ 0 ] := _AreaC.Min;                                           // 書き込み
     _Buffer.Data[ 1 ] := _AreaC.Max;                                           // 書き込み
     _Buffer.Data.Unmap;                                                        // 同期
end;

end. //######################################################################### ■
