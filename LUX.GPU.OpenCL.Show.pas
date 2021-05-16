unit LUX.GPU.OpenCL.Show;

interface //#################################################################### ■

uses System.Classes,
     cl_version, cl_platform, cl,
     LUX.Code.C,
     LUX.GPU.OpenCL.core;

//type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

procedure ShowSystem( const Strings_:TStrings );

implementation //############################################################### ■

uses System.SysUtils,
     LUX.GPU.OpenCL;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

procedure ShowParames( const Strings_:TStrings; const Parames_:TCLParames );
var
   A :TCLParame;
begin
     with Strings_ do
     begin
          Add( ' ┃　│　┃　│　┃　│　┃　│' );
          Add( ' ┃　│　┃　│　┃　│　┃　┝ Parames(' + Parames_.Count.ToString + ') :TCLParames' );
          for A in Parames_ do
          begin
               Add( ' ┃　│　┃　│　┃　│　┃　│　┃' );
               Add( ' ┃　│　┃　│　┃　│　┃　│　┣・Parame[' + A.Order.ToString + '] :TCLParame' );
               Add( ' ┃　│　┃　│　┃　│　┃　│　┃　├ Name    = ' + A.Name );
               Add( ' ┃　│　┃　│　┃　│　┃　│　┃　├ ParameI = ' + A.ParameI.ToString );
               Add( ' ┃　│　┃　│　┃　│　┃　│　┃　├ Argume  = Platfo[' + A.Argume.Contex.Platfo.Order.ToString + ']'
                                                                   + '.Contex[' + A.Argume.Contex       .Order.ToString + ']'
                                                                   + '.Argume[' + A.Argume              .Order.ToString + ']' );
          end;
     end;
end;

procedure ShowKernels( const Strings_:TStrings; const Kernels_:TCLKernels );
var
   K :TCLKernel;
begin
     with Strings_ do
     begin
          Add( ' ┃　│　┃　│　┃　│' );
          Add( ' ┃　│　┃　│　┃　┝ Kernels(' + Kernels_.Count.ToString + ') :TCLKernels' );
          for K in Kernels_ do
          begin
               Add( ' ┃　│　┃　│　┃　│　┃' );
               Add( ' ┃　│　┃　│　┃　│　┣・Kernel[' + K.Order.ToString + '] :TCLKernel' );
               Add( ' ┃　│　┃　│　┃　│　┃　├ Name    = ' + K.Name );
               Add( ' ┃　│　┃　│　┃　│　┃　├ GloDimN = ' + K.GloDimN.ToString );
               Add( ' ┃　│　┃　│　┃　│　┃　├ Queuer  = Platfo[' + K.Queuer.Contex.Platfo.Order.ToString + ']'
                                                           + '.Contex[' + K.Queuer.Contex       .Order.ToString + ']'
                                                           + '.Queuer[' + K.Queuer              .Order.ToString + ']' );

               ShowParames( Strings_, K.Parames );
          end;
     end;
end;

procedure ShowBuildrs( const Strings_:TStrings; const Buildrs_:TCLBuildrs );
var
   B :TCLBuildr;
begin
     with Strings_ do
     begin
          Add( ' ┃　│　┃　│　┃　│' );
          Add( ' ┃　│　┃　│　┃　┝ Buildrs(' + Buildrs_.Count.ToString + ') :TCLBuildrs' );
          for B in Buildrs_ do
          begin
               Add( ' ┃　│　┃　│　┃　│　┃' );
               Add( ' ┃　│　┃　│　┃　│　┣・Buildr[' + B.Order.ToString + '] :TCLBuildr' );
               Add( ' ┃　│　┃　│　┃　│　┃　├ Device       = Platfo[' + B.Device.Platfo.Order.ToString + ']'
                                                                + '.Device[' + B.Device       .Order.ToString + ']' );
               Add( ' ┃　│　┃　│　┃　│　┃　├ CompileState = ' + B.CompileStatus.ToString );
               Add( ' ┃　│　┃　│　┃　│　┃　├ LinkState    = ' + B.LinkStatus.ToString );
          end;
     end;
end;

procedure ShowExecuts( const Strings_:TStrings; const Executs_:TCLExecuts );
var
   E :TCLExecut;
begin
     with Strings_ do
     begin
          Add( ' ┃　│　┃　│' );
          Add( ' ┃　│　┃　┝ Executs(' + Executs_.Count.ToString + ') :TCLExecuts' );
          for E in Executs_ do
          begin
               Add( ' ┃　│　┃　│　┃' );
               Add( ' ┃　│　┃　│　┣・Execut[' + E.Order.ToString + '] :TCLExecut' );
               Add( ' ┃　│　┃　│　┃　├ Name    = ' + E.Name );
               Add( ' ┃　│　┃　│　┃　├ LangVer = ' + E.LangVer.ToString );

               ShowBuildrs( Strings_, E.Buildrs );
               ShowKernels( Strings_, E.Kernels );
          end;
     end;
end;

procedure ShowLibrars( const Strings_:TStrings; const Librars_:TCLLibrars );
var
   L :TCLLibrar;
begin
     with Strings_ do
     begin
          Add( ' ┃　│　┃　│' );
          Add( ' ┃　│　┃　┝ Librars(' + Librars_.Count.ToString + ') :TCLLibrars' );
          for L in Librars_ do
          begin
               Add( ' ┃　│　┃　│　┃' );
               Add( ' ┃　│　┃　│　┣・Librar[' + L.Order.ToString + '] :TCLLibrar' );
               Add( ' ┃　│　┃　│　┃　├ Name = ' + L.Name );
          end;
     end;
