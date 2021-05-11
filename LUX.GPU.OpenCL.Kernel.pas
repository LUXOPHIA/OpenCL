unit LUX.GPU.OpenCL.Kernel;

interface //#################################################################### ■

uses System.Generics.Collections,
     cl_version, cl_platform, cl,
     LUX.Data.List,
     LUX.Code.C,
     LUX.GPU.OpenCL.root,
     LUX.GPU.OpenCL.Device,
     LUX.GPU.OpenCL.Queuer,
     LUX.GPU.OpenCL.Memory;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TCLKernels     <TCLProgra_,TCLContex_,TCLPlatfo_:class> = class;
       TCLKernel    <TCLProgra_,TCLContex_,TCLPlatfo_:class> = class;
         TCLArgumes <TCLProgra_,TCLContex_,TCLPlatfo_:class> = class;
           TCLArgume<TCLProgra_,TCLContex_,TCLPlatfo_:class> = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLArgume<TCLProgra_,TCLContex_,TCLPlatfo_>

     TCLArgume<TCLProgra_,TCLContex_,TCLPlatfo_:class> = class( TListChildr<TCLKernel <TCLProgra_,TCLContex_,TCLPlatfo_>,
                                                                            TCLArgumes<TCLProgra_,TCLContex_,TCLPlatfo_>> )
     private
       type TCLMemory_  = TCLMemory <TCLContex_,TCLPlatfo_>;
            TCLKernel_  = TCLKernel <TCLProgra_,TCLContex_,TCLPlatfo_>;
            TCLArgumes_ = TCLArgumes<TCLProgra_,TCLContex_,TCLPlatfo_>;
     protected
       _Name    :String;
       _ParameI :Integer;
       _Memory  :TCLMemory_;
       ///// アクセス
       function GetName :String; virtual;
       procedure SetName( const Name_:String ); virtual;
       function GetParameI :Integer; virtual;
       function GetMemory :TCLMemory_; virtual;
       procedure SetMemory( const Memory_:TCLMemory_ ); virtual;
     public
       constructor Create; override;
       constructor Create( const Argumes_:TCLArgumes_; const Name_:String ); overload; virtual;
       constructor Create( const Argumes_:TCLArgumes_; const Name_:String; const Memory_:TCLMemory_ ); overload; virtual;
       ///// プロパティ
       property Kernel  :TCLKernel_  read GetOwnere                 ;
       property Argumes :TCLArgumes_ read GetParent                 ;
       property Name    :String      read GetName    write SetName  ;
       property ParameI :Integer     read GetParameI                ;
       property Memory  :TCLMemory_  read GetMemory  write SetMemory;
       ///// メソッド
       procedure Bind;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLArgumes<TCLProgra_,TCLContex_,TCLPlatfo_>

     TCLArgumes<TCLProgra_,TCLContex_,TCLPlatfo_:class> = class( TListParent<TCLKernel<TCLProgra_,TCLContex_,TCLPlatfo_>,
                                                                             TCLArgume<TCLProgra_,TCLContex_,TCLPlatfo_>> )
     private
       type TCLMemory_ = TCLMemory<TCLContex_,TCLPlatfo_>;
            TCLKernel_ = TCLKernel<TCLProgra_,TCLContex_,TCLPlatfo_>;
            TCLArgume_ = TCLArgume<TCLProgra_,TCLContex_,TCLPlatfo_>;
            TCLVarArgs = TDictionary<String,TCLArgume_>;
     protected
       _VarArgs :TCLVarArgs;
       _FindsOK :Boolean;
       _BindsOK :Boolean;
       ///// アクセス
       function GetChildr( const Name_:String ) :TCLArgume_; overload; virtual;
       procedure SetChildr( const Name_:String; const Childr_:TCLArgume_ ); overload; virtual;
       function GetMemorys( const Name_:String ) :TCLMemory_; virtual;
       procedure SetMemorys( const Name_:String; const Memory_:TCLMemory_ ); virtual;
       function GetFindsOK :Boolean; virtual;
       procedure SetFindsOK( const FindsOK_:Boolean ); virtual;
       function GetBindsOK :Boolean; virtual;
       procedure SetBindsOK( const BindsOK_:Boolean ); virtual;
       ///// イベント
       procedure OnInsertChild( const Childr_:TCLArgume_ ); override;
       procedure OnRemoveChild( const Childr_:TCLArgume_ ); override;
     public
       constructor Create; override;
       destructor Destroy; override;
       ///// プロパティ
       property Kernel                        :TCLKernel_ read GetOwnere                  ;
       property Childrs[ const Name_:String ] :TCLArgume_ read GetChildr  write SetChildr ;
       property Items  [ const Name_:String ] :TCLArgume_ read GetChildr  write SetChildr ;
       property Memorys[ const Name_:String ] :TCLMemory_ read GetMemorys write SetMemorys; default;
       property FindsOK                       :Boolean    read GetFindsOK write SetFindsOK;
       property BindsOK                       :Boolean    read GetBindsOK write SetBindsOK;
       ///// メソッド
       procedure Add( const Name_:String; const Memory_:TCLMemory_ ); overload;
       function Contains( const Name_:String ) :Boolean;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLKernel<TCLProgra_,TCLContex_,TCLPlatfo_>

     TCLKernel<TCLProgra_,TCLContex_,TCLPlatfo_:class> = class( TListChildr<TCLProgra_,TCLKernels<TCLProgra_,TCLContex_,TCLPlatfo_>> )
     private
       type TCLQueuer_  = TCLQueuer <TCLContex_,TCLPlatfo_>;
            TCLKernels_ = TCLKernels<TCLProgra_,TCLContex_,TCLPlatfo_>;
            TCLKernel_  = TCLKernel <TCLProgra_,TCLContex_,TCLPlatfo_>;
            TCLArgumes_ = TCLArgumes<TCLProgra_,TCLContex_,TCLPlatfo_>;
            TCLArgume_  = TCLArgume <TCLProgra_,TCLContex_,TCLPlatfo_>;
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
       _Queuer       :TCLQueuer_;
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
       constructor Create( const Progra_:TCLProgra_; const Name_:String; const Queuer_:TCLQueuer_ ); overload; virtual;
       destructor Destroy; override;
       ///// プロパティ
       property Progra       :TCLProgra_       read GetOwnere                            ;
       property Kernels      :TCLKernels_      read GetParent                            ;
       property Handle       :T_cl_kernel      read GetHandle       write SetHandle      ;
       property Name         :String           read   _Name         write   _Name        ;
       property Queuer       :TCLQueuer_       read   _Queuer                            ;
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
       type TCLQueuer_ = TCLQueuer<TCLContex_,TCLPlatfo_>;
            TCLKernel_ = TCLKernel<TCLProgra_,TCLContex_,TCLPlatfo_>;
     protected
     public
       ///// プロパティ
       property Progra :TCLProgra_ read GetOwnere;
       ///// メソッド
       function Add( const Name_:String ) :TCLKernel_; overload;
       function Add( const Name_:String; const Queuer_:TCLQueuer_ ) :TCLKernel_; overload;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses System.SysUtils,
     LUX.GPU.OpenCL;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLArgume<TCLProgra_,TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLArgume<TCLProgra_,TCLContex_,TCLPlatfo_>.GetName :String;
