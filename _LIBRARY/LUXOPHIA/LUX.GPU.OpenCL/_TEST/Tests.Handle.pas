unit Tests.Handle;

// ハンドルの遅延の作成と、解放の伝わり方の試験
//
//【確かめること】
// ・元になるプロパティを変えると、ハンドルが解放され、次に使うときに、新しい状態で作り直される。
// ・上流（コンテキスト・ライブラリ・実行プログラム・ビルド）の解放が、下流へ伝わる。
// ・メモリの解放は、カーネルを解放せず、引数の渡し直しだけを起こす。

interface //#################################################################### ■

uses DUnitX.TestFramework,
     Tests.Base;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 T Y P E 】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R E C O R D 】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C L A S S 】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% THandleTests

     [TestFixture]
     THandleTests = class( TCLTests )
     public
       [Test] procedure RunsAsBuilt;
       [Test] procedure HandleIsCreatedOnRead;
       [Test] procedure BufferResized;
       [Test] procedure BufferKindChanged;
       [Test] procedure BufferQueuerChangedWhileMapped;
       [Test] procedure BufferHandleReleased;
       [Test] procedure SourceChanged;
       [Test] procedure LibraryUsed;
       [Test] procedure LibrarySourceChanged;
       [Test] procedure LibraryAddedAfterBuild;
       [Test] procedure ContextReleased;
       [Test] procedure ExecutReleased;
       [Test] procedure KernelRenamed;
       [Test] procedure SameValueKeepsHandle;
       [Test] procedure DataSurvivesUnmap;
     end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

implementation //############################################################### ■

uses System.SysUtils,
     cl_version, cl_platform, cl,
     LUX.OpenCL;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R E C O R D 】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C L A S S 】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% THandleTests

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

// 作ったままの組で、カーネルが走る
procedure THandleTests.RunsAsBuilt;
begin
     Assert.IsTrue( RunIs( 1 ) );
end;

// ハンドルは、読んだときに作られ、nil を入れると手放され、また読めば作られる
procedure THandleTests.HandleIsCreatedOnRead;
begin
     Assert.IsTrue( Assigned( _Contex.Handle ) );
     Assert.IsTrue( Assigned( _Queuer.Handle ) );
     Assert.IsTrue( Assigned( _Buffer.Handle ) );
     Assert.IsTrue( Assigned( _Librar.Handle ) );
     Assert.IsTrue( Assigned( _Execut.Handle ) );
     Assert.IsTrue( Assigned( _Kernel.Handle ) );

     _Kernel.Handle := nil;

     Assert.IsTrue( Assigned( _Kernel.Handle ) );
     Assert.IsTrue( RunIs( 1 ) );
end;

// 大きさを変えたバッファが、作り直され、カーネルに渡し直される
procedure THandleTests.BufferResized;
begin
     Assert.IsTrue( RunIs( 1 ) );

     _Buffer.Count := 8;

     Assert.AreEqual( 8, _Buffer.Count );
     Assert.IsTrue( RunIs( 1 ) );

     _Buffer.Count := 2;

     Assert.IsTrue( RunIs( 1 ) );
end;

// 種類を変えたバッファが、作り直される
procedure THandleTests.BufferKindChanged;
begin
     Assert.IsTrue( RunIs( 1 ) );

     _Buffer.Kind := CL_MEM_READ_WRITE or CL_MEM_ALLOC_HOST_PTR;

     Assert.IsTrue( RunIs( 1 ) );
end;

// マップしたままキューを外しても、古いキューで解除され、付け直せば使える
procedure THandleTests.BufferQueuerChangedWhileMapped;
begin
     _Buffer.Data.Map;

     _Buffer.Queuer := nil;
     _Buffer.Queuer := _Queuer;

     Assert.IsTrue( RunIs( 1 ) );
end;

// バッファのハンドルだけを手放しても、カーネルは残り、次の実行で渡し直される
procedure THandleTests.BufferHandleReleased;
var
   K :Pointer;
begin
     Assert.IsTrue( RunIs( 1 ) );

     K := _Kernel.Handle;

     _Buffer.Handle := nil;

     Assert.IsFalse( _Kernel.Parames.BindsOK = False, 'BindsOK は、読めば渡し直して True になる' );
     Assert.AreEqual( K, Pointer( _Kernel.Handle ), 'カーネルは作り直されない' );
     Assert.IsTrue( RunIs( 1 ) );
