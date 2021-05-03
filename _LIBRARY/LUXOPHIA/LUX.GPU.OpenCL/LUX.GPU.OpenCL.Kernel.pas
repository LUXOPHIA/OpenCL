unit LUX.GPU.OpenCL.Kernel;

interface //#################################################################### ■

uses System.Generics.Collections,
     cl_version, cl_platform, cl,
     LUX.Data.List,
     LUX.Code.C,
     LUX.GPU.OpenCL.root,
     LUX.GPU.OpenCL.Device,
     LUX.GPU.OpenCL.Comman,
     LUX.GPU.OpenCL.Memory;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TCLKernels    <TCLProgra_,TCLContex_,TCLPlatfo_:class> = class;
       TCLKernel   <TCLProgra_,TCLContex_,TCLPlatfo_:class> = class;
         TCLArgumes<TCLKernel_,TCLContex_,TCLPlatfo_:class> = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLArgumes<TCLKernel_,TCLContex_,TCLPlatfo_>

     TCLArgumes<TCLKernel_,TCLContex_,TCLPlatfo_:class> = class( TList<TCLMemory<TCLContex_>> );

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLKernel<TCLProgra_,TCLContex_,TCLPlatfo_>

     TCLKernel<TCLProgra_,TCLContex_,TCLPlatfo_:class> = class( TListChildr<TCLProgra_,TCLKernels<TCLProgra_,TCLContex_,TCLPlatfo_>> )
     private
       type TCLComman_  = TCLComman <TCLContex_,TCLPlatfo_>;
            TCLKernels_ = TCLKernels<TCLProgra_,TCLContex_,TCLPlatfo_>;
            TCLKernel_  = TCLKernel <TCLProgra_,TCLContex_,TCLPlatfo_>;
            TCLArgumes_ = TCLArgumes<TCLKernel_,TCLContex_,TCLPlatfo_>;
       ///// メソッド
       function GetInfo<_TYPE_>( const Name_:T_cl_kernel_info ) :_TYPE_;
       function GetInfoSize( const Name_:T_cl_kernel_info ) :T_size_t;
       function GetInfos<_TYPE_>( const Name_:T_cl_kernel_info ) :TArray<_TYPE_>;
       function GetInfoString( const Name_:T_cl_kernel_info ) :String;
       function GetArgInfo<_TYPE_>( const I_:T_cl_uint; const Name_:T_cl_kernel_arg_info ) :_TYPE_;
       function GetArgInfoSize( const I_:T_cl_uint; const Name_:T_cl_kernel_arg_info ) :T_size_t;
       function GetArgInfos<_TYPE_>( const I_:T_cl_uint; const Name_:T_cl_kernel_arg_info ) :TArray<_TYPE_>;
       function GetArgInfoString( const I_:T_cl_uint; const Name_:T_cl_kernel_arg_info ) :String;
     protected
       _Handle       :T_cl_kernel;
       _Name         :String;
       _Comman       :TCLComman_;
       _Argumes      :TCLArgumes_;
       _GlobWorkOffs :TArray<T_size_t>;
       _GlobWorkSize :TArray<T_size_t>;
       _LocaWorkSize :TArray<T_size_t>;
       ///// アクセス
       function GetHandle :T_cl_kernel;
       procedure SetHandle( const Handle_:T_cl_kernel );
       function GetDimension :T_cl_uint;
       procedure SetGlobWorkOffs( const GlobWorkOffs_:TArray<T_size_t> );
       procedure SetGlobWorkSize( const GlobWorkSize_:TArray<T_size_t> );
       procedure SetLocaWorkSize( const LocaWorkSize_:TArray<T_size_t> );
       (* cl_kernel_info *)
       function GetKERNEL_FUNCTION_NAME :String;
       function GetKERNEL_NUM_ARGS :T_cl_uint;
       function GetKERNEL_REFERENCE_COUNT :T_cl_uint;
       function GetKERNEL_CONTEXT :T_cl_context;
       function GetKERNEL_PROGRAM :T_cl_program;
       {$IF CL_VERSION_1_2 <> 0 }
       function GetKERNEL_ATTRIBUTES :String;
       {$ENDIF}
       (* cl_kernel_arg_info *)
       function GetKERNEL_ARG_ADDRESS_QUALIFIER( const I_:T_cl_uint ) :T_cl_kernel_arg_address_qualifier;
       function GetKERNEL_ARG_ACCESS_QUALIFIER( const I_:T_cl_uint ) :T_cl_kernel_arg_access_qualifier;
       function GetKERNEL_ARG_TYPE_NAME( const I_:T_cl_uint ) :String;
       function GetKERNEL_ARG_TYPE_QUALIFIER( const I_:T_cl_uint ) :T_cl_kernel_arg_type_qualifier;
       function GetKERNEL_ARG_NAME( const I_:T_cl_uint ) :String;
       ///// メソッド
       procedure CreateHandle;
       procedure DestroHandle;
     public
       constructor Create; override;
       constructor Create( const Progra_:TCLProgra_ ); overload; virtual;
       constructor Create( const Progra_:TCLProgra_; const Name_:String ); overload; virtual;
       constructor Create( const Progra_:TCLProgra_; const Name_:String; const Comman_:TCLComman_ ); overload; virtual;
       destructor Destroy; override;
       ///// プロパティ
       property Progra       :TCLProgra_       read GetOwnere                            ;
       property Kernels      :TCLKernels_      read GetParent                            ;
       property Handle       :T_cl_kernel      read GetHandle       write SetHandle      ;
       property Name         :String           read   _Name         write   _Name        ;
       property Comman       :TCLComman_       read   _Comman                            ;
       property Argumes      :TCLArgumes_      read   _Argumes                           ;
       property Dimension    :T_cl_uint        read GetDimension                         ;
       property GlobWorkOffs :TArray<T_size_t> read   _GlobWorkOffs write SetGlobWorkOffs;
       property GlobWorkSize :TArray<T_size_t> read   _GlobWorkSize write SetGlobWorkSize;
       property LocaWorkSize :TArray<T_size_t> read   _LocaWorkSize write SetLocaWorkSize;
       (* cl_kernel_info *)
       property KERNEL_FUNCTION_NAME   :String       read GetKERNEL_FUNCTION_NAME;
       property KERNEL_NUM_ARGS        :T_cl_uint    read GetKERNEL_NUM_ARGS;
       property KERNEL_REFERENCE_COUNT :T_cl_uint    read GetKERNEL_REFERENCE_COUNT;
       property KERNEL_CONTEXT         :T_cl_context read GetKERNEL_CONTEXT;
       property KERNEL_PROGRAM         :T_cl_program read GetKERNEL_PROGRAM;
       {$IF CL_VERSION_1_2 <> 0 }
       property KERNEL_ATTRIBUTES      :String       read GetKERNEL_ATTRIBUTES;
       {$ENDIF}
       (* cl_kernel_arg_info *)
       property KERNEL_ARG_ADDRESS_QUALIFIER[ const I_:T_cl_uint ] :T_cl_kernel_arg_address_qualifier read GetKERNEL_ARG_ADDRESS_QUALIFIER;
       property KERNEL_ARG_ACCESS_QUALIFIER[ const I_:T_cl_uint ]  :T_cl_kernel_arg_access_qualifier  read GetKERNEL_ARG_ACCESS_QUALIFIER;
       property KERNEL_ARG_TYPE_NAME[ const I_:T_cl_uint ]         :String                            read GetKERNEL_ARG_TYPE_NAME;
       property KERNEL_ARG_TYPE_QUALIFIER[ const I_:T_cl_uint ]    :T_cl_kernel_arg_type_qualifier    read GetKERNEL_ARG_TYPE_QUALIFIER;
       property KERNEL_ARG_NAME[ const I_:T_cl_uint ]              :String                            read GetKERNEL_ARG_NAME;
       ///// メソッド
       procedure Run;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLKernels<TCLProgra_,TCLContex_,TCLPlatfo_>

     TCLKernels<TCLProgra_,TCLContex_,TCLPlatfo_:class> = class( TListParent<TCLProgra_,TCLKernel<TCLProgra_,TCLContex_,TCLPlatfo_>> )
     private
     protected
     public
       ///// プロパティ
       property Progra :TCLProgra_ read GetOwnere ;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses System.SysUtils,
     LUX.GPU.OpenCL;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLArgumes<TCLKernel_,TCLContex_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLKernel<TCLProgra_,TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

