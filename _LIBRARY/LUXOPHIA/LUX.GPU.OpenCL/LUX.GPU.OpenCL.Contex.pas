unit LUX.GPU.OpenCL.Contex;

interface //#################################################################### ■

uses System.Generics.Collections,
     cl_version, cl_platform, cl,
     LUX.Code.C,
     LUX.GPU.OpenCL.root,
     LUX.GPU.OpenCL.Comman,
     LUX.GPU.OpenCL.Progra,
     LUX.GPU.OpenCL.Memory;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLContext<_TPlatform_,_TDevice_>

     TCLContext<_TPlatform_,_TDevice_:class> = class
     private
       type TCLComman  = TCLComman<TCLContext<_TPlatform_,_TDevice_>,_TDevice_>;
       type TCLProgram = TCLProgram<TCLContext<_TPlatform_,_TDevice_>>;
       type TCLMemory  = TCLMemory<TCLContext<_TPlatform_,_TDevice_>>;
     protected
       _Parent   :_TPlatform_;
       _Commands :TObjectList<TCLComman>;
       _Handle   :T_cl_context;
       _Programs :TObjectList<TCLProgram>;
       _Memorys  :TObjectList<TCLMemory>;
       ///// アクセス
       procedure SetParent( const Parent_:_TPlatform_ );
       function GetHandle :T_cl_context;
       function GetavHandle :Boolean;
       procedure SetavHandle( const avHandle_:Boolean );
       ///// メソッド
       procedure BeginHandle;
       procedure EndHandle;
     public
       constructor Create; overload;
       constructor Create( const Parent_:_TPlatform_ ); overload;
       constructor Create( const Parent_:_TPlatform_; const Devices_:TArray<_TDevice_> ); overload;
       destructor Destroy; override;
       ///// プロパティ
       property Parent   :_TPlatform_             read   _Parent   write SetParent  ;
       property Commands :TObjectList<TCLComman>  read   _Commands                  ;
       property Handle   :T_cl_context            read GetHandle                    ;
       property avHandle :Boolean                 read GetavHandle write SetavHandle;
       property Programs :TObjectList<TCLProgram> read   _Programs                  ;
       property Memorys  :TObjectList<TCLMemory>  read   _Memorys                   ;
       ///// メソッド
       procedure Add( const Device_:_TDevice_ );
       procedure Remove( const Device_:_TDevice_ );
       function GetDevices :TArray<T_cl_device_id>;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses LUX.GPU.OpenCL;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLContext<_TPlatform_,_TDevice_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

procedure TCLContext<_TPlatform_,_TDevice_>.SetParent( const Parent_:_TPlatform_ );
begin
     if Assigned( _Parent ) then TCLPlatform( _Parent ).Contexts.Remove( TCLContext( Self ) );

                  _Parent := Parent_;

     if Assigned( _Parent ) then TCLPlatform( _Parent ).Contexts.Add   ( TCLContext( Self ) );
end;

//------------------------------------------------------------------------------

function TCLContext<_TPlatform_,_TDevice_>.GetHandle :T_cl_context;
begin
     if not avHandle then BeginHandle;

     Result := _Handle;
end;

function TCLContext<_TPlatform_,_TDevice_>.GetavHandle :Boolean;
begin
     Result := Assigned( _Handle );
end;

procedure TCLContext<_TPlatform_,_TDevice_>.SetavHandle( const avHandle_:Boolean );
begin
     if avHandle  then EndHandle;

     if avHandle_ then BeginHandle;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLContext<_TPlatform_,_TDevice_>.BeginHandle;
var
   Ps :array [ 0..2 ] of T_cl_context_properties;
   Ds :TArray<T_cl_device_id>;
begin
     Ps[ 0 ] := CL_CONTEXT_PLATFORM;
     Ps[ 1 ] := NativeInt( TCLPlatform( _Parent ).Handle );
     Ps[ 2 ] := 0;

     Ds := GetDevices;

     _Handle := clCreateContext( @Ps[0], Length( Ds ), @Ds[0], nil, nil, nil );
end;

procedure TCLContext<_TPlatform_,_TDevice_>.EndHandle;
begin
     clReleaseContext( _Handle );

     _Handle := nil;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLContext<_TPlatform_,_TDevice_>.Create;
begin
     inherited;

     _Commands := TObjectList<TCLComman>.Create;
     _Programs := TObjectList<TCLProgram>.Create;
     _Memorys  := TObjectList<TCLMemory >.Create;

     _Parent := nil;
     _Handle := nil;
end;

constructor TCLContext<_TPlatform_,_TDevice_>.Create( const Parent_:_TPlatform_ );
begin
     Create;

     Parent := Parent_;
end;

constructor TCLContext<_TPlatform_,_TDevice_>.Create( const Parent_:_TPlatform_; const Devices_:TArray<_TDevice_> );
var
   D :_TDevice_;
begin
     Create( Parent_ );

     for D in Devices_ do Add( D );
end;

destructor TCLContext<_TPlatform_,_TDevice_>.Destroy;
begin
     if avHandle then EndHandle;

     _Commands.Free;
     _Programs.Free;
     _Memorys .Free;

     inherited;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLContext<_TPlatform_,_TDevice_>.Add( const Device_:_TDevice_ );
begin
     _Commands.Add( TCLComman.Create( Self, Device_ ) );

     avHandle := False;
end;

procedure TCLContext<_TPlatform_,_TDevice_>.Remove( const Device_:_TDevice_ );
var
   C :TCLComman;
begin
     for C in _Commands do
     begin
          if C.Device = Device_ then C.Free;
     end;

     avHandle := False;
end;

//------------------------------------------------------------------------------

function TCLContext<_TPlatform_,_TDevice_>.GetDevices :TArray<T_cl_device_id>;
var
   I :Integer;
begin
     with _Commands do
     begin
          SetLength( Result, Count );

          for I := 0 to Count-1 do Result[ I ] := TCLDevice( Items[ I ].Device ).Handle;
     end;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

//############################################################################## □

initialization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 初期化

finalization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 最終化

end. //######################################################################### ■