begin
     Result := _Name;
end;

procedure TCLArgume<TCLProgra_,TCLContex_,TCLPlatfo_>.SetName( const Name_:String );
begin
     _Name := Name_;

     Argumes.FindsOK := False;
end;

//------------------------------------------------------------------------------

function TCLArgume<TCLProgra_,TCLContex_,TCLPlatfo_>.GetParameI :Integer;
begin
     Argumes.FindsOK;

     Result := _ParameI;
end;

//------------------------------------------------------------------------------

function TCLArgume<TCLProgra_,TCLContex_,TCLPlatfo_>.GetMemory :TCLMemory_;
begin
     Result := _Memory;
end;

procedure TCLArgume<TCLProgra_,TCLContex_,TCLPlatfo_>.SetMemory( const Memory_:TCLMemory_ );
begin
     _Memory := Memory_;

     if Assigned( Argumes ) then Argumes.BindsOK := False;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLArgume<TCLProgra_,TCLContex_,TCLPlatfo_>.Create;
begin
     inherited;

     _Name    := '';
     _ParameI := -1;
     _Memory  := nil;
end;

constructor TCLArgume<TCLProgra_,TCLContex_,TCLPlatfo_>.Create( const Argumes_:TCLArgumes_; const Name_:String );
begin
     inherited Create( Argumes_ );

     _Name := Name_;
end;

constructor TCLArgume<TCLProgra_,TCLContex_,TCLPlatfo_>.Create( const Argumes_:TCLArgumes_; const Name_:String; const Memory_:TCLMemory_ );
begin
     Create( Argumes_, Name_ );

     _Memory := Memory_;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLArgume<TCLProgra_,TCLContex_,TCLPlatfo_>.Bind;
var
   H :T_cl_mem;
begin
     H := Memory.Handle;

     AssertCL( clSetKernelArg( Kernel.Handle, T_cl_uint( ParameI ), SizeOf( T_cl_mem ), @H ) );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLArgumes<TCLProgra_,TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLArgumes<TCLProgra_,TCLContex_,TCLPlatfo_>.GetChildr( const Name_:String ) :TCLArgume_;
begin
     Result := _VarArgs[ Name_ ];
end;

procedure TCLArgumes<TCLProgra_,TCLContex_,TCLPlatfo_>.SetChildr( const Name_:String; const Childr_:TCLArgume_ );
begin
     if _VarArgs.ContainsKey( Name_ ) then _VarArgs[ Name_ ].Free;

     _VarArgs[ Name_ ] := Childr_;
end;

//------------------------------------------------------------------------------

