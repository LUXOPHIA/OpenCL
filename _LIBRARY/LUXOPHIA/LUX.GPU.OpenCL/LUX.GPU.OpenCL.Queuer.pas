unit LUX.GPU.OpenCL.Queuer;

interface //#################################################################### ■

uses cl_version, cl_platform, cl,
     LUX.Data.List,
     LUX.Code.C,
     LUX.GPU.OpenCL.root,
     LUX.GPU.OpenCL.Device;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TCLCommans <TCLContex_,TCLPlatfo_:class> = class;
       TCLComman<TCLContex_,TCLPlatfo_:class> = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLComman<TCLContex_,TCLPlatfo_>

     TCLComman<TCLContex_,TCLPlatfo_:class> = class( TListChildr<TCLContex_,TCLCommans<TCLContex_,TCLPlatfo_>> )
     private
       type TCLDevice_  = TCLDevice <TCLPlatfo_>;
            TCLCommans_ = TCLCommans<TCLContex_,TCLPlatfo_>;
     protected
       _Device :TCLDevice_;
       _Handle :T_cl_command_queue;
       ///// アクセス
       function GetHandle :T_cl_command_queue;
       procedure SetHandle( const Handle_:T_cl_command_queue );
       ///// メソッド
       procedure CreateHandle;
       procedure DestroHandle;
     public
       constructor Create; override;
       constructor Create( const Contex_:TCLContex_; const Device_:TCLDevice_ ); overload; virtual;
       destructor Destroy; override;
       ///// プロパティ
       property Contex  :TCLContex_         read GetOwnere                ;
       property Commans :TCLCommans_        read GetParent                ;
       property Device  :TCLDevice_         read   _Device                ;
       property Handle  :T_cl_command_queue read GetHandle write SetHandle;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLCommans<TCLContex_,TCLPlatfo_>

     TCLCommans<TCLContex_,TCLPlatfo_:class> = class( TListParent<TCLContex_,TCLComman<TCLContex_,TCLPlatfo_>> )
     private
     protected
     public
       ///// プロパティ
       property Contex :TCLContex_ read GetOwnere;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses LUX.GPU.OpenCL;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLComman<TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLComman<TCLContex_,TCLPlatfo_>.GetHandle :T_cl_command_queue;
begin
     if not Assigned( _Handle ) then CreateHandle;

     Result := _Handle;
end;

procedure TCLComman<TCLContex_,TCLPlatfo_>.SetHandle( const Handle_:T_cl_command_queue );
begin
     if Assigned( _Handle ) then DestroHandle;

     _Handle := Handle_;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLComman<TCLContex_,TCLPlatfo_>.CreateHandle;
begin
     {$IF CL_VERSION_2_0 <> 0 }
     _Handle := clCreateCommandQueueWithProperties( TCLContex( Contex ).Handle, TCLDevice( Device ).Handle, nil, nil );
     {$ELSE}
     _Handle := clCreateCommandQueue              ( TCLContex( Contex ).Handle, TCLDevice( Device ).Handle, nil, nil );
     {$ENDIF}
end;

procedure TCLComman<TCLContex_,TCLPlatfo_>.DestroHandle;
begin
     clReleaseCommandQueue( _Handle );

     _Handle := nil;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLComman<TCLContex_,TCLPlatfo_>.Create;
begin
     inherited;

     _Handle := nil;
end;

constructor TCLComman<TCLContex_,TCLPlatfo_>.Create( const Contex_:TCLContex_; const Device_:TCLDevice_ );
begin
     inherited Create( TCLContex( Contex_ ).Commans );

     _Device := Device_;
end;

destructor TCLComman<TCLContex_,TCLPlatfo_>.Destroy;
begin
      Handle := nil;

     TCLContex( Contex ).Handle := nil;

     inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLCommans<TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

end. //######################################################################### ■
