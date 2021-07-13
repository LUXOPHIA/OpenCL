unit LUX.GPU.OpenCL.Queuer;

interface //#################################################################### ■

uses System.Generics.Collections,
     cl_version, cl_platform, cl,
     LUX.Data.List,
     LUX.Code.C,
     LUX.GPU.OpenCL.core,
     LUX.GPU.OpenCL.Device;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TCLQueuers <TCLSystem_,TCLPlatfo_,TCLContex_:class> = class;
       TCLQueuer<TCLSystem_,TCLPlatfo_,TCLContex_:class> = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLQueuer<TCLSystem_,TCLPlatfo_,TCLContex_>

     TCLQueuer<TCLSystem_,TCLPlatfo_,TCLContex_:class> = class( TListChildr<TCLContex_,TCLQueuers<TCLSystem_,TCLPlatfo_,TCLContex_>> )
     private
       type TCLDevice_  = TCLDevice <TCLSystem_,TCLPlatfo_>;
            TCLQueuers_ = TCLQueuers<TCLSystem_,TCLPlatfo_,TCLContex_>;
     protected
       _Device :TCLDevice_;
       _Handle :T_cl_command_queue;
       ///// アクセス
       function GetHandle :T_cl_command_queue;
       procedure SetHandle( const Handle_:T_cl_command_queue );
       function GetDevice :TCLDevice_;
       procedure SetDevice( const Device_:TCLDevice_ );
       ///// メソッド
       function CreateHandle :T_cl_int; virtual;
       function DestroHandle :T_cl_int; virtual;
     public
       constructor Create; override;
       constructor Create( const Contex_:TCLContex_; const Device_:TCLDevice_ ); overload; virtual;
       destructor Destroy; override;
       ///// プロパティ
       property Contex  :TCLContex_         read GetOwnere                ;
       property Queuers :TCLQueuers_        read GetParent                ;
       property Handle  :T_cl_command_queue read GetHandle write SetHandle;
       property Device  :TCLDevice_         read GetDevice write SetDevice;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLQueuers<TCLSystem_,TCLPlatfo_,TCLContex_>

     TCLQueuers<TCLSystem_,TCLPlatfo_,TCLContex_:class> = class( TListParent<TCLContex_,TCLQueuer<TCLSystem_,TCLPlatfo_,TCLContex_>> )
     private
       type TCLDevice_  = TCLDevice<TCLSystem_,TCLPlatfo_>;
            TCLQueuer_  = TCLQueuer<TCLSystem_,TCLPlatfo_,TCLContex_>;
            TCLDevQues_ = TDictionary<TCLDevice_,TCLQueuer_>;
     protected
       _DevQues :TCLDevQues_;
       ///// アクセス
       function GetQueuers( const Device_:TCLDevice_ ) :TCLQueuer_;
       procedure SetQueuers( const Device_:TCLDevice_; const Queuer_:TCLQueuer_ );
       ///// イベント
       procedure OnInsertChild( const Childr_:TCLQueuer_ ); override;
       procedure OnRemoveChild( const Childr_:TCLQueuer_ ); override;
     public
       constructor Create; override;
       destructor Destroy; override;
       ///// プロパティ
       property Contex                              :TCLContex_ read GetOwnere                  ;
       property Queuers[ const Device_:TCLDevice_ ] :TCLQueuer_ read GetQueuers write SetQueuers; default;
       ///// メソッド
       function Contains( const Device_:TCLDevice_ ) :Boolean;
       function Add( const Device_:TCLDevice_ ) :TCLQueuer_; overload;
       function GetDeviceIDs :TArray<T_cl_device_id>;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses LUX.GPU.OpenCL.Contex;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLQueuer<TCLSystem_,TCLPlatfo_,TCLContex_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLQueuer<TCLSystem_,TCLPlatfo_,TCLContex_>.GetHandle :T_cl_command_queue;
begin
     if not Assigned( _Handle ) then CreateHandle;

     Result := _Handle;
end;

procedure TCLQueuer<TCLSystem_,TCLPlatfo_,TCLContex_>.SetHandle( const Handle_:T_cl_command_queue );
begin
     if Assigned( _Handle ) then AssertCL( DestroHandle, 'TCLQueuer.DestroHandle is Error!' );

     _Handle := Handle_;
end;

//------------------------------------------------------------------------------

function TCLQueuer<TCLSystem_,TCLPlatfo_,TCLContex_>.GetDevice :TCLDevice_;
begin
     Result := _Device;
