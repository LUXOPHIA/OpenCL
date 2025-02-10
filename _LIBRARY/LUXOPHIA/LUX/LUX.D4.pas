﻿unit LUX.D4;

interface //#################################################################### ■

uses System.Math.Vectors,
     LUX, LUX.D1, LUX.D3;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 T Y P E 】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R E C O R D 】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TSingle4D

     TSingle4D = record
     private
       ///// A C C E S S O R
       function GetD1( const X_:Integer ) :Single;
       procedure SetD1( const X_:Integer; const D1_:Single );
       function GetSize2 :Single;
       procedure SetSize2( const Size2_:Single );
       function GetSize :Single;
       procedure SetSize( const Size_:Single );
       function GetUnitor :TSingle4D;
       procedure SetUnitor( const Unitor_:TSingle4D );
     public
       constructor Create( const V_:Single ); overload;
       constructor Create( const X_,Y_,Z_,W_:Single ); overload;
       constructor Create( const P_:TSingle3D; const W_:Single ); overload;
       ///// P R O P E R T Y
       property D1[ const X_:Integer ] :Single    read GetD1     write SetD1    ; default;
       property Size2                  :Single    read GetSize2  write SetSize2 ;
       property Size                   :Single    read GetSize   write SetSize  ;
       property Unitor                 :TSingle4D read GetUnitor write SetUnitor;
       ///// O P E R A T O R
       class operator Negative( const V_:TSingle4D ) :TSingle4D;
       class operator Positive( const V_:TSingle4D ) :TSingle4D;
       class operator Add( const A_,B_:TSingle4D ) :TSingle4D;
       class operator Subtract( const A_,B_:TSingle4D ) :TSingle4D;
       class operator Multiply( const A_:TSingle4D; const B_:Single ) :TSingle4D;
       class operator Multiply( const A_:Single; const B_:TSingle4D ) :TSingle4D;
       class operator Divide( const A_:TSingle4D; const B_:Single ) :TSingle4D;
       ///// C A S T
       class operator Implicit( const V_:TSingle3D ) :TSingle4D;
       class operator Explicit( const V_:TSingle4D ) :TSingle3D;
       class operator Implicit( const V_:TPoint3D ) :TSingle4D;
       class operator Explicit( const V_:TSingle4D ) :TPoint3D;
       class operator Implicit( const V_:TVector3D ) :TSingle4D;
       class operator Explicit( const V_:TSingle4D ) :TVector3D;
       ///// C O N S T A N T
       class function IdentityX :TSingle4D; static;
       class function IdentityY :TSingle4D; static;
       class function IdentityZ :TSingle4D; static;
       class function IdentityW :TSingle4D; static;
       ///// M E T H O D
       function VectorTo( const P_:TSingle4D ) :TSingle4D;
       function UnitorTo( const P_:TSingle4D ) :TSingle4D;
       function DistanTo( const P_:TSingle4D ) :Single;
       function ToCart :TSingle3D;
       class function RandG :TSingle4D; static;
       class function RandBS1 :TSingle4D; static;
       class function RandBS2 :TSingle4D; static;
       class function RandBS4 :TSingle4D; static;
       ///// F I E L D
     case Integer of
      0:( _1D :array [ 0..4-1 ] of Single );
      1:( _1  :Single;
          _2  :Single;
          _3  :Single;
          _4  :Single;                    );
      2:(  X  :Single;
           Y  :Single;
           Z  :Single;
           W  :Single;                    );
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TDouble4D

     TDouble4D = record
     private
       ///// A C C E S S O R
       function GetD1( const X_:Integer ) :Double;
       procedure SetD1( const X_:Integer; const D1_:Double );
       function GetSize2 :Double;
       procedure SetSize2( const Size2_:Double );
       function GetSize :Double;
       procedure SetSize( const Size_:Double );
       function GetUnitor :TDouble4D;
       procedure SetUnitor( const Unitor_:TDouble4D );
     public
       constructor Create( const V_:Double ); overload;
       constructor Create( const X_,Y_,Z_,W_:Double ); overload;
       constructor Create( const P_:TDouble3D; const W_:Double ); overload;
       ///// P R O P E R T Y
       property D1[ const X_:Integer ] :Double    read GetD1     write SetD1    ; default;
       property Size2                  :Double    read GetSize2  write SetSize2 ;
       property Size                   :Double    read GetSize   write SetSize  ;
       property Unitor                 :TDouble4D read GetUnitor write SetUnitor;
       ///// O P E R A T O R
       class operator Negative( const V_:TDouble4D ) :TDouble4D;
       class operator Positive( const V_:TDouble4D ) :TDouble4D;
       class operator Add( const A_,B_:TDouble4D ) :TDouble4D;
       class operator Subtract( const A_,B_:TDouble4D ) :TDouble4D;
       class operator Multiply( const A_:TDouble4D; const B_:Double ) :TDouble4D;
       class operator Multiply( const A_:Double; const B_:TDouble4D ) :TDouble4D;
       class operator Divide( const A_:TDouble4D; const B_:Double ) :TDouble4D;
       ///// C A S T
       class operator Implicit( const V_:TDouble3D ) :TDouble4D;
       class operator Explicit( const V_:TDouble4D ) :TDouble3D;
       class operator Implicit( const V_:TPoint3D ) :TDouble4D;
       class operator Explicit( const V_:TDouble4D ) :TPoint3D;
       class operator Implicit( const V_:TVector3D ) :TDouble4D;
       class operator Explicit( const V_:TDouble4D ) :TVector3D;
       ///// C O N S T A N T
       class function IdentityX :TDouble4D; static;
       class function IdentityY :TDouble4D; static;
       class function IdentityZ :TDouble4D; static;
       class function IdentityW :TDouble4D; static;
       ///// M E T H O D
       function VectorTo( const P_:TDouble4D ) :TDouble4D;
       function UnitorTo( const P_:TDouble4D ) :TDouble4D;
       function DistanTo( const P_:TDouble4D ) :Double;
       function ToCart :TDouble3D;
       class function RandG :TDouble4D; static;
       class function RandBS1 :TDouble4D; static;
       class function RandBS2 :TDouble4D; static;
       class function RandBS4 :TDouble4D; static;
       ///// F I E L D
     case Integer of
      0:( _1D :array [ 0..4-1 ] of Double );
      1:( _1  :Double;
          _2  :Double;
          _3  :Double;
          _4  :Double;                    );
      2:(  X  :Double;
           Y  :Double;
           Z  :Double;
           W  :Double;                    );
     end;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C L A S S 】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% DotProduct

