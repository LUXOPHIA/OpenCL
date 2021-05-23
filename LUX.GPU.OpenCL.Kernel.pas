unit LUX.GPU.OpenCL.Kernel;

interface //#################################################################### ■

uses System.Generics.Collections,
     cl_version, cl_platform, cl,
     LUX.Data.List,
     LUX.Code.C,
     LUX.GPU.OpenCL.core,
     LUX.GPU.OpenCL.Device,
     LUX.GPU.OpenCL.Queuer,
     LUX.GPU.OpenCL.Argume;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TCLKernels     <TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_:class> = class;
       TCLKernel    <TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_:class> = class;
         TCLParames <TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_:class> = class;
           TCLParame<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_:class> = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TLoop3D

     TLoop3D = record
       X, Y, Z :T_size_t;
     end;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLParame<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>

     TCLParame<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_:class> = class( TListChildr<TCLKernel <TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>,
                                                                                       TCLParames<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>> )
     private
       type TCLArgume_  = TCLArgume <TCLSystem_,TCLPlatfo_,TCLContex_>;
            TCLKernel_  = TCLKernel <TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>;
            TCLParames_ = TCLParames<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>;
     protected
       _Name    :String;
       _ParameI :Integer;
       _Argume  :TCLArgume_;
       ///// アクセス
       function GetName :String; virtual;
       procedure SetName( const Name_:String ); virtual;
       function GetParameI :Integer; virtual;
       function GetArgume :TCLArgume_; virtual;
       procedure SetArgume( const Argume_:TCLArgume_ ); virtual;
     public
       constructor Create; override;
       constructor Create( const Parames_:TCLParames_; const Name_:String ); overload; virtual;
       constructor Create( const Parames_:TCLParames_; const Name_:String; const Argume_:TCLArgume_ ); overload; virtual;
       ///// プロパティ
       property Kernel  :TCLKernel_  read GetOwnere                 ;
       property Parames :TCLParames_ read GetParent                 ;
       property Name    :String      read GetName    write SetName  ;
       property ParameI :Integer     read GetParameI                ;
       property Argume  :TCLArgume_  read GetArgume  write SetArgume;
       ///// メソッド
       function Bind :T_cl_int;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLParames<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>

     TCLParames<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_:class> = class( TListParent<TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>,
                                                                                        TCLParame<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>> )
     private
       type TCLArgume_  = TCLArgume<TCLSystem_,TCLPlatfo_,TCLContex_>;
            TCLKernel_  = TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>;
            TCLParame_  = TCLParame<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>;
            TCLNamPars_ = TDictionary<String,TCLParame_>;
     protected
       _NamPars :TCLNamPars_;
       _FindsOK :Boolean;
       _BindsOK :Boolean;
       ///// アクセス
       function GetChildr( const Name_:String ) :TCLParame_; overload; virtual;
       procedure SetChildr( const Name_:String; const Childr_:TCLParame_ ); overload; virtual;
       function GetArgumes( const Name_:String ) :TCLArgume_; virtual;
       procedure SetArgumes( const Name_:String; const Argume_:TCLArgume_ ); virtual;
       function GetFindsOK :Boolean; virtual;
       procedure SetFindsOK( const FindsOK_:Boolean ); virtual;
       function GetBindsOK :Boolean; virtual;
       procedure SetBindsOK( const BindsOK_:Boolean ); virtual;
       ///// イベント
       procedure OnInsertChild( const Childr_:TCLParame_ ); override;
       procedure OnRemoveChild( const Childr_:TCLParame_ ); override;
     public
       constructor Create; override;
       destructor Destroy; override;
       ///// プロパティ
       property Kernel                        :TCLKernel_ read GetOwnere                  ;
       property Childrs[ const Name_:String ] :TCLParame_ read GetChildr  write SetChildr ;
       property Items  [ const Name_:String ] :TCLParame_ read GetChildr  write SetChildr ;
       property Argumes[ const Name_:String ] :TCLArgume_ read GetArgumes write SetArgumes; default;
       property FindsOK                       :Boolean    read GetFindsOK write SetFindsOK;
       property BindsOK                       :Boolean    read GetBindsOK write SetBindsOK;
       ///// メソッド
       function Contains( const Name_:String ) :Boolean;
       function Add( const Name_:String ) :TCLParame_; overload;
       function Add( const Name_:String; const Argume_:TCLArgume_ ) :TCLParame_; overload;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>

     TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_:class> = class( TListChildr<TCLExecut_,TCLKernels<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>> )
     private
       type TCLQueuer_  = TCLQueuer <TCLSystem_,TCLPlatfo_,TCLContex_>;
            TCLKernels_ = TCLKernels<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>;
            TCLParames_ = TCLParames<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>;
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
       _Parames :TCLParames_;
       _GloMin  :TLoop3D;
       _GloSiz  :TLoop3D;
       ///// アクセス
       function GetHandle :T_cl_kernel; virtual;
       procedure SetHandle( const Handle_:T_cl_kernel ); virtual;
       function GetName :String; virtual;
       procedure SetName( const Name_:String ); virtual;
       function GetGloMinX :Integer; virtual;
       procedure SetGloMinX( const GloMinX_:Integer ); virtual;
       function GetGloMinY :Integer; virtual;
       procedure SetGloMinY( const GloMinY_:Integer ); virtual;
       function GetGloMinZ :Integer; virtual;
       procedure SetGloMinZ( const GloMinZ_:Integer ); virtual;
       function GetGloSizX :Integer; virtual;
       procedure SetGloSizX( const GloSizX_:Integer ); virtual;
       function GetGloSizY :Integer; virtual;
       procedure SetGloSizY( const GloSizY_:Integer ); virtual;
       function GetGloSizZ :Integer; virtual;
       procedure SetGloSizZ( const GloSizZ_:Integer ); virtual;
       function GetGloMaxX :Integer; virtual;
       procedure SetGloMaxX( const GloMaxX_:Integer ); virtual;
       function GetGloMaxY :Integer; virtual;
       procedure SetGloMaxY( const GloMaxY_:Integer ); virtual;
       function GetGloMaxZ :Integer; virtual;
       procedure SetGloMaxZ( const GloMaxZ_:Integer ); virtual;
       function GetGloDimN :Integer; virtual;
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
       constructor Create( const Execut_:TCLExecut_; const Queuer_:TCLQueuer_ ); overload; virtual;
       constructor Create( const Execut_:TCLExecut_; const Name_:String; const Queuer_:TCLQueuer_ ); overload; virtual;
       destructor Destroy; override;
       ///// プロパティ
       property Execut  :TCLExecut_  read GetOwnere                  ;
       property Kernels :TCLKernels_ read GetParent                  ;
       property Handle  :T_cl_kernel read GetHandle  write SetHandle ;
       property Name    :String      read GetName    write SetName   ;
       property Queuer  :TCLQueuer_  read   _Queuer                  ;
       property Parames :TCLParames_ read   _Parames                 ;
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

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLKernels<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>

     TCLKernels<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_:class> = class( TListParent<TCLExecut_,TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>> )
     private
       type TCLQueuer_ = TCLQueuer<TCLSystem_,TCLPlatfo_,TCLContex_>;
            TCLKernel_ = TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>;
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
     LUX.GPU.OpenCL.Progra;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLParame<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLParame<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.GetName :String;