end;

procedure ShowArgumes( const Strings_:TStrings; const Argumes_:TCLArgumes );
var
   A :TCLArgume;
   M :TCLMemory;
begin
     with Strings_ do
     begin
          Add( ' ┃　│　┃　│' );
          Add( ' ┃　│　┃　┝ Argumes(' + Argumes_.Count.ToString + ') :TCLArgumes' );
          for A in Argumes_ do
          begin
               Add( ' ┃　│　┃　│　┃' );
               Add( ' ┃　│　┃　│　┣・Argume[' + A.Order.ToString + '] :TCLArgume' );
               Add( ' ┃　│　┃　│　┃　├ Class = ' + A.ClassName );

               if A.ClassType = TCLMemory then
               begin
                    M := A as TCLMemory;

                    Add( ' ┃　│　┃　│　┃　├ Size  = ' + M.Size.ToString );
               end;
          end;
     end;
end;

procedure ShowQueuers( const Strings_:TStrings; const Queuers_:TCLQueuers );
var
   Q :TCLQueuer;
begin
     with Strings_ do
     begin
          Add( ' ┃　│　┃　│' );
          Add( ' ┃　│　┃　┝ Queuers(' + Queuers_.Count.ToString + ') :TCLQueuers' );
          for Q in Queuers_ do
          begin
               Add( ' ┃　│　┃　│　┃' );
               Add( ' ┃　│　┃　│　┣・Queuer[' + Q.Order.ToString + '] :TCLQueuer' );
               Add( ' ┃　│　┃　│　┃　├ Device = Platfo[' + Q.Device.Platfo.Order.ToString + ']'
                                                  + '.Device[' + Q.Device       .Order.ToString + ']' );
          end;
     end;
end;

procedure ShowContexs( const Strings_:TStrings; const Contexs_:TCLContexs );
var
   C :TCLContex;
begin
     with Strings_ do
     begin
          Add( ' ┃　│' );
          Add( ' ┃　┝ Contexs(' + Contexs_.Count.ToString + ') :TCLContexs' );
          for C in Contexs_ do
          begin
               Add( ' ┃　│　┃' );
               Add( ' ┃　│　┣・Contex[' + C.Order.ToString + '] :TCLContex' );

               ShowQueuers( Strings_, C.Queuers );
               ShowArgumes( Strings_, C.Argumes );
               ShowLibrars( Strings_, C.Librars );
               ShowExecuts( Strings_, C.Executs );
          end;
     end;
end;

procedure ShowDevices( const Strings_:TStrings; const Devices_:TCLDevices );
var
   D :TCLDevice;
   Cs :T_cl_device_svm_capabilities;
   S :String;
begin
     with Strings_ do
     begin
          Add( ' ┃　│' );
          Add( ' ┃　┝ Devices(' + Devices_.Count.ToString + ') :TCLDevices' );
          for D in Devices_ do
          begin
               Add( ' ┃　│　┃' );
               Add( ' ┃　│　┣・Device[' + D.Order.ToString + '] :TCLDevice' );
               Add( ' ┃　│　┃　├ DEVICE_TYPE             = '  + D.DEVICE_TYPE.ToString );
               Add( ' ┃　│　┃　├ DEVICE_VENDOR_ID        = '  + D.DEVICE_VENDOR_ID.ToString );
               Add( ' ┃　│　┃　├ DEVICE_NAME             = '  + D.DEVICE_NAME );
               Add( ' ┃　│　┃　├ DEVICE_VENDOR           = '  + D.DEVICE_VENDOR );
               Add( ' ┃　│　┃　├ DRIVER_VERSION          = '  + D.DRIVER_VERSION );
               Add( ' ┃　│　┃　├ DEVICE_PROFILE          = '  + D.DEVICE_PROFILE );
               Add( ' ┃　│　┃　├ DEVICE_VERSION          = '  + D.DEVICE_VERSION );

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

procedure ShowExtenss( const Strings_:TStrings; const Extenss_:TCLExtenss );
var
   I :Integer;
   E :String;
begin
     with Strings_ do
     begin
          Add( ' ┃　│' );
          Add( ' ┃　├ Extenss(' + Extenss_.Count.ToString + ') :TCLExtenss' );
          for I := 0 to Extenss_.Count-1 do
          begin
               E := Extenss_[ I ];

               Add( ' ┃　│　├ Extens[' + I.ToString + '] = ' + E );
          end;
     end;
end;

procedure ShowPlatfos( const Strings_:TStrings; const Platfos_:TCLPlatfos );
var
   F :TCLPlatfo;
begin
     with Strings_ do
     begin
          Add( 'Platfos(' + Platfos_.Count.ToString + ') :TCLPlatfos' );
          for F in Platfos_ do
          begin
               Add( ' ┃' );
               Add( ' ┣・Platfo[' + F.Order.ToString + '] :TCLPlatfo' );
               Add( ' ┃　├ Profile = ' + F.Profile );
               Add( ' ┃　├ Version = ' + F.Version );
               Add( ' ┃　├ Name    = ' + F.Name );
               Add( ' ┃　├ Vendor  = ' + F.Vendor );

               ShowExtenss( Strings_, F.Extenss );
               ShowDevices( Strings_, F.Devices );
               ShowContexs( Strings_, F.Contexs );
          end;
     end;
end;

procedure ShowSystem( const Strings_:TStrings );
begin
     ShowPlatfos( Strings_, TOpenCL.Platfos );

     Strings_.Add( '' );
end;

end. //######################################################################### ■