function DotProduct( const A_,B_:TSingle4D ) :Single; overload;
function DotProduct( const A_,B_:TDouble4D ) :Double; overload;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CrossProduct

function CrossProduct( const A_,B_,C_:TSingle4D ) :TSingle4D; overload;
function CrossProduct( const A_,B_,C_:TDouble4D ) :TDouble4D; overload;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Distance

function Distance2( const A_,B_:TSingle4D ) :Single; overload;
function Distance2( const A_,B_:TDouble4D ) :Double; overload;

function Distance( const A_,B_:TSingle4D ) :Single; overload;
function Distance( const A_,B_:TDouble4D ) :Double; overload;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Ave

function Ave( const P1_,P2_:TSingle4D ) :TSingle4D; overload;
function Ave( const P1_,P2_:TDouble4D ) :TDouble4D; overload;

function Ave( const P1_,P2_,P3_:TSingle4D ) :TSingle4D; overload;
function Ave( const P1_,P2_,P3_:TDouble4D ) :TDouble4D; overload;

function Ave( const P1_,P2_,P3_,P4_:TSingle4D ) :TSingle4D; overload;
function Ave( const P1_,P2_,P3_,P4_:TDouble4D ) :TDouble4D; overload;

implementation //############################################################### ■

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R E C O R D 】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TSingle4D

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//////////////////////////////////////////////////////////////// A C C E S S O R

function TSingle4D.GetD1( const X_:Integer ) :Single;
begin
     Result := _1D[ X_-1 ];
end;

