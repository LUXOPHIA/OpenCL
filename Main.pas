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
    _Comman  :TCLComman;
    _BufferA :TCLHostBuffer<T_float>;
    _BufferB :TCLHostBuffer<T_float>;
    _BufferC :TCLHostBuffer<T_float>;
    _Progra  :TCLProgra;
    _Kernel  :TCLKernel;
    ///// メソッド
    procedure ShowArgumes( const Argumes_:TCLArgumes );
    procedure ShowKernels( const Kernels_:TCLKernels );
    procedure ShowDeploys( const Deploys_:TCLDeploys );
    procedure ShowProgras( const Progras_:TCLProgras );
    procedure ShowMemorys( const Memorys_:TCLMemorys );
    procedure ShowCommans( const Commans_:TCLCommans );
    procedure ShowContexs( const Contexs_:TCLContexs );
    procedure ShowDevices( const Devices_:TCLDevices );
    procedure ShowExtenss( const Extenss_:TCLExtenss );
    procedure ShowPlatfos( const Platfos_:TCLPlatfos );
    procedure ShowSystem;
    procedure ShowResult;
  end;

var
  Form1: TForm1;

implementation //############################################################### ■

{$R *.fmx}

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

procedure TForm1.ShowArgumes( const Argumes_:TCLArgumes );
var
   M :TCLMemory;
begin
     with MemoS.Lines do
     begin
          Add( ' ┃　│　┃　│　┃　│　┃　│' );
          Add( ' ┃　│　┃　│　┃　│　┃　├ Argumes[*] :TCLArgumes' );
          for M in Argumes_ do
          begin
               Add( ' ┃　│　┃　│　┃　│　┃　│　├ Argume[' + M.Order.ToString + '] = Memory[' + M.Order.ToString + ']'  );
          end;
     end;
end;

procedure TForm1.ShowKernels( const Kernels_:TCLKernels );
var
   K :TCLKernel;
begin
     with MemoS.Lines do
     begin
          Add( ' ┃　│　┃　│　┃　│' );
          Add( ' ┃　│　┃　│　┃　┝ Kernels[*] :TCLKernels' );
          for K in Kernels_ do
          begin
               Add( ' ┃　│　┃　│　┃　│　┃' );
               Add( ' ┃　│　┃　│　┃　│　┣・Kernel[' + K.Order.ToString + '] :TCLKernel' );
               Add( ' ┃　│　┃　│　┃　│　┃　├ Name      = ' + K.Name );
               Add( ' ┃　│　┃　│　┃　│　┃　├ Dimension = ' + K.Dimension.ToString );
               Add( ' ┃　│　┃　│　┃　│　┃　├ Comman    = Comman[' + K.Comman.Order.ToString + ']' );

               ShowArgumes( K.Argumes );
          end;
     end;
end;

procedure TForm1.ShowDeploys( const Deploys_:TCLDeploys );
var
   L :TCLDeploy;
begin
     with MemoS.Lines do
     begin
          Add( ' ┃　│　┃　│　┃　│' );
          Add( ' ┃　│　┃　│　┃　┝ Deploys[*] :TCLDeploys' );
          for L in Deploys_ do
          begin
               Add( ' ┃　│　┃　│　┃　│　┃' );
               Add( ' ┃　│　┃　│　┃　│　┣・Deploy[' + L.Order.ToString + '] :TCLDeploy' );
               Add( ' ┃　│　┃　│　┃　│　┃　├ Device = Device[' + L.Device.Order.ToString + ']' );
               Add( ' ┃　│　┃　│　┃　│　┃　├ State  = ' + L.State.ToString );
          end;
     end;

     with MemoL.Lines do
     begin
          for L in Deploys_ do
          begin
               if L.State <> CL_BUILD_SUCCESS then
               begin
                    Add( '▼ Device[' + L.Device.Order.ToString + ']' );
                    Add( L.Log );
                    Add( '' );
               end;
          end;

          if Count > 0 then
          begin
               TabControl1.ActiveTab := TabItemP;
               TabControlP.ActiveTab := TabItemL;
          end;
     end;
end;

