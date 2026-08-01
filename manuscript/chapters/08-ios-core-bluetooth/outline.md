# 第8章「iOSからBLEデバイスを使う」執筆方針

## この章の役割

第4章で設計し、第6章と第7章でnRF52840へ実装したGATTインターフェースを、iOSアプリから利用します。Core BluetoothのクラスやDelegate Methodを個別に紹介するのではなく、一つの製品へ接続し、状態を読み、設定とコマンドを書き、イベントを受け取り、切断後に回復するまでを、クライアント側の状態遷移として組み立てます。

iOSから見えるのは、Bluetooth ControllerやATT PDUそのものではなく、`CBCentralManager`、`CBPeripheral`、`CBService`、`CBCharacteristic`と非同期のDelegate Callbackです。本章では、これらのAPIがGAP、ATT、GATTのどの処理に対応し、どの部分をOSが隠しているかを示します。API呼び出しが成功したことと、製品上の操作が完了したことも区別します。

iOSを本書の詳しいクライアント基準実装とします。第9章と第10章では、同じ製品仕様をWeb、Android、Linuxから利用し、本章との差分を中心に説明します。

## 読了時の到達点

読者は、次の一連の処理を説明し、実装できる状態を目指します。

- Bluetoothの利用可否と権限を確認してからスキャンを開始する
- Advertisement Dataとアプリが保持する製品情報を区別して、目的のデバイスを選ぶ
- 接続後にServiceとCharacteristicを探索し、UUIDを製品仕様へ対応づける
- Valueのバイト列を、符号、エンディアン、単位、バージョンを含む製品データとして解釈する
- 状態のRead、設定のWrite、コマンドの要求と結果を使い分ける
- Notify／Indicateを購読し、更新値や非同期イベントをアプリ状態へ反映する
- 切断、再接続、GATTキャッシュ、バックグラウンド移行を別の問題として扱う
- iOSのログ、nRF52840のログ、BLEパケットを同じ操作へ対応づける

## 共通題材

第6章と第7章のDevice Control Serviceをそのまま利用します。

| 製品上の意味 | GATT上の表現 | iOS側の主な処理 |
|---|---|---|
| LEDの現在状態 | LED State | ReadまたはNotifyで取得する |
| センサー測定値 | Measurement Value | Readで初期値を取得し、Notifyで更新する |
| 測定周期の設定 | Measurement Interval | Writeし、公開された現在値を確認する |
| 処理の依頼 | Command Request | Request IDを付けてWriteする |
| 処理結果 | Command Response | NotifyまたはIndicateで受け取る |
| 製品で発生した事実 | Device Event | NotifyまたはIndicateで受け取る |

アプリ内では、`CBCharacteristic`をそのまま製品状態として扱いません。受信したValueを検証・変換し、アプリが管理するDevice Stateへ反映します。UIはDevice Stateを表示し、Core BluetoothのCallbackから直接更新しない構成を基本にします。

## 説明の流れ

```text
第4章のGATT契約
    ↓
iOS APIから見える境界を対応づける
    ↓
Bluetooth利用可否と権限を確認する
    ↓
スキャンして製品候補を見つける
    ↓
接続してService／Characteristicを探索する
    ↓
Valueを製品データへ変換する
    ↓
Read／Writeで状態、設定、コマンドを扱う
    ↓
Notify／Indicateで更新と結果を受け取る
    ↓
切断、再接続、キャッシュを扱う
    ↓
バックグラウンドと状態復元を製品要件へ照合する
    ↓
nRF52840とiOSを端対端で確認する
```

## 節構成

### 8.0 同じ製品仕様をiOSから利用する

- 第6章と第7章で完成させた製品を、クライアント側から利用する章であることを示す
- スキャン、接続、探索、データ交換、切断という一連の経路を提示する
- アプリ、iOS、Bluetooth Controller、nRF52840の責任を分ける
- 本章で完成させる最小アプリの画面と操作を示す
  - 接続状態
  - LED State
  - Measurement Value
  - Measurement Interval
  - Commandの実行状態と結果
  - Device Event
- APIの網羅ではなく、同じ製品仕様を端対端で扱うことを到達点にする

