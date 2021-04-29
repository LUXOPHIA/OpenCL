# OpenCL

[OpenCL](https://ja.wikipedia.org/wiki/OpenCL) を用いて、ＧＰＵで計算する方法。

----
## ■ 1. クラスの依存関係

> ・[`TOpenCL`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.pas#L50)  
　┗・[`TCLPlatfos`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Platfo.pas#L78)：プラットフォームリスト  
　　　┗・[`TCLPlatfo`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Platfo.pas#L24)：プラットフォーム  
　　　　　┣・[`TCLDevices`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Device.pas#L291)：デバイスリスト  
　　　　　┃　┗・[`TCLDevice`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Device.pas#L21)：デバイス  
　　　　　┗・[`TCLContexs`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Contex.pas#L61)：コンテキストリスト  
　　　　　　　┗・[`TCLContex`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Contex.pas#L25)：コンテキスト  
　　　　　　　　　┣・[`TCLCommans`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Comman.pas#L48)：コマンドキューリスト  
　　　　　　　　　┃　┗・[`TCLComman`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Comman.pas#L22)：コマンドキュー  
　　　　　　　　　┣・[`TCLMemorys`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Memory.pas#L45)：メモリーリスト  
　　　　　　　　　┃　┗・[`TCLMemory`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Memory.pas#L21)：メモリー  
　　　　　　　　　┗・[`TCLProgras`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Progra.pas#L56)：プログラムリスト  
　　　　　　　　　　　┗・[`TCLProgra`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Progra.pas#L23)：プログラム  
　　　　　　　　　　　　　┗・[`TCLKernels`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Kernel.pas#L65)：カーネルリスト  
　　　　　　　　　　　　　　　┗・[`TCLKernel`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Kernel.pas#L23)：カーネル

----
## ■ 2. 利用方法

ライブラリを読み込むと同時に、実行マシンにおけるすべての「**プラットフォーム**」と「**デバイス**」が検出され、「`LUX.GPU.OpenCL`」ユニットで定義されているグローバル変数「`_OpenCL_`」内のリストとして列挙される。

### ▼ 2.1. プラットフォーム
すべての Platform へは、以下のようにアクセスでき、
```C
_OpenCL_.Platfors.Count :Integer      // 全 Platform の数
_OpenCL_.Platfors[*]    :TCLPlatform  // 全 Platform の配列
```

特定のプラットフォームの情報は、以下のように取得できる。
```C
_Platfo := _OpenCL_.Platfors[0];         // 特定のプラットフォームの選択

_Platfo.Handle        :T_cl_platform_id  // ポインタ
_Platfo.Profile       :String            // プロファイル
_Platfo.Version       :String            // バージョン
_Platfo.Name          :String            // 名前
_Platfo.Vendor        :String            // ベンダー名
_Platfo.Extenss.Count :Integer           // 拡張機能の数
_Platfo.Extenss[*]    :String            // 拡張機能の配列
```

### ▼ 2.2. デバイス
プラットフォーム毎に存在している「デバイス」へは、以下のようにアクセスできる。
```C
_Platfo.Devices.Count :Integer    // デバイスの数
_Platfo.Devices[*]    :TCLDevice  // デバイスの配列
```

特定のデバイスの情報は、以下のように取得できる。
```C
_Device := _Platfo.Devices[0];              // 特定のデバイスの選択

_Device.DEVICE_TYPE      :T_cl_device_type  // タイプ
_Device.DEVICE_VENDOR_ID :T_cl_uint         // ベンダーＩＤ
_Device.DEVICE_NAME      :String            // 名前
_Device.DEVICE_VENDOR    :String            // ベンダー
_Device.DRIVER_VERSION   :String            // ドライバのバージョン
_Device.DEVICE_PROFILE   :String            // プロファイル
_Device.DEVICE_VERSION   :String            // バージョン
```

### ▼ 2.3. コンテキスト
コンテキストは、プラットフォームを元に生成できる。
```C
_Contex := TCLContex.Create( _Platfo ); 
```

### ▼ 2.4. コマンドキュー
コマンドキューは、コンテキストとデバイスを元に生成できる。
```C
_Comman := TCLComman.Create( _Contex, _Device ); 
```

コマンドキューは、コンテキスト内のリストに登録される。
```C
_Contex.Commans.Count :Integer    // コマンドキューの数
_Contex.Commans[*]    :TCLComman  // コマンドキューの配列
```

なお以下のように、Context の親となる Platform に所属していない Device は集約できない。
```C
F0 := _OpenCL_.Platfors[0];
F1 := _OpenCL_.Platfors[1];
F2 := _OpenCL_.Platfors[2];

D00 := F0.Devices[0];  D01 := F0.Devices[1];  D02 := F0.Devices[2]; 
D10 := F1.Devices[0];
D20 := F2.Devices[0];

C0 := TCLContex.Create( F0 ); 
C1 := TCLContex.Create( F1 ); 
C2 := TCLContex.Create( F2 );

Q00 := TCLComman.Create( C0, D00 );  // OK
Q01 := TCLComman.Create( C0, D01 );  // OK
Q02 := TCLComman.Create( C0, D02 );  // OK

Q10 := TCLComman.Create( C1, D00 );  // Error
Q11 := TCLComman.Create( C1, D10 );  // OK
Q12 := TCLComman.Create( C1, D20 );  // Error
```


----

* **Delphi IDE** @ Embarcadero  
https://www.embarcadero.com/jp/products/delphi/starter