procedure TSingle4D.SetD1( const X_:Integer; const D1_:Single );
begin
     _1D[ X_-1 ] := D1_;
end;

//------------------------------------------------------------------------------

function TSingle4D.GetSize2 :Single;
begin
     Result := Pow2( X ) + Pow2( Y ) + Pow2( Z ) + Pow2( W );
end;

procedure TSingle4D.SetSize2( const Size2_:Single );
begin
     Self := Roo2( Size2_ / Size2 ) * Self;
end;

function TSingle4D.GetSize :Single;
begin
     Result := Roo2( GetSize2 );
end;

procedure TSingle4D.SetSize( const Size_:Single );
begin
     Self := Size_ * Unitor;
end;

function TSingle4D.GetUnitor :TSingle4D;
begin
     Result := Self / Size;
end;

procedure TSingle4D.SetUnitor( const Unitor_:TSingle4D );
begin
     Self := Size * Unitor_;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TSingle4D.Create( const V_:Single );
begin
     X := V_;
     Y := V_;
     Z := V_;
     W := V_;
end;

constructor TSingle4D.Create( const X_,Y_,Z_,W_:Single );
begin
     X := X_;
     Y := Y_;
     Z := Z_;
     W := W_;
end;

constructor TSingle4D.Create( const P_:TSingle3D; const W_:Single );
begin
     X := P_.X ;
     Y := P_.Y ;
     Z := P_.Z ;
     W :=    W_;
end;

//////////////////////////////////////////////////////////////// O P E R A T O R

class operator TSingle4D.Negative( const V_:TSingle4D ) :TSingle4D;
begin
     with Result do
     begin
          X := -V_.X;
          Y := -V_.Y;
          Z := -V_.Z;
          W := -V_.W;
     end;
end;

class operator TSingle4D.Positive( const V_:TSingle4D ) :TSingle4D;
begin
     with Result do
     begin
          X := +V_.X;
          Y := +V_.Y;
          Z := +V_.Z;
          W := +V_.W;
     end;
end;

class operator TSingle4D.Add( const A_,B_:TSingle4D ) :TSingle4D;
begin
     with Result do
     begin
          X := A_.X + B_.X;
          Y := A_.Y + B_.Y;
          Z := A_.Z + B_.Z;
          W := A_.W + B_.W;
     end;
end;

class operator TSingle4D.Subtract( const A_,B_:TSingle4D ) :TSingle4D;
begin
     with Result do
     begin
          X := A_.X - B_.X;
          Y := A_.Y - B_.Y;
          Z := A_.Z - B_.Z;
          W := A_.W - B_.W;
     end;
end;

class operator TSingle4D.Multiply( const A_:TSingle4D; const B_:Single ) :TSingle4D;
begin
     with Result do
     begin
          X := A_.X * B_;
          Y := A_.Y * B_;
          Z := A_.Z * B_;
          W := A_.W * B_;
     end;
end;

class operator TSingle4D.Multiply( const A_:Single; const B_:TSingle4D ) :TSingle4D;
begin
     with Result do
     begin
          X := A_ * B_.X;
          Y := A_ * B_.Y;
          Z := A_ * B_.Z;
          W := A_ * B_.W;
     end;
end;

class operator TSingle4D.Divide( const A_:TSingle4D; const B_:Single ) :TSingle4D;
begin
     with Result do
     begin
          X := A_.X / B_;
          Y := A_.Y / B_;
          Z := A_.Z / B_;
          W := A_.W / B_;
     end;
end;

//////////////////////////////////////////////////////////////////////// C A S T

class operator TSingle4D.Implicit( const V_:TSingle3D ) :TSingle4D;
begin
     with Result do
     begin
          X := V_.X;
          Y := V_.Y;
          Z := V_.Z;
          W :=    0;
     end;
end;

class operator TSingle4D.Explicit( const V_:TSingle4D ) :TSingle3D;
begin
     with Result do
     begin
          X := V_.X;
          Y := V_.Y;
          Z := V_.Z;
     end;
end;