end;

procedure TCLQueuer<TCLSystem_,TCLPlatfo_,TCLContex_>.SetDevice( const Device_:TCLDevice_ );
begin
     _Device := Device_;

     Handle := nil;
end;

/////////////////////////////////////////////////////////////////////// メソッド

function TCLQueuer<TCLSystem_,TCLPlatfo_,TCLContex_>.CreateHandle :T_cl_int;
begin
     {$IF CL_VERSION_2_0 <> 0 }
     _Handle := clCreateCommandQueueWithProperties( TCLContex<TCLSystem_,TCLPlatfo_>( Contex ).Handle,
                                                    Device.Handle,
                                                    nil,
                                                    @Result );
     {$ELSE}
     _Handle := clCreateCommandQueue              ( TCLContex<TCLSystem_,TCLPlatfo_>( Contex ).Handle,
                                                    Device.Handle,
                                                    nil,
                                                    @Result );
     {$ENDIF}
end;

function TCLQueuer<TCLSystem_,TCLPlatfo_,TCLContex_>.DestroHandle :T_cl_int;
begin
     Result := clReleaseCommandQueue( _Handle );

     _Handle := nil;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLQueuer<TCLSystem_,TCLPlatfo_,TCLContex_>.Create;
begin
     inherited;

     _Handle := nil;
end;

constructor TCLQueuer<TCLSystem_,TCLPlatfo_,TCLContex_>.Create( const Contex_:TCLContex_; const Device_:TCLDevice_ );
begin
     inherited Create( TCLContex<TCLSystem_,TCLPlatfo_>( Contex_ ).Queuers );

     _Device := Device_;
end;

destructor TCLQueuer<TCLSystem_,TCLPlatfo_,TCLContex_>.Destroy;
begin
      Handle := nil;

     TCLContex<TCLSystem_,TCLPlatfo_>( Contex ).Handle := nil;

     inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLQueuers<TCLSystem_,TCLPlatfo_,TCLContex_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLQueuers<TCLSystem_,TCLPlatfo_,TCLContex_>.GetQueuers( const Device_:TCLDevice_ ) :TCLQueuer_;
begin
     if Contains( Device_ ) then Result := _DevQues[ Device_ ]
                            else Result := Add( Device_ );
end;

procedure TCLQueuers<TCLSystem_,TCLPlatfo_,TCLContex_>.SetQueuers( const Device_:TCLDevice_; const Queuer_:TCLQueuer_ );
begin
     Queuer_.Device := Device_;
     Queuer_.Parent := Self;
end;

/////////////////////////////////////////////////////////////////////// イベント

procedure TCLQueuers<TCLSystem_,TCLPlatfo_,TCLContex_>.OnInsertChild( const Childr_:TCLQueuer_ );
begin
     inherited;

     if Contains( Childr_.Device ) then _DevQues[ Childr_.Device ].Free;

     _DevQues.Add( Childr_.Device, Childr_ );
end;

procedure TCLQueuers<TCLSystem_,TCLPlatfo_,TCLContex_>.OnRemoveChild( const Childr_:TCLQueuer_ );
begin
     inherited;

     _DevQues.Remove( Childr_.Device );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLQueuers<TCLSystem_,TCLPlatfo_,TCLContex_>.Create;
begin
     inherited;

     _DevQues := TCLDevQues_.Create;
end;

destructor TCLQueuers<TCLSystem_,TCLPlatfo_,TCLContex_>.Destroy;
begin
     Clear;

     _DevQues.Free;

     inherited;
end;

/////////////////////////////////////////////////////////////////////// メソッド

function TCLQueuers<TCLSystem_,TCLPlatfo_,TCLContex_>.Contains( const Device_:TCLDevice_ ) :Boolean;
begin
     Result := _DevQues.ContainsKey( Device_ );
end;

//------------------------------------------------------------------------------

function TCLQueuers<TCLSystem_,TCLPlatfo_,TCLContex_>.Add( const Device_:TCLDevice_ ) :TCLQueuer_;
begin
     Result := TCLQueuer_.Create( Contex, Device_ );
end;

//------------------------------------------------------------------------------

function TCLQueuers<TCLSystem_,TCLPlatfo_,TCLContex_>.GetDeviceIDs :TArray<T_cl_device_id>;
var
   I :Integer;
begin
     SetLength( Result, Count );

     for I := 0 to Count-1 do Result[ I ] := Items[ I ].Device.Handle;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

end. //######################################################################### ■
