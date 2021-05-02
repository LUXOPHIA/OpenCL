unit LUX.GPU.OpenCL.Show;

interface //#################################################################### ■

uses System.Classes;

//type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

procedure ShowSystem( const Strings_:TStrings );

implementation //############################################################### ■

uses System.SysUtils,
     cl_version, cl_platform, cl,
     LUX.Code.C,
     LUX.GPU.OpenCL.root,
     LUX.GPU.OpenCL;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

procedure ShowArgumes( const Strings_:TStrings; const Argumes_:TCLArgumes );
var
   M :TCLMemory;
begin
     with Strings_ do
     begin
          Add( ' ┃　│　┃　│　┃　│　┃　│' );
          Add( ' ┃　│　┃　│　┃　│　┃　├ Argumes[*] :TCLArgumes' );
          for M in Argumes_ do
          begin
               Add( ' ┃　│　┃　│　┃　│　┃　│　├ Argume[' + M.Order.ToString + '] = Memory[' + M.Order.ToString + ']'  );
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
          Add( ' ┃　│　┃　│　┃　┝ Kernels[*] :TCLKernels' );
          for K in Kernels_ do
          begin
               Add( ' ┃　│　┃　│　┃　│　┃' );
               Add( ' ┃　│　┃　│　┃　│　┣・Kernel[' + K.Order.ToString + '] :TCLKernel' );
               Add( ' ┃　│　┃　│　┃　│　┃　├ Name      = ' + K.Name );
               Add( ' ┃　│　┃　│　┃　│　┃　├ Dimension = ' + K.Dimension.ToString );
               Add( ' ┃　│　┃　│　┃　│　┃　├ Comman    = Comman[' + K.Comman.Order.ToString + ']' );

               ShowArgumes( Strings_, K.Argumes );
          end;
     end;
end;

procedure ShowDeploys( const Strings_:TStrings; const Deploys_:TCLDeploys );
var
   L :TCLDeploy;
begin
     with Strings_ do
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
end;

procedure ShowProgras( const Strings_:TStrings; const Progras_:TCLProgras );
var
   P :TCLProgra;
begin
     with Strings_ do
     begin
          Add( ' ┃　│　┃　│' );
          Add( ' ┃　│　┃　┝ Progras[*] :TCLProgras' );
          for P in Progras_ do
          begin
               Add( ' ┃　│　┃　│　┃' );
               Add( ' ┃　│　┃　│　┣・Progra[' + P.Order.ToString + '] :TCLProgra' );
               Add( ' ┃　│　┃　│　┃　├ LangVer = ' + P.LangVer.ToString );

               ShowDeploys( Strings_, P.Deploys );
               ShowKernels( Strings_, P.Kernels );
          end;
     end;
end;

procedure ShowMemorys( const Strings_:TStrings; const Memorys_:TCLMemorys );
var
   M :TCLMemory;
begin
     with Strings_ do
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

procedure ShowCommans( const Strings_:TStrings; const Commans_:TCLCommans );
var
   Q :TCLComman;
begin
     with Strings_ do
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

procedure ShowContexs( const Strings_:TStrings; const Contexs_:TCLContexs );
var
   C :TCLContex;
begin
     with Strings_ do
     begin
          Add( ' ┃　│' );
          Add( ' ┃　┝ Contexs[*] :TCLContexs' );
          for C in Contexs_ do
          begin
               Add( ' ┃　│　┃' );
               Add( ' ┃　│　┣・Contex[' + C.Order.ToString + '] :TCLContex' );

               ShowCommans( Strings_, C.Commans );
               ShowMemorys( Strings_, C.Memorys );
               ShowProgras( Strings_, C.Progras );
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

procedure ShowExtenss( const Strings_:TStrings; const Extenss_:TCLExtenss );
var
   I :Integer;
   E :String;
begin
     with Strings_ do
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

procedure ShowPlatfos( const Strings_:TStrings; const Platfos_:TCLPlatfos );
var
   F :TCLPlatfo;
begin
     with Strings_ do
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

               ShowExtenss( Strings_, F.Extenss );
               ShowDevices( Strings_, F.Devices );
               ShowContexs( Strings_, F.Contexs );
          end;
     end;
end;

procedure ShowSystem( const Strings_:TStrings );
begin
     ShowPlatfos( Strings_, _OpenCL_.Platfos );

     Strings_.Add( '' );
end;

end. //######################################################################### ■
