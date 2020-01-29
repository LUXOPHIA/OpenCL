unit Main;

interface //#################################################################### ■

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, FMX.TabControl,
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
    _Context :TCLContext;
    _Program :TCLProgram;
    _Kernel  :TCLKernel;
    _BufferA :TCLHostBuffer<T_float>;
    _BufferB :TCLHostBuffer<T_float>;
    _BufferC :TCLHostBuffer<T_float>;
    ///// メソッド
    procedure ShowPlatforms;
    procedure ShowDevices;
    procedure ShowContexts;
  end;

var
  Form1: TForm1;

implementation //############################################################### ■

{$R *.fmx}

uses System.Math;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

procedure TForm1.ShowPlatforms;
var
   PI, EI :Integer;
   P :TCLPlatform;
   E :String;
begin
     with MemoSP.Lines do
     begin
          for PI := 0 to _OpenCL_.Platforms.Count-1 do
          begin
               P := _OpenCL_.Platforms[ PI ];

               Add( '┃' );
               Add( '┣・Platform[ ' + PI.ToString + ' ]<' + Longint( P.Handle ).ToHexString + '>' );
               Add( '┃　├・Profile   ：' + P.Profile );
               Add( '┃　├・Version   ：' + P.Version );
               Add( '┃　├・Name      ：' + P.Name    );
               Add( '┃　├・Vendor    ：' + P.Vendor  );
               Add( '┃　├・Extensions：' );
               for EI := 0 to P.Extensions.Count-1 do
               begin
                    E := P.Extensions[ EI ];

                    Add( '┃　│　 - ' + E );
               end;
          end;
          Add( '' );
     end;
end;

//------------------------------------------------------------------------------

procedure TForm1.ShowDevices;
var
   PI, DI :Integer;
   P :TCLPlatform;
   D :TCLDevice;
begin
     with MemoSD.Lines do
     begin
          for PI := 0 to _OpenCL_.Platforms.Count-1 do
          begin
               P := _OpenCL_.Platforms[ PI ];

               Add( '┃' );
               Add( '┣・Platform[ ' + PI.ToString + ' ]<' + Longint( P.Handle ).ToHexString + '>' );
               Add( '┃　│' );
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

procedure TForm1.ShowContexts;
var
   PI, CI, QI :Integer;
   P :TCLPlatform;
   C :TCLCOntext;
   Q :TCLCommand;
begin
     with MemoSC.Lines do
     begin
          for PI := 0 to _OpenCL_.Platforms.Count-1 do
          begin
               P := _OpenCL_.Platforms[ PI ];

               Add( '┃' );
               Add( '┣・Platform[ ' + PI.ToString + ' ]<' + Longint( P.Handle ).ToHexString + '>' );
               for CI := 0 to P.Contexts.Count-1 do
               begin
                    C := P.Contexts[ CI ];

                    Add( '┃　│' );
                    Add( '┃　┝・Context[ ' + CI.ToString + ' ]<' + LongInt( C.Handle ).ToHexString + '>' );
                    for QI := 0 to C.Commands.Count-1 do
                    begin
                         Q := C.Commands[ QI ];

                         Add( '┃　│　│' );
                         Add( '┃　│　├・Command[ ' + QI.ToString + ' ]<' + LongInt( Q.Handle ).ToHexString + '>'
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
begin
     ShowPlatforms;
     ShowDevices;

     ///// Context
     _Context := TCLContext.Create( _OpenCL_.Platforms[ 0 ] );  // 生成
     _Context.Add( _OpenCL_.Platforms[ 0 ].Devices[ 0 ] );      // デバイスの登録

     ShowContexts;

     ///// Program
     _Program := TCLProgram.Create( _Context );                // 生成
     _Program.Source.LoadFromFile( '..\..\_DATA\Source.cl' );  // ソースの読み込み
     _Program.Build;                                           // ビルド

     MemoPC.Lines.Assign( _Program.Source );

     ///// Buffer
     _BufferA := TCLHostBuffer<T_float>.Create( _Context );  // 生成
     _BufferB := TCLHostBuffer<T_float>.Create( _Context );  // 生成
     _BufferC := TCLHostBuffer<T_float>.Create( _Context );  // 生成

     _BufferA.Count := 1;                                    // 要素数の設定
     _BufferB.Count := 1;                                    // 要素数の設定
     _BufferC.Count := 1;                                    // 要素数の設定

     ///// Kernel
     _Kernel := TCLKernel.Create( _Program, 'add' );  // 生成
     _Kernel.Memorys.Add( _BufferA );                 // Buffer の登録
     _Kernel.Memorys.Add( _BufferB );                 // Buffer の登録
     _Kernel.Memorys.Add( _BufferC );                 // Buffer の登録
     MemoPR.Lines.Add( 'C = A + B' );

     ///// Buffer
     A := TCLBufferIter<T_float>.Create( _Context.Commands[ 0 ], _BufferA );  // マップ
     A.Values[ 0 ] := 1;                                                      // 書き込み
     MemoPR.Lines.Add( 'A = ' + FloatToStr( A.Values[ 0 ] ) );
     A.Free;                                                                  // アンマップ

     B := TCLBufferIter<T_float>.Create( _Context.Commands[ 0 ], _BufferB );  // マップ
     B.Values[ 0 ] := 2;                                                      // 書き込み
     MemoPR.Lines.Add( 'B = ' + FloatToStr( B.Values[ 0 ] ) );
     B.Free;                                                                  // アンマップ

     ///// Kernel
     _Kernel.Run( _Context.Commands[ 0 ] );  // 実行

     ///// Buffer
     C := TCLBufferIter<T_float>.Create( _Context.Commands[ 0 ], _BufferC );  // マップ
     MemoPR.Lines.Add( 'C = ' + FloatToStr( C.Values[ 0 ] ) );                // 読み込み
     C.Free;                                                                  // アンマップ
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
     /////
end;

end. //######################################################################### ■
