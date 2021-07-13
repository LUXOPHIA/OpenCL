#ifndef EXECUT
#define EXECUT
//############################################################################## ■

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

float ComplexToCount( const TDoubleC C, const int MaxN )
{
  TDoubleC Z = { 0, 0 };

  for ( int N = 1; N < MaxN; N++ )
  {
    Z = Add( Pow2( Z ), C );

    if ( Abs( Z ) > 10 )
    {
      N++; Z = Add( Pow2( Z ), C );
      N++; Z = Add( Pow2( Z ), C );
      N++; Z = Add( Pow2( Z ), C );
      N++; Z = Add( Pow2( Z ), C );
      N++; Z = Add( Pow2( Z ), C );

      return (float)N + 1 - log( log2( Abs( Z ) ) );
    }
  }

  return MaxN;
}

//############################################################################## ■

kernel void Main( global     TDoubleC* Buffer,
                  read_only  image1d_t Textur,
                  const      sampler_t Samplr,
                  write_only image2d_t Imager )
{
  const int2         P    = { get_global_id  ( 0 ), get_global_id  ( 1 ) };
  const int2         S    = { get_global_size( 0 ), get_global_size( 1 ) };
  const TDoubleAreaC A    = { Buffer[0], Buffer[1] };
  const int          MaxN = 1000;

  TDoubleC C = ScreenToComplex( P, S, A );

  float N = ComplexToCount( C, MaxN );

  float4 T = read_imagef( Textur, Samplr, sqrt( N / MaxN ) );

  write_imagef( Imager, P, T );
}

//############################################################################## ■
#endif
