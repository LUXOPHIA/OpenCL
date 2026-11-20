unit Tests.Member;

// 一覧への所属（親子）が変わるときの試験
//
//【確かめること】
// ・一覧から外れる子は、外れる前にハンドルを手放す（外した後に解放しても、落ちない）。
// ・別のコンテキストへ移した子は、移った先で作り直される。
// ・キューのデバイスを変えると、デバイスからキューを引く対応も、付いて変わる。
// ・途中で子を解放しても、コンテキストの残りは動き続ける。

interface //#################################################################### ■

uses DUnitX.TestFramework,
     Tests.Base;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 T Y P E 】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R E C O R D 】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C L A S S 】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TMemberTests

     [TestFixture]
     TMemberTests = class( TCLTests )
     public
       [Test] procedure BufferDetachedThenFreed;
       [Test] procedure BufferFreedWhileBound;
       [Test] procedure BufferMovedToAnotherContext;
       [Test] procedure LibraryDetachedThenFreed;
       [Test] procedure KernelFreed;
       [Test] procedure ExecutFreed;
       [Test] procedure QueuerDeviceRemovedAndRestored;
       [Test] procedure QueuerDeviceChangedWhileMapped;
       [Test] procedure SecondDevice;
       [Test] procedure ContextFreedWithEverythingAlive;
     end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

implementation //############################################################### ■

uses System.SysUtils,
     LUX.OpenCL;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R E C O R D 】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C L A S S 】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TMemberTests

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

// コンテキストから外したバッファを解放しても、落ちない
procedure TMemberTests.BufferDetachedThenFreed;
var
   B :TCLBuffer<Single>;
begin
     B := TCLBuffer<Single>.Create( _Queuer );
     B.Count := 4;

     Assert.IsTrue( Assigned( B.Handle ) );

     B.Parent := nil;
     B.Free;

     Assert.IsTrue( RunIs( 1 ) );
end;

// カーネルに渡したままのバッファを解放しても、別のバッファを渡せば走る
procedure TMemberTests.BufferFreedWhileBound;
begin
     Assert.IsTrue( RunIs( 1 ) );

     _Buffer.Free;

     _Buffer := TCLBuffer<Single>.Create( _Queuer );
     _Buffer.Count := 6;

     _Kernel.Parames[ 'Buffer' ] := _Buffer;

     Assert.IsTrue( RunIs( 1 ) );
end;

// 別のコンテキストへ移したバッファは、移った先で作り直される
procedure TMemberTests.BufferMovedToAnotherContext;
var
   C :TCLContex;
   Q :TCLQueuer;
   B :TCLBuffer<Single>;
begin
     C := TCLContex.Create( _Platfo );
     try
        Q := TCLQueuer.Create( C, _Device );

        B := TCLBuffer<Single>.Create( _Queuer );
        B.Count := 4;

        Assert.IsTrue( Assigned( B.Handle ) );

        B.Parent := C.Argumes;
        B.Queuer := Q;

        B.Data[ 0 ] := 7;
        B.Data.Unmap;

        Assert.AreEqual( Single( 7 ), B.Data[ 0 ] );

        B.Data.Unmap;
     finally
        C.Free;
     end;

     Assert.IsTrue( RunIs( 1 ) );
end;

// コンテキストから外したライブラリを解放しても、落ちない
procedure TMemberTests.LibraryDetachedThenFreed;
var
   L :TCLLibrar;
begin
     L := TCLLibrar.Create( _Contex );
     L.Name := 'lib2.cl';
     L.Source.Text := '#define VAL2 9.0f';

     Assert.IsTrue( RunIs( 1 ) );
     Assert.IsTrue( Assigned( L.Handle ) );

     L.Parent := nil;
     L.Free;

     Assert.IsTrue( RunIs( 1 ) );
end;

// カーネルを解放しても、同じ実行プログラムから作り直せる
procedure TMemberTests.KernelFreed;
begin
     Assert.IsTrue( RunIs( 1 ) );

     _Kernel.Free;

     _Kernel := TCLKernel.Create( _Execut, 'Fill', _Queuer );
     _Kernel.Parames[ 'Buffer' ] := _Buffer;

     Assert.IsTrue( RunIs( 1 ) );
end;

// 実行プログラムを解放すると、そのカーネルとビルドも一緒に無くなり、一覧から消える
procedure TMemberTests.ExecutFreed;
var
   N :Integer;
begin
     Assert.IsTrue( RunIs( 1 ) );

     N := _Contex.Executs.ChildrsN;

     _Execut.Free;

     Assert.AreEqual( N - 1, _Contex.Executs.ChildrsN );

     _Execut := TCLExecut.Create( _Contex );

     SetSource( '2.0f' );

     _Kernel := TCLKernel.Create( _Execut, 'Fill', _Queuer );
     _Kernel.Parames[ 'Buffer' ] := _Buffer;

     Assert.IsTrue( RunIs( 2 ) );
end;

// キューのデバイスを外すと、対応から消え、戻すと、同じキューが引ける
procedure TMemberTests.QueuerDeviceRemovedAndRestored;
begin
     Assert.IsTrue( RunIs( 1 ) );

     _Queuer.Device := nil;

     Assert.IsFalse( _Contex.Queuers.Contains( _Device ) );

     _Queuer.Device := _Device;

     Assert.AreSame( _Queuer, _Contex.Queuers[ _Device ] );
     Assert.IsTrue( RunIs( 1 ) );
end;

// バッファをマップしたまま、キューのデバイスを変えても、落ちない
procedure TMemberTests.QueuerDeviceChangedWhileMapped;
begin
     _Buffer.Data.Map;

     _Queuer.Device := nil;
     _Queuer.Device := _Device;

     Assert.IsTrue( RunIs( 1 ) );
end;

// 2 つ目のデバイスのキューを足すと、コンテキストが作り直されて、走る（デバイスが 1 つの機械では、確かめられない）
procedure TMemberTests.SecondDevice;
var
   Q :TCLQueuer;
begin
     if _Platfo.Devices.Count < 2 then Assert.Pass( 'デバイスが 1 つなので、確かめていない' );

     Assert.IsTrue( RunIs( 1 ) );

     Q := TCLQueuer.Create( _Contex, _Platfo.Devices[ 1 ] );

     Assert.IsTrue( Assigned( Q.Handle ) );
     Assert.IsTrue( RunIs( 1 ) );

     Q.Free;

     Assert.IsTrue( RunIs( 1 ) );
end;

// 全部のハンドルを作った状態でコンテキストを解放しても、落ちない
procedure TMemberTests.ContextFreedWithEverythingAlive;
var
   C :TCLContex;
   Q :TCLQueuer;
   B :TCLBuffer<Single>;
   M :TCLImager2DxRGBAxSFlo32;
   S :TCLSamplr;
   L :TCLLibrar;
   E :TCLExecut;
   K :TCLKernel;
begin
     C := TCLContex.Create( _Platfo );
     Q := TCLQueuer.Create( C, _Device );

     B := TCLBuffer<Single>.Create( Q );
     B.Count := 4;
     B.Data.Map;

     M := TCLImager2DxRGBAxSFlo32.Create( Q );
     M.CountX := 4;
     M.CountY := 4;
     M.Data.Map;

     S := TCLSamplr.Create( C );

     L := TCLLibrar.Create( C );
     L.Name := 'lib.cl';
     L.Source.Text := '#define VAL 3.0f';

     E := TCLExecut.Create( C );
     E.Source.Text := '#include "lib.cl"' + sLineBreak
                    + 'kernel void Fill( global float* Buffer ) { Buffer[ get_global_id( 0 ) ] = VAL; }';

     K := TCLKernel.Create( E, 'Fill', Q );
     K.Parames[ 'Buffer' ] := B;

     Assert.IsTrue( Assigned( S.Handle ) );
     Assert.IsTrue( Assigned( L.Handle ) );
     Assert.IsTrue( Assigned( K.Handle ) );
     Assert.IsTrue( K.Parames.BindsOK );

     C.Free;

     Assert.IsTrue( RunIs( 1 ) );
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

initialization //############################################################### ■

     TDUnitX.RegisterTestFixture( TMemberTests );

end. //######################################################################### ■
