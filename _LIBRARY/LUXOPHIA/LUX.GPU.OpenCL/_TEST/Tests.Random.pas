unit Tests.Random;

// でたらめな順の操作の試験
//
//【ねらい】
// ・このライブラリの不具合は、「ある操作の後に別の操作をすると壊れる」という、順番の組み合わせで起きやすい。
//   人が思いつく筋書きには限りがあるので、操作の列を乱数で作り、どの順でも正しく動くことを確かめる。
//
//【やり方】
// ・公開の口だけを使う操作（大きさ・ソース・ライブラリ・版・種類・キュー・デバイス・ハンドルの手放し・
//   子の追加と解放・カーネルの作り直し・仮引数の付け替え・壊れたソース）を、乱数で選んで順に行う。
// ・あるべき結果（バッファの全要素の値）は、試験の側で覚えておく。何手かごとにカーネルを走らせ、
//   落ちないことと、結果が覚えている値に一致することを確かめる。
// ・乱数は、この試験の中だけの生成器で作る。種を決めれば、列は毎回同じになる。
//   失敗したときは、種と、そこまでの操作の列を、メッセージに出す。

interface //#################################################################### ■

uses DUnitX.TestFramework,
     Tests.Base;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 T Y P E 】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R E C O R D 】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C L A S S 】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TRandomTests

     [TestFixture]
     TRandomTests = class( TCLTests )
     private
       _Seed   :Cardinal;  // 乱数の状態
       _Value  :Integer;   // ソースに書いてある定数
       _LibVal :Integer;   // ライブラリの VAL
       _UseLib :Boolean;   // ソースが VAL を使っているか
       _Extra  :TObject;   // 足してある、使っていないバッファ（無ければ nil）
       _Lib2   :TObject;   // 足してある、使っていないライブラリ（無ければ nil）
       _Trace  :String;    // ここまでの操作の列
       ///// M E T H O D
       function Next( const N_:Integer ) :Integer;
       function Expected :Single;
       procedure Rewrite;
       procedure Step;
       procedure Check;
       procedure Sequence( const Seed_:Cardinal; const StepsN_:Integer );
     public
       [Test]
       [TestCase( 'Seed 1', '1' )]
       [TestCase( 'Seed 2', '2' )]
       [TestCase( 'Seed 3', '3' )]
       [TestCase( 'Seed 4', '4' )]
       [TestCase( 'Seed 5', '5' )]
       [TestCase( 'Seed 6', '6' )]
       [TestCase( 'Seed 7', '7' )]
       [TestCase( 'Seed 8', '8' )]
       procedure RandomOrder( const Seed_:Integer );
     end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

implementation //############################################################### ■

uses System.SysUtils,
     cl_version, cl_platform, cl,
     LUX.GPU.OpenCL,
     LUX.GPU.OpenCL.core;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R E C O R D 】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C L A S S 】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TRandomTests

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//////////////////////////////////////////////////////////////////// M E T H O D

// 0 以上 N_ 未満の乱数（線形合同法。上位のビットを使う）
function TRandomTests.Next( const N_:Integer ) :Integer;
begin
     {$Q-}
     _Seed := _Seed * 1664525 + 1013904223;
     {$Q+}

     Result := Integer( ( _Seed shr 8 ) mod Cardinal( N_ ) );
end;

function TRandomTests.Expected :Single;
begin
     if _UseLib then Result := _LibVal
                else Result := _Value;
end;

// 覚えている状態のとおりに、ソースとライブラリを書く
procedure TRandomTests.Rewrite;
begin
     _Librar.Source.Text := '#define VAL ' + _LibVal.ToString + '.0f';

     if _UseLib then SetSource( 'VAL'                    )
                else SetSource( _Value.ToString + '.0f' );
end;

procedure TRandomTests.Step;
var
   K :Integer;
   B :TCLBuildr;
   P :TCLParame;
