﻿unit LUX.GPU.OpenCL.Contex;

interface //#################################################################### ■

uses cl_version, cl_platform, cl,
     LUX.Data.List,
     LUX.Code.C,
     LUX.GPU.OpenCL.core,
     LUX.GPU.OpenCL.Device,
     LUX.GPU.OpenCL.Queuer,
     LUX.GPU.OpenCL.Argume,
     LUX.GPU.OpenCL.Progra;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TCLContexs <TCLPlatfo_:class> = class;
       TCLContex<TCLPlatfo_:class> = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLContex<TCLPlatfo_>

     TCLContex<TCLPlatfo_:class> = class( TListChildr<TCLPlatfo_,TCLContexs<TCLPlatfo_>> )
     private
       type TCLDevice_  = TCLDevice <TCLPlatfo_>;
            TCLContexs_ = TCLContexs<TCLPlatfo_>;
            TCLContex_  = TCLContex <TCLPlatfo_>;
            TCLQueuers_ = TCLQueuers<TCLContex_,TCLPlatfo_>;
            TCLArgumes_ = TCLArgumes<TCLContex_,TCLPlatfo_>;
            TCLLibrars_ = TCLLibrars<TCLContex_,TCLPlatfo_>;
            TCLExecuts_ = TCLExecuts<TCLContex_,TCLPlatfo_>;
     protected
       _Queuers :TCLQueuers_;
       _Handle  :T_cl_context;
       _Argumes :TCLArgumes_;
       _Librars :TCLLibrars_;
       _Executs :TCLExecuts_;
       ///// アクセス
       function GetHandle :T_cl_context;
       procedure SetHandle( const Handle_:T_cl_context );
       ///// メソッド
       function CreateHandle :T_cl_int; virtual;
       function DestroHandle :T_cl_int; virtual;
     public
       constructor Create; override;
       constructor Create( const Platfo_:TCLPlatfo_ ); overload; virtual;
       destructor Destroy; override;
       ///// プロパティ
       property Platfo  :TCLPlatfo_   read GetOwnere                 ;
       property Contexs :TCLContexs_  read GetParent                 ;
       property Queuers :TCLQueuers_  read   _Queuers                ;
       property Handle  :T_cl_context read GetHandle  write SetHandle;
       property Argumes :TCLArgumes_  read   _Argumes                ;
       property Librars :TCLLibrars_  read   _Librars                ;
       property Executs :TCLExecuts_  read   _Executs                ;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLContexs<TCLPlatfo_>

     TCLContexs<TCLPlatfo_:class> = class( TListParent<TCLPlatfo_,TCLContex<TCLPlatfo_>> )
     private
       type TCLContex_ = TCLContex<TCLPlatfo_>;
     protected
     public
       ///// プロパティ
       property Platfo :TCLPlatfo_ read GetOwnere;
       ///// メソッド
       function Add :TCLContex_; overload;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses LUX.GPU.OpenCL;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLContex<TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLContex<TCLPlatfo_>.GetHandle :T_cl_context;
begin
     if not Assigned( _Handle ) then CreateHandle;

     Result := _Handle;
end;

procedure TCLContex<TCLPlatfo_>.SetHandle( const Handle_:T_cl_context );
begin
     if Assigned( _Handle ) then AssertCL( DestroHandle, 'TCLContex.DestroHandle is Error!' );

     _Handle := Handle_;
end;

/////////////////////////////////////////////////////////////////////// メソッド

function TCLContex<TCLPlatfo_>.CreateHandle :T_cl_int;
var
   Ps :array [ 0..2 ] of T_cl_context_properties;
   Ds :TArray<T_cl_device_id>;
begin
     Ps[ 0 ] := CL_CONTEXT_PLATFORM;
     Ps[ 1 ] := T_cl_context_properties( TCLPlatfo( Platfo ).Handle );
     Ps[ 2 ] := 0;

     Ds := Queuers.GetDeviceIDs;

     _Handle := clCreateContext( @Ps[0],
                                 Length( Ds ), @Ds[0],
                                 nil, nil,
                                 @Result );
end;

function TCLContex<TCLPlatfo_>.DestroHandle :T_cl_int;
begin
     Result := clReleaseContext( _Handle );

     _Handle := nil;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLContex<TCLPlatfo_>.Create;
begin
     inherited;

     _Handle := nil;

     _Queuers := TCLQueuers_.Create( Self );
     _Argumes := TCLArgumes_.Create( Self );
     _Librars := TCLLibrars_.Create( Self );
     _Executs := TCLExecuts_.Create( Self );
end;

constructor TCLContex<TCLPlatfo_>.Create( const Platfo_:TCLPlatfo_ );
begin
     inherited Create( TCLPlatfo( Platfo_ ).Contexs );
end;

destructor TCLContex<TCLPlatfo_>.Destroy;
begin
     _Executs.Free;
     _Librars.Free;
     _Argumes.Free;
     _Queuers.Free;

      Handle := nil;

     inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLContexs<TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

/////////////////////////////////////////////////////////////////////// メソッド

function TCLContexs<TCLPlatfo_>.Add :TCLContex_;
begin
     Result := TCLContex_.Create( Platfo );
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

end. //######################################################################### ■
