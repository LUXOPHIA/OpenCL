﻿unit LUX.D2x2;

interface //#################################################################### ■

uses LUX, LUX.D2;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 T Y P E 】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R E C O R D 】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TSingleM2

     TSingleM2 = record
     private
       ///// A C C E S S O R
       function GetD2( const Y_,X_:Integer ) :Single;
       procedure SetD2( const Y_,X_:Integer; const D2_:Single );
       function GetAxisX :TSingle2D;
       procedure SetAxisX( const AxisX_:TSingle2D );
       function GetAxisY :TSingle2D;
       procedure SetAxisY( const AxisY_:TSingle2D );
     public
       constructor Create( const _11_,_12_,
                                 _21_,_22_:Single );
       ///// O P E R A T O R
       class operator Negative( const V_:TSingleM2 ) :TSingleM2;
       class operator Positive( const V_:TSingleM2 ) :TSingleM2;
       class operator Add( const A_,B_:TSingleM2 ) :TSingleM2;
       class operator Subtract( const A_,B_:TSingleM2 ) :TSingleM2;
       class operator Multiply( const A_,B_:TSingleM2 ) :TSingleM2;
       class operator Multiply( const A_:TSingleM2; const B_:Single ) :TSingleM2;
       class operator Multiply( const A_:Single; const B_:TSingleM2 ) :TSingleM2;
       class operator Multiply( const A_:TSingle2D; const B_:TSingleM2 ) :TSingle2D;
       class operator Multiply( const A_:TSingleM2; const B_:TSingle2D ) :TSingle2D;
       class operator Divide( const A_:TSingleM2; const B_:Single ) :TSingleM2;
       ///// P R O P E R T Y
       property D2[ const Y_,X_:Integer ] :Single    read GetD2    write SetD2   ; default;
       property AxisX                     :TSingle2D read GetAxisX write SetAxisX;
       property AxisY                     :TSingle2D read GetAxisY write SetAxisY;
       ///// M E T H O D
       function Det :Single;
       function Adjugate :TSingleM2;
       function Inverse :TSingleM2;
       class function Rotate( const Angle_:Single ) :TSingleM2; static;
       ///// F I E L D
     case Byte of
      0:( _1D :array [ 0..2*2-1       ] of Single; );
      1:( _2D :array [ 0..2-1, 0..2-1 ] of Single; );
      2:( _11, _21,
          _12, _22 :Single;                        );
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TDoubleM2

     TDoubleM2 = record
     private
       ///// A C C E S S O R
       function GetD2( const Y_,X_:Integer ) :Double;
       procedure SetD2( const Y_,X_:Integer; const D2_:Double );
       function GetAxisX :TDouble2D;
       procedure SetAxisX( const AxisX_:TDouble2D );
       function GetAxisY :TDouble2D;
       procedure SetAxisY( const AxisY_:TDouble2D );
     public
       constructor Create( const _11_,_12_,
                                 _21_,_22_:Double );
       ///// O P E R A T O R
       class operator Negative( const V_:TDoubleM2 ) :TDoubleM2;
       class operator Positive( const V_:TDoubleM2 ) :TDoubleM2;
       class operator Add( const A_,B_:TDoubleM2 ) :TDoubleM2;
       class operator Subtract( const A_,B_:TDoubleM2 ) :TDoubleM2;
       class operator Multiply( const A_,B_:TDoubleM2 ) :TDoubleM2;
       class operator Multiply( const A_:TDoubleM2; const B_:Double ) :TDoubleM2;
       class operator Multiply( const A_:Double; const B_:TDoubleM2 ) :TDoubleM2;
       class operator Multiply( const A_:TDouble2D; const B_:TDoubleM2 ) :TDouble2D;
       class operator Multiply( const A_:TDoubleM2; const B_:TDouble2D ) :TDouble2D;
       class operator Divide( const A_:TDoubleM2; const B_:Double ) :TDoubleM2;
       ///// P R O P E R T Y
       property D2[ const Y_,X_:Integer ] :Double    read GetD2    write SetD2   ; default;
       property AxisX                     :TDouble2D read GetAxisX write SetAxisX;
       property AxisY                     :TDouble2D read GetAxisY write SetAxisY;
       ///// M E T H O D
       function Det :Double;
       function Adjugate :TDoubleM2;
       function Inverse :TDoubleM2;
       class function Rotate( const Angle_:Double ) :TDoubleM2; static;
       ///// F I E L D
     case Byte of
       0: ( _1D :array [ 0..2*2-1       ] of Double; );
       1: ( _2D :array [ 0..2-1, 0..2-1 ] of Double; );
       2: ( _11, _21,
            _12, _22 :Double;                        );
     end;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C L A S S 】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