class operator TSingle4D.Implicit( const V_:TPoint3D ) :TSingle4D;
begin
     with Result do
     begin
          X := +V_.X;
          Y := -V_.Y;
          Z := -V_.Z;
          W :=     0;
     end;
end;

class operator TSingle4D.Explicit( const V_:TSingle4D ) :TPoint3D;
begin
     with Result do
     begin
          X := +V_.X;
          Y := -V_.Y;
          Z := -V_.Z;
     end;
end;

class operator TSingle4D.Implicit( const V_:TVector3D ) :TSingle4D;
begin
     with Result do
     begin
          X := +V_.X;
          Y := -V_.Y;
          Z := -V_.Z;
          W :=  V_.W;
     end;
end;

class operator TSingle4D.Explicit( const V_:TSingle4D ) :TVector3D;
begin
     with Result do
     begin
          X := +V_.X;
          Y := -V_.Y;
          Z := -V_.Z;
          W :=  V_.W;
     end;
end;

//////////////////////////////////////////////////////////////// C O N S T A N T

class function TSingle4D.IdentityX :TSingle4D;
begin
     with Result do
     begin
          X := 1;
          Y := 0;
          Z := 0;
          W := 0;
     end;
end;

class function TSingle4D.IdentityY :TSingle4D;
begin
     with Result do
     begin
          X := 0;
          Y := 1;
          Z := 0;
          W := 0;
     end;
end;

class function TSingle4D.IdentityZ :TSingle4D;
begin
     with Result do
     begin
          X := 0;
          Y := 0;
          Z := 1;
          W := 0;
     end;
end;

class function TSingle4D.IdentityW :TSingle4D;
begin
     with Result do
     begin
          X := 0;
          Y := 0;
          Z := 0;
          W := 1;
     end;
end;

//////////////////////////////////////////////////////////////////// M E T H O D

function TSingle4D.VectorTo( const P_:TSingle4D ) :TSingle4D;
begin
     Result := P_ - Self;
end;

function TSingle4D.UnitorTo( const P_:TSingle4D ) :TSingle4D;
begin
     Result := VectorTo( P_ ).Unitor;
end;

function TSingle4D.DistanTo( const P_:TSingle4D ) :Single;
begin
     Result := VectorTo( P_ ).Size;
end;

//------------------------------------------------------------------------------

function TSingle4D.ToCart :TSingle3D;
begin
     Result.X := X / W;
     Result.Y := Y / W;
     Result.Z := Z / W;
end;

//------------------------------------------------------------------------------

class function TSingle4D.RandG :TSingle4D;
begin
     with Result do
     begin
          X := TSingle.RandG;
          Y := TSingle.RandG;
          Z := TSingle.RandG;
          W := TSingle.RandG;
     end;
end;

//------------------------------------------------------------------------------

class function TSingle4D.RandBS1 :TSingle4D;
begin
     with Result do
     begin
          X := TSingle.RandBS1;
          Y := TSingle.RandBS1;
          Z := TSingle.RandBS1;
          W := TSingle.RandBS1;
     end;
end;

class function TSingle4D.RandBS2 :TSingle4D;
begin
     with Result do
     begin
          X := TSingle.RandBS2;
          Y := TSingle.RandBS2;
          Z := TSingle.RandBS2;
          W := TSingle.RandBS2;
     end;
end;

class function TSingle4D.RandBS4 :TSingle4D;
begin
     with Result do
     begin
          X := TSingle.RandBS4;
          Y := TSingle.RandBS4;
          Z := TSingle.RandBS4;
          W := TSingle.RandBS4;
     end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TDouble4D

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//////////////////////////////////////////////////////////////// A C C E S S O R

function TDouble4D.GetD1( const X_:Integer ) :Double;
begin
     Result := _1D[ X_-1 ];
end;

procedure TDouble4D.SetD1( const X_:Integer; const D1_:Double );
begin
     _1D[ X_-1 ] := D1_;
end;

//------------------------------------------------------------------------------

function TDouble4D.GetSize2 :Double;
begin
     Result := Pow2( X ) + Pow2( Y ) + Pow2( Z ) + Pow2( W );
