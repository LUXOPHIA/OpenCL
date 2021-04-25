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
    _Contex  :TCLContex;
    _Progra  :TCLProgra;
    _Kernel  :TCLKernel;
    _BufferA :TCLHostBuffer<T_float>;
    _BufferB :TCLHostBuffer<T_float>;
    _BufferC :TCLHostBuffer<T_float>;
    ///// メソッド
    procedure ShowPlatfos;
    procedure ShowDevices;
    procedure ShowContexs;
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
               Add( '┣・Platform[ ' + PI.ToString + ' ]<' + Longint( P.Handle ).ToHexString + '>' );
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
                    Add( '┃　┝・Device[ ' + DI.ToString + ' ]<' + Longint( D.Handle ).ToHexString + '>' );
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

                    for QI := 0 to C.Commands.Count-1 do
                    begin
                         Q := C.Commands[ QI ];

                         Add( '┃　│　│' );
                         Add( '┃　│　├・Commans[ ' + QI.ToString + ' ]<' + LongInt( Q.Handle ).ToHexString + '>'
                            + ' → Device<' + LongInt( Q.Device.Handle ).ToHexString + '>' );
                    end;
               end;
          end;

          Add( '' );
     end;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

procedure TForm1.FormCreate(Sender: TObject);
var
   A, B, C :TCLBufferIter<T_float>;
   I :Integer;
begin
     ///// Platform
     ShowPlatfos;                                                               // 一覧表示

     ///// Device
     ShowDevices;  // 一覧表示

     ///// Context
     _Contex := TCLContex.Create( _OpenCL_.Platfos[ 0 ] );                      // 生成
     _Contex.Add( _OpenCL_.Platfos[ 0 ].Devices[ 0 ] );                         // デバイスの登録

     ShowContexs;                                                               // 一覧表示

     ///// Program
     _Progra := TCLProgra.Create( _Contex );                                    // 生成
     _Progra.Source.LoadFromFile( '..\..\_DATA\Source.cl' );                    // ソースの読み込み
     _Progra.Build;                                                             // ビルド

     MemoPC.Lines.Assign( _Progra.Source );                                     // ソースの表示

     ///// Buffer
     _BufferA := TCLHostBuffer<T_float>.Create( _Contex );                      // 生成
     _BufferB := TCLHostBuffer<T_float>.Create( _Contex );                      // 生成
     _BufferC := TCLHostBuffer<T_float>.Create( _Contex );                      // 生成

     _BufferA.Count := 10;                                                      // 要素数の設定
     _BufferB.Count := 10;                                                      // 要素数の設定
     _BufferC.Count := 10;                                                      // 要素数の設定

     A := TCLBufferIter<T_float>.Create( _Contex.Commands[ 0 ], _BufferA );     // マップ
     B := TCLBufferIter<T_float>.Create( _Contex.Commands[ 0 ], _BufferB );     // マップ
     for I := 0 to _BufferA.Count-1 do A.Values[ I ] := Random( 10 );           // 書き込み
     for I := 0 to _BufferB.Count-1 do B.Values[ I ] := Random( 10 );           // 書き込み
     A.Free;                                                                    // アンマップ
     B.Free;                                                                    // アンマップ

     ///// Kernel
     _Kernel := TCLKernel.Create( _Progra, 'mul' );                             // 生成
     _Kernel.Memorys.Add( _BufferA );                                           // Buffer の登録
     _Kernel.Memorys.Add( _BufferB );                                           // Buffer の登録
     _Kernel.Memorys.Add( _BufferC );                                           // Buffer の登録
     _Kernel.GlobalWorkSize := [ 10 ];                                          // ループ回数の設定

     _Kernel.Run( _Contex.Commands[ 0 ] );                                      // 実行

     ///// Buffer
     MemoPR.Lines.Add( 'A[i] + B[i] = C[i]' );
     A := TCLBufferIter<T_float>.Create( _Contex.Commands[ 0 ], _BufferA );     // マップ
     B := TCLBufferIter<T_float>.Create( _Contex.Commands[ 0 ], _BufferB );     // マップ
     C := TCLBufferIter<T_float>.Create( _Contex.Commands[ 0 ], _BufferC );     // マップ
     for I := 0 to _BufferC.Count-1 do
     begin
          MemoPR.Lines.Add( FloatToStr( A.Values[ I ] ) + ' * '                 // 読み込み
                          + FloatToStr( B.Values[ I ] ) + ' = '                 // 読み込み
                          + FloatToStr( C.Values[ I ] ) );                      // 読み込み
     end;
     A.Free;                                                                    // アンマップ
     B.Free;                                                                    // アンマップ
     C.Free;                                                                    // アンマップ
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
     /////
end;

end. //######################################################################### ■