begin
     Result := _Name;
end;

procedure TCLParame<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.SetName( const Name_:String );
begin
     _Name := Name_;

     Parames.FindsOK := False;
end;

//------------------------------------------------------------------------------

function TCLParame<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.GetParameI :Integer;
begin
     Parames.FindsOK;

     Result := _ParameI;
end;

//------------------------------------------------------------------------------

function TCLParame<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.GetArgume :TCLArgume_;
begin
     Result := _Argume;
end;

procedure TCLParame<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.SetArgume( const Argume_:TCLArgume_ );
begin
     _Argume := Argume_;

     if Assigned( Parames ) then Parames.BindsOK := False;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLParame<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.Create;
begin
     inherited;

     _Name    := '';
     _ParameI := -1;
     _Argume  := nil;
end;

constructor TCLParame<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.Create( const Parames_:TCLParames_; const Name_:String );
begin
     inherited Create( Parames_ );

     _Name := Name_;
end;

constructor TCLParame<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.Create( const Parames_:TCLParames_; const Name_:String; const Argume_:TCLArgume_ );
begin
     Create( Parames_, Name_ );

     _Argume := Argume_;
end;

/////////////////////////////////////////////////////////////////////// メソッド

function TCLParame<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.Bind :T_cl_int;
var
   H :T_cl_mem;
begin
     H := Argume.HanPtr;

     Result := clSetKernelArg( Kernel.Handle,
                               T_cl_uint( ParameI ),
                               Argume.HanSiz,
                               @H );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLParames<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLParames<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.GetChildr( const Name_:String ) :TCLParame_;
begin
     if Contains( Name_ ) then Result := _NamPars[ Name_ ]
                          else Result := Add( Name_ );
end;

procedure TCLParames<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.SetChildr( const Name_:String; const Childr_:TCLParame_ );
begin
     if _NamPars.ContainsKey( Name_ ) then _NamPars[ Name_ ].Free;

     _NamPars[ Name_ ] := Childr_;