end;

procedure TDouble4D.SetSize2( const Size2_:Double );
begin
     Self := Roo2( Size2_ / Size2 ) * Self;
end;

function TDouble4D.GetSize :Double;
begin
     Result := Roo2( GetSize2 );
end;

procedure TDouble4D.SetSize( const Size_:Double );
begin
     Self := Size_ * Unitor;
end;

function TDouble4D.GetUnitor :TDouble4D;
begin
     Result := Self / Size;
end;

procedure TDouble4D.SetUnitor( const Unitor_:TDouble4D );
begin
     Self := Size * Unitor_;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TDouble4D.Create( const V_:Double );
begin
     X := V_;
     Y := V_;
     Z := V_;
     W := V_;
end;

constructor TDouble4D.Create( const X_,Y_,Z_,W_:Double );
begin
     X := X_;
     Y := Y_;
     Z := Z_;
     W := W_;
end;

constructor TDouble4D.Create( const P_:TDouble3D; const W_:Double );
begin
     X := P_.X ;
     Y := P_.Y ;
     Z := P_.Z ;
     W :=    W_;
end;

//////////////////////////////////////////////////////////////// O P E R A T O R

class operator TDouble4D.Negative( const V_:TDouble4D ) :TDouble4D;
begin
     with Result do
     begin
          X := -V_.X;
          Y := -V_.Y;
          Z := -V_.Z;
          W := -V_.W;
     end;
end;

class operator TDouble4D.Positive( const V_:TDouble4D ) :TDouble4D;
begin
     with Result do
     begin
          X := +V_.X;
          Y := +V_.Y;
          Z := +V_.Z;
          W := +V_.W;
     end;
end;

class operator TDouble4D.Add( const A_,B_:TDouble4D ) :TDouble4D;
begin
     with Result do
     begin
          X := A_.X + B_.X;
          Y := A_.Y + B_.Y;
          Z := A_.Z + B_.Z;
          W := A_.W + B_.W;
     end;
end;

class operator TDouble4D.Subtract( const A_,B_:TDouble4D ) :TDouble4D;
begin
     with Result do
     begin
          X := A_.X - B_.X;
          Y := A_.Y - B_.Y;
          Z := A_.Z - B_.Z;
          W := A_.W - B_.W;
     end;
end;

class operator TDouble4D.Multiply( const A_:TDouble4D; const B_:Double ) :TDouble4D;
begin
     with Result do
     begin
          X := A_.X * B_;
          Y := A_.Y * B_;
          Z := A_.Z * B_;
          W := A_.W * B_;
     end;
end;

class operator TDouble4D.Multiply( const A_:Double; const B_:TDouble4D ) :TDouble4D;
begin
     with Result do
     begin
          X := A_ * B_.X;
          Y := A_ * B_.Y;
          Z := A_ * B_.Z;
          W := A_ * B_.W;
     end;
end;

class operator TDouble4D.Divide( const A_:TDouble4D; const B_:Double ) :TDouble4D;
begin
     with Result do
     begin
          X := A_.X / B_;
          Y := A_.Y / B_;
          Z := A_.Z / B_;
          W := A_.W / B_;
     end;
end;

//////////////////////////////////////////////////////////////////////// C A S T

class operator TDouble4D.Implicit( const V_:TDouble3D ) :TDouble4D;
begin
     with Result do
     begin
          X := V_.X;
          Y := V_.Y;
          Z := V_.Z;
          W :=    0;
     end;
end;

class operator TDouble4D.Explicit( const V_:TDouble4D ) :TDouble3D;
begin
     with Result do
     begin
          X := V_.X;
          Y := V_.Y;
          Z := V_.Z;
     end;
end;

class operator TDouble4D.Implicit( const V_:TPoint3D ) :TDouble4D;
begin
     with Result do
     begin
          X := +V_.X;
          Y := -V_.Y;
          Z := -V_.Z;
          W :=     0;
     end;
end;

class operator TDouble4D.Explicit( const V_:TDouble4D ) :TPoint3D;
begin
     with Result do
     begin
          X := +V_.X;
          Y := -V_.Y;
          Z := -V_.Z;
     end;