/////////////////////////////////////////////////////////////////////// メソッド

function TCLKernel<TCLProgra_,TCLContex_,TCLPlatfo_>.GetInfo<_TYPE_>( const Name_:T_cl_kernel_info ) :_TYPE_;
begin
     AssertCL( clGetKernelInfo( Handle, Name_, SizeOf( _TYPE_ ), @Result, nil ) );
end;

function TCLKernel<TCLProgra_,TCLContex_,TCLPlatfo_>.GetInfoSize( const Name_:T_cl_kernel_info ) :T_size_t;
begin
     AssertCL( clGetKernelInfo( Handle, Name_, 0, nil, @Result ) );
end;

function TCLKernel<TCLProgra_,TCLContex_,TCLPlatfo_>.GetInfos<_TYPE_>( const Name_:T_cl_kernel_info ) :TArray<_TYPE_>;
var
   S :T_size_t;
begin
     S := GetInfoSize( Name_ );

     SetLength( Result, S div Cardinal( SizeOf( _TYPE_ ) ) );

     AssertCL( clGetKernelInfo( Handle, Name_, S, @Result[ 0 ], nil ) );
end;

function TCLKernel<TCLProgra_,TCLContex_,TCLPlatfo_>.GetInfoString( const Name_:T_cl_kernel_info ) :String;
begin
     Result := TrimRight( String( P_char( GetInfos<T_char>( Name_ ) ) ) );
end;

//------------------------------------------------------------------------------

function TCLKernel<TCLProgra_,TCLContex_,TCLPlatfo_>.GetArgInfo<_TYPE_>( const I_:T_cl_uint; const Name_:T_cl_kernel_arg_info ) :_TYPE_;
begin
     AssertCL( clGetKernelArgInfo( Handle, I_, Name_, SizeOf( _TYPE_ ), @Result, nil ) );
end;

function TCLKernel<TCLProgra_,TCLContex_,TCLPlatfo_>.GetArgInfoSize( const I_:T_cl_uint; const Name_:T_cl_kernel_arg_info ) :T_size_t;
begin
     AssertCL( clGetKernelArgInfo( Handle, I_, Name_, 0, nil, @Result ) );
end;

function TCLKernel<TCLProgra_,TCLContex_,TCLPlatfo_>.GetArgInfos<_TYPE_>( const I_:T_cl_uint; const Name_:T_cl_kernel_arg_info ) :TArray<_TYPE_>;
var
   S :T_size_t;
begin
     S := GetArgInfoSize( I_, Name_ );

     SetLength( Result, S div Cardinal( SizeOf( _TYPE_ ) ) );

     AssertCL( clGetKernelArgInfo( Handle, I_, Name_, S, @Result[ 0 ], nil ) );
end;

function TCLKernel<TCLProgra_,TCLContex_,TCLPlatfo_>.GetArgInfoString( const I_:T_cl_uint; const Name_:T_cl_kernel_arg_info ) :String;
begin
     Result := TrimRight( String( P_char( GetArgInfos<T_char>( I_, Name_ ) ) ) );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLKernel<TCLProgra_,TCLContex_,TCLPlatfo_>.GetHandle :T_cl_kernel;
begin
     if not Assigned( _Handle ) then CreateHandle;

     Result := _Handle;
end;

procedure TCLKernel<TCLProgra_,TCLContex_,TCLPlatfo_>.SetHandle( const Handle_:T_cl_kernel );
begin
     if Assigned( _Handle ) then DestroHandle;

     _Handle := Handle_;
end;

//------------------------------------------------------------------------------

function TCLKernel<TCLProgra_,TCLContex_,TCLPlatfo_>.GetDimension :T_cl_uint;
begin
     Result := Length( _GlobWorkSize );
end;

procedure TCLKernel<TCLProgra_,TCLContex_,TCLPlatfo_>.SetGlobWorkOffs( const GlobWorkOffs_:TArray<T_size_t> );
begin
     _GlobWorkOffs := GlobWorkOffs_;
end;

procedure TCLKernel<TCLProgra_,TCLContex_,TCLPlatfo_>.SetGlobWorkSize( const GlobWorkSize_:TArray<T_size_t> );
begin
     _GlobWorkSize := GlobWorkSize_;
end;

procedure TCLKernel<TCLProgra_,TCLContex_,TCLPlatfo_>.SetLocaWorkSize( const LocaWorkSize_:TArray<T_size_t> );
begin
     _LocaWorkSize := LocaWorkSize_;
end;

//----------------------------------------------------------(* cl_kernel_info *)

function TCLKernel<TCLProgra_,TCLContex_,TCLPlatfo_>.GetKERNEL_FUNCTION_NAME :String;
begin
     Result := GetInfoString( CL_KERNEL_FUNCTION_NAME );
end;

function TCLKernel<TCLProgra_,TCLContex_,TCLPlatfo_>.GetKERNEL_NUM_ARGS :T_cl_uint;
begin
     Result := GetInfo<T_cl_uint>( CL_KERNEL_NUM_ARGS );
end;

function TCLKernel<TCLProgra_,TCLContex_,TCLPlatfo_>.GetKERNEL_REFERENCE_COUNT :T_cl_uint;
begin
     Result := GetInfo<T_cl_uint>( CL_KERNEL_REFERENCE_COUNT );
end;

function TCLKernel<TCLProgra_,TCLContex_,TCLPlatfo_>.GetKERNEL_CONTEXT :T_cl_context;
begin
     Result := GetInfo<T_cl_context>( CL_KERNEL_CONTEXT );
end;

function TCLKernel<TCLProgra_,TCLContex_,TCLPlatfo_>.GetKERNEL_PROGRAM :T_cl_program;
begin
     Result := GetInfo<T_cl_program>( CL_KERNEL_PROGRAM );
end;

{$IF CL_VERSION_1_2 <> 0 }
function TCLKernel<TCLProgra_,TCLContex_,TCLPlatfo_>.GetKERNEL_ATTRIBUTES :String;
begin
     Result := GetInfoString( CL_KERNEL_ATTRIBUTES );
end;
{$ENDIF}

//------------------------------------------------------(* cl_kernel_arg_info *)

function TCLKernel<TCLProgra_,TCLContex_,TCLPlatfo_>.GetKERNEL_ARG_ADDRESS_QUALIFIER( const I_:T_cl_uint ) :T_cl_kernel_arg_address_qualifier;
begin
     Result := GetArgInfo<T_cl_kernel_arg_address_qualifier>( I_, CL_KERNEL_ARG_ADDRESS_QUALIFIER );
end;

function TCLKernel<TCLProgra_,TCLContex_,TCLPlatfo_>.GetKERNEL_ARG_ACCESS_QUALIFIER( const I_:T_cl_uint ) :T_cl_kernel_arg_access_qualifier;
begin
     Result := GetArgInfo<T_cl_kernel_arg_access_qualifier>( I_, CL_KERNEL_ARG_ACCESS_QUALIFIER );
end;

function TCLKernel<TCLProgra_,TCLContex_,TCLPlatfo_>.GetKERNEL_ARG_TYPE_NAME( const I_:T_cl_uint ) :String;
begin
     Result := GetArgInfoString( I_, CL_KERNEL_ARG_TYPE_NAME );
end;

function TCLKernel<TCLProgra_,TCLContex_,TCLPlatfo_>.GetKERNEL_ARG_TYPE_QUALIFIER( const I_:T_cl_uint ) :T_cl_kernel_arg_type_qualifier;
begin
     Result := GetArgInfo<T_cl_kernel_arg_type_qualifier>( I_, CL_KERNEL_ARG_TYPE_QUALIFIER );
end;

function TCLKernel<TCLProgra_,TCLContex_,TCLPlatfo_>.GetKERNEL_ARG_NAME( const I_:T_cl_uint ) :String;
begin
     Result := GetArgInfoString( I_, CL_KERNEL_ARG_NAME );
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLKernel<TCLProgra_,TCLContex_,TCLPlatfo_>.CreateHandle;
var
   E :T_cl_int;
   I :Integer;
   H :T_cl_mem;
begin
     TCLProgra( Progra ).BuildTo( TCLComman( Comman ).Device );

     _Handle := clCreateKernel( TCLProgra( Progra ).Handle, P_char( AnsiString( _Name ) ), @E );

     AssertCL( E );

     for I := 0 to _Argumes.Count-1 do
     begin
          H := _Argumes[ I ].Handle;

          AssertCL( clSetKernelArg( _Handle, I, SizeOf( T_cl_mem ), @H ) );
     end;
end;

procedure TCLKernel<TCLProgra_,TCLContex_,TCLPlatfo_>.DestroHandle;
begin
     clReleaseKernel( _Handle );

     _Handle := nil;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLKernel<TCLProgra_,TCLContex_,TCLPlatfo_>.Create;
begin
     inherited;

     _Handle := nil;

     _Argumes := TCLArgumes_.Create;

     _Name         := '';
     _Comman       := nil;
     _GlobWorkOffs := [];
     _GlobWorkSize := [ 1 ];
     _LocaWorkSize := [];
end;

constructor TCLKernel<TCLProgra_,TCLContex_,TCLPlatfo_>.Create( const Progra_:TCLProgra_ );
begin
     inherited Create( TCLProgra( Progra_ ).Kernels );
end;

constructor TCLKernel<TCLProgra_,TCLContex_,TCLPlatfo_>.Create( const Progra_:TCLProgra_; const Name_:String );
begin
     Create( Progra_ );

     _Name := Name_;
end;

constructor TCLKernel<TCLProgra_,TCLContex_,TCLPlatfo_>.Create( const Progra_:TCLProgra_; const Name_:String; const Comman_:TCLComman_ );
begin
     Create( Progra_, Name_ );

     _Comman := Comman_;
end;

destructor TCLKernel<TCLProgra_,TCLContex_,TCLPlatfo_>.Destroy;
begin
     _Argumes.Free;

      Handle := nil;

     inherited;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLKernel<TCLProgra_,TCLContex_,TCLPlatfo_>.Run;
begin
     AssertCL( clEnqueueNDRangeKernel( _Comman.Handle,
                                       Handle,
                                       Dimension,
                                       @_GlobWorkOffs[ 0 ],
                                       @_GlobWorkSize[ 0 ],
                                       @_LocaWorkSize[ 0 ],
                                       0, nil, nil ) );

     clFinish( _Comman.Handle );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLKernels<TCLProgra_,TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

end. //######################################################################### ■
