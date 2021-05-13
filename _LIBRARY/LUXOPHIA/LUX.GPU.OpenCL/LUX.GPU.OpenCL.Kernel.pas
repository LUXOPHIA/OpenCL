unit LUX.GPU.OpenCL.Kernel;

interface //#################################################################### ■

uses System.Generics.Collections,
     cl_version, cl_platform, cl,
     LUX.Data.List,
     LUX.Code.C,
     LUX.GPU.OpenCL.core,
     LUX.GPU.OpenCL.Device,
     LUX.GPU.OpenCL.Queuer,
     LUX.GPU.OpenCL.Memory;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TCLKernels     <TCLExecut_,TCLContex_,TCLPlatfo_:class> = class;
       TCLKernel    <TCLExecut_,TCLContex_,TCLPlatfo_:class> = class;
         TCLArgumes <TCLExecut_,TCLContex_,TCLPlatfo_:class> = class;
           TCLArgume<TCLExecut_,TCLContex_,TCLPlatfo_:class> = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TLoop3D

     TLoop3D = record
       X, Y, Z :T_size_t;
     end;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLArgume<TCLExecut_,TCLContex_,TCLPlatfo_>

     TCLArgume<TCLExecut_,TCLContex_,TCLPlatfo_:class> = class( TListChildr<TCLKernel <TCLExecut_,TCLContex_,TCLPlatfo_>,
                                                                            TCLArgumes<TCLExecut_,TCLContex_,TCLPlatfo_>> )
     private
       type TCLMemory_  = TCLMemory <TCLContex_,TCLPlatfo_>;
            TCLKernel_  = TCLKernel <TCLExecut_,TCLContex_,TCLPlatfo_>;
            TCLArgumes_ = TCLArgumes<TCLExecut_,TCLContex_,TCLPlatfo_>;
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

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLArgumes<TCLExecut_,TCLContex_,TCLPlatfo_>

     TCLArgumes<TCLExecut_,TCLContex_,TCLPlatfo_:class> = class( TListParent<TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>,
                                                                             TCLArgume<TCLExecut_,TCLContex_,TCLPlatfo_>> )
     private
       type TCLMemory_ = TCLMemory<TCLContex_,TCLPlatfo_>;
            TCLKernel_ = TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>;
            TCLArgume_ = TCLArgume<TCLExecut_,TCLContex_,TCLPlatfo_>;
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

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>

     TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_:class> = class( TListChildr<TCLExecut_,TCLKernels<TCLExecut_,TCLContex_,TCLPlatfo_>> )
     private
       type TCLQueuer_  = TCLQueuer <TCLContex_,TCLPlatfo_>;
            TCLKernels_ = TCLKernels<TCLExecut_,TCLContex_,TCLPlatfo_>;
            TCLKernel_  = TCLKernel <TCLExecut_,TCLContex_,TCLPlatfo_>;
            TCLArgumes_ = TCLArgumes<TCLExecut_,TCLContex_,TCLPlatfo_>;
            TCLArgume_  = TCLArgume <TCLExecut_,TCLContex_,TCLPlatfo_>;
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
       _Handle  :T_cl_kernel;
       _Name    :String;
       _Queuer  :TCLQueuer_;
       _Argumes :TCLArgumes_;
       _GloMin  :TLoop3D;
       _GloSiz  :TLoop3D;
       ///// アクセス
       function GetHandle :T_cl_kernel;
       procedure SetHandle( const Handle_:T_cl_kernel );
       function GetGloMinX :Integer;
       procedure SetGloMinX( const GloMinX_:Integer );
       function GetGloMinY :Integer;
       procedure SetGloMinY( const GloMinY_:Integer );
       function GetGloMinZ :Integer;
       procedure SetGloMinZ( const GloMinZ_:Integer );
       function GetGloSizX :Integer;
       procedure SetGloSizX( const GloSizX_:Integer );
       function GetGloSizY :Integer;
       procedure SetGloSizY( const GloSizY_:Integer );
       function GetGloSizZ :Integer;
       procedure SetGloSizZ( const GloSizZ_:Integer );
       function GetGloMaxX :Integer;
       procedure SetGloMaxX( const GloMaxX_:Integer );
       function GetGloMaxY :Integer;
       procedure SetGloMaxY( const GloMaxY_:Integer );
       function GetGloMaxZ :Integer;
       procedure SetGloMaxZ( const GloMaxZ_:Integer );
       function GetGloDimN :Integer;
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
       function CreateHandle :T_cl_int; virtual;
       function DestroHandle :T_cl_int; virtual;
     public
       constructor Create; override;
       constructor Create( const Execut_:TCLExecut_ ); overload; virtual;
       constructor Create( const Execut_:TCLExecut_; const Name_:String ); overload; virtual;
       constructor Create( const Execut_:TCLExecut_; const Name_:String; const Queuer_:TCLQueuer_ ); overload; virtual;
       destructor Destroy; override;
       ///// プロパティ
       property Execut  :TCLExecut_  read GetOwnere                  ;
       property Kernels :TCLKernels_ read GetParent                  ;
       property Handle  :T_cl_kernel read GetHandle  write SetHandle ;
       property Name    :String      read   _Name    write   _Name   ;
       property Queuer  :TCLQueuer_  read   _Queuer                  ;
       property Argumes :TCLArgumes_ read   _Argumes                 ;
       property GloMinX :Integer     read GetGloMinX write SetGloMinX;
       property GloMinY :Integer     read GetGloMinY write SetGloMinY;
       property GloMinZ :Integer     read GetGloMinZ write SetGloMinZ;
       property GloSizX :Integer     read GetGloSizX write SetGloSizX;
       property GloSizY :Integer     read GetGloSizY write SetGloSizY;
       property GloSizZ :Integer     read GetGloSizZ write SetGloSizZ;
       property GloMaxX :Integer     read GetGloMaxX write SetGloMaxX;
       property GloMaxY :Integer     read GetGloMaxY write SetGloMaxY;
       property GloMaxZ :Integer     read GetGloMaxZ write SetGloMaxZ;
       property GloDimN :Integer     read GetGloDimN                 ;
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

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLKernels<TCLExecut_,TCLContex_,TCLPlatfo_>

     TCLKernels<TCLExecut_,TCLContex_,TCLPlatfo_:class> = class( TListParent<TCLExecut_,TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>> )
     private
       type TCLQueuer_ = TCLQueuer<TCLContex_,TCLPlatfo_>;
            TCLKernel_ = TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>;
     protected
     public
       ///// プロパティ
       property Execut :TCLExecut_ read GetOwnere;
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

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLArgume<TCLExecut_,TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLArgume<TCLExecut_,TCLContex_,TCLPlatfo_>.GetName :String;
begin
     Result := _Name;