end;

// ソースを変えると、ビルドとカーネルが作り直される
procedure THandleTests.SourceChanged;
begin
     Assert.IsTrue( RunIs( 1 ) );

     SetSource( '2.0f' );

     Assert.IsTrue( RunIs( 2 ) );
end;

// ライブラリを、名前で #include できる
procedure THandleTests.LibraryUsed;
begin
     SetSource( 'VAL' );

     Assert.IsTrue( RunIs( 3 ) );
end;

// ライブラリのソースを変えると、それを取り込んだ実行プログラムが作り直される
procedure THandleTests.LibrarySourceChanged;
begin
     SetSource( 'VAL' );

     Assert.IsTrue( RunIs( 3 ) );

     _Librar.Source.Text := '#define VAL 4.0f';

     Assert.IsTrue( RunIs( 4 ) );
end;

// ビルドの後に足したライブラリも、次に使うときには取り込まれる。外して解放しても、残りは動く
procedure THandleTests.LibraryAddedAfterBuild;
var
   L :TCLLibrar;
begin
     Assert.IsTrue( RunIs( 1 ) );

     L := TCLLibrar.Create( _Contex );
     L.Name := 'lib2.cl';
     L.Source.Text := '#define VAL2 9.0f';

     _Execut.Source.Text := '#include "lib2.cl"' + sLineBreak
                          + 'kernel void Fill( global float* Buffer )' + sLineBreak
                          + '{ Buffer[ get_global_id( 0 ) ] = VAL2; }';

     Assert.IsTrue( RunIs( 9 ) );

     SetSource( '5.0f' );

     L.Free;

     Assert.IsTrue( RunIs( 5 ) );
end;

// コンテキストを手放すと、その上のすべてが作り直される
procedure THandleTests.ContextReleased;
begin
     Assert.IsTrue( RunIs( 1 ) );

     _Contex.Handle := nil;

     Assert.IsTrue( RunIs( 1 ) );
end;

// 実行プログラムを手放すと、ビルドとカーネルが作り直される
procedure THandleTests.ExecutReleased;
begin
     Assert.IsTrue( RunIs( 1 ) );

     _Execut.Handle := nil;

     Assert.IsTrue( _Execut.BuildTo( _Device ).BuildOK );
     Assert.IsTrue( RunIs( 1 ) );
end;

// カーネルの名前を変えると、その名前のカーネルが作り直される
procedure THandleTests.KernelRenamed;
begin
     _Execut.Source.Text := 'kernel void One( global float* Buffer ) { Buffer[ get_global_id( 0 ) ] = 1.0f; }' + sLineBreak
                          + 'kernel void Two( global float* Buffer ) { Buffer[ get_global_id( 0 ) ] = 2.0f; }';

     _Kernel.Name := 'One';

     Assert.IsTrue( RunIs( 1 ) );

     _Kernel.Name := 'Two';

     Assert.IsTrue( RunIs( 2 ) );
end;

// 同じ値を入れても、ハンドルは作り直されない
procedure THandleTests.SameValueKeepsHandle;
var
   B, K :Pointer;
begin
     Assert.IsTrue( RunIs( 1 ) );

     B := _Buffer.Handle;
     K := _Kernel.Handle;

     _Buffer.Count  := _Buffer.Count;
     _Buffer.Kind   := _Buffer.Kind;
     _Buffer.Queuer := _Queuer;
     _Kernel.Name   := _Kernel.Name;
     _Queuer.Device := _Device;

     Assert.AreEqual( B, Pointer( _Buffer.Handle ) );
     Assert.AreEqual( K, Pointer( _Kernel.Handle ) );
     Assert.IsTrue( RunIs( 1 ) );
end;

// マップを解除しても、書いた中身は残り、もう一度マップすれば読める
procedure THandleTests.DataSurvivesUnmap;
var
   I :Integer;
begin
     for I := 0 to _Buffer.Count-1 do _Buffer.Data[ I ] := I + 0.5;

     _Buffer.Data.Unmap;

     for I := 0 to _Buffer.Count-1 do Assert.AreEqual( Single( I + 0.5 ), _Buffer.Data[ I ] );

     _Buffer.Data.Unmap;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

initialization //############################################################### ■

     TDUnitX.RegisterTestFixture( THandleTests );

end. //######################################################################### ■