end;

//------------------------------------------------------------------------------

function TCLParames<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.GetArgumes( const Name_:String ) :TCLArgume_;
begin
     Result := _NamPars[ Name_ ].Argume;
end;

procedure TCLParames<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.SetArgumes( const Name_:String; const Argume_:TCLArgume_ );
begin
     Childrs[ Name_ ].Argume := Argume_;
end;

//------------------------------------------------------------------------------

function TCLParames<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.GetFindsOK :Boolean;
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

procedure TCLParames<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.SetFindsOK( const FindsOK_:Boolean );
begin
     _FindsOK := FindsOK_;
     _BindsOK := False;
end;

//------------------------------------------------------------------------------

function TCLParames<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.GetBindsOK :Boolean;
var
   A :TCLParame_;
begin
     if FindsOK and not _BindsOK then
     begin
          for A in Self do AssertCL( A.Bind, 'TCLParame.Bind is Error!' );

          _BindsOK := True;
     end;

     Result := _BindsOK;
end;

procedure TCLParames<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.SetBindsOK( const BindsOK_:Boolean );
begin
     _BindsOK := BindsOK_;
end;

/////////////////////////////////////////////////////////////////////// イベント

procedure TCLParames<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.OnInsertChild( const Childr_:TCLParame_ );
begin
     inherited;

     if _NamPars.ContainsKey( Childr_.Name ) then _NamPars[ Childr_.Name ].Free;

     _NamPars.Add( Childr_.Name, Childr_ );
end;

procedure TCLParames<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.OnRemoveChild( const Childr_:TCLParame_ );
begin
     inherited;

     _NamPars.Remove( Childr_.Name );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLParames<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.Create;
begin
     inherited;

     _NamPars := TCLNamPars_.Create;

     _FindsOK := False;
     _BindsOK := False;
end;

destructor TCLParames<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.Destroy;
begin
     Clear;

     _NamPars.Free;

     inherited;
end;

/////////////////////////////////////////////////////////////////////// メソッド

function TCLParames<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.Contains( const Name_:String ) :Boolean;
begin
     Result := _NamPars.ContainsKey( Name_ );
end;

//------------------------------------------------------------------------------

function TCLParames<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.Add( const Name_:String ) :TCLParame_;
begin
     Result := TCLParame_.Create( Self, Name_ );
end;

function TCLParames<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.Add( const Name_:String; const Argume_:TCLArgume_ ) :TCLParame_;
begin
     Result := TCLParame_.Create( Self, Name_, Argume_ );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

/////////////////////////////////////////////////////////////////////// メソッド

function TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.GetInfo<_TYPE_>( const Name_:T_cl_kernel_info ) :_TYPE_;
begin
     AssertCL( clGetKernelInfo( Handle, Name_, SizeOf( _TYPE_ ), @Result, nil ), 'TCLKernel.GetInfo is Error!' );
end;

function TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.GetInfoSize( const Name_:T_cl_kernel_info ) :T_size_t;
begin
     AssertCL( clGetKernelInfo( Handle, Name_, 0, nil, @Result ), 'TCLKernel.GetInfoSize is Error!' );
end;

function TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.GetInfos<_TYPE_>( const Name_:T_cl_kernel_info ) :TArray<_TYPE_>;
var
   S :T_size_t;
begin
     S := GetInfoSize( Name_ );

     SetLength( Result, S div Cardinal( SizeOf( _TYPE_ ) ) );

     AssertCL( clGetKernelInfo( Handle, Name_, S, @Result[ 0 ], nil ), 'TCLKernel.GetInfos is Error!' );
end;

function TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.GetInfoString( const Name_:T_cl_kernel_info ) :String;
begin
     Result := TrimRight( String( P_char( GetInfos<T_char>( Name_ ) ) ) );
end;

//------------------------------------------------------------------------------

function TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.GetArgInfo<_TYPE_>( const I_:T_cl_uint; const Name_:T_cl_kernel_arg_info ) :_TYPE_;
begin
     AssertCL( clGetKernelArgInfo( Handle, I_, Name_, SizeOf( _TYPE_ ), @Result, nil ), 'TCLKernel.GetArgInfo is Error!' );
end;

function TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.GetArgInfoSize( const I_:T_cl_uint; const Name_:T_cl_kernel_arg_info ) :T_size_t;
begin
     AssertCL( clGetKernelArgInfo( Handle, I_, Name_, 0, nil, @Result ), 'TCLKernel.GetArgInfoSize is Error!' );
end;

function TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.GetArgInfos<_TYPE_>( const I_:T_cl_uint; const Name_:T_cl_kernel_arg_info ) :TArray<_TYPE_>;
var
   S :T_size_t;
begin
     S := GetArgInfoSize( I_, Name_ );

     SetLength( Result, S div Cardinal( SizeOf( _TYPE_ ) ) );

     AssertCL( clGetKernelArgInfo( Handle, I_, Name_, S, @Result[ 0 ], nil ), 'TCLKernel.GetArgInfos is Error!' );
end;

function TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.GetArgInfoString( const I_:T_cl_uint; const Name_:T_cl_kernel_arg_info ) :String;
begin
     Result := TrimRight( String( P_char( GetArgInfos<T_char>( I_, Name_ ) ) ) );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.GetHandle :T_cl_kernel;
begin
     if not Assigned( _Handle ) then CreateHandle;

     Result := _Handle;
end;

procedure TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.SetHandle( const Handle_:T_cl_kernel );
begin
     if Assigned( _Handle ) then AssertCL( DestroHandle, 'TCLKernel.DestroHandle is Error!' );

     _Handle := Handle_;
end;

//------------------------------------------------------------------------------

function TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.GetName :String;
begin
     Result := _Name;
end;

procedure TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.SetName( const Name_:String );
begin
     _Name := Name_;

     Handle := nil;
end;

//------------------------------------------------------------------------------

function TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.GetGloMinX :Integer;
begin
     Result := _GloMin.X;
end;

procedure TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.SetGloMinX( const GloMinX_:Integer );
begin
     _GloMin.X := GloMinX_;
end;

function TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.GetGloMinY :Integer;
begin
     Result := _GloMin.Y;
end;

procedure TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.SetGloMinY( const GloMinY_:Integer );
begin
     _GloMin.Y := GloMinY_;
end;

function TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.GetGloMinZ :Integer;
begin
     Result := _GloMin.Z;
end;

procedure TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.SetGloMinZ( const GloMinZ_:Integer );
begin
     _GloMin.Z := GloMinZ_;
end;

//------------------------------------------------------------------------------

function TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.GetGloSizX :Integer;
begin
     Result := _GloSiz.X;
end;

procedure TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.SetGloSizX( const GloSizX_:Integer );
begin
     _GloSiz.X := GloSizX_;
end;

function TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.GetGloSizY :Integer;
begin
     Result := _GloSiz.Y;
end;

procedure TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.SetGloSizY( const GloSizY_:Integer );
begin
     _GloSiz.Y := GloSizY_;
end;

function TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.GetGloSizZ :Integer;
begin
     Result := _GloSiz.Z;
end;

procedure TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.SetGloSizZ( const GloSizZ_:Integer );
begin
     _GloSiz.Z := GloSizZ_;
end;

//------------------------------------------------------------------------------

function TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.GetGloMaxX :Integer;
begin
     Result := GloMinX + GloSizX - 1;
end;

procedure TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.SetGloMaxX( const GloMaxX_:Integer );
begin
     GloSizX := GloMaxX_ - GloMinX + 1;
end;

function TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.GetGloMaxY :Integer;
begin
     Result := GloMinY + GloSizY - 1;
end;

procedure TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.SetGloMaxY( const GloMaxY_:Integer );
begin
     GloSizY := GloMaxY_ - GloMinY + 1;
end;

function TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.GetGloMaxZ :Integer;
begin
     Result := GloMinZ + GloSizZ - 1;
end;

procedure TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.SetGloMaxZ( const GloMaxZ_:Integer );
begin
     GloSizZ := GloMaxZ_ - GloMinZ + 1;
end;

//------------------------------------------------------------------------------

function TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.GetGloDimN :Integer;
begin
     if ( GloMinZ > 0 ) or ( GloSizZ > 1 ) then Result := 3
                                           else
     if ( GloMinY > 0 ) or ( GloSizY > 1 ) then Result := 2
                                           else Result := 1;
end;

//----------------------------------------------------------(* cl_kernel_info *)

function TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.GetKERNEL_FUNCTION_NAME :String;
begin
     Result := GetInfoString( CL_KERNEL_FUNCTION_NAME );
end;

function TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.GetKERNEL_NUM_ARGS :T_cl_uint;
begin
     Result := GetInfo<T_cl_uint>( CL_KERNEL_NUM_ARGS );
end;

function TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.GetKERNEL_REFERENCE_COUNT :T_cl_uint;
begin
     Result := GetInfo<T_cl_uint>( CL_KERNEL_REFERENCE_COUNT );
end;

function TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.GetKERNEL_CONTEXT :T_cl_context;
begin
     Result := GetInfo<T_cl_context>( CL_KERNEL_CONTEXT );
end;

function TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.GetKERNEL_PROGRAM :T_cl_program;
begin
     Result := GetInfo<T_cl_program>( CL_KERNEL_PROGRAM );
end;

{$IF CL_VERSION_1_2 <> 0 }
function TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.GetKERNEL_ATTRIBUTES :String;
begin
     Result := GetInfoString( CL_KERNEL_ATTRIBUTES );
end;
{$ENDIF}

//------------------------------------------------------(* cl_kernel_arg_info *)

function TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.GetKERNEL_ARG_ADDRESS_QUALIFIER( const I_:T_cl_uint ) :T_cl_kernel_arg_address_qualifier;
begin
     Result := GetArgInfo<T_cl_kernel_arg_address_qualifier>( I_, CL_KERNEL_ARG_ADDRESS_QUALIFIER );
end;

function TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.GetKERNEL_ARG_ACCESS_QUALIFIER( const I_:T_cl_uint ) :T_cl_kernel_arg_access_qualifier;
begin
     Result := GetArgInfo<T_cl_kernel_arg_access_qualifier>( I_, CL_KERNEL_ARG_ACCESS_QUALIFIER );
end;

function TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.GetKERNEL_ARG_TYPE_NAME( const I_:T_cl_uint ) :String;
begin
     Result := GetArgInfoString( I_, CL_KERNEL_ARG_TYPE_NAME );
end;

function TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.GetKERNEL_ARG_TYPE_QUALIFIER( const I_:T_cl_uint ) :T_cl_kernel_arg_type_qualifier;
begin
     Result := GetArgInfo<T_cl_kernel_arg_type_qualifier>( I_, CL_KERNEL_ARG_TYPE_QUALIFIER );
end;

function TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.GetKERNEL_ARG_NAME( const I_:T_cl_uint ) :String;
begin
     Result := GetArgInfoString( I_, CL_KERNEL_ARG_NAME );
end;

/////////////////////////////////////////////////////////////////////// メソッド

function TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.CreateHandle :T_cl_int;
var
   B :TCLBuildr<TCLSystem_,TCLPlatfo_,TCLContex_>;
begin
     B := TCLExecut<TCLSystem_,TCLPlatfo_,TCLContex_>( Execut ).Buildrs[ Queuer.Device ];

     _Handle := clCreateKernel( B.Handle, P_char( AnsiString( _Name ) ), @Result );
end;

function TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.DestroHandle :T_cl_int;
begin
     Result := clReleaseKernel( _Handle );

     _Handle := nil;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.Create;
begin
     inherited;

     _Handle := nil;

     _Parames := TCLParames_.Create( Self );

     _Name   := '';
     _Queuer := nil;

     _GloMin.X := 0;  _GloMin.Y := 0;  _GloMin.Z := 0;
     _GloSiz.X := 1;  _GloSiz.Y := 1;  _GloSiz.Z := 1;
end;

constructor TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.Create( const Execut_:TCLExecut_ );
begin
     inherited Create( TCLExecut<TCLSystem_,TCLPlatfo_,TCLContex_>( Execut_ ).Kernels );
end;

constructor TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.Create( const Execut_:TCLExecut_; const Name_:String );
begin
     Create( Execut_ );

     _Name := Name_;
end;

constructor TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.Create( const Execut_:TCLExecut_; const Queuer_:TCLQueuer_ );
begin
     Create( Execut_ );

     _Queuer := Queuer_;
end;

constructor TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.Create( const Execut_:TCLExecut_; const Name_:String; const Queuer_:TCLQueuer_ );
begin
     Create( Execut_, Name_ );

     _Queuer := Queuer_;
end;

destructor TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.Destroy;
begin
     _Parames.Free;

      Handle := nil;

     inherited;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.Run;
begin
     Parames.BindsOK;

     AssertCL( clEnqueueNDRangeKernel( Queuer.Handle, Handle,
                                       GloDimN, @_GloMin, @_GloSiz, nil,
                                       0, nil, nil ), 'TCLKernel.Run is Error!' );

     AssertCL( clFinish( Queuer.Handle ), 'TCLKernel.Run is Error!' );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLKernels<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

function TCLKernels<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.Add( const Name_:String ) :TCLKernel_;
begin
     Result := TCLKernel_.Create( Execut, Name_ );
end;

function TCLKernels<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>.Add( const Name_:String; const Queuer_:TCLQueuer_ ) :TCLKernel_;
begin
     Result := TCLKernel_.Create( Execut, Name_, Queuer_ );
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

end. //######################################################################### ■