end;

procedure TCLArgume<TCLExecut_,TCLContex_,TCLPlatfo_>.SetName( const Name_:String );
begin
     _Name := Name_;

     Argumes.FindsOK := False;
end;

//------------------------------------------------------------------------------

function TCLArgume<TCLExecut_,TCLContex_,TCLPlatfo_>.GetParameI :Integer;
begin
     Argumes.FindsOK;

     Result := _ParameI;
end;

//------------------------------------------------------------------------------

function TCLArgume<TCLExecut_,TCLContex_,TCLPlatfo_>.GetMemory :TCLMemory_;
begin
     Result := _Memory;
end;

procedure TCLArgume<TCLExecut_,TCLContex_,TCLPlatfo_>.SetMemory( const Memory_:TCLMemory_ );
begin
     _Memory := Memory_;

     if Assigned( Argumes ) then Argumes.BindsOK := False;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLArgume<TCLExecut_,TCLContex_,TCLPlatfo_>.Create;
begin
     inherited;

     _Name    := '';
     _ParameI := -1;
     _Memory  := nil;
end;

constructor TCLArgume<TCLExecut_,TCLContex_,TCLPlatfo_>.Create( const Argumes_:TCLArgumes_; const Name_:String );
begin
     inherited Create( Argumes_ );

     _Name := Name_;
