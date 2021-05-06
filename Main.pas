﻿unit Main;

interface //#################################################################### ■

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Memo.Types, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, FMX.TabControl,
  cl_version, cl_platform, cl,
  LUX,
  LUX.Code.C,
  LUX.GPU.OpenCL.root,
  LUX.GPU.OpenCL;

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
        MemoR: TMemo;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private 宣言 }
  public
    { public 宣言 }
    _Platfo  :TCLPlatfo;
    _Device  :TCLDevice;
    _Contex  :TCLContex;
    _Queuer  :TCLQueuer;
    _BufferA :TCLDevBuf<T_float>;
    _BufferB :TCLDevBuf<T_float>;
    _BufferC :TCLDevBuf<T_float>;
    _Progra  :TCLProgra;
    _Deploy  :TCLDeploy;
    _Kernel  :TCLKernel;
    ///// メソッド
    function ShowDeploys :Boolean;
    procedure ShowResult;
  end;

var
  Form1: TForm1;

implementation //############################################################### ■

{$R *.fmx}

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

//------------------------------------------------------------------------------

procedure TForm1.ShowResult;
var
   A, B, C :TCLBufferIter<T_float>;
   I :Integer;
begin
     with MemoR.Lines do
     begin
          Add( 'A[ i ] * B[ i ] = C[ i ]' );
          Add( '' );

          A := TCLBufferIter<T_float>.Create( _Queuer, _BufferA );
          B := TCLBufferIter<T_float>.Create( _Queuer, _BufferB );
          C := TCLBufferIter<T_float>.Create( _Queuer, _BufferC );

          for I := 0 to _BufferC.Count-1 do
          begin
               Add( A[ I ].ToString + ' * '
                  + B[ I ].ToString + ' = '
                  + C[ I ].ToString );
          end;

          A.Free;
          B.Free;
          C.Free;

          Add( '' );
     end;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

procedure TForm1.FormCreate(Sender: TObject);
var
   A, B :TCLBufferIter<T_float>;
   I :Integer;
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
     _BufferA := TCLDevBuf<T_float>.Create( _Contex );                          // 生成
     _BufferB := TCLDevBuf<T_float>.Create( _Contex );                          // 生成
     _BufferC := TCLDevBuf<T_float>.Create( _Contex );                          // 生成

     _BufferA.Count := 10;                                                      // 要素数の設定
     _BufferB.Count := 10;                                                      // 要素数の設定
     _BufferC.Count := 10;                                                      // 要素数の設定

     A := TCLBufferIter<T_float>.Create( _Queuer, _BufferA );                   // マップ
     B := TCLBufferIter<T_float>.Create( _Queuer, _BufferB );                   // マップ

     for I := 0 to _BufferA.Count-1 do A[ I ] := Random( 10 );                  // 書き込み
     for I := 0 to _BufferB.Count-1 do B[ I ] := Random( 10 );                  // 書き込み

     A.Free;                                                                    // アンマップ
     B.Free;                                                                    // アンマップ

     ///// プログラム
   { _Progra := TCLProgra.Create( _Contex ); }
     _Progra := _Contex.Progras.Add;                                            // 生成
     _Progra.Source.LoadFromFile( '..\..\_DATA\Source.cl' );                    // ソースコードのロード

     MemoC.Lines.Assign( _Progra.Source );                                      // ソースコードの表示

     ///// ビルド
   { _Deploy := _Progra.Deploys.Add( _Device ); }
     _Deploy := _Progra.BuildTo( _Device );                                     // 生成

     ///// カーネル
   { _Kernel := TCLKernel.Create( _Progra, 'Main', _Queuer ); }
     _Kernel := _Progra.Kernels.Add( 'Main', _Queuer );                         // 生成
     _Kernel.Argumes['BufferA'] := _BufferA;                                    // バッファの登録
     _Kernel.Argumes['BufferB'] := _BufferB;                                    // バッファの登録
     _Kernel.Argumes['BufferC'] := _BufferC;                                    // バッファの登録
     _Kernel.GlobWorkSize := [ 10 ];                                            // ループ回数の設定

     //////////

     TOpenCL.Show( MemoS.Lines );                                               // システム情報の表示

     if ShowDeploys then                                                        // ビルド情報の表示
     begin
          _Kernel.Run;                                                          // 実行

          ShowResult;                                                           // 結果表示
     end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
     MemoS.Lines.SaveToFile( 'System.txt', TEncoding.UTF8 );
end;

end. //######################################################################### ■
