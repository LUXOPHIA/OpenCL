#include<Librar.cl>

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

TDoubleC ScreenToComplex( const int2 P, const int2 S, const TDoubleAreaC A )
{
  TDoubleC Result;

  Result.R = ( A.Max.R - A.Min.R ) * ( P.x + 0.5 ) / S.x + A.Min.R;
  Result.I = ( A.Min.I - A.Max.I ) * ( P.y + 0.5 ) / S.y + A.Max.I;

  return Result;
}

float ComplexToColor( const TDoubleC C, const int MaxN )
{
  TDoubleC Z = { 0, 0 };

  for ( int N = 1; N < MaxN; N++ )
  {
    Z = Add( Pow2( Z ), C );
    if ( Abs( Z ) > 2 ) return (float)N / MaxN;
  }

  return 1;
}

//------------------------------------------------------------------------------

float4 GammaCorrect( const float4 Color_, const float Gamma_ )
{
  float4 Result;

  Result.rgb = pow( Color_.rgb, 1/Gamma_ );
  Result.a   =      Color_.a              ;

  return Result;
}

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

kernel void Main( global     TDoubleC* Buffer,
                  write_only image2d_t Imager )
{
  const int2 P = { get_global_id  ( 0 ), get_global_id  ( 1 ) };
  const int2 S = { get_global_size( 0 ), get_global_size( 1 ) };

  const TDoubleAreaC A = { Buffer[0], Buffer[1] };

  TDoubleC C = ScreenToComplex( P, S, A );

  float L = ComplexToColor( C, 1000 );

  float4 R = (float4)( L, L, L, 1 );

  float4 G = GammaCorrect( R, 2.2 );

  uint4 U = convert_uint4_sat_rte( 255 * G );

  write_imageui( Imager, P, U );
}

//##############################################################################