### 8.1 Core BluetoothとGAP／GATTを対応づける

- CentralとPeripheral、GATT ClientとGATT Serverの関係を確認する
- `CBCentralManager`、`CBPeripheral`、`CBService`、`CBCharacteristic`の役割を、GAP／GATTの概念へ対応づける
- Core Bluetoothのオブジェクト階層と、第4章のService／Characteristic階層を重ねる
- Delegate Callbackを、OSが管理する非同期処理の完了通知として扱う
- UUIDは製品仕様上の識別子であり、アプリ内の画面名や変数名とは別に管理する
- iOSから直接指定できないATT MTU、接続パラメーター、Link Layer処理を区別する
- OS APIの成功、ATT Procedureの成功、製品処理の完了が同じではないことを先に示す

### 8.2 Bluetoothの利用可否とアプリ状態を管理する

- `CBCentralManager`の生成と`centralManagerDidUpdateState(_:)`を入口にする
- `.poweredOn`以外ではスキャンを始めない
- Bluetoothの状態、権限、アプリが行いたい操作を別々の状態として持つ
- `unauthorized`、`poweredOff`、`unsupported`を同じエラー表示へまとめない
- Info.plistの利用目的と、OSが表示する権限ダイアログの関係を扱う
- 接続処理をViewのLifecycleへ直接結び付けず、BLEセッションを所有するオブジェクトを決める
- Delegate Callbackの順序へ依存しすぎない状態遷移を作る
- Swift ConcurrencyやCombineを利用する場合も、Core BluetoothのCallbackとキャンセル条件を隠さない

### 8.3 スキャンして目的の製品へ接続する

- Service UUIDを指定するスキャンと、指定しないスキャンの違いを扱う
- Advertisement Data、RSSI、`CBPeripheral`の識別子から何が分かり、何が分からないかを整理する
- Local NameやRSSIだけで製品の同一性や所有者を判断しない
- 重複発見を受け取る条件と、RSSI変化を必要とする場合の負荷を説明する
- 候補の選択、スキャン停止、接続開始を一つの状態遷移として実装する
- 接続要求の開始と、`didConnect`による接続成立を区別する
- 接続失敗と切断を別のイベントとして扱う
- 複数台を扱う設計では、発見した候補、接続対象、接続済みデバイスを分ける

### 8.4 ServiceとCharacteristicを探索する

- 接続直後には、アプリが必要なCharacteristicをまだ利用できないことを示す
- `discoverServices(_:)`から`discoverCharacteristics(_:for:)`までの順序を実装する
- 必要なUUIDだけを探索し、探索完了をアプリのReady状態と同一視しない
- CharacteristicのPropertiesを確認し、Read、Write、Notifyなどの利用可否を製品仕様と照合する
- 必須Characteristicと任意Characteristicを分ける
- 不足しているService、未知のバージョン、互換性のない構成を検出する
- `CBCharacteristic`への参照を、接続セッションより長く保持しない
- Service ChangedとGATTキャッシュの役割を説明し、開発中のUUID変更と製品更新を混同しない

### 8.5 GATT Valueを製品データへ変換する

- `Data`を受け取った直後に、長さとバージョンを確認する
- 整数の符号、エンディアン、固定小数点、単位、欠損値を第4章のValue Formatへ対応づける
- Measurement Value、Measurement Interval、Command Response、Device Eventを型の異なるデータとして扱う
- 不正な長さ、未知の列挙値、未知のバージョンを、通信切断とは別のデータエラーとして扱う
- パース処理をDelegate CallbackやViewから分離し、バイト列だけで単体試験できるようにする
- UUIDとValue Formatの対応を一か所へ集める
- ATT MTUから単純に「20バイト上限」としない。Core Bluetoothが提供する書き込み可能長と、製品独自の分割規則を分ける

### 8.6 Read／Writeで状態、設定、コマンドを扱う