function TCLArgumes<TCLProgra_,TCLContex_,TCLPlatfo_>.GetMemorys( const Name_:String ) :TCLMemory_;
begin
     Result := _VarArgs[ Name_ ].Memory;
end;

procedure TCLArgumes<TCLProgra_,TCLContex_,TCLPlatfo_>.SetMemorys( const Name_:String; const Memory_:TCLMemory_ );
begin
     if _VarArgs.ContainsKey( Name_ ) then _VarArgs[ Name_ ].Memory := Memory_
                                      else Add( Name_, Memory_ );
end;

//------------------------------------------------------------------------------

function TCLArgumes<TCLProgra_,TCLContex_,TCLPlatfo_>.GetFindsOK :Boolean;
var
   I :T_cl_uint;
   K :String;
begin
     if not _FindsOK then
     begin
          _FindsOK := True;

          for I := 0 to Kernel.KERNEL_NUM_ARGS-1 do
          begin
               K := Kernel.KERNEL_ARG_NAME[ I ];

               if Contains( K ) then Items[ K ]._ParameI := I
                                else _FindsOK := False;
          end;
     end;

     Result := _FindsOK;
end;

procedure TCLArgumes<TCLProgra_,TCLContex_,TCLPlatfo_>.SetFindsOK( const FindsOK_:Boolean );
begin
     _FindsOK := FindsOK_;
     _BindsOK := False;
end;

//------------------------------------------------------------------------------

function TCLArgumes<TCLProgra_,TCLContex_,TCLPlatfo_>.GetBindsOK :Boolean;
var
   A :TCLArgume_;
begin
     if FindsOK and not _BindsOK then
     begin
          for A in Self do A.Bind;

          _BindsOK := True;
     end;

     Result := _BindsOK;
end;

procedure TCLArgumes<TCLProgra_,TCLContex_,TCLPlatfo_>.SetBindsOK( const BindsOK_:Boolean );
begin
     _BindsOK := BindsOK_;
end;

/////////////////////////////////////////////////////////////////////// イベント

procedure TCLArgumes<TCLProgra_,TCLContex_,TCLPlatfo_>.OnInsertChild( const Childr_:TCLArgume_ );
begin
     inherited;

     if _VarArgs.ContainsKey( Childr_.Name ) then _VarArgs[ Childr_.Name ].Free;

     _VarArgs.Add( Childr_.Name, Childr_ );
end;

procedure TCLArgumes<TCLProgra_,TCLContex_,TCLPlatfo_>.OnRemoveChild( const Childr_:TCLArgume_ );
begin
     inherited;

     _VarArgs.Remove( Childr_.Name );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLArgumes<TCLProgra_,TCLContex_,TCLPlatfo_>.Create;
begin
     inherited;

     _VarArgs := TCLVarArgs.Create;

     _FindsOK := False;
     _BindsOK := False;
end;

destructor TCLArgumes<TCLProgra_,TCLContex_,TCLPlatfo_>.Destroy;
begin
     _VarArgs.Free;

     inherited;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLArgumes<TCLProgra_,TCLContex_,TCLPlatfo_>.Add( const Name_:String; const Memory_:TCLMemory_ );
begin
     TCLArgume_.Create( Self, Name_, Memory_ );
end;

//------------------------------------------------------------------------------

function TCLArgumes<TCLProgra_,TCLContex_,TCLPlatfo_>.Contains( const Name_:String ) :Boolean;
begin
     Result := _VarArgs.ContainsKey( Name_ );
end;

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
begin
     TCLProgra( Progra ).BuildTo( TCLQueuer( Queuer ).Device );

     _Handle := clCreateKernel( TCLProgra( Progra ).Handle, P_char( AnsiString( _Name ) ), @E );

     AssertCL( E );
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

     _Argumes := TCLArgumes_.Create( Self );

     _Name         := '';
     _Queuer       := nil;
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

constructor TCLKernel<TCLProgra_,TCLContex_,TCLPlatfo_>.Create( const Progra_:TCLProgra_; const Name_:String; const Queuer_:TCLQueuer_ );
begin
     Create( Progra_, Name_ );

     _Queuer := Queuer_;
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
     Argumes.BindsOK;

     AssertCL( clEnqueueNDRangeKernel( _Queuer.Handle,
                                       Handle,
                                       Dimension,
                                       @_GlobWorkOffs[ 0 ],
                                       @_GlobWorkSize[ 0 ],
                                       @_LocaWorkSize[ 0 ],
                                       0, nil, nil ) );

     clFinish( _Queuer.Handle );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLKernels<TCLProgra_,TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

function TCLKernels<TCLProgra_,TCLContex_,TCLPlatfo_>.Add( const Name_:String ) :TCLKernel_;
begin
     Result := TCLKernel_.Create( Progra, Name_ );
end;

function TCLKernels<TCLProgra_,TCLContex_,TCLPlatfo_>.Add( const Name_:String; const Queuer_:TCLQueuer_ ) :TCLKernel_;
begin
     Result := TCLKernel_.Create( Progra, Name_, Queuer_ );
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

end. //######################################################################### ■
