﻿unit LUX.GPU.OpenCL.Argume.Samplr;

interface //#################################################################### ■

uses cl_version, cl_platform, cl,
     LUX.Data.List,
     LUX.Code.C,
     LUX.GPU.OpenCL.core,
     LUX.GPU.OpenCL.Argume;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TCLSamplr<TCLContex_,TCLPlatfo_:class> = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLSamplr<TCLContex_,TCLPlatfo_>

     TCLSamplr<TCLContex_,TCLPlatfo_:class> = class( TCLArgume<TCLContex_,TCLPlatfo_> )
     private
       type TCLArgumes_ = TCLArgumes<TCLContex_,TCLPlatfo_>;
     protected
       _Handle :T_cl_sampler;
       ///// アクセス
       function GetHanPtr :P_void; override;
       function GetHanSiz :T_size_t; override;
       function GetHandle :T_cl_sampler;
       procedure SetHandle( const Handle_:T_cl_sampler );
       ///// メソッド
       function CreateHandle :T_cl_int; override;
       function DestroHandle :T_cl_int; override;
     public
       constructor Create; override;
       destructor Destroy; override;
       ///// プロパティ
       property Contex  :TCLContex_   read GetOwnere                ;
       property Argumes :TCLArgumes_  read GetParent                ;
       property Handle  :T_cl_sampler read GetHandle write SetHandle;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses LUX.GPU.OpenCL;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLSamplr<TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLSamplr<TCLContex_,TCLPlatfo_>.GetHanPtr :P_void;
begin
     Result := Handle;
end;

function TCLSamplr<TCLContex_,TCLPlatfo_>.GetHanSiz :T_size_t;
begin
     Result := SizeOf( T_cl_sampler );
end;

function TCLSamplr<TCLContex_,TCLPlatfo_>.GetHandle :T_cl_sampler;
begin
     if not Assigned( _Handle ) then CreateHandle;

     Result := _Handle;
end;

procedure TCLSamplr<TCLContex_,TCLPlatfo_>.SetHandle( const Handle_:T_cl_sampler );
begin
     if Assigned( _Handle ) then AssertCL( DestroHandle, 'TCLSamplr.DestroHandle is Error!' );

     _Handle := Handle_;
end;

/////////////////////////////////////////////////////////////////////// メソッド

function TCLSamplr<TCLContex_,TCLPlatfo_>.CreateHandle :T_cl_int;
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

     _Handle := clCreateSamplerWithProperties( TCLContex( Contex ).Handle,
                                               @Ps[ 0 ],
                                               @Result );
     {$ELSE}
     _Handle := clCreateSampler              ( TCLContex( Contex ).Handle,
                                               CL_TRUE,
                                               CL_ADDRESS_CLAMP,
                                               CL_FILTER_LINEAR,
                                               @Result );
     {$ENDIF}
end;

function TCLSamplr<TCLContex_,TCLPlatfo_>.DestroHandle :T_cl_int;
begin
     Result := clReleaseSampler( _Handle );

     _Handle := nil;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLSamplr<TCLContex_,TCLPlatfo_>.Create;
begin
     inherited;

     _Handle := nil;
end;

destructor TCLSamplr<TCLContex_,TCLPlatfo_>.Destroy;
begin
      Handle := nil;

     inherited;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

end. //######################################################################### ■