begin
     K := Next( 22 );

     _Trace := _Trace + ' ' + K.ToString;

     case K of
        0: _Buffer.Count := 1 + Next( 64 );
        1: begin  _Value  := 1 + Next( 9 );  Rewrite;  end;
        2: begin  _LibVal := 1 + Next( 9 );  Rewrite;  end;
        3: begin  _UseLib := not _UseLib;    Rewrite;  end;
        4: _Contex.Handle := nil;
        5: _Execut.Handle := nil;
        6: _Librar.Handle := nil;
        7: _Kernel.Handle := nil;
        8: _Buffer.Handle := nil;
        9: _Queuer.Handle := nil;
       10: begin
                B := _Execut.BuildTo( _Device );

                if B.Version = TCLVersion.CL120 then B.Version := _Device.LanVer
                                                else B.Version := TCLVersion.CL120;
           end;
       11: begin
                if _Buffer.Kind = CL_MEM_READ_WRITE then _Buffer.Kind := CL_MEM_READ_WRITE or CL_MEM_ALLOC_HOST_PTR
                                                    else _Buffer.Kind := CL_MEM_READ_WRITE;
           end;
       12: _Buffer.Data.Map;
       13: begin  _Buffer.Queuer := nil;  _Buffer.Queuer := _Queuer;  end;
       14: begin  _Queuer.Device := nil;  _Queuer.Device := _Device;  end;
       15: begin
                B := _Execut.BuildTo( _Device );

                B.Device := nil;  B.Device := _Device;
           end;
       16: begin  // 使っていないバッファを足す・解放する
                if Assigned( _Extra ) then FreeAndNil( _Extra )
                else
                begin
                     _Extra := TCLBuffer<Single>.Create( _Queuer );

                     TCLBuffer<Single>( _Extra ).Count := 1 + Next( 16 );

                     if Next( 2 ) = 0 then TCLBuffer<Single>( _Extra ).Data.Map;
                end;
           end;
       17: begin  // 使っていないライブラリを足す・外して解放する
                if Assigned( _Lib2 ) then
                begin
                     if Next( 2 ) = 0 then TCLLibrar( _Lib2 ).Parent := nil;

                     FreeAndNil( _Lib2 );
                end
                else
                begin
                     _Lib2 := TCLLibrar.Create( _Contex );

                     TCLLibrar( _Lib2 ).Name := 'lib2.cl';
                     TCLLibrar( _Lib2 ).Source.Text := '#define VAL2 ' + Next( 9 ).ToString + '.0f';
                end;
           end;
       18: begin  // カーネルを作り直す
                _Kernel.Free;

                _Kernel := TCLKernel.Create( _Execut, 'Fill', _Queuer );
                _Kernel.Parames[ 'Buffer' ] := _Buffer;
           end;
       19: begin  // 仮引数の名前を、いったん違う名前にして、戻す
                P := _Kernel.Parames.Items[ 'Buffer' ];

                P.Name := 'Other';

                if Next( 2 ) = 0 then _Kernel.Parames.FindsOK;

                P.Name := 'Buffer';
           end;
       20: begin  // バッファを作り直して、渡し直す
                _Buffer.Free;

                _Buffer := TCLBuffer<Single>.Create( _Queuer );
                _Buffer.Count := 1 + Next( 32 );

                _Kernel.Parames[ 'Buffer' ] := _Buffer;
           end;
       21: begin  // ソースを壊して、失敗を見てから、直す
                _Execut.Source.Text := 'kernel void Fill( global float* Buffer ) { syntax error';

                Assert.IsFalse( _Execut.BuildTo( _Device ).BuildOK, 'seed の列 :' + _Trace );

                if Next( 2 ) = 0 then Assert.IsTrue( Raises( procedure begin _Kernel.Run; end ) );

                Rewrite;
           end;
     end;
end;

procedure TRandomTests.Check;
begin
     _Trace := _Trace + ' /';

     Assert.IsTrue( RunIs( Expected ), '結果が合わない。操作の列 :' + _Trace );
end;

procedure TRandomTests.Sequence( const Seed_:Cardinal; const StepsN_:Integer );
var
   I :Integer;
begin
     _Seed   := Seed_;
     _Value  := 1;
     _LibVal := 3;
     _UseLib := False;
     _Extra  := nil;
     _Lib2   := nil;
     _Trace  := '';

     try
        for I := 1 to StepsN_ do
        begin
             Step;

             if Next( 3 ) = 0 then Check;
        end;

        Check;
     except
        on E:ECLError  do Assert.Fail( E.ClassName + ' : ' + E.Message + '。操作の列 :' + _Trace );
        on E:EExternal do Assert.Fail( E.ClassName + ' : ' + E.Message + '。操作の列 :' + _Trace );  // アクセス違反など
     end;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

// 乱数で選んだ 60 手の操作を、どの順で行っても、落ちず、結果が合う
procedure TRandomTests.RandomOrder( const Seed_:Integer );
begin
     Sequence( Cardinal( ( UInt64( Seed_ ) * 2654435761 ) and $FFFFFFFF ), 60 );
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

initialization //############################################################### ■

     TDUnitX.RegisterTestFixture( TRandomTests );

end. //######################################################################### ■
