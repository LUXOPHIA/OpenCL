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
    _Imager :TCLDevIma2DxBGRAxNormUInt8;
    _Textur :TCLDevIma1DxBGRAxNormUInt8;
    _Samplr :TCLSamplr;
    _Librar :TCLLibrar;
    _Execut :TCLExecut;
    _Buildr :TCLBuildr;
    _Kernel :TCLKernel;
    ///// メソッド
    procedure ShowBuildr;
  end;

var
  Form1: TForm1;

implementation //############################################################### ■

{$R *.fmx}

uses System.Math;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

procedure TForm1.ShowBuildr;
begin
     with MemoPB.Lines do
     begin
          if _Buildr.CompileStatus <> CL_BUILD_SUCCESS then
          begin
               Add( '▽ Compile' );
               Add( _Buildr.CompileLog );
               Add( '' );
          end;

          if _Buildr.LinkStatus <> CL_BUILD_SUCCESS then
          begin
               Add( '▽ Link' );
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

     Assert( Assigned( _Contex.Handle ), '_Contex is Error!' );
     Assert( Assigned( _Queuer.Handle ), '_Queuer is Error!' );

     ///// バッファー
     _Buffer := TCLDevBuf<TDoubleC>.Create( _Contex, _Queuer );                 // 生成
     _Buffer.Count := 2;                                                        // 要素数の設定

     Assert( Assigned( _Buffer.Handle ), '_Buffer is Error!' );

     _AreaC := TDoubleAreaC.Create( -2, -2, +2, +2 );

     _Buffer.Storag.Map;                                                        // マップ
     _Buffer.Storag[ 0 ] := _AreaC.Min;                                         // 書き込み
     _Buffer.Storag[ 1 ] := _AreaC.Max;                                         // 書き込み
     _Buffer.Storag.Unmap;                                                      // アンマップ

     ///// イメージ
     _Imager := TCLDevIma2DxBGRAxNormUInt8.Create( _Contex, _Queuer );          // 生成
     _Imager.CountX := 500;                                                     // ピクセル数の設定
     _Imager.CountY := 500;                                                     // ピクセル数の設定

     Assert( Assigned( _Imager.Handle ), '_Imager is Error!' );

     ///// テクスチャ
     _Textur := TCLDevIma1DxBGRAxNormUInt8.Create( _Contex, _Queuer );          // 生成
     _Textur.CountX := 4;
     _Textur.Storag.Map;
     _Textur.Storag[ 0 ] := TAlphaColors.Black;
     _Textur.Storag[ 1 ] := TAlphaColors.Red;
     _Textur.Storag[ 2 ] := TAlphaColors.Yellow;
     _Textur.Storag[ 3 ] := TAlphaColors.White;
     _Textur.Storag.Unmap;

     Assert( Assigned( _Textur.Handle ), '_Textur is Error!' );

     ///// サンプラー
     _Samplr := TCLSamplr.Create( _Contex );                                    // 生成

     Assert( Assigned( _Samplr.Handle ), '_Samplr is Error!' );

     ////////// プログラム

     ///// ライブラリ
   { _Librar := TCLLibrar.Create( _Contex ); }
     _Librar := _Contex.Librars.Add;                                            // 生成
     _Librar.Source.LoadFromFile( '..\..\_DATA\Librar.cl' );                    // ソースコードのロード

     MemoPL.Lines.Assign( _Librar.Source );                                     // ソースコードの表示

     Assert( Assigned( _Librar.Handle ), '_Librar is Error!' );

     ///// 実行形式
   { _Execut := TCLExecut.Create( _Contex ); }
     _Execut := _Contex.Executs.Add;                                            // 生成
     _Execut.Source.LoadFromFile( '..\..\_DATA\Execut.cl' );                    // ソースコードのロード

     MemoPE.Lines.Assign( _Execut.Source );                                     // ソースコードの表示

     Assert( Assigned( _Execut.Handle ), '_Execut is Error!' );

     ///// ビルド
   { _Buildr := _Execut.Buildrs.Add( _Device ); }
     _Buildr := _Execut.BuildTo( _Device );                                     // 生成

     if Assigned( _Buildr.Handle ) then
     begin
          ///// カーネル
        { _Kernel := TCLKernel.Create( _Execut, 'Main', _Queuer ); }
          _Kernel := _Execut.Kernels.Add( 'Main', _Queuer );                    // 生成
          _Kernel.Parames['Buffer'] := _Buffer;                                 // バッファの接続
          _Kernel.Parames['Imager'] := _Imager;                                 // イメージの接続
          _Kernel.Parames['Textur'] := _Textur;                                 // テクスチャの接続
          _Kernel.Parames['Samplr'] := _Samplr;                                 // サンプラーの接続
          _Kernel.GloSizX := _Imager.CountX;                                    // Ｘ方向ループ回数の設定
          _Kernel.GloSizY := _Imager.CountY;                                    // Ｙ方向ループ回数の設定

          Assert( Assigned( _Kernel.Handle ), '_Kernel is Error!' );

          if _Kernel.Parames.BindsOK then Timer1.Enabled := True                // 描画ループ開始
                                     else TabControl1.ActiveTab := TabItemS;    // 引数のバインドエラー
     end
     else ShowBuildr; { _Buildr is Error! }                                     // ビルド情報の表示

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