- Readを、現在状態の取得やNotify購読前の初期同期に使う
- Write With ResponseとWrite Without Responseを、信頼性の上下ではなくATT上の応答と送信制御の違いとして整理する
- `didWriteValueFor`はATT Writeの結果であり、製品コマンドの処理完了ではないことを示す
- Measurement Intervalの設定では、要求値、Write結果、製品が公開する現在値を分ける
- Command RequestではRequest IDを付け、Command Responseと対応づける
- 複数のGATT操作を同時に投げず、アプリ側で進行中の操作を管理する
- タイムアウト、切断、再試行、重複実行の扱いをコマンド仕様へ含める
- `maximumWriteValueLength(for:)`と、製品プロトコル上の最大長を分ける

### 8.7 Notify／Indicateで更新とイベントを受け取る

- `setNotifyValue(_:for:)`の要求と、`didUpdateNotificationStateFor`による購読結果を区別する
- `didUpdateValueFor`がRead結果とNotify／Indicateの受信で共用されることを示す
- Measurement ValueをDevice Stateへ反映し、UI更新頻度を通知頻度から分離する
- LED State、Command Response、Device Eventを同じ受信経路で識別する
- CCCD、Notify、Indicateの関係を第4章と対応づける
- NotifyとIndicateの選択はファームウェア側のCharacteristic定義を含む製品仕様であり、iOS側だけでは変更できないことを示す
- 購読後の初期値、欠落、重複、順序、切断中の更新を製品仕様として扱う
- アプリが処理できる速度と、通知頻度・表示頻度・保存頻度を分ける

### 8.8 切断、再接続、キャッシュを扱う

- ユーザー操作による切断、通信断、Peripheral側の切断、Bluetooth OFFを区別する
- `didDisconnectPeripheral`で、接続セッションに属するCharacteristic参照と進行中操作を無効化する
- 自動再接続する条件、停止する条件、待ち時間を製品要件から決める
- 再接続後はService DiscoveryとNotify購読をどこまでやり直すかを整理する
- アプリが記憶した`CBPeripheral`と、再スキャンで見つけるデバイスの使い分けを扱う
- GATTキャッシュにより、ファームウェア更新後のService構成が見えない場合を説明する
- Service Changed、Bonding、OSキャッシュの関係は断定せず、公開APIと製品側の構成から確認できる範囲を示す
- 再接続を無限ループにせず、ユーザーへ提示すべき状態を決める

### 8.9 バックグラウンド動作を含めて端対端で確認する

- Foregroundで一連の操作を完成させた後に、Background Modeを追加する
- `bluetooth-central`を有効にした場合のCallback、スキャン、接続維持の制約を確認する
- State Preservation and Restorationが、任意の処理を継続する仕組みではないことを示す
- アプリの再起動、iOSによる終了、ユーザーによる強制終了を区別する
- 常時接続、必要時接続、デバイス側蓄積のどれを選ぶかを製品要件へ戻す
- iOS側のバックグラウンド動作と、nRF52840側の接続間隔・通知頻度・電力状態を同じシナリオで評価する
- 最後に、次の端対端シナリオを確認する
  1. 製品を発見して接続する
  2. ServiceとCharacteristicの互換性を確認する
  3. 初期状態をReadする
  4. Measurement ValueのNotifyを購読する
  5. Measurement Intervalを書き込み、反映結果を確認する
  6. Command Requestを書き込み、対応するCommand Responseを受け取る
  7. Device Eventを受け取る
  8. 切断して再接続し、状態と購読を復元する
- iOSログ、nRF52840ログ、BLEパケットをRequest IDと時刻で対応づける
- 第9章へ、同じGATT契約と端対端シナリオを引き渡す

## 章内で一貫して使う状態

Core BluetoothのCallbackを順番に並べるだけでは、アプリが現在どの操作を受け付けられるか分かりません。本章では、少なくとも次の状態を区別します。実装上の型名は本文執筆時に調整します。

```text
BluetoothUnavailable
    ↓
Idle
    ↓
Scanning
    ↓
Connecting
    ↓
Discovering
    ↓
Synchronizing
    ↓
Ready
    ↓
Disconnecting／Recovering
```

- Bluetoothの利用可否は接続状態とは別に保持する
- `Ready`は接続済みだけでなく、必須Characteristicの探索と初期同期が完了した状態とする
- Read、Write、Commandは、接続状態とは別に進行状態と結果を持つ
- UIはCore Bluetoothの一時的なCallbackではなく、明示したアプリ状態を表示する

