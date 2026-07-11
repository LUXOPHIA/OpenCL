#ifndef EXECUT
#define EXECUT
//############################################################################## ■

#include<Librar.cl>

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 T Y P E 】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

TSingleC ScreenToComplex( const int2 P, const int2 S, const TSingleC Cent, const TSingleC Size )
{
  TSingleC Result;

  Result.R = Cent.R + Size.R * ( 2 * ( P.x + 0.5f ) / S.x - 1 );
  Result.I = Cent.I - Size.I * ( 2 * ( P.y + 0.5f ) / S.y - 1 );

  return Result;
}

float ComplexToCount( const TSingleC C, const int MaxN )
{
  TSingleC Z = { 0, 0 };

  for ( int N = 1; N < MaxN; N++ )
  {
    Z = Add( Pow2( Z ), C );

    if ( Abs( Z ) > 2 ) return N + 1 - log( log2( Abs( Z ) ) );
  }

  return MaxN;
}

//############################################################################## ■

kernel void Main( global     TSingleC* Buffer,
                  read_only  image1d_t Textur,
                  const      sampler_t Samplr,
                  write_only image2d_t Imager )
{
  const int2     P    = { get_global_id  ( 0 ), get_global_id  ( 1 ) };
  const int2     S    = { get_global_size( 0 ), get_global_size( 1 ) };
  const TSingleC Cent = Buffer[0];
  const TSingleC Size = Buffer[1];
  const int      MaxN = 1000;

  TSingleC C = ScreenToComplex( P, S, Cent, Size );

  float N = ComplexToCount( C, MaxN );

  float4 T = read_imagef( Textur, Samplr, sqrt( N / MaxN ) );

  write_imagef( Imager, P, T );
}

//############################################################################## ■
#endif