implementation //############################################################### ■

uses System.Math;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R E C O R D 】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TSingleM2

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//////////////////////////////////////////////////////////////// A C C E S S O R

function TSingleM2.GetD2( const Y_,X_:Integer ) :Single;
begin
     Result := _2D[ X_-1, Y_-1 ];
end;

procedure TSingleM2.SetD2( const Y_,X_:Integer; const D2_:Single );
begin
     _2D[ X_-1, Y_-1 ] := D2_;
end;

//------------------------------------------------------------------------------

function TSingleM2.GetAxisX :TSingle2D;
begin
     with Result do
     begin
          X := _11; {X := _12;}
          Y := _21; {Y := _22;}
     end;
end;

procedure TSingleM2.SetAxisX( const AxisX_:TSingle2D );
begin
     with AxisX_ do
     begin
          _11 := X; {_12 := X;}
          _21 := Y; {_22 := Y;}
     end;
end;

function TSingleM2.GetAxisY :TSingle2D;
begin
     with Result do
     begin
         {X := _11;} X := _12;
         {Y := _21;} Y := _22;
     end;
end;

procedure TSingleM2.SetAxisY( const AxisY_:TSingle2D );
begin
     with AxisY_ do
     begin
         {_11 := X;} _12 := X;
         {_21 := Y;} _22 := Y;
     end;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TSingleM2.Create( const _11_,_12_, _21_,_22_:Single );
begin
     _11 := _11_;  _12 := _12_;
     _21 := _21_;  _22 := _22_;
end;

//////////////////////////////////////////////////////////////// O P E R A T O R

class operator TSingleM2.Positive( const V_:TSingleM2 ) :TSingleM2;
begin
     with Result do
     begin
          _11 := +V_._11;  _12 := +V_._12;
          _21 := +V_._21;  _22 := +V_._22;
     end;
end;

class operator TSingleM2.Negative( const V_:TSingleM2 ) :TSingleM2;
begin
     with Result do
     begin
          _11 := -V_._11;  _12 := -V_._12;
          _21 := -V_._21;  _22 := -V_._22;
     end;
end;

class operator TSingleM2.Add( const A_,B_:TSingleM2 ) :TSingleM2;
begin
     with Result do
     begin
          _11 := A_._11 + B_._11;  _12 := A_._12 + B_._12;
          _21 := A_._21 + B_._21;  _22 := A_._22 + B_._22;
     end;
end;

class operator TSingleM2.Subtract( const A_,B_:TSingleM2 ) :TSingleM2;
begin
     with Result do
     begin
          _11 := A_._11 - B_._11;  _12 := A_._12 - B_._12;
          _21 := A_._21 - B_._21;  _22 := A_._22 - B_._22;
     end;
end;

class operator TSingleM2.Multiply( const A_,B_:TSingleM2 ) :TSingleM2;
begin
     // _11 _12    _11 _12
     // _21 _22 × _21 _22

     with Result do
     begin
          _11 := A_._11 * B_._11 + A_._12 * B_._21;
          _12 := A_._11 * B_._12 + A_._12 * B_._22;

          _21 := A_._21 * B_._11 + A_._22 * B_._21;
          _22 := A_._21 * B_._12 + A_._22 * B_._22;
     end;
end;

