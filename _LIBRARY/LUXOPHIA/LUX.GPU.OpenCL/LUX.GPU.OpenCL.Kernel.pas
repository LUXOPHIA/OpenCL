unit LUX.GPU.OpenCL.Kernel;

interface //#################################################################### ■

uses System.Classes, System.Generics.Collections,
     cl_version, cl_platform, cl,
     LUX.Code.C,
     LUX.GPU.OpenCL.root,
     LUX.GPU.OpenCL.Memory;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLKernel<_TContext_,_TProgram_>

     TCLKernel<_TContext_,_TProgram_:class> = class
     private
       type TCLMemory = TCLMemory<_TContext_>;
     protected
       _Parent           :_TProgram_;
       _Handle           :T_cl_kernel;
       _Name             :String;
       _Memorys          :TList<TCLMemory>;
       _GlobalWorkOffset :TArray<T_size_t>;
       _GlobalWorkSize   :TArray<T_size_t>;
       _LocalWorkSize    :TArray<T_size_t>;
       ///// アクセス
       procedure SetParent( const Parent_:_TProgram_ );
       function GetHandle :T_cl_kernel;
       function GetavHandle :Boolean;
       procedure SetavHandle( const avHandle_:Boolean );
       function GetDimention :T_cl_uint;
       procedure SetGlobalWorkOffset( const GlobalWorkOffset_:TArray<T_size_t> );
       procedure SetGlobalWorkSize( const GlobalWorkSize_:TArray<T_size_t> );
       procedure SetLocalWorkSize( const LocalWorkSize_:TArray<T_size_t> );
       ///// メソッド
       procedure CreateHandle;
       procedure DestroHandle;
     public
       constructor Create; overload;
       constructor Create( const Parent_:_TProgram_ ); overload;
       constructor Create( const Parent_:_TProgram_; const Name_:String ); overload;
       destructor Destroy; override;
       ///// プロパティ
       property Parent           :_TProgram_       read   _Parent           write SetParent          ;
       property Handle           :T_cl_kernel      read GetHandle                                    ;
       property avHandle         :Boolean          read GetavHandle         write SetavHandle        ;
       property Name             :String           read   _Name             write   _Name            ;
       property Memorys          :TList<TCLMemory> read   _Memorys                                   ;
       property Dimention        :T_cl_uint        read GetDimention                                 ;
       property GlobalWorkOffset :TArray<T_size_t> read   _GlobalWorkOffset write SetGlobalWorkOffset;
       property GlobalWorkSize   :TArray<T_size_t> read   _GlobalWorkSize   write SetGlobalWorkSize  ;
       property LocalWorkSize    :TArray<T_size_t> read   _LocalWorkSize    write SetLocalWorkSize   ;
       ///// メソッド
       procedure Run( const Command_:TObject );
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses LUX.GPU.OpenCL;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLKernel<_TContext_,_TProgram_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

procedure TCLKernel<_TContext_,_TProgram_>.SetParent( const Parent_:_TProgram_ );
begin
     if Assigned( _Parent ) then TCLProgra( _Parent ).Kernels.Remove( TCLKernel( Self ) );

                  _Parent := Parent_;

     if Assigned( _Parent ) then TCLProgra( _Parent ).Kernels.Add   ( TCLKernel( Self ) );
end;

//------------------------------------------------------------------------------

function TCLKernel<_TContext_,_TProgram_>.GetHandle :T_cl_kernel;
begin
     if not avHandle then CreateHandle;

     Result := _Handle;
end;

function TCLKernel<_TContext_,_TProgram_>.GetavHandle :Boolean;
begin
     Result := TCLProgra( _Parent ).avHandle and Assigned( _Handle );
end;

procedure TCLKernel<_TContext_,_TProgram_>.SetavHandle( const avHandle_:Boolean );
begin
     if avHandle  then DestroHandle;

     if avHandle_ then CreateHandle;
end;

//------------------------------------------------------------------------------

function TCLKernel<_TContext_,_TProgram_>.GetDimention :T_cl_uint;
begin
     Result := Length( _GlobalWorkSize );
end;

procedure TCLKernel<_TContext_,_TProgram_>.SetGlobalWorkOffset( const GlobalWorkOffset_:TArray<T_size_t> );
begin
     _GlobalWorkOffset := GlobalWorkOffset_;
end;

procedure TCLKernel<_TContext_,_TProgram_>.SetGlobalWorkSize( const GlobalWorkSize_:TArray<T_size_t> );
begin
     _GlobalWorkSize := GlobalWorkSize_;
end;

procedure TCLKernel<_TContext_,_TProgram_>.SetLocalWorkSize( const LocalWorkSize_:TArray<T_size_t> );
begin
     _LocalWorkSize := LocalWorkSize_;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLKernel<_TContext_,_TProgram_>.CreateHandle;
var
   E :T_cl_int;
   I :Integer;
   H :T_cl_mem;
begin
     _Handle := clCreateKernel( TCLProgra( _Parent ).Handle, P_char( AnsiString( _Name ) ), @E );

     AssertCL( E );

     for I := 0 to _Memorys.Count-1 do
     begin
          H := _Memorys[ I ].Handle;

          AssertCL( clSetKernelArg( _Handle, I, SizeOf( T_cl_mem ), @H ) );
     end;
end;

procedure TCLKernel<_TContext_,_TProgram_>.DestroHandle;
begin
     clReleaseKernel( _Handle );

     _Handle := nil;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLKernel<_TContext_,_TProgram_>.Create;
begin
     inherited;

     _Memorys := TList<TCLMemory>.Create;

     _Parent := nil;
     _Handle := nil;
     _Name   := '';

     _GlobalWorkOffset := [];
     _GlobalWorkSize   := [ 1 ];
     _LocalWorkSize    := [];
end;

constructor TCLKernel<_TContext_,_TProgram_>.Create( const Parent_:_TProgram_ );
begin
     Create;

     Parent := Parent_;
end;

constructor TCLKernel<_TContext_,_TProgram_>.Create( const Parent_:_TProgram_; const Name_:String );
begin
     Create( Parent_ );

     _Name := Name_;
end;

destructor TCLKernel<_TContext_,_TProgram_>.Destroy;
begin
     if avHandle then DestroHandle;

     _Memorys.Free;

     inherited;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLKernel<_TContext_,_TProgram_>.Run( const Command_:TObject );
begin
     AssertCL( clEnqueueNDRangeKernel( TCLComman( Command_ ).Handle,
                                       Handle,
                                       Dimention,
                                       @_GlobalWorkOffset[ 0 ],
                                       @_GlobalWorkSize[ 0 ],
                                       @_LocalWorkSize[ 0 ],
                                       0, nil, nil ) );

     clFinish( TCLComman( Command_ ).Handle );
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

//############################################################################## □

initialization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 初期化

finalization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 最終化

end. //######################################################################### ■
