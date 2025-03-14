﻿unit LUX.GPU.OpenCL.Argume.Samplr;

interface //#################################################################### ■

uses cl_version, cl_platform, cl,
     LUX.Data.List,
     LUX.Code.C,
     LUX.GPU.OpenCL.core,
     LUX.GPU.OpenCL.Argume;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 T Y P E 】

     TCLSamplr<TCLSystem_,TCLPlatfo_,TCLContex_:class> = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R E C O R D 】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C L A S S 】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLSamplr<TCLSystem_,TCLPlatfo_,TCLContex_>

     TCLSamplr<TCLSystem_,TCLPlatfo_,TCLContex_:class> = class( TCLArgume<TCLSystem_,TCLPlatfo_,TCLContex_> )
     private
       type TCLArgumes_ = TCLArgumes<TCLSystem_,TCLPlatfo_,TCLContex_>;
     protected
       _Handle :T_cl_sampler;
       ///// A C C E S S O R
       function GetHanPtr :P_void; override;
       function GetHanSiz :T_size_t; override;
       function GetHandle :T_cl_sampler;
       procedure SetHandle( const Handle_:T_cl_sampler );
       ///// M E T H O D
       function CreateHandle :T_cl_int; override;
       function DestroHandle :T_cl_int; override;
     public
       constructor Create; override;
       destructor Destroy; override;
       ///// P R O P E R T Y
       property Contex  :TCLContex_   read GetOwnere                ;
       property Argumes :TCLArgumes_  read GetParent                ;
       property Handle  :T_cl_sampler read GetHandle write SetHandle;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C O N S T A N T 】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 V A R I A B L E 】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

implementation //############################################################### ■

uses LUX.GPU.OpenCL.Contex;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R E C O R D 】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C L A S S 】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLSamplr<TCLSystem_,TCLPlatfo_,TCLContex_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//////////////////////////////////////////////////////////////// A C C E S S O R

function TCLSamplr<TCLSystem_,TCLPlatfo_,TCLContex_>.GetHanPtr :P_void;
begin
     Result := Handle;
end;

function TCLSamplr<TCLSystem_,TCLPlatfo_,TCLContex_>.GetHanSiz :T_size_t;
begin
     Result := SizeOf( T_cl_sampler );
end;

function TCLSamplr<TCLSystem_,TCLPlatfo_,TCLContex_>.GetHandle :T_cl_sampler;
begin
     if not Assigned( _Handle ) then CreateHandle;

     Result := _Handle;
end;

procedure TCLSamplr<TCLSystem_,TCLPlatfo_,TCLContex_>.SetHandle( const Handle_:T_cl_sampler );
begin
     if Assigned( _Handle ) then AssertCL( DestroHandle, 'TCLSamplr.DestroHandle is Error!' );

     _Handle := Handle_;
end;

//////////////////////////////////////////////////////////////////// M E T H O D

function TCLSamplr<TCLSystem_,TCLPlatfo_,TCLContex_>.CreateHandle :T_cl_int;
var
   Ps :array [ 0..6 ] of T_cl_sampler_properties;
begin
     {$IF CL_VERSION_2_0 <> 0 }
     Ps[ 0 ] := CL_SAMPLER_NORMALIZED_COORDS;
     Ps[ 1 ] := CL_TRUE;
     Ps[ 2 ] := CL_SAMPLER_ADDRESSING_MODE;
     Ps[ 3 ] := CL_ADDRESS_MIRRORED_REPEAT;
     Ps[ 4 ] := CL_SAMPLER_FILTER_MODE;
     Ps[ 5 ] := CL_FILTER_LINEAR;
     Ps[ 6 ] := 0;

     _Handle := clCreateSamplerWithProperties( TCLContex<TCLSystem_,TCLPlatfo_>( Contex ).Handle,
                                               @Ps[ 0 ],
                                               @Result );
     {$ELSE}
     _Handle := clCreateSampler              ( TCLContex<TCLSystem_,TCLPlatfo_>( Contex ).Handle,
                                               CL_TRUE,
                                               CL_ADDRESS_CLAMP,
                                               CL_FILTER_LINEAR,
                                               @Result );
     {$ENDIF}
end;

function TCLSamplr<TCLSystem_,TCLPlatfo_,TCLContex_>.DestroHandle :T_cl_int;
begin
     Result := clReleaseSampler( _Handle );

     _Handle := nil;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLSamplr<TCLSystem_,TCLPlatfo_,TCLContex_>.Create;
begin
     inherited;

     _Handle := nil;
end;

destructor TCLSamplr<TCLSystem_,TCLPlatfo_,TCLContex_>.Destroy;
begin
      Handle := nil;

     inherited;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

end. //######################################################################### ■