end;

class operator TDouble4D.Implicit( const V_:TVector3D ) :TDouble4D;
begin
     with Result do
     begin
          X := +V_.X;
          Y := -V_.Y;
          Z := -V_.Z;
          W :=  V_.W;
     end;
end;

class operator TDouble4D.Explicit( const V_:TDouble4D ) :TVector3D;
begin
     with Result do
     begin
          X := +V_.X;
          Y := -V_.Y;
          Z := -V_.Z;
          W :=  V_.W;
     end;
end;

//////////////////////////////////////////////////////////////// C O N S T A N T

class function TDouble4D.IdentityX :TDouble4D;
begin
     with Result do
     begin
          X := 1;
          Y := 0;
          Z := 0;
          W := 0;
     end;
end;

class function TDouble4D.IdentityY :TDouble4D;
begin
     with Result do
     begin
          X := 0;
          Y := 1;
          Z := 0;
          W := 0;
     end;
end;

class function TDouble4D.IdentityZ :TDouble4D;
begin
     with Result do
     begin
          X := 0;
          Y := 0;
          Z := 1;
          W := 0;
     end;
end;

class function TDouble4D.IdentityW :TDouble4D;
begin
     with Result do
     begin
          X := 0;
          Y := 0;
          Z := 0;
          W := 1;
     end;
end;

//////////////////////////////////////////////////////////////////// M E T H O D

function TDouble4D.VectorTo( const P_:TDouble4D ) :TDouble4D;
begin
     Result := P_ - Self;
end;

function TDouble4D.UnitorTo( const P_:TDouble4D ) :TDouble4D;
begin
     Result := VectorTo( P_ ).Unitor;
end;

function TDouble4D.DistanTo( const P_:TDouble4D ) :Double;
begin
     Result := VectorTo( P_ ).Size;
end;

//------------------------------------------------------------------------------

function TDouble4D.ToCart :TDouble3D;
begin
     Result.X := X / W;
     Result.Y := Y / W;
     Result.Z := Z / W;
end;

//------------------------------------------------------------------------------

class function TDouble4D.RandG :TDouble4D;
begin
     with Result do
     begin
          X := TDouble.RandG;
          Y := TDouble.RandG;
          Z := TDouble.RandG;
          W := TDouble.RandG;
     end;
end;

//------------------------------------------------------------------------------

class function TDouble4D.RandBS1 :TDouble4D;
begin
     with Result do
     begin
          X := TDouble.RandBS1;
          Y := TDouble.RandBS1;
          Z := TDouble.RandBS1;
          W := TDouble.RandBS1;
     end;
end;

class function TDouble4D.RandBS2 :TDouble4D;
begin
     with Result do
     begin
          X := TDouble.RandBS2;
          Y := TDouble.RandBS2;
          Z := TDouble.RandBS2;
          W := TDouble.RandBS2;
     end;
end;

class function TDouble4D.RandBS4 :TDouble4D;
begin
     with Result do
     begin
          X := TDouble.RandBS4;
          Y := TDouble.RandBS4;
          Z := TDouble.RandBS4;
          W := TDouble.RandBS4;
     end;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C L A S S 】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% DotProduct

function DotProduct( const A_,B_:TSingle4D ) :Single;
begin
     Result := A_.X * B_.X
             + A_.Y * B_.Y
             + A_.Z * B_.Z
             + A_.W * B_.W;
end;

function DotProduct( const A_,B_:TDouble4D ) :Double;
begin
     Result := A_.X * B_.X
             + A_.Y * B_.Y
             + A_.Z * B_.Z
             + A_.W * B_.W;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CrossProduct

