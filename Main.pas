unit Main;

interface //#################################################################### ■

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.TabControl, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo,
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
      TabItemC: TTabItem;
        MemoC: TMemo;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private 宣言 }
  public
    { public 宣言 }
    _Context :TCLContext;
    _Program :TCLProgram;
    _Kernel  :TCLKernel;
    ///// メソッド
    procedure ShowPlatforms;
    procedure ShowDevices;
    procedure ShowContexts;
  end;

var
  Form1: TForm1;

implementation //############################################################### ■

{$R *.fmx}

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
begin
     ShowPlatforms;
     ShowDevices;

     _Context := TCLContext.Create( _OpenCL_.Platforms[ 0 ] );

     _Context.Add( _OpenCL_.Platforms[ 0 ].Devices[ 0 ] );

     ShowContexts;

     _Program := TCLProgram.Create( _Context );

     _Program.Source.LoadFromFile( '..\..\_DATA\Source.cl' );

     _Program.Build;

     MemoC.Lines.Assign( _Program.Source );

     _Kernel := TCLKernel.Create( _Program, 'add' );

     _Kernel.Handle;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
     /////
end;

end. //######################################################################### ■
