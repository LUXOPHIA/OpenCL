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

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 T Y P E 】

     TCLContexs <TCLSystem_,TCLPlatfo_:class> = class;
       TCLContex<TCLSystem_,TCLPlatfo_:class> = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R E C O R D 】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C L A S S 】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLContex<TCLSystem_,TCLPlatfo_>

     TCLContex<TCLSystem_,TCLPlatfo_:class> = class( TListChildr<TCLPlatfo_,TCLContexs<TCLSystem_,TCLPlatfo_>> )
     private
       type TCLDevice_  = TCLDevice <TCLSystem_,TCLPlatfo_>;
            TCLContexs_ = TCLContexs<TCLSystem_,TCLPlatfo_>;
            TCLContex_  = TCLContex <TCLSystem_,TCLPlatfo_>;
            TCLQueuers_ = TCLQueuers<TCLSystem_,TCLPlatfo_,TCLContex_>;
            TCLArgumes_ = TCLArgumes<TCLSystem_,TCLPlatfo_,TCLContex_>;
            TCLLibrars_ = TCLLibrars<TCLSystem_,TCLPlatfo_,TCLContex_>;
            TCLExecuts_ = TCLExecuts<TCLSystem_,TCLPlatfo_,TCLContex_>;
     protected
       _Queuers :TCLQueuers_;
       _Handle  :T_cl_context;
       _Argumes :TCLArgumes_;
       _Librars :TCLLibrars_;
       _Executs :TCLExecuts_;
       ///// A C C E S S O R
       function GetHandle :T_cl_context;
       procedure SetHandle( const Handle_:T_cl_context );
       ///// M E T H O D
       function CreateHandle :T_cl_int; virtual;
       function DestroHandle :T_cl_int; virtual;
     public
       constructor Create; override;
       constructor Create( const Platfo_:TCLPlatfo_ ); overload; virtual;
       destructor Destroy; override;
       ///// P R O P E R T Y
       property Platfo  :TCLPlatfo_   read GetOwnere                 ;
       property Contexs :TCLContexs_  read GetParent                 ;
       property Queuers :TCLQueuers_  read   _Queuers                ;
       property Handle  :T_cl_context read GetHandle  write SetHandle;
       property Argumes :TCLArgumes_  read   _Argumes                ;
       property Librars :TCLLibrars_  read   _Librars                ;
       property Executs :TCLExecuts_  read   _Executs                ;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLContexs<TCLSystem_,TCLPlatfo_>

     TCLContexs<TCLSystem_,TCLPlatfo_:class> = class( TListParent<TCLPlatfo_,TCLContex<TCLSystem_,TCLPlatfo_>> )
     private
       type TCLContex_ = TCLContex<TCLSystem_,TCLPlatfo_>;
     protected
     public
       ///// P R O P E R T Y
       property Platfo :TCLPlatfo_ read GetOwnere;
       ///// M E T H O D
       function Add :TCLContex_; overload;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C O N S T A N T 】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 V A R I A B L E 】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

implementation //############################################################### ■

uses LUX.GPU.OpenCL.Platfo;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R E C O R D 】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C L A S S 】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLContex<TCLSystem_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//////////////////////////////////////////////////////////////// A C C E S S O R

function TCLContex<TCLSystem_,TCLPlatfo_>.GetHandle :T_cl_context;
begin
     if not Assigned( _Handle ) then CreateHandle;

     Result := _Handle;
end;

procedure TCLContex<TCLSystem_,TCLPlatfo_>.SetHandle( const Handle_:T_cl_context );
begin
     if Assigned( _Handle ) then AssertCL( DestroHandle, 'TCLContex.DestroHandle is Error!' );

     _Handle := Handle_;
end;

//////////////////////////////////////////////////////////////////// M E T H O D

function TCLContex<TCLSystem_,TCLPlatfo_>.CreateHandle :T_cl_int;
var
   Ps :array [ 0..2 ] of T_cl_context_properties;
   Ds :TArray<T_cl_device_id>;
begin
     Ps[ 0 ] := CL_CONTEXT_PLATFORM;
     Ps[ 1 ] := T_cl_context_properties( TCLPlatfo<TCLSystem_>( Platfo ).Handle );
     Ps[ 2 ] := 0;

     Ds := Queuers.GetDeviceIDs;

     _Handle := clCreateContext( @Ps[0],
                                 Length( Ds ), @Ds[0],
                                 nil, nil,
                                 @Result );
end;

function TCLContex<TCLSystem_,TCLPlatfo_>.DestroHandle :T_cl_int;
begin
     Result := clReleaseContext( _Handle );

     _Handle := nil;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLContex<TCLSystem_,TCLPlatfo_>.Create;
begin
     inherited;

     _Handle := nil;

     _Queuers := TCLQueuers_.Create( Self );
     _Argumes := TCLArgumes_.Create( Self );
     _Librars := TCLLibrars_.Create( Self );
     _Executs := TCLExecuts_.Create( Self );
end;

constructor TCLContex<TCLSystem_,TCLPlatfo_>.Create( const Platfo_:TCLPlatfo_ );
begin
     inherited Create( TCLPlatfo<TCLSystem_>( Platfo_ ).Contexs );
end;

destructor TCLContex<TCLSystem_,TCLPlatfo_>.Destroy;
begin
     _Executs.Free;
     _Librars.Free;
     _Argumes.Free;
     _Queuers.Free;

      Handle := nil;

     inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLContexs<TCLSystem_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//////////////////////////////////////////////////////////////////// M E T H O D

function TCLContexs<TCLSystem_,TCLPlatfo_>.Add :TCLContex_;
begin
     Result := TCLContex_.Create( Platfo );
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

end. //######################################################################### ■
