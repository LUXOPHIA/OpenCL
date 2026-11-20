unit Tests.Base;

// LUX.OpenCL の試験の土台
//
//【構成】
// ・TCLTests ：どの試験にも要る最小の組（コンテキスト・キュー・バッファ・ライブラリ・実行プログラム・カーネル）を、
//   試験ごとに作り、試験ごとに解放する。試験どうしは、何も共有しない。
// ・カーネル Fill は、バッファの全要素に、ソースに書いた式の値を入れる。
//   式は SetSource で差し替える。ライブラリ lib.cl は、定数 VAL を定義する。
//
//【確かめ方】
// ・RunIs( V ) ：バッファを 0 で埋めてからカーネルを走らせ、全要素が V になったかを返す。
//   ハンドルの作り直しが正しく伝わっていなければ、古いプログラムや古いバッファが使われ、値が合わない。
// ・Raises( 手続き ) ：手続きが ECLError を出したかを返す。

interface //#################################################################### ■

uses System.SysUtils,
     DUnitX.TestFramework,
     LUX.OpenCL;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 T Y P E 】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R E C O R D 】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C L A S S 】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLTests

     TCLTests = class
     private
     protected
       _Platfo :TCLPlatfo;
       _Device :TCLDevice;
       _Contex :TCLContex;
       _Queuer :TCLQueuer;
       _Buffer :TCLBuffer<Single>;
       _Librar :TCLLibrar;
       _Execut :TCLExecut;
       _Kernel :TCLKernel;
       ///// M E T H O D
       procedure SetSource( const Value_:String );
       function RunIs( const Value_:Single ) :Boolean;
       function Raises( const Proc_:TProc ) :Boolean;
     public
       [Setup]    procedure Setup;
       [TearDown] procedure TearDown;
     end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

implementation //############################################################### ■

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R E C O R D 】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C L A S S 】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLTests

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//////////////////////////////////////////////////////////////////// M E T H O D

procedure TCLTests.SetSource( const Value_:String );
begin
     _Execut.Source.Text := '#include "lib.cl"' + sLineBreak
                          + 'kernel void Fill( global float* Buffer )' + sLineBreak
                          + '{ Buffer[ get_global_id( 0 ) ] = ' + Value_ + '; }';
end;

function TCLTests.RunIs( const Value_:Single ) :Boolean;
var
   I :Integer;
begin
     for I := 0 to _Buffer.Count-1 do _Buffer.Data[ I ] := 0;

     _Buffer.Data.Unmap;

     _Kernel.GloSizX := _Buffer.Count;
     _Kernel.Run;

     Result := True;

     for I := 0 to _Buffer.Count-1 do
     begin
          if _Buffer.Data[ I ] <> Value_ then Result := False;
     end;

     _Buffer.Data.Unmap;
end;

// Proc_ が ECLError を出したかを返す（ほかの例外は、そのまま外へ出す）
function TCLTests.Raises( const Proc_:TProc ) :Boolean;
begin
     Result := False;

     try
        Proc_();
     except
        on E:ECLError do Result := True;
     end;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

procedure TCLTests.Setup;
begin
     _Platfo := TOpenCL.Platfos[ 0 ];
     _Device := _Platfo.Devices[ 0 ];

     _Contex := TCLContex.Create( _Platfo );
     _Queuer := TCLQueuer.Create( _Contex, _Device );

     _Buffer := TCLBuffer<Single>.Create( _Queuer );
     _Buffer.Count := 4;

     _Librar := TCLLibrar.Create( _Contex );
     _Librar.Name := 'lib.cl';
     _Librar.Source.Text := '#define VAL 3.0f';

     _Execut := TCLExecut.Create( _Contex );

     SetSource( '1.0f' );

     _Kernel := TCLKernel.Create( _Execut, 'Fill', _Queuer );
     _Kernel.Parames[ 'Buffer' ] := _Buffer;
end;

procedure TCLTests.TearDown;
begin
     _Contex.Free;  // キュー・バッファ・ライブラリ・実行プログラム・カーネルは、コンテキストの持ち物
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

end. //######################################################################### ■