function CrossProduct( const A_,B_,C_:TSingle4D ) :TSingle4D;
begin
     with Result do
     begin
          X := A_.Y * B_.Z * C_.W - A_.W * B_.Z * C_.Y
             + B_.Y * C_.Z * A_.W - B_.W * C_.Z * A_.Y
             + C_.Y * A_.Z * B_.W - C_.W * A_.Z * B_.Y;

          Y := A_.X * B_.W * C_.Z - A_.Z * B_.W * C_.X
             + B_.X * C_.W * A_.Z - B_.Z * C_.W * A_.X
             + C_.X * A_.W * B_.Z - C_.Z * A_.W * B_.X;

          Z := A_.W * B_.X * C_.Y - A_.Y * B_.X * C_.W
             + B_.W * C_.X * A_.Y - B_.Y * C_.X * A_.W
             + C_.W * A_.X * B_.Y - C_.Y * A_.X * B_.W;

          W := A_.Z * B_.Y * C_.X - A_.X * B_.Y * C_.Z
             + B_.Z * C_.Y * A_.X - B_.X * C_.Y * A_.Z
             + C_.Z * A_.Y * B_.X - C_.X * A_.Y * B_.Z;
     end;
end;

function CrossProduct( const A_,B_,C_:TDouble4D ) :TDouble4D;
begin
     with Result do
     begin
          X := A_.Y * B_.Z * C_.W - A_.W * B_.Z * C_.Y
             + B_.Y * C_.Z * A_.W - B_.W * C_.Z * A_.Y
             + C_.Y * A_.Z * B_.W - C_.W * A_.Z * B_.Y;

          Y := A_.X * B_.W * C_.Z - A_.Z * B_.W * C_.X
             + B_.X * C_.W * A_.Z - B_.Z * C_.W * A_.X
             + C_.X * A_.W * B_.Z - C_.Z * A_.W * B_.X;

          Z := A_.W * B_.X * C_.Y - A_.Y * B_.X * C_.W
             + B_.W * C_.X * A_.Y - B_.Y * C_.X * A_.W
             + C_.W * A_.X * B_.Y - C_.Y * A_.X * B_.W;

          W := A_.Z * B_.Y * C_.X - A_.X * B_.Y * C_.Z
             + B_.Z * C_.Y * A_.X - B_.X * C_.Y * A_.Z
             + C_.Z * A_.Y * B_.X - C_.X * A_.Y * B_.Z;
     end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Distance

function Distance2( const A_,B_:TSingle4D ) :Single;
begin
     Result := Pow2( B_.X - A_.X )
             + Pow2( B_.Y - A_.Y )
             + Pow2( B_.Z - A_.Z )
             + Pow2( B_.W - A_.W );
end;

function Distance2( const A_,B_:TDouble4D ) :Double;
begin
     Result := Pow2( B_.X - A_.X )
             + Pow2( B_.Y - A_.Y )
             + Pow2( B_.Z - A_.Z )
             + Pow2( B_.W - A_.W );
end;

//------------------------------------------------------------------------------

function Distance( const A_,B_:TSingle4D ) :Single;
begin
     Result := Roo2( Distance2( A_, B_ ) );
end;

function Distance( const A_,B_:TDouble4D ) :Double;
begin
     Result := Roo2( Distance2( A_, B_ ) );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Ave

function Ave( const P1_,P2_:TSingle4D ) :TSingle4D;
begin
     Result := ( P1_ + P2_ ) / 2;
end;

function Ave( const P1_,P2_:TDouble4D ) :TDouble4D;
begin
     Result := ( P1_ + P2_ ) / 2;
end;

//------------------------------------------------------------------------------

function Ave( const P1_,P2_,P3_:TSingle4D ) :TSingle4D;
begin
     Result := ( P1_ + P2_ + P3_ ) / 3;
end;

function Ave( const P1_,P2_,P3_:TDouble4D ) :TDouble4D;
begin
     Result := ( P1_ + P2_ + P3_ ) / 3;
end;

//------------------------------------------------------------------------------

function Ave( const P1_,P2_,P3_,P4_:TSingle4D ) :TSingle4D;
begin
     Result := ( P1_ + P2_ + P3_ + P4_ ) / 4;
end;

function Ave( const P1_,P2_,P3_,P4_:TDouble4D ) :TDouble4D;
begin
     Result := ( P1_ + P2_ + P3_ + P4_ ) / 4;
end;

end. //######################################################################### ■