procedure TForm1.ShowProgras( const Progras_:TCLProgras );
var
   P :TCLProgra;
begin
     with MemoS.Lines do
     begin
          Add( ' ┃　│　┃　│' );
          Add( ' ┃　│　┃　┝ Progras[*] :TCLProgras' );
          for P in Progras_ do
          begin
               Add( ' ┃　│　┃　│　┃' );
               Add( ' ┃　│　┃　│　┣・Progra[' + P.Order.ToString + '] :TCLProgra' );
               Add( ' ┃　│　┃　│　┃　├ LangVer = ' + P.LangVer.ToString );

               ShowDeploys( P.Deploys );
               ShowKernels( P.Kernels );
          end;
     end;
end;

procedure TForm1.ShowMemorys( const Memorys_:TCLMemorys );
var
   M :TCLMemory;
begin
     with MemoS.Lines do
     begin
          Add( ' ┃　│　┃　│' );
          Add( ' ┃　│　┃　┝ Memorys[*] :TCLMemorys' );
          for M in Memorys_ do
          begin
               Add( ' ┃　│　┃　│　┃' );
               Add( ' ┃　│　┃　│　┣・Memory[' + M.Order.ToString + '] :TCLMemory' );
               Add( ' ┃　│　┃　│　┃　├ Size = ' + M.Size.ToString );
          end;
     end;
end;

procedure TForm1.ShowCommans( const Commans_:TCLCommans );
var
   Q :TCLComman;
begin
     with MemoS.Lines do
     begin
          Add( ' ┃　│　┃　│' );
          Add( ' ┃　│　┃　┝ Commans[*] :TCLCommans' );
          for Q in Commans_ do
          begin
               Add( ' ┃　│　┃　│　┃' );
               Add( ' ┃　│　┃　│　┣・Comman[' + Q.Order.ToString + '] :TCLComman' );
               Add( ' ┃　│　┃　│　┃　├ Device = Device[' + Q.Device.Order.ToString + ']' );
          end;
     end;
end;

procedure TForm1.ShowContexs( const Contexs_:TCLContexs );
var
   C :TCLContex;
begin
     with MemoS.Lines do
     begin
          Add( ' ┃　│' );
          Add( ' ┃　┝ Contexs[*] :TCLContexs' );
          for C in Contexs_ do
          begin
               Add( ' ┃　│　┃' );
               Add( ' ┃　│　┣・Contex[' + C.Order.ToString + '] :TCLContex' );

               ShowCommans( C.Commans );
               ShowMemorys( C.Memorys );
               ShowProgras( C.Progras );
          end;
     end;
end;

procedure TForm1.ShowDevices( const Devices_:TCLDevices );
var
   D :TCLDevice;
   Cs :T_cl_device_svm_capabilities;
   S :String;
begin
     with MemoS.Lines do
     begin
          Add( ' ┃　│' );
          Add( ' ┃　┝ Devices[*] :TCLDevices' );
          for D in Devices_ do
          begin
               Add( ' ┃　│　┃' );
               Add( ' ┃　│　┣・Device[' + D.Order.ToString + '] :TCLDevice' );
               Add( ' ┃　│　┃　├ DEVICE_TYPE             = '  + D.DEVICE_TYPE     .ToString );
               Add( ' ┃　│　┃　├ DEVICE_VENDOR_ID        = '  + D.DEVICE_VENDOR_ID.ToString );
               Add( ' ┃　│　┃　├ DEVICE_NAME             = '  + D.DEVICE_NAME               );
               Add( ' ┃　│　┃　├ DEVICE_VENDOR           = '  + D.DEVICE_VENDOR             );
               Add( ' ┃　│　┃　├ DRIVER_VERSION          = '  + D.DRIVER_VERSION            );
               Add( ' ┃　│　┃　├ DEVICE_PROFILE          = '  + D.DEVICE_PROFILE            );
               Add( ' ┃　│　┃　├ DEVICE_VERSION          = '  + D.DEVICE_VERSION            );

               Cs := D.DEVICE_SVM_CAPABILITIES;
               if Cs and CL_DEVICE_SVM_COARSE_GRAIN_BUFFER <> 0 then S := 'OK' else S := 'NO';
               Add( ' ┃　│　┃　├ SVM_COARSE_GRAIN_BUFFER = ' + S );
               if Cs and CL_DEVICE_SVM_FINE_GRAIN_BUFFER   <> 0 then S := 'OK' else S := 'NO';
               Add( ' ┃　│　┃　├ SVM_FINE_GRAIN_BUFFER   = ' + S );
               if Cs and CL_DEVICE_SVM_FINE_GRAIN_SYSTEM   <> 0 then S := 'OK' else S := 'NO';
               Add( ' ┃　│　┃　├ SVM_FINE_GRAIN_SYSTEM   = ' + S );
               if Cs and CL_DEVICE_SVM_ATOMICS             <> 0 then S := 'OK' else S := 'NO';
               Add( ' ┃　│　┃　├ SVM_ATOMICS             = ' + S );
          end;
     end;