end;

constructor TCLArgume<TCLExecut_,TCLContex_,TCLPlatfo_>.Create( const Argumes_:TCLArgumes_; const Name_:String; const Memory_:TCLMemory_ );
begin
     Create( Argumes_, Name_ );

     _Memory := Memory_;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLArgume<TCLExecut_,TCLContex_,TCLPlatfo_>.Bind;
var
   H :T_cl_mem;
begin
     H := Memory.Handle;

     AssertCL( clSetKernelArg( Kernel.Handle, T_cl_uint( ParameI ), SizeOf( T_cl_mem ), @H ), 'TCLArgume.Bind is Error!' );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLArgumes<TCLExecut_,TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLArgumes<TCLExecut_,TCLContex_,TCLPlatfo_>.GetChildr( const Name_:String ) :TCLArgume_;
begin
     Result := _VarArgs[ Name_ ];
end;

procedure TCLArgumes<TCLExecut_,TCLContex_,TCLPlatfo_>.SetChildr( const Name_:String; const Childr_:TCLArgume_ );
begin
     if _VarArgs.ContainsKey( Name_ ) then _VarArgs[ Name_ ].Free;

     _VarArgs[ Name_ ] := Childr_;
end;

//------------------------------------------------------------------------------

function TCLArgumes<TCLExecut_,TCLContex_,TCLPlatfo_>.GetMemorys( const Name_:String ) :TCLMemory_;
begin
     Result := _VarArgs[ Name_ ].Memory;
end;

procedure TCLArgumes<TCLExecut_,TCLContex_,TCLPlatfo_>.SetMemorys( const Name_:String; const Memory_:TCLMemory_ );
begin
     if _VarArgs.ContainsKey( Name_ ) then _VarArgs[ Name_ ].Memory := Memory_
                                      else Add( Name_, Memory_ );
end;

//------------------------------------------------------------------------------

function TCLArgumes<TCLExecut_,TCLContex_,TCLPlatfo_>.GetFindsOK :Boolean;
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

procedure TCLArgumes<TCLExecut_,TCLContex_,TCLPlatfo_>.SetFindsOK( const FindsOK_:Boolean );
begin
     _FindsOK := FindsOK_;
     _BindsOK := False;
end;

//------------------------------------------------------------------------------

function TCLArgumes<TCLExecut_,TCLContex_,TCLPlatfo_>.GetBindsOK :Boolean;
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

procedure TCLArgumes<TCLExecut_,TCLContex_,TCLPlatfo_>.SetBindsOK( const BindsOK_:Boolean );
begin
     _BindsOK := BindsOK_;
end;

/////////////////////////////////////////////////////////////////////// イベント

procedure TCLArgumes<TCLExecut_,TCLContex_,TCLPlatfo_>.OnInsertChild( const Childr_:TCLArgume_ );
begin
     inherited;

     if _VarArgs.ContainsKey( Childr_.Name ) then _VarArgs[ Childr_.Name ].Free;

     _VarArgs.Add( Childr_.Name, Childr_ );
end;

procedure TCLArgumes<TCLExecut_,TCLContex_,TCLPlatfo_>.OnRemoveChild( const Childr_:TCLArgume_ );
begin
     inherited;

     _VarArgs.Remove( Childr_.Name );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLArgumes<TCLExecut_,TCLContex_,TCLPlatfo_>.Create;
begin
     inherited;

     _VarArgs := TCLVarArgs.Create;

     _FindsOK := False;
     _BindsOK := False;
end;

