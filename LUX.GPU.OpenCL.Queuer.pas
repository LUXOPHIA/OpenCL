﻿unit LUX.GPU.OpenCL.Queuer;

interface //#################################################################### ■

uses cl_version, cl_platform, cl,
     LUX.Data.List,
     LUX.Code.C,
     LUX.GPU.OpenCL.core,
     LUX.GPU.OpenCL.Device;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TCLQueuers <TCLContex_,TCLPlatfo_:class> = class;
       TCLQueuer<TCLContex_,TCLPlatfo_:class> = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLQueuer<TCLContex_,TCLPlatfo_>

     TCLQueuer<TCLContex_,TCLPlatfo_:class> = class( TListChildr<TCLContex_,TCLQueuers<TCLContex_,TCLPlatfo_>> )
     private
       type TCLDevice_  = TCLDevice <TCLPlatfo_>;
            TCLQueuers_ = TCLQueuers<TCLContex_,TCLPlatfo_>;
     protected
       _Device :TCLDevice_;
       _Handle :T_cl_command_queue;
       ///// アクセス
       function GetHandle :T_cl_command_queue;
       procedure SetHandle( const Handle_:T_cl_command_queue );
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
       property Device  :TCLDevice_         read   _Device                ;
       property Handle  :T_cl_command_queue read GetHandle write SetHandle;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLQueuers<TCLContex_,TCLPlatfo_>

     TCLQueuers<TCLContex_,TCLPlatfo_:class> = class( TListParent<TCLContex_,TCLQueuer<TCLContex_,TCLPlatfo_>> )
     private
       type TCLDevice_ = TCLDevice<TCLPlatfo_>;
            TCLQueuer_ = TCLQueuer<TCLContex_,TCLPlatfo_>;
     protected
     public
       ///// プロパティ
       property Contex :TCLContex_ read GetOwnere;
       ///// メソッド
       function Add( const Device_:TCLDevice_ ) :TCLQueuer_; overload;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses LUX.GPU.OpenCL;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLQueuer<TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLQueuer<TCLContex_,TCLPlatfo_>.GetHandle :T_cl_command_queue;
begin
     if not Assigned( _Handle ) then CreateHandle;

     Result := _Handle;
end;

procedure TCLQueuer<TCLContex_,TCLPlatfo_>.SetHandle( const Handle_:T_cl_command_queue );
begin
     if Assigned( _Handle ) then AssertCL( DestroHandle, 'TCLQueuer.DestroHandle is Error!' );

     _Handle := Handle_;
end;

/////////////////////////////////////////////////////////////////////// メソッド

function TCLQueuer<TCLContex_,TCLPlatfo_>.CreateHandle :T_cl_int;
begin
     {$IF CL_VERSION_2_0 <> 0 }
     _Handle := clCreateCommandQueueWithProperties( TCLContex( Contex ).Handle,
                                                    TCLDevice( Device ).Handle,
                                                    nil,
                                                    @Result );
     {$ELSE}
     _Handle := clCreateCommandQueue              ( TCLContex( Contex ).Handle,
                                                    TCLDevice( Device ).Handle,
                                                    nil,
                                                    @Result );
     {$ENDIF}
end;

function TCLQueuer<TCLContex_,TCLPlatfo_>.DestroHandle :T_cl_int;
begin
     Result := clReleaseCommandQueue( _Handle );

     _Handle := nil;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLQueuer<TCLContex_,TCLPlatfo_>.Create;
begin
     inherited;

     _Handle := nil;
end;

constructor TCLQueuer<TCLContex_,TCLPlatfo_>.Create( const Contex_:TCLContex_; const Device_:TCLDevice_ );
begin
     inherited Create( TCLContex( Contex_ ).Queuers );

     _Device := Device_;
end;

destructor TCLQueuer<TCLContex_,TCLPlatfo_>.Destroy;
begin
      Handle := nil;

     TCLContex( Contex ).Handle := nil;

     inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLQueuers<TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

function TCLQueuers<TCLContex_,TCLPlatfo_>.Add( const Device_:TCLDevice_ ) :TCLQueuer_;
begin
     Result := TCLQueuer_.Create( Contex, Device_ );
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

end. //######################################################################### ■
