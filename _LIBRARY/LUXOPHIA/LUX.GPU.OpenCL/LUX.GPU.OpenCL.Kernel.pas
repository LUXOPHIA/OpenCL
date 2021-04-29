unit LUX.GPU.OpenCL.Kernel;

interface //#################################################################### ■

uses System.Generics.Collections,
     cl_version, cl_platform, cl,
     LUX.Data.List,
     LUX.Code.C,
     LUX.GPU.OpenCL.root,
     LUX.GPU.OpenCL.Memory;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TCLArgumes<TCLKernel_,TCLContex_:class> = class;

     TCLKernels <TCLProgra_,TCLContex_:class> = class;
       TCLKernel<TCLProgra_,TCLContex_:class> = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLArgumes<TCLKernel_,TCLContex_>

     TCLArgumes<TCLKernel_,TCLContex_:class> = class( TList<TCLMemory<TCLContex_>> );

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLKernel<TCLProgra_,TCLContex_>

     TCLKernel<TCLProgra_,TCLContex_:class> = class( TListChildr<TCLProgra_,TCLKernels<TCLProgra_,TCLContex_>> )
     private
       type TCLKernels_ = TCLKernels<TCLProgra_,TCLContex_>;
            TCLKernel_  = TCLKernel <TCLProgra_,TCLContex_>;
            TCLArgumes_ = TCLArgumes<TCLKernel_,TCLContex_>;
     protected
       _Handle           :T_cl_kernel;
       _Name             :String;
       _Argumes          :TCLArgumes_;
       _GlobalWorkOffset :TArray<T_size_t>;
       _GlobalWorkSize   :TArray<T_size_t>;
       _LocalWorkSize    :TArray<T_size_t>;
       ///// アクセス
       function GetHandle :T_cl_kernel;
       procedure SetHandle( const Handle_:T_cl_kernel );
       function GetDimension :T_cl_uint;
       procedure SetGlobalWorkOffset( const GlobalWorkOffset_:TArray<T_size_t> );
       procedure SetGlobalWorkSize( const GlobalWorkSize_:TArray<T_size_t> );
       procedure SetLocalWorkSize( const LocalWorkSize_:TArray<T_size_t> );
       ///// メソッド
       procedure CreateHandle;
       procedure DestroHandle;
     public
       constructor Create; override;
       constructor Create( const Progra_:TCLProgra_ ); overload; virtual;
       constructor Create( const Progra_:TCLProgra_; const Name_:String ); overload; virtual;
       destructor Destroy; override;
       ///// プロパティ
       property Progra           :TCLProgra_       read GetOwnere                                    ;
       property Kernels          :TCLKernels_      read GetParent                                    ;
       property Handle           :T_cl_kernel      read GetHandle           write SetHandle          ;
       property Name             :String           read   _Name             write   _Name            ;
       property Argumes          :TCLArgumes_      read   _Argumes                                   ;
       property Dimension        :T_cl_uint        read GetDimension                                 ;
       property GlobalWorkOffset :TArray<T_size_t> read   _GlobalWorkOffset write SetGlobalWorkOffset;
       property GlobalWorkSize   :TArray<T_size_t> read   _GlobalWorkSize   write SetGlobalWorkSize  ;
       property LocalWorkSize    :TArray<T_size_t> read   _LocalWorkSize    write SetLocalWorkSize   ;
       ///// メソッド
       procedure Run( const Comman_:TObject );
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLKernels<TCLProgra_,TCLContex_>

     TCLKernels<TCLProgra_,TCLContex_:class> = class( TListParent<TCLProgra_,TCLKernel<TCLProgra_,TCLContex_>> )
     private
     protected
     public
       ///// プロパティ
       property Progra :TCLProgra_ read GetOwnere;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses LUX.GPU.OpenCL;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLArgumes<TCLKernel_,TCLContex_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLKernel<TCLProgra_,TCLContex_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLKernel<TCLProgra_,TCLContex_>.GetHandle :T_cl_kernel;
begin
     if not Assigned( _Handle ) then CreateHandle;

     Result := _Handle;
end;

procedure TCLKernel<TCLProgra_,TCLContex_>.SetHandle( const Handle_:T_cl_kernel );
begin
     if Assigned( _Handle ) then DestroHandle;

     _Handle := Handle_;
end;

//------------------------------------------------------------------------------

function TCLKernel<TCLProgra_,TCLContex_>.GetDimension :T_cl_uint;
begin
     Result := Length( _GlobalWorkSize );
end;

procedure TCLKernel<TCLProgra_,TCLContex_>.SetGlobalWorkOffset( const GlobalWorkOffset_:TArray<T_size_t> );
begin
     _GlobalWorkOffset := GlobalWorkOffset_;
end;

procedure TCLKernel<TCLProgra_,TCLContex_>.SetGlobalWorkSize( const GlobalWorkSize_:TArray<T_size_t> );
begin
     _GlobalWorkSize := GlobalWorkSize_;
end;

procedure TCLKernel<TCLProgra_,TCLContex_>.SetLocalWorkSize( const LocalWorkSize_:TArray<T_size_t> );
begin
     _LocalWorkSize := LocalWorkSize_;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLKernel<TCLProgra_,TCLContex_>.CreateHandle;
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

procedure TCLKernel<TCLProgra_,TCLContex_>.DestroHandle;
begin
     clReleaseKernel( _Handle );

     _Handle := nil;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLKernel<TCLProgra_,TCLContex_>.Create;
begin
     inherited;

     _Handle := nil;

     _Argumes := TCLArgumes_.Create;

     _Name   := '';

     _GlobalWorkOffset := [];
     _GlobalWorkSize   := [ 1 ];
     _LocalWorkSize    := [];
end;

constructor TCLKernel<TCLProgra_,TCLContex_>.Create( const Progra_:TCLProgra_ );
begin
     inherited Create( TCLProgra( Progra_ ).Kernels );
end;

constructor TCLKernel<TCLProgra_,TCLContex_>.Create( const Progra_:TCLProgra_; const Name_:String );
begin
     Create( Progra_ );

     _Name := Name_;
end;

destructor TCLKernel<TCLProgra_,TCLContex_>.Destroy;
begin
     _Argumes.Free;

      Handle := nil;

     inherited;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLKernel<TCLProgra_,TCLContex_>.Run( const Comman_:TObject );
begin
     AssertCL( clEnqueueNDRangeKernel( TCLComman( Comman_ ).Handle,
                                       Handle,
                                       Dimension,
                                       @_GlobalWorkOffset[ 0 ],
                                       @_GlobalWorkSize[ 0 ],
                                       @_LocalWorkSize[ 0 ],
                                       0, nil, nil ) );

     clFinish( TCLComman( Comman_ ).Handle );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLKernels<TCLProgra_,TCLContex_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

end. //######################################################################### ■
