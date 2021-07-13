unit LUX.GPU.OpenCL.Argume.Seeder.D1;

interface //#################################################################### ■

uses cl_version, cl_platform, cl,
     LUX, LUX.Color,
     LUX.Code.C,
     LUX.GPU.OpenCL.core,
     LUX.GPU.OpenCL.Queuer,
     LUX.GPU.OpenCL.Argume.Memory.Imager.D1,
     LUX.GPU.OpenCL.Progra,
     LUX.GPU.OpenCL.Kernel;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TCLSeeder1D<TCLSystem_,TCLPlatfo_,TCLContex_:class> = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLSeeder1D<TCLSystem_,TCLPlatfo_,TCLContex_>

     TCLSeeder1D<TCLSystem_,TCLPlatfo_,TCLContex_:class> = class( TCLImager1D<TCLSystem_,TCLPlatfo_,TCLContex_,TUInt32xRGBA> )
     private
       type TCLQueuer_ = TCLQueuer<TCLSystem_,TCLPlatfo_,TCLContex_>;
            TCLExecut_ = TCLExecut<TCLSystem_,TCLPlatfo_,TCLContex_>;
            TCLKernel_ = TCLKernel<TCLSystem_,TCLPlatfo_,TCLContex_,TCLExecut_>;
     protected
       _Execut :TCLExecut_;
       _MakerX :TCLKernel_;
       ///// アクセス
       function GetPixCha :T_cl_channel_order; override;
       function GetPixTyp :T_cl_channel_type; override;
       ///// メソッド
       function CreateHandle :T_cl_int; override;
     public
       constructor Create( const Contex_:TCLContex_; const Queuer_:TCLQueuer_ ); override;
       destructor Destroy; override;
       ///// プロパティ
       property Execut :TCLExecut_ read _Execut;
       property MakerX :TCLKernel_ read _MakerX;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses System.SysUtils;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLSeeder1D<TCLSystem_,TCLPlatfo_,TCLContex_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLSeeder1D<TCLSystem_,TCLPlatfo_,TCLContex_>.GetPixCha :T_cl_channel_order;
begin
     Result := CL_RGBA;
end;

function TCLSeeder1D<TCLSystem_,TCLPlatfo_,TCLContex_>.GetPixTyp :T_cl_channel_type;
begin
     Result := CL_UNSIGNED_INT32;
end;

/////////////////////////////////////////////////////////////////////// メソッド

function TCLSeeder1D<TCLSystem_,TCLPlatfo_,TCLContex_>.CreateHandle :T_cl_int;
begin
     inherited;

     Fill( TUInt32xRGBA.Create( Random( Int32.MaxValue ) + 1,
                                Random( Int32.MaxValue ) + 1,
                                Random( Int32.MaxValue ) + 1,
                                Random( Int32.MaxValue ) + 1 ) );

     _MakerX.GloSizX := 1;
     _MakerX.Run;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLSeeder1D<TCLSystem_,TCLPlatfo_,TCLContex_>.Create( const Contex_:TCLContex_; const Queuer_:TCLQueuer_ );
begin
     inherited;

     _Execut := TCLExecut_.Create( Contex );
     _MakerX := TCLKernel_.Create( Execut, 'MakerX', Queuer );

     with _Execut.Source do
     begin
          Add( 'uint rotl( const uint x, const int k )' );
          Add( '{' );
          Add( '  return ( x << k ) | ( x >> ( 32 - k ) );' );
          Add( '}' );

          Add( 'void Next0( uint4* const Seed )' );
          Add( '{' );
          Add( '  const uint t = Seed->y << 9;' );
          Add( '  Seed->z ^= Seed->x;' );
          Add( '  Seed->w ^= Seed->y;' );
          Add( '  Seed->y ^= Seed->z;' );
          Add( '  Seed->x ^= Seed->w;' );
          Add( '  Seed->z ^= t;' );
          Add( '  Seed->w = rotl( Seed->w, 11 );' );
          Add( '}' );

          Add( 'void Next64( uint4* const Seed )' );
          Add( '{' );
          Add( '  const uint JUMP[4] = { 0x8764000b, 0xf542d2d3, 0x6fa035c3, 0x77f2db5b };' );
          Add( '  uint4 S = (uint4)0;' );
          Add( '  for( int i = 0; i < 4; i++ )' );
          Add( '  {' );
          Add( '    for( int b = 0; b < 32; b++ )' );
          Add( '    {' );
          Add( '      if ( JUMP[i] & (uint)1 << b ) S ^= *Seed;' );
          Add( '      Next0( Seed );' );
          Add( '    }' );
          Add( '  }' );
          Add( '  *Seed = S;' );
          Add( '}' );

          Add( 'kernel void MakerX( read_write image1d_t Seeder )' );
          Add( '{' );
          Add( '  const int SeeSiz = get_image_width( Seeder );' );
          Add( '  uint4 Seed = read_imageui( Seeder, 0 );' );
          Add( '  for( int X = 0; X < SeeSiz; X++ )' );
          Add( '  {' );
          Add( '    Next64( &Seed );' );
          Add( '    write_imageui( Seeder, X, Seed );' );
          Add( '  }' );
          Add( '}' );
     end;

     //with _Execut.BuildTo( Queuer.Device ) do Assert( Assigned( Handle ), CompileLog );

     _MakerX.Parames['Seeder'] := Self;
end;

destructor TCLSeeder1D<TCLSystem_,TCLPlatfo_,TCLContex_>.Destroy;
begin

     inherited;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

end. //######################################################################### ■
