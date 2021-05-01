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
       TCLDeploys  <TCLProgra_,TCLContex_,TCLPlatfo_:class> = class;
         TCLDeploy <TCLProgra_,TCLContex_,TCLPlatfo_:class> = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDeploy<TCLProgra_,TCLContex_,TCLPlatfo_>

     TCLDeploy<TCLProgra_,TCLContex_,TCLPlatfo_:class> = class( TListChildr<TCLKernels<TCLProgra_,TCLContex_,TCLPlatfo_>,
                                                                            TCLDeploys<TCLProgra_,TCLContex_,TCLPlatfo_>> )
     private
       type TCLDevice_  = TCLDevice <TCLPlatfo_>;
            TCLKernels_ = TCLKernels<TCLProgra_,TCLContex_,TCLPlatfo_>;
            TCLDeploys_ = TCLDeploys<TCLProgra_,TCLContex_,TCLPlatfo_>;
     protected
       _Device :TCLDevice_;
       _Log    :String;
       ///// アクセス
       function GetDevice :TCLDevice_;
     public
       constructor Create( const Deploys_:TCLDeploys_; const Device_:TCLDevice_ ); overload; virtual;
       ///// プロパティ
       property Kernels :TCLKernels_ read GetOwnere             ;
       property Deploys :TCLDeploys_ read GetParent             ;
       property Device  :TCLDevice_  read GetDevice             ;
       property Log     :String      read   _Log    write   _Log;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDeploys<TCLProgra_,TCLContex_,TCLPlatfo_>

     TCLDeploys<TCLProgra_,TCLContex_,TCLPlatfo_:class> = class( TListParent<TCLKernels<TCLProgra_,TCLContex_,TCLPlatfo_>,
                                                                             TCLDeploy <TCLProgra_,TCLContex_,TCLPlatfo_>> )
     private
       type TCLDevice_  = TCLDevice <TCLPlatfo_>;
            TCLKernels_ = TCLKernels<TCLProgra_,TCLContex_,TCLPlatfo_>;
            TCLKernel_  = TCLKernel <TCLProgra_,TCLContex_,TCLPlatfo_>;
            TCLDeploy_  = TCLDeploy <TCLProgra_,TCLContex_,TCLPlatfo_>;
     protected
       ///// イベント
       procedure OnInit; override;
     public
       ///// プロパティ
       property Kernels :TCLKernels_ read GetOwnere;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLArgumes<TCLKernel_,TCLContex_,TCLPlatfo_>

     TCLArgumes<TCLKernel_,TCLContex_,TCLPlatfo_:class> = class( TList<TCLMemory<TCLContex_>> );

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLKernel<TCLProgra_,TCLContex_,TCLPlatfo_>

     TCLKernel<TCLProgra_,TCLContex_,TCLPlatfo_:class> = class( TListChildr<TCLProgra_,TCLKernels<TCLProgra_,TCLContex_,TCLPlatfo_>> )
     private
       type TCLComman_  = TCLComman <TCLContex_,TCLPlatfo_>;
            TCLKernels_ = TCLKernels<TCLProgra_,TCLContex_,TCLPlatfo_>;
            TCLKernel_  = TCLKernel <TCLProgra_,TCLContex_,TCLPlatfo_>;
            TCLArgumes_ = TCLArgumes<TCLKernel_,TCLContex_,TCLPlatfo_>;
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
       ///// メソッド
       procedure Run;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLKernels<TCLProgra_,TCLContex_,TCLPlatfo_>

     TCLKernels<TCLProgra_,TCLContex_,TCLPlatfo_:class> = class( TListParent<TCLProgra_,TCLKernel<TCLProgra_,TCLContex_,TCLPlatfo_>> )
     private
       type TCLDeploys_ = TCLDeploys<TCLProgra_,TCLContex_,TCLPlatfo_>;
     protected
       _Deploys :TCLDeploys_;
     public
       constructor Create; override;
       destructor Destroy; override;
       ///// プロパティ
       property Progra  :TCLProgra_  read GetOwnere ;
       property Deploys :TCLDeploys_ read   _Deploys;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses LUX.GPU.OpenCL;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDeploy<TCLProgra_,TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

function TCLDeploy<TCLProgra_,TCLContex_,TCLPlatfo_>.GetDevice :TCLDevice_;
begin
     Result := _Device;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLDeploy<TCLProgra_,TCLContex_,TCLPlatfo_>.Create( const Deploys_:TCLDeploys_; const Device_:TCLDevice_ );
begin
     inherited Create( Deploys_ );

     _Device := Device_;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLDeploys<TCLProgra_,TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// イベント

procedure TCLDeploys<TCLProgra_,TCLContex_,TCLPlatfo_>.OnInit;
var
   DLs :TDictionary<TCLDevice_,TCLDeploy_>;
   K :TCLKernel_;
   D :TCLDevice_;
begin
     inherited;

     DLs := TDictionary<TCLDevice_,TCLDeploy_>.Create;

     for K in Kernels do
     begin
          D := K.Comman.Device;

          if not DLs.ContainsKey( D ) then DLs.Add( D, TCLDeploy_.Create( Self, D ) );
     end;

     DLs.Free;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLArgumes<TCLKernel_,TCLContex_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLKernel<TCLProgra_,TCLContex_,TCLPlatfo_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

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

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLKernel<TCLProgra_,TCLContex_,TCLPlatfo_>.CreateHandle;
var
   E :T_cl_int;
   I :Integer;
   H :T_cl_mem;
begin
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

constructor TCLKernels<TCLProgra_,TCLContex_,TCLPlatfo_>.Create;
begin
     inherited;

     _Deploys := TCLDeploys_.Create( Self );
end;

destructor TCLKernels<TCLProgra_,TCLContex_,TCLPlatfo_>.Destroy;
begin
     _Deploys.Free;

     inherited;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

end. //######################################################################### ■
