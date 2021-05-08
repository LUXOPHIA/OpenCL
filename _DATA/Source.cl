//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

typedef struct
{
  double R;
  double I;
}
TDoubleC;

typedef struct
{
  TDoubleC Min;
  TDoubleC Max;
}
TDoubleAreaC;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

///////////////////////////////////////////////////////////////////////// 演算子

TDoubleC Add( TDoubleC A, TDoubleC B )
{
  TDoubleC Result;
  Result.R = A.R + B.R;
  Result.I = A.I + B.I;
  return Result;
}

TDoubleC Sub( TDoubleC A, TDoubleC B )
{
  TDoubleC Result;
  Result.R = A.R - B.R;
  Result.I = A.I - B.I;
  return Result;
}

TDoubleC Mul( TDoubleC A, TDoubleC B )
{
  TDoubleC Result;
  Result.R = A.R * B.R - A.I * B.I;
  Result.I = A.R * B.I + A.I * B.R;
  return Result;
}

TDoubleC Pow2( TDoubleC C )
{
  return Mul( C, C );
}

double Abs( TDoubleC C )
{
  return sqrt( C.R * C.R + C.I * C.I );
}

////////////////////////////////////////////////////////////////////////////////

TDoubleC ScreenToComplex( int2 P, int2 S, TDoubleAreaC A )
{
  TDoubleC Result;
  Result.R = ( A.Max.R - A.Min.R ) * ( P.x + 0.5 ) / S.x + A.Min.R;
  Result.I = ( A.Min.I - A.Max.I ) * ( P.y + 0.5 ) / S.y + A.Max.I;
  return Result;
}

float ComplexToColor( TDoubleC C )
{
  const int MaxN = 1000;

  TDoubleC Z = { 0, 0 };
  for ( int N = 1; N < MaxN; N++ )
  {
    Z = Add( Pow2( Z ), C );
    if ( Abs( Z ) > 2 ) return (float)N / MaxN;
  }
  return 1;
}

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

kernel void Main( global     double*   Buffer,
                  write_only image2d_t Imager )
{
  const int2 P = { get_global_id  ( 0 ), get_global_id  ( 1 ) };
  const int2 S = { get_global_size( 0 ), get_global_size( 1 ) };

  const TDoubleAreaC A = { { Buffer[0], Buffer[1] },
                           { Buffer[2], Buffer[3] } };

  TDoubleC C = ScreenToComplex( P, S, A );

  float L = ComplexToColor( C );

  float4 R = (float4)( L, L, L, 1 );

  write_imagef( Imager, P, R );
}

//##############################################################################