end;

procedure TForm1.ShowExtenss( const Extenss_:TCLExtenss );
var
   I :Integer;
   E :String;
begin
     with MemoS.Lines do
     begin
          Add( ' ┃　│' );
          Add( ' ┃　├ Extenss[*] :TCLExtenss' );
          for I := 0 to Extenss_.Count-1 do
          begin
               E := Extenss_[ I ];

               Add( ' ┃　│　├ Extens[' + I.ToString + '] = ' + E );
          end;
     end;
end;

procedure TForm1.ShowPlatfos( const Platfos_:TCLPlatfos );
var
   F :TCLPlatfo;
begin
     with MemoS.Lines do
     begin
          Add( 'Platfos[*] :TCLPlatfos' );

          for F in Platfos_ do
          begin
               Add( ' ┃' );
               Add( ' ┣・Platfo[' + F.Order.ToString + '] :TCLPlatfo' );
               Add( ' ┃　├ Profile = ' + F.Profile );
               Add( ' ┃　├ Version = ' + F.Version );
               Add( ' ┃　├ Name    = ' + F.Name    );
               Add( ' ┃　├ Vendor  = ' + F.Vendor  );

               ShowExtenss( F.Extenss );
               ShowDevices( F.Devices );
               ShowContexs( F.Contexs );
          end;
     end;
end;

procedure TForm1.ShowSystem;
begin
     ShowPlatfos( _OpenCL_.Platfos );

     MemoS.Lines.Add( '' );
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

          A := TCLBufferIter<T_float>.Create( _Comman, _BufferA );
          B := TCLBufferIter<T_float>.Create( _Comman, _BufferB );
          C := TCLBufferIter<T_float>.Create( _Comman, _BufferC );

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
     _Platfo := _OpenCL_.Platfos[ 0 ];                                          // 選択

     ///// デバイス
     _Device := _Platfo.Devices[ 0 ];                                           // 選択

     ///// コンテキスト
     _Contex := TCLContex.Create( _Platfo );                                    // 生成

     ///// コマンドキュー
     _Comman := TCLComman.Create( _Contex, _Device );                           // 生成

     ///// バッファー
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

     ///// プログラム
     _Progra := TCLProgra.Create( _Contex );                                    // 生成
     _Progra.Source.LoadFromFile( '..\..\_DATA\Source.cl' );                    // ソースコードの読み込み

     MemoC.Lines.Assign( _Progra.Source );                                      // ソースコードの表示

     ///// カーネル
     _Kernel := TCLKernel.Create( _Progra, 'Main', _Comman );                   // 生成
     _Kernel.Argumes.Add( _BufferA );                                           // バッファの登録
     _Kernel.Argumes.Add( _BufferB );                                           // バッファの登録
     _Kernel.Argumes.Add( _BufferC );                                           // バッファの登録
     _Kernel.GlobWorkSize := [ 10 ];                                            // ループ回数の設定

     //////////

     _Kernel.Run;                                                               // 実行

     ShowSystem;                                                                // システム表示
     ShowResult;                                                                // 結果表示
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
     MemoS.Lines.SaveToFile( 'System.txt', TEncoding.UTF8 );
end;

end. //######################################################################### ■
