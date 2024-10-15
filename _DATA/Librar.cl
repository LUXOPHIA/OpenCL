#ifndef LIBRAR
#define LIBRAR
//############################################################################## ■

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 T Y P E 】

typedef struct
{
  float R;
  float I;
}
TSingleC;

typedef struct
{
  TSingleC Min;
  TSingleC Max;
}
TSingleAreaC;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TSingleC

/////////////////////////////////////////////////////////////////////// OPERATOR

TSingleC Add( const TSingleC A, const TSingleC B )
{
  TSingleC Result;

  Result.R = A.R + B.R;
  Result.I = A.I + B.I;

  return Result;
}

TSingleC Sub( const TSingleC A, const TSingleC B )
{
  TSingleC Result;

  Result.R = A.R - B.R;
  Result.I = A.I - B.I;

  return Result;
}

TSingleC Mul( const TSingleC A, const TSingleC B )
{
  TSingleC Result;

  Result.R = A.R * B.R - A.I * B.I;
  Result.I = A.R * B.I + A.I * B.R;

  return Result;
}

TSingleC Pow2( const TSingleC C )
{
  return Mul( C, C );
}

float Abs( const TSingleC C )
{
  return sqrt( C.R * C.R + C.I * C.I );
}

//############################################################################## ■
#endif