class operator TSingleM2.Multiply( const A_:TSingleM2; const B_:Single ) :TSingleM2;
begin
     with Result do
     begin
          _11 := A_._11 * B_;  _12 := A_._12 * B_;
          _21 := A_._21 * B_;  _22 := A_._22 * B_;
     end;
end;

class operator TSingleM2.Multiply( const A_:Single; const B_:TSingleM2 ) :TSingleM2;
begin
     with Result do
     begin
          _11 := A_ * B_._11;  _12 := A_ * B_._12;
          _21 := A_ * B_._21;  _22 := A_ * B_._22;
     end;
end;

class operator TSingleM2.Multiply( const A_:TSingle2D; const B_:TSingleM2 ) :TSingle2D;
begin
     {
               _11 _12
        X Y × _21 _22
     }

     with Result do
     begin
          X := A_.X * B_._11 + A_.Y * B_._21;
          Y := A_.X * B_._12 + A_.Y * B_._22;
     end;
end;

class operator TSingleM2.Multiply( const A_:TSingleM2; const B_:TSingle2D ) :TSingle2D;
begin
     {
       _11 _12    X
       _21 _22 × Y
     }

     with Result do
     begin
          X := A_._11 * B_.X + A_._12 * B_.Y;
          Y := A_._21 * B_.X + A_._22 * B_.Y;
     end;
end;

class operator TSingleM2.Divide( const A_:TSingleM2; const B_:Single ) :TSingleM2;
begin
     with Result do
     begin
          _11 := A_._11 / B_;  _12 := A_._12 / B_;
          _21 := A_._21 / B_;  _22 := A_._22 / B_;
     end;
end;

//////////////////////////////////////////////////////////////////// M E T H O D

function TSingleM2.Det :Single;
begin
     Result := _11 * _22 - _21 * _12;
end;

function TSingleM2.Adjugate :TSingleM2;
begin
     Result._11 := +_22;  Result._12 := -_12;
     Result._21 := -_21;  Result._22 := +_11;
end;

function TSingleM2.Inverse :TSingleM2;
begin
     Result := Adjugate / Det;
end;

//------------------------------------------------------------------------------

class function TSingleM2.Rotate( const Angle_:Single ) :TSingleM2;
var
   S, C :Single;
begin
     SinCos( Angle_, S, C );

     with Result do
     begin
          _11 :=  C;  _12 := -S;
          _21 := +S;  _22 :=  C;
     end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TDoubleM2

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//////////////////////////////////////////////////////////////// A C C E S S O R

function TDoubleM2.GetD2( const Y_,X_:Integer ) :Double;
begin
     Result := _2D[ X_-1, Y_-1 ];
end;

procedure TDoubleM2.SetD2( const Y_,X_:Integer; const D2_:Double );
begin
     _2D[ X_-1, Y_-1 ] := D2_;
end;

//------------------------------------------------------------------------------

function TDoubleM2.GetAxisX :TDouble2D;
begin
     with Result do
     begin
          X := _11; {X := _12;}
          Y := _21; {Y := _22;}
     end;
end;

procedure TDoubleM2.SetAxisX( const AxisX_:TDouble2D );
begin
     with AxisX_ do
     begin
          _11 := X; {_12 := X;}
          _21 := Y; {_22 := Y;}
     end;
end;

function TDoubleM2.GetAxisY :TDouble2D;
begin
     with Result do
     begin
         {X := _11;} X := _12;
         {Y := _21;} Y := _22;
     end;
end;

procedure TDoubleM2.SetAxisY( const AxisY_:TDouble2D );
begin
     with AxisY_ do
     begin
         {_11 := X;} _12 := X;
         {_21 := Y;} _22 := Y;
     end;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TDoubleM2.Create( const _11_,_12_, _21_,_22_:Double );
begin
     _11 := _11_;  _12 := _12_;
     _21 := _21_;  _22 := _22_;
end;

//////////////////////////////////////////////////////////////// O P E R A T O R

class operator TDoubleM2.Positive( const V_:TDoubleM2 ) :TDoubleM2;
begin
     with Result do
     begin
          _11 := +V_._11;  _12 := +V_._12;
          _21 := +V_._21;  _22 := +V_._22;
     end;
