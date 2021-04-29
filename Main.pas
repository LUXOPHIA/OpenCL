unit Main;

interface //#################################################################### ■

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Memo.Types, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, FMX.TabControl,
  cl_version,
  cl_platform,
  cl,
  LUX,
  LUX.Code.C,
  LUX.GPU.OpenCL.root,
  LUX.GPU.OpenCL;

type
  TForm1 = class(TForm)
    TabControl1: TTabControl;
      TabItemS: TTabItem;
        TabControlS: TTabControl;
          TabItemSP: TTabItem;
            MemoSP: TMemo;
          TabItemSD: TTabItem;
            MemoSD: TMemo;
          TabItemSC: TTabItem;
            MemoSC: TMemo;
      TabItemP: TTabItem;
        TabControlP: TTabControl;
          TabItemPC: TTabItem;
            MemoPC: TMemo;
          TabItemPR: TTabItem;
            MemoPR: TMemo;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private 宣言 }
  public
    { public 宣言 }
    _Platfo  :TCLPlatfo;
    _Device  :TCLDevice;
    _Contex  :TCLContex;
    _Comman  :TCLComman;
    _Progra  :TCLProgra;
    _Kernel  :TCLKernel;
    _BufferA :TCLHostBuffer<T_float>;
    _BufferB :TCLHostBuffer<T_float>;
    _BufferC :TCLHostBuffer<T_float>;
    ///// メソッド
    procedure ShowPlatfos;
    procedure ShowDevices;
    procedure ShowContexs;
    procedure ShowBuffers;
  end;

var
  Form1: TForm1;

implementation //############################################################### ■

{$R *.fmx}

uses System.Math;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

procedure TForm1.ShowPlatfos;
var
   PI :Integer;
   P :TCLPlatfo;
   E :String;
begin
     with MemoSP.Lines do
     begin
          for PI := 0 to _OpenCL_.Platfos.Count-1 do
          begin
               P := _OpenCL_.Platfos[ PI ];

               Add( '┃' );
               Add( '┣・Platfos[ ' + PI.ToString + ' ]<' + Longint( P.Handle ).ToHexString + '>' );
               Add( '┃　├・Profile   ：' + P.Profile );
               Add( '┃　├・Version   ：' + P.Version );
               Add( '┃　├・Name      ：' + P.Name    );
               Add( '┃　├・Vendor    ：' + P.Vendor  );
               Add( '┃　├・Extensions：' );

               for E in P.Extenss do Add( '┃　│　 - ' + E );
          end;

          Add( '' );
     end;
end;

//------------------------------------------------------------------------------

procedure TForm1.ShowDevices;
var
   PI, DI :Integer;
   P :TCLPlatfo;
   D :TCLDevice;
begin
     with MemoSD.Lines do
     begin
          for PI := 0 to _OpenCL_.Platfos.Count-1 do
          begin
               P := _OpenCL_.Platfos[ PI ];

               Add( '┃' );
               Add( '┣・Platfos[ ' + PI.ToString + ' ]<' + Longint( P.Handle ).ToHexString + '>' );

               for DI := 0 to P.Devices.Count-1 do
               begin
                    D := P.Devices[ DI ];

                    Add( '┃　│' );
                    Add( '┃　┝・Devices[ ' + DI.ToString + ' ]<' + Longint( D.Handle ).ToHexString + '>' );
                    Add( '┃　│　├・DEVICE_TYPE     ：'  + IntTosTr( D.DEVICE_TYPE      ) );
                    Add( '┃　│　├・DEVICE_VENDOR   ：'  +           D.DEVICE_VENDOR      );
                    Add( '┃　│　├・DEVICE_VENDOR_ID：'  + IntToStr( D.DEVICE_VENDOR_ID ) );
                    Add( '┃　│　├・DEVICE_VERSION  ：'  +           D.DEVICE_VERSION     );
                    Add( '┃　│　├・DRIVER_VERSION  ：'  +           D.DRIVER_VERSION     );
               end;
          end;

          Add( '' );
     end;
end;

//------------------------------------------------------------------------------

procedure TForm1.ShowContexs;
var
   PI, CI, QI :Integer;
   P :TCLPlatfo;
   C :TCLContex;
   Q :TCLComman;
begin
     with MemoSC.Lines do
     begin
          for PI := 0 to _OpenCL_.Platfos.Count-1 do
          begin
               P := _OpenCL_.Platfos[ PI ];

               Add( '┃' );
               Add( '┣・Platfos[ ' + PI.ToString + ' ]<' + Longint( P.Handle ).ToHexString + '>' );

               for CI := 0 to P.Contexs.Count-1 do
               begin
                    C := P.Contexs[ CI ];

                    Add( '┃　│' );
                    Add( '┃　┝・Contexs[ ' + CI.ToString + ' ]<' + LongInt( C.Handle ).ToHexString + '>' );

                    for QI := 0 to C.Commans.Count-1 do
                    begin
                         Q := C.Commans[ QI ];

                         Add( '┃　│　│' );
                         Add( '┃　│　├・Commans[ ' + QI.ToString + ' ]<' + LongInt( Q.Handle ).ToHexString + '>'
                            + ' → Device<' + LongInt( Q.Device.Handle ).ToHexString + '>' );
                    end;
               end;
          end;

          Add( '' );
     end;
end;

//------------------------------------------------------------------------------

procedure TForm1.ShowBuffers;
var
   A, B, C :TCLBufferIter<T_float>;
   I :Integer;
begin
     MemoPR.Lines.Add( 'A[i] + B[i] = C[i]' );

     A := TCLBufferIter<T_float>.Create( _Comman, _BufferA );
     B := TCLBufferIter<T_float>.Create( _Comman, _BufferB );
     C := TCLBufferIter<T_float>.Create( _Comman, _BufferC );

     for I := 0 to _BufferC.Count-1 do
     begin
          MemoPR.Lines.Add( FloatToStr( A[ I ] ) + ' * '
                          + FloatToStr( B[ I ] ) + ' = '
                          + FloatToStr( C[ I ] ) );
     end;

     A.Free;
     B.Free;
     C.Free;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

procedure TForm1.FormCreate(Sender: TObject);
var
   A, B :TCLBufferIter<T_float>;
   I :Integer;
begin
     ///// Platfo                                                               ：プラットフォーム
     _Platfo := _OpenCL_.Platfos[ 0 ];                                          // 選択

     ShowPlatfos;                                                               // 一覧表示

     ///// Device                                                               ：デバイス
     _Device := _Platfo.Devices[ 0 ];                                           // 選択

     ShowDevices;                                                               // 一覧表示

     ///// Contex                                                               ：コンテキスト
     _Contex := TCLContex.Create( _Platfo );                                    // 生成

     ShowContexs;                                                               // 一覧表示

     ///// Comman                                                               ：コマンドキュー
     _Comman := TCLComman.Create( _Contex, _Device );                           // 生成

     ///// Buffer                                                               ：バッファー
     _BufferA := TCLHostBuffer<T_float>.Create( _Contex );                      // 生成
     _BufferB := TCLHostBuffer<T_float>.Create( _Contex );                      // 生成
     _BufferC := TCLHostBuffer<T_float>.Create( _Contex );                      // 生成

     _BufferA.Count := 10;                                                      // 要素数の設定
     _BufferB.Count := 10;                                                      // 要素数の設定
     _BufferC.Count := 10;                                                      // 要素数の設定

     A := TCLBufferIter<T_float>.Create( _Comman, _BufferA );                   // マップ
     B := TCLBufferIter<T_float>.Create( _Comman, _BufferB );                   // マップ

     for I := 0 to _BufferA.Count-1 do A[ I ] := Random( 10 );                  // 書き込み
     for I := 0 to _BufferB.Count-1 do B[ I ] := Random( 10 );                  // 書き込み

     A.Free;                                                                    // アンマップ
     B.Free;                                                                    // アンマップ

     ///// Progra                                                               ：プログラム
     _Progra := TCLProgra.Create( _Contex );                                    // 生成
     _Progra.Source.LoadFromFile( '..\..\_DATA\Source.cl' );                    // ソースコードの読み込み
     _Progra.Build;                                                             // ビルド

     MemoPC.Lines.Assign( _Progra.Source );                                     // ソースコードの表示

     ///// Kernel                                                               ：カーネル
     _Kernel := TCLKernel.Create( _Progra, 'mul' );                             // 生成
     _Kernel.Memorys.Add( _BufferA );                                           // バッファの登録
     _Kernel.Memorys.Add( _BufferB );                                           // バッファの登録
     _Kernel.Memorys.Add( _BufferC );                                           // バッファの登録
     _Kernel.GlobalWorkSize := [ 10 ];                                          // ループ回数の設定

     _Kernel.Run( _Comman );                                                    // 実行

     ShowBuffers;                                                               // 結果表示
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
     /////
end;

end. //######################################################################### ■
