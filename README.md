# OpenCL

OpenCL を用いて GPU で計算する方法。

ライブラリを読み込むと同時に、実行マシンにおけるすべての“Platform”と“Device”が検出され、`LUX.GPU.OpenCL`ユニットで定義されているグローバル変数`_OpenCL_`内のリストとして列挙される。

すべての Platform へは、以下ようにアクセスでき、
```Delphi
_OpenCL_.Platforms.Count                  :Integer           // 全 Platform の数
_OpenCL_.Platforms[ * ]                   :TCLPlatform       // 全 Platform の配列
```

特定の Platform の情報へは、以下のようにアクセスできる。
```Delphi
_OpenCL_.Platforms[ * ].Handle            :T_cl_platform_id  // 特定 Platform のポインタ
_OpenCL_.Platforms[ * ].Profile           :String            // 特定 Platform のプロファイル
_OpenCL_.Platforms[ * ].Version           :String            // 特定 Platform のバージョン
_OpenCL_.Platforms[ * ].Name              :String            // 特定 Platform の名前
_OpenCL_.Platforms[ * ].Vendor            :String            // 特定 Platform のベンダー名
_OpenCL_.Platforms[ * ].Extensions.Count  :Integer           // 特定 Platform の Extension の数
_OpenCL_.Platforms[ * ].Extensions[ * ]   :String            // 特定 Platform の Extension の配列
```

![](https://github.com/LUXOPHIA/OpenCL/raw/master/--------/_SCREENSHOT/OpenCL-Platforms.png)

Platform 毎に存在している Device へは、以下ようにアクセスできる。
```Delphi
_OpenCL_.Platforms[ * ].Devices.Count  :Integer    // 特定 Platform 内の全 Device の数
_OpenCL_.Platforms[ * ].Devices[ * ]   :TCLDevice  // 特定 Platform 内の全 Device の配列
```

![](https://github.com/LUXOPHIA/OpenCL/raw/master/--------/_SCREENSHOT/OpenCL-Devices.png)

Context は、以下の３つの方法で生成可能である。
```Delphi
C1 := TCLContext.Create;
C1.Parent := _OpenCL_.Platforms[ 0 ];
C1.Add( _OpenCL_.Platforms[ 0 ].Devices[ 0 ] );
C1.Add( _OpenCL_.Platforms[ 0 ].Devices[ 1 ] );
C1.Add( _OpenCL_.Platforms[ 0 ].Devices[ 2 ] );
```
```Delphi
C2 := TCLContext.Create( _OpenCL_.Platforms[ 1 ] );
C2.Add( _OpenCL_.Platforms[ 1 ].Devices[ 0 ] );
C2.Add( _OpenCL_.Platforms[ 1 ].Devices[ 1 ] );
C2.Add( _OpenCL_.Platforms[ 1 ].Devices[ 2 ] );
```
```Delphi
C3 := TCLContext.Create( _OpenCL_.Platforms[ 2 ],
                       [ _OpenCL_.Platforms[ 2 ].Devices[ 0 ],
                         _OpenCL_.Platforms[ 2 ].Devices[ 1 ],
                         _OpenCL_.Platforms[ 2 ].Devices[ 2 ] ]);
```

なお以下のように、Context の親となる Platform に所属していない Device は集約できない。
```Delphi
C0 := TCLContext.Create( _OpenCL_.Platforms[ 2 ],
                       [ _OpenCL_.Platforms[ 0 ].Devices[ 0 ],
                         _OpenCL_.Platforms[ 1 ].Devices[ 1 ],
                         _OpenCL_.Platforms[ 2 ].Devices[ 2 ] ]);
```

生成された Context は、自動的に親となる Platform 内のリストへ登録される。Platform と共に自動解放されるので、明示的に解放する必要はない。
```Delphi
_OpenCL_.Platforms[ * ].Contexts.Count  :Integer      // 特定 Platform 内の全 Contexts の数
_OpenCL_.Platforms[ * ].Contexts[ * ]   :TCLContexts  // 特定 Platform 内の全 Contexts の配列
```

![](https://github.com/LUXOPHIA/OpenCL/raw/master/--------/_SCREENSHOT/OpenCL-Contexts.png)

----

[![Delphi Starter](https://github.com/delphiusers/FreeDelphi/raw/master/Banner/FreeDelphi-Banner_350x126.png)](https://www.embarcadero.com/jp/products/delphi/starter)