destructor TCLArgumes<TCLExecut_,TCLContex_,TCLPlatfo_>.Destroy;
begin
     Clear;

     _VarArgs.Free;

     inherited;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLArgumes<TCLExecut_,TCLContex_,TCLPlatfo_>.Add( const Name_:String; const Memory_:TCLMemory_ );
begin
     TCLArgume_.Create( Self, Name_, Memory_ );
end;

//------------------------------------------------------------------------------

function TCLArgumes<TCLExecut_,TCLContex_,TCLPlatfo_>.Contains( const Name_:String ) :Boolean;
begin
     Result := _VarArgs.ContainsKey( Name_ );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

/////////////////////////////////////////////////////////////////////// メソッド

function TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>.GetInfo<_TYPE_>( const Name_:T_cl_kernel_info ) :_TYPE_;
begin
     AssertCL( clGetKernelInfo( Handle, Name_, SizeOf( _TYPE_ ), @Result, nil ), 'TCLKernel.GetInfo is Error!' );
end;

function TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>.GetInfoSize( const Name_:T_cl_kernel_info ) :T_size_t;
begin
     AssertCL( clGetKernelInfo( Handle, Name_, 0, nil, @Result ), 'TCLKernel.GetInfoSize is Error!' );
end;

function TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>.GetInfos<_TYPE_>( const Name_:T_cl_kernel_info ) :TArray<_TYPE_>;
var
   S :T_size_t;
begin
     S := GetInfoSize( Name_ );

     SetLength( Result, S div Cardinal( SizeOf( _TYPE_ ) ) );

     AssertCL( clGetKernelInfo( Handle, Name_, S, @Result[ 0 ], nil ), 'TCLKernel.GetInfos is Error!' );
end;

function TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>.GetInfoString( const Name_:T_cl_kernel_info ) :String;
begin
     Result := TrimRight( String( P_char( GetInfos<T_char>( Name_ ) ) ) );
end;

//------------------------------------------------------------------------------

function TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>.GetArgInfo<_TYPE_>( const I_:T_cl_uint; const Name_:T_cl_kernel_arg_info ) :_TYPE_;
begin
     AssertCL( clGetKernelArgInfo( Handle, I_, Name_, SizeOf( _TYPE_ ), @Result, nil ), 'TCLKernel.GetArgInfo is Error!' );
end;

function TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>.GetArgInfoSize( const I_:T_cl_uint; const Name_:T_cl_kernel_arg_info ) :T_size_t;
begin
     AssertCL( clGetKernelArgInfo( Handle, I_, Name_, 0, nil, @Result ), 'TCLKernel.GetArgInfoSize is Error!' );
end;

function TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>.GetArgInfos<_TYPE_>( const I_:T_cl_uint; const Name_:T_cl_kernel_arg_info ) :TArray<_TYPE_>;
var
   S :T_size_t;
begin
     S := GetArgInfoSize( I_, Name_ );

     SetLength( Result, S div Cardinal( SizeOf( _TYPE_ ) ) );

     AssertCL( clGetKernelArgInfo( Handle, I_, Name_, S, @Result[ 0 ], nil ), 'TCLKernel.GetArgInfos is Error!' );
end;

function TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>.GetArgInfoString( const I_:T_cl_uint; const Name_:T_cl_kernel_arg_info ) :String;
begin
     Result := TrimRight( String( P_char( GetArgInfos<T_char>( I_, Name_ ) ) ) );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>.GetHandle :T_cl_kernel;
begin
     if not Assigned( _Handle ) then AssertCL( CreateHandle, 'TCLKernel.CreateHandle is Error!' );

     Result := _Handle;
end;

procedure TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>.SetHandle( const Handle_:T_cl_kernel );
begin
     if Assigned( _Handle ) then AssertCL( DestroHandle, 'TCLKernel.DestroHandle is Error!' );

     _Handle := Handle_;
end;

//------------------------------------------------------------------------------

function TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>.GetGloMinX :Integer;
begin
     Result := _GloMin.X;