## 第4章・第6章・第7章との対応

- 第4章は、GATTで公開する状態、設定、コマンド、イベントの契約を定義します。
- 第6章は、その契約をnRF52840上のGATT Serverとして実装します。
- 第7章は、GATT Serverを実際のIO、製品状態、省電力、更新、評価へ接続します。
- 第8章は、同じ契約をiOS上のGATT Clientとして実装し、製品の利用シナリオを完成させます。

第4章のATT／GATT説明を繰り返しません。Core Bluetoothが公開するAPIと隠蔽する処理の境界が必要な箇所だけ参照します。nRF52840側のコードも再掲せず、UUID、Value Format、操作の順序、エラー、Request IDという両者の契約を比較します。

## 第9章・第10章との境界

- 第8章は、iOSを使ってクライアント実装を詳しく組み立てます。
- 第9章は、同じGATT契約をWeb Bluetoothから使い、ユーザー操作、権限、対応環境の違いを扱います。
- 第10章は、Androidの権限とGATT操作、Linux／BlueZ／Bleakによる操作と試験を、本章との差分として扱います。

Web、Android、Linuxでも共通するパース処理、状態・設定・コマンド・イベントの意味は本章を基準とし、後続章で重複させません。

## 既存原稿の再配置方針

現行原稿は約46,800文字あり、Core Bluetoothの主要APIとコード例を広く含んでいます。ただし、APIごとの説明が中心で、製品の状態遷移とGATT契約の流れが分断されています。本文更新時は、利用できる説明とコードを残しながら、次のように再配置します。

| 現行ファイル | 主な移行先 |
|---|---|
| `8.0-intro.md` | 8.0の章導入として書き直す |
| `8.1-framework-overview.md` | 8.1へCore BluetoothとGATTの対応を集約する |
| `8.2-centralmanager.md` | 8.2の利用可否、権限、アプリ状態へ移す |
| `8.3-scanning.md` | 8.3の発見、候補選択、接続開始へ移す |
| `8.4-service-discovery.md` | 8.3の接続完了と8.4の探索・キャッシュへ分ける |
| `8.5-read-write.md` | Valueのパースを8.5、Read／Writeを8.6へ分ける |
| `8.6-notify.md` | 8.7へ移し、状態、応答、イベントを共通経路で扱う |
| `8.7-background.md` | 切断・再接続を8.8、バックグラウンドと状態復元を8.9へ分ける |
| `8.8-summary.md` | 各節の重複まとめを減らし、8.9の端対端確認と第9章への接続へ再構成する |

旧温度計章の受信、パース、表示コードは、Measurement Valueを扱う具体例として利用できます。ただし、Device Control ServiceのValue Formatへ合わせ、温度計だけに閉じた章へ戻さないようにします。

## 本文更新時に確認する技術事項

- 対象とするiOS／Xcode／Swiftのバージョン
- Bluetooth利用目的のInfo.plist Keyと権限表示
- `CBCentralManager`と`CBPeripheral`の公開API契約
- Foreground／Backgroundにおけるスキャン、接続、Notifyの制約
- State Preservation and Restorationの開始条件と復元される状態
- `maximumWriteValueLength(for:)`とWrite Without Responseの送信制御
- Service Changed、GATTキャッシュ、Bondingについて公開資料で確認できる範囲
- 掲載コードのActor／ThreadとUI更新方法

プラットフォーム依存の記述はAppleの公式文書を基準にし、対象バージョンと確認日を残します。BLE仕様上の説明はBluetooth Core Specification v6.3と第2章から第4章を基準にし、iOSの実装上の制約と混同しません。

## 読者層別Noteの候補

- 【ファーム開発者の方へ】: `didWriteValueFor`と製品処理完了を区別し、Command Responseを仕様化する理由
- 【アプリ開発者の方へ】: 接続済みとReadyを分け、Service Discoveryと初期同期を状態へ含める判断
- 【企画者の方へ】: バックグラウンド常時接続を前提にせず、必要時接続やデバイス側蓄積を比較する判断

Noteは本文の流れに必要な場合だけ置き、同じ内容を本文と重複させません。