end;

class operator TDoubleM2.Negative( const V_:TDoubleM2 ) :TDoubleM2;
begin
     with Result do
     begin
          _11 := -V_._11;  _12 := -V_._12;
          _21 := -V_._21;  _22 := -V_._22;
     end;
end;

class operator TDoubleM2.Add( const A_,B_:TDoubleM2 ) :TDoubleM2;
begin
     with Result do
     begin
          _11 := A_._11 + B_._11;  _12 := A_._12 + B_._12;
          _21 := A_._21 + B_._21;  _22 := A_._22 + B_._22;
     end;
end;

class operator TDoubleM2.Subtract( const A_,B_:TDoubleM2 ) :TDoubleM2;
begin
     with Result do
     begin
          _11 := A_._11 - B_._11;  _12 := A_._12 - B_._12;
          _21 := A_._21 - B_._21;  _22 := A_._22 - B_._22;
     end;
end;

class operator TDoubleM2.Multiply( const A_,B_:TDoubleM2 ) :TDoubleM2;
begin
     // _11 _12    _11 _12
     // _21 _22 × _21 _22

     with Result do
     begin
          _11 := A_._11 * B_._11 + A_._12 * B_._21;
          _12 := A_._11 * B_._12 + A_._12 * B_._22;

          _21 := A_._21 * B_._11 + A_._22 * B_._21;
          _22 := A_._21 * B_._12 + A_._22 * B_._22;
     end;
end;

class operator TDoubleM2.Multiply( const A_:TDoubleM2; const B_:Double ) :TDoubleM2;
begin
     with Result do
     begin
          _11 := A_._11 * B_;  _12 := A_._12 * B_;
          _21 := A_._21 * B_;  _22 := A_._22 * B_;
     end;
end;

class operator TDoubleM2.Multiply( const A_:Double; const B_:TDoubleM2 ) :TDoubleM2;
begin
     with Result do
     begin
          _11 := A_ * B_._11;  _12 := A_ * B_._12;
          _21 := A_ * B_._21;  _22 := A_ * B_._22;
     end;
end;

class operator TDoubleM2.Multiply( const A_:TDouble2D; const B_:TDoubleM2 ) :TDouble2D;
begin
     {
               _11 _12
        X Y × _21 _22
     }

     with Result do
     begin
          X := A_.X * B_._11 + A_.Y * B_._21;
          Y := A_.X * B_._12 + A_.Y * B_._22;
     end;
end;

class operator TDoubleM2.Multiply( const A_:TDoubleM2; const B_:TDouble2D ) :TDouble2D;
begin
     {
       _11 _12    X
       _21 _22 × Y
     }

     with Result do
     begin
          X := A_._11 * B_.X + A_._12 * B_.Y;
          Y := A_._21 * B_.X + A_._22 * B_.Y;
     end;
end;

class operator TDoubleM2.Divide( const A_:TDoubleM2; const B_:Double ) :TDoubleM2;
begin
     with Result do
     begin
          _11 := A_._11 / B_;  _12 := A_._12 / B_;
          _21 := A_._21 / B_;  _22 := A_._22 / B_;
     end;
end;

//////////////////////////////////////////////////////////////////// M E T H O D

function TDoubleM2.Det :Double;
begin
     Result := _11 * _22 - _21 * _12;
end;

function TDoubleM2.Adjugate :TDoubleM2;
begin
     Result._11 := +_22;  Result._12 := -_12;
     Result._21 := -_21;  Result._22 := +_11;
end;

function TDoubleM2.Inverse :TDoubleM2;
begin
     Result := Adjugate / Det;
end;

//------------------------------------------------------------------------------

class function TDoubleM2.Rotate( const Angle_:Double ) :TDoubleM2;
var
   S, C :Double;
begin
     SinCos( Angle_, S, C );

     with Result do
     begin
          _11 :=  C;  _12 := -S;
          _21 := +S;  _22 :=  C;
     end;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C L A S S 】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

end. //######################################################################### ■