end;

procedure TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>.SetGloMinX( const GloMinX_:Integer );
begin
     _GloMin.X := GloMinX_;
end;

function TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>.GetGloMinY :Integer;
begin
     Result := _GloMin.Y;
end;

procedure TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>.SetGloMinY( const GloMinY_:Integer );
begin
     _GloMin.Y := GloMinY_;
end;

function TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>.GetGloMinZ :Integer;
begin
     Result := _GloMin.Z;
end;

procedure TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>.SetGloMinZ( const GloMinZ_:Integer );
begin
     _GloMin.Z := GloMinZ_;
end;

//------------------------------------------------------------------------------

function TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>.GetGloSizX :Integer;
begin
     Result := _GloSiz.X;
end;

procedure TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>.SetGloSizX( const GloSizX_:Integer );
begin
     _GloSiz.X := GloSizX_;
end;

function TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>.GetGloSizY :Integer;
begin
     Result := _GloSiz.Y;
end;

procedure TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>.SetGloSizY( const GloSizY_:Integer );
begin
     _GloSiz.Y := GloSizY_;
end;

function TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>.GetGloSizZ :Integer;
begin
     Result := _GloSiz.Z;
end;

procedure TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>.SetGloSizZ( const GloSizZ_:Integer );
begin
     _GloSiz.Z := GloSizZ_;
end;

//------------------------------------------------------------------------------

function TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>.GetGloMaxX :Integer;
begin
     Result := GloMinX + GloSizX - 1;
end;

procedure TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>.SetGloMaxX( const GloMaxX_:Integer );
begin
     GloSizX := GloMaxX_ - GloMinX + 1;
end;

function TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>.GetGloMaxY :Integer;
begin
     Result := GloMinY + GloSizY - 1;
end;

procedure TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>.SetGloMaxY( const GloMaxY_:Integer );
begin
     GloSizY := GloMaxY_ - GloMinY + 1;
end;

function TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>.GetGloMaxZ :Integer;
begin
     Result := GloMinZ + GloSizZ - 1;
end;

procedure TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>.SetGloMaxZ( const GloMaxZ_:Integer );
begin
     GloSizZ := GloMaxZ_ - GloMinZ + 1;
end;

//------------------------------------------------------------------------------

function TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>.GetGloDimN :Integer;
begin
     if ( GloMinZ > 0 ) or ( GloSizZ > 1 ) then Result := 3
                                           else
     if ( GloMinY > 0 ) or ( GloSizY > 1 ) then Result := 2
                                           else Result := 1;
end;

//----------------------------------------------------------(* cl_kernel_info *)

function TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>.GetKERNEL_FUNCTION_NAME :String;
begin
     Result := GetInfoString( CL_KERNEL_FUNCTION_NAME );
end;

function TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>.GetKERNEL_NUM_ARGS :T_cl_uint;
begin
     Result := GetInfo<T_cl_uint>( CL_KERNEL_NUM_ARGS );
end;

function TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>.GetKERNEL_REFERENCE_COUNT :T_cl_uint;
begin
     Result := GetInfo<T_cl_uint>( CL_KERNEL_REFERENCE_COUNT );
end;

function TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>.GetKERNEL_CONTEXT :T_cl_context;
begin
     Result := GetInfo<T_cl_context>( CL_KERNEL_CONTEXT );
end;

function TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>.GetKERNEL_PROGRAM :T_cl_program;
begin
     Result := GetInfo<T_cl_program>( CL_KERNEL_PROGRAM );
end;

{$IF CL_VERSION_1_2 <> 0 }
function TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>.GetKERNEL_ATTRIBUTES :String;
begin
     Result := GetInfoString( CL_KERNEL_ATTRIBUTES );
end;
{$ENDIF}

//------------------------------------------------------(* cl_kernel_arg_info *)

function TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>.GetKERNEL_ARG_ADDRESS_QUALIFIER( const I_:T_cl_uint ) :T_cl_kernel_arg_address_qualifier;
begin
     Result := GetArgInfo<T_cl_kernel_arg_address_qualifier>( I_, CL_KERNEL_ARG_ADDRESS_QUALIFIER );
end;

function TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>.GetKERNEL_ARG_ACCESS_QUALIFIER( const I_:T_cl_uint ) :T_cl_kernel_arg_access_qualifier;
begin
     Result := GetArgInfo<T_cl_kernel_arg_access_qualifier>( I_, CL_KERNEL_ARG_ACCESS_QUALIFIER );
end;

function TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>.GetKERNEL_ARG_TYPE_NAME( const I_:T_cl_uint ) :String;
begin
     Result := GetArgInfoString( I_, CL_KERNEL_ARG_TYPE_NAME );
end;

function TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>.GetKERNEL_ARG_TYPE_QUALIFIER( const I_:T_cl_uint ) :T_cl_kernel_arg_type_qualifier;
begin
     Result := GetArgInfo<T_cl_kernel_arg_type_qualifier>( I_, CL_KERNEL_ARG_TYPE_QUALIFIER );
end;

function TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>.GetKERNEL_ARG_NAME( const I_:T_cl_uint ) :String;
begin
     Result := GetArgInfoString( I_, CL_KERNEL_ARG_NAME );
end;

/////////////////////////////////////////////////////////////////////// メソッド

function TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>.CreateHandle :T_cl_int;
var
   B :TCLBuildr;
begin
     B := TCLExecut( Execut ).Buildrs[ TCLQueuer( Queuer ).Device ];

     _Handle := clCreateKernel( B.Handle, P_char( AnsiString( _Name ) ), @Result );
end;

function TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>.DestroHandle :T_cl_int;
begin
     Result := clReleaseKernel( _Handle );

     _Handle := nil;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>.Create;
begin
     inherited;

     _Handle := nil;

     _Argumes := TCLArgumes_.Create( Self );

     _Name   := '';
     _Queuer := nil;

     _GloMin.X := 0;  _GloMin.Y := 0;  _GloMin.Z := 0;
     _GloSiz.X := 1;  _GloSiz.Y := 1;  _GloSiz.Z := 1;
end;

constructor TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>.Create( const Execut_:TCLExecut_ );
begin
     inherited Create( TCLExecut( Execut_ ).Kernels );
end;

constructor TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>.Create( const Execut_:TCLExecut_; const Name_:String );
begin
     Create( Execut_ );

     _Name := Name_;
end;

constructor TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>.Create( const Execut_:TCLExecut_; const Name_:String; const Queuer_:TCLQueuer_ );
begin
     Create( Execut_, Name_ );

     _Queuer := Queuer_;
end;

destructor TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>.Destroy;
begin
     _Argumes.Free;

      Handle := nil;

     inherited;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLKernel<TCLExecut_,TCLContex_,TCLPlatfo_>.Run;
begin
     Argumes.BindsOK;

     AssertCL( clEnqueueNDRangeKernel( _Queuer.Handle, Handle,
                                       2, @_GloMin, @_GloSiz, nil,
                                       0, nil, nil ), 'TCLKernel.Run is Error!' );

     AssertCL( clFinish( _Queuer.Handle ), 'TCLKernel.Run is Error!' );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLKernels<TCLExecut_,TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

function TCLKernels<TCLExecut_,TCLContex_,TCLPlatfo_>.Add( const Name_:String ) :TCLKernel_;
begin
     Result := TCLKernel_.Create( Execut, Name_ );
end;

function TCLKernels<TCLExecut_,TCLContex_,TCLPlatfo_>.Add( const Name_:String; const Queuer_:TCLQueuer_ ) :TCLKernel_;
begin
     Result := TCLKernel_.Create( Execut, Name_, Queuer_ );
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

end. //######################################################################### ■
