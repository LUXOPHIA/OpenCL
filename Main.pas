unit Main;

interface //#################################################################### ■

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.TabControl, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo,
  LUX.GPU.OpenCL,
  LUX.GPU.OpenCL.Context;

type
  TForm1 = class(TForm)
    TabControl1: TTabControl;
      TabItem1: TTabItem;
        Memo1: TMemo;
      TabItem2: TTabItem;
        Memo2: TMemo;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private 宣言 }
  public
    { public 宣言 }
    _Context :TCLContext;
    ///// メソッド
    procedure ShowOPENCL;
    procedure ShowContext;
  end;

var
  Form1: TForm1;

implementation //############################################################### ■

{$R *.fmx}


//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

procedure TForm1.ShowOPENCL;
var
   PI, EI, DI :Integer;
   P :TCLPlatform;
   D :TCLDevice;
begin
     with Memo1.Lines do
     begin
          Add( '・Platforms' );

          for PI := 0 to _OpenCL_.Platforms.Count-1 do
          begin
               P := _OpenCL_.Platforms[ PI ];

               Add( '　・Platform[ ' + PI.ToString + ' ]：$' + Longint( P.ID ).ToHexString );

               Add( '　　・Profile：' + P.Profile );
               Add( '　　・Version：' + P.Version );
               Add( '　　・Name   ：' + P.Name    );
               Add( '　　・Vendor ：' + P.Vendor  );

               Add( '　　・Extensions' );
               for EI := 0 to P.Extensions.Count-1 do Add( '　　　・' + P.Extensions[ EI ] );

               Add( '　　・Devices' );
               for DI := 0 to P.Devices.Count-1 do
               begin
                    D := P.Devices[ DI ];

                    Add( '　　　・Device[ ' + DI.ToString + ' ]：$' + Longint( D.ID ).ToHexString );

                    Add( '　　　　・DEVICE_TYPE     ：'  + IntTosTr( D.DEVICE_TYPE      ) );
                    Add( '　　　　・DEVICE_VENDOR   ：'  +           D.DEVICE_VENDOR      );
                    Add( '　　　　・DEVICE_VENDOR_ID：'  + IntToStr( D.DEVICE_VENDOR_ID ) );
                    Add( '　　　　・DEVICE_VERSION  ：'  +           D.DEVICE_VERSION     );
                    Add( '　　　　・DRIVER_VERSION  ：'  +           D.DRIVER_VERSION     );
               end;
          end;
     end;
end;

//------------------------------------------------------------------------------

procedure TForm1.ShowContext;
var
   CI :Integer;
   C :TCLCommand;
begin
     with Memo2.Lines do
     begin
          Add( '・Handle  ：$' + LongInt( _Context.Handle ).ToHexString );

          Add( '・Commands：' );
          for CI := 0 to _Context.Commands.Count-1 do
          begin
               C := _Context.Commands[ CI ];

               Add( '　・Command[ ' + CI.ToString + ' ]' );
               Add( '　　・Handle：$' + LongInt( C.Handle    ).ToHexString );
               Add( '　　・Device：$' + LongInt( C.Device.ID ).ToHexString );
          end;
     end;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

procedure TForm1.FormCreate(Sender: TObject);
begin
     ShowOPENCL;

     _Context := TCLContext.Create( _OpenCL_.Platforms[ 0 ] );

     _Context.Add( _OpenCL_.Platforms[ 0 ].Devices[ 0 ] );

     ShowContext;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
     _Context.Free;
end;

end. //######################################################################### ■
