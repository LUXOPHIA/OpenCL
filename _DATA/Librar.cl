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

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TDoubleC

///////////////////////////////////////////////////////////////////////// 演算子

TDoubleC __attribute__((overloadable)) Add( const TDoubleC A, const TDoubleC B )
{
  TDoubleC Result;

  Result.R = A.R + B.R;
  Result.I = A.I + B.I;

  return Result;
}

TDoubleC __attribute__((overloadable)) Sub( const TDoubleC A, const TDoubleC B )
{
  TDoubleC Result;

  Result.R = A.R - B.R;
  Result.I = A.I - B.I;

  return Result;
}

TDoubleC __attribute__((overloadable)) Mul( const TDoubleC A, const TDoubleC B )
{
  TDoubleC Result;

  Result.R = A.R * B.R - A.I * B.I;
  Result.I = A.R * B.I + A.I * B.R;

  return Result;
}

TDoubleC __attribute__((overloadable)) Pow2( const TDoubleC C )
{
  return Mul( C, C );
}

double __attribute__((overloadable)) Abs( const TDoubleC C )
{
  return sqrt( C.R * C.R + C.I * C.I );
}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TDoubleAreaC

//##############################################################################