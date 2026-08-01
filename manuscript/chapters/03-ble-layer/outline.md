# 第3章 執筆方針

## この章の役割

第3章では、第2章で理解した基本的なBLE通信へ、後からどのような通信能力が加えられたかを説明します。物理層、Link Layer、GAPを仕様書の順に網羅する章にはしません。製品開発で生じる「より速く」「より遠く」「接続せずに」「多数の機器へ」「距離を測る」「音声を運ぶ」という要求を起点にし、それぞれの機能が基本経路のどこを拡張するかを示します。

Bluetooth Core Specificationは、過去から追加されてきた機能をレイヤーごとに収録しています。本章は、その目次を縮小して再現するのではなく、利用場面と解決した制約から技術を組み直します。

説明はBluetooth Core Specification v6.3を基準にします。バージョン番号は機能が追加された時期を示すために使いますが、章を4.x、5.x、6.xの年表にはしません。

## 第2章から受け取る前提

第2章では、Bluetooth 4.2までに成立していた基本的な利用場面を題材に、次の二つの流れを説明します。

```text
アドバタイジング → スキャン → 接続 → 必要に応じた暗号化
```

```text
アプリケーション
    ↓
GATT → ATT → L2CAP → HCI → Link Layer → PHY
    ↓
電波を渡り、相手側で逆の順序を上がる
```

第3章では、この基本経路を最初から説明し直しません。必要な箇所だけ地図として再掲し、「今回の機能はPHYを変える」「Link Layerで運べる長さを変える」「接続しない別の経路を作る」という位置づけを示します。

読者は、Legacy Advertising、LE 1M PHY、通常のACL接続、ATT/GATTによるRead、Write、Notify、Indicateを知っている前提です。

## 第2章との理解の深さを分ける

第2章では、読者が通信を迷わず追うために、GATT、ATT、L2CAP、HCI、Link Layer、PHYをデータが通る場所の地図として示しました。それぞれの名前は経路上の道標であり、仕様書のレイヤー構造を体系的に説明したものではありません。

第3章では、同じ通信をBluetooth Core Specificationがどのような責務と通信路へ分解しているかを読み直します。第2章が「一つの値がどこを通るか」を追う章なら、第3章は「各位置が仕様上どの単位として定義され、どの情報がPDUへ現れ、どの実装が責任を持つか」を判断できるようにする章です。

この違いを保つため、第2章と同じGATT WriteやLegacy Advertisingを例に使っても、動作を最初から説明し直しません。第3章では、同じデータがGATTではキャラクタリスティックへの操作、ATTではハンドルを持つPDU、L2CAPではCIDで識別されるチャンネルのデータ、HCIではConnection Handleに対応するACL Data、Link Layerでは接続イベントで交換するData PDUとして見えることを対応づけます。

## 仕様書の構成から通信路の詳細へ進む

基本経路を拡張する機能へ進む前に、3.1節でBLEプロトコルスタックの全体構造を示します。PHY、Link Layer、HCI、L2CAP、SMP、ATT、GATTの役割、HostとControllerの境界、GAPが複数の構成要素を使うことを説明します。各構成要素がCore SpecificationのどのVolumeとPartにあるかも示し、読者が仕様書から必要な情報を探せるようにします。

続く3.2節では、レイヤーの説明から、データを運ぶ通信路の説明へ進みます。physical channel、physical link、logical transport、logical link、L2CAP channelは、レイヤーの別名ではありません。接続中のGATT通信とLegacy Advertisingを並べ、どこまで同じ仕組みを使い、どこから異なる通信路になるかを示します。

3.1節は仕様書に登場する構成要素と役割、3.2節は構成要素を通ってデータが運ばれるときの通信関係と伝送特性を担当します。同じGATT Writeを例にしても、前者ではプロトコルスタック上の担当、後者ではlogical transportやlogical linkとの対応を説明します。

| 見る対象 | 接続中の基本的なGATT通信 |
|---|---|
| 上位プロトコルの振り分け | ATTのL2CAP固定チャンネル |
| 運ぶ情報の種類 | LE-U logical link |
| データを運ぶ性質 | LE ACL logical transport |
| 二台の関係 | LE active physical link |
| パケットを交換する場 | LE piconet physical channel |
| 実際に使う周波数 | 接続イベントごとに選ばれるPHY channel |

この精密な地図を先に持つことで、LE 2MとLE CodedはPHYの選択、Data Length ExtensionはLink Layerで運べるデータ長の拡張、Extended AdvertisingはAdvertising Physical Channel上の運び方の拡張、Isochronous Channelsは通常のLE ACLとは異なる論理トランスポートの追加、として位置づけられます。後続の各機能は、この地図のどこを変更または追加するかという差分で説明します。

## 構成の軸

### より多くのデータを短時間で送る

アプリケーションが大きなデータを渡しても、一つの機能だけで転送速度が決まるわけではありません。次の仕組みが異なる層でどのように組み合わさるかを説明します。

- ATT MTU
- LE Data Packet Length Extension
- LE 2M PHY
- 一つの接続イベントで交換できるパケット
- L2CAPによる分割と再構成
- HCIのバッファーとHost–Controller間のフロー制御
- OSやSDKがアプリケーションへ示す送信可能量

OTA更新やログ転送を例にし、「2 Mbps対応」だけではアプリケーションの転送速度を説明できないことを示します。データがどの境界で分割され、どこで待ち、どの条件で次へ渡されるかを追います。

「パケットのウィンドウ」という表現を使う場合は、接続開始時のTransmit Window、Link LayerのAcknowledgment and Flow Control、HCIのフロー制御、L2CAPのCredit Based Flow Controlなどのどれを指すかをCore v6.3で特定します。異なる層のウィンドウ、バッファー、クレジットを同じ仕組みとして説明しません。

### より遠くまで届ける

LE Coded PHYを中心に、通信距離とデータ量の交換関係を説明します。

- LE 1M PHYとの違い
- S=2とS=8
- 冗長な情報による誤り訂正
- 通信速度が下がる代わりに受信可能性が上がること
- 送信電力を上げる方法との違い
- 複数の機器が中継するBluetooth Meshとの違い

LE 2M PHYとLE Coded PHYは、同じPHYの追加でも目的が反対です。高速化と長距離化を一つの性能向上として扱わず、製品が必要とする速度、距離、消費電力から選ぶ技術として比較します。

### 接続しない通信を拡張する

Legacy Advertisingを基準に、接続しない通信がどのように拡張されたかを扱います。Legacy Advertisingだけでもビーコンは作れますが、ビーコンなど接続しない利用場面が広がる中で、データ量、利用チャンネル、送信時刻を共有する方法などに新しい要求が生じた、という順で導入します。

- Extended Advertising
- Periodic Advertising
- Periodic Advertising with Responses（PAwR）
- 多数の受信機への情報配信
- 電子棚札のような多数の低消費電力機器との双方向通信

PDUの全種類や全フィールドを列挙するのではなく、Legacy Advertisingにあったデータ長、送信タイミング、一方向通信、機器数の制約を、それぞれの技術がどう補ったかを説明します。

### 位置、方向、距離を扱う

BLEの電波を使って位置に関する情報を得る技術を、得られる情報の違いから整理します。

- RSSIによる粗い近接推定
- Direction Findingによる方向検出
- Channel Soundingによる距離測定
- PBRとRTT
- 距離と方向を混同しないこと
- リレー攻撃への対策とデジタルキー
- 落とし物タグ、近接アクセサリー、距離に応じた操作

Channel Soundingは本章で重点的に扱います。GATTのキャラクタリスティクスを読み書きして距離を求める機能ではなく、通常の接続を前提に、測距用の無線手順を追加する技術として説明します。

AppleはiOS 27向けのCore BluetoothとNearby InteractionにChannel Sounding APIを追加しています。Core Bluetoothでは距離を取得し、Nearby Interactionではカメラ支援を組み合わせた方向情報も扱えます。現時点ではベータ資料であり、対応OS、対応iPhone、周辺機器に必要なCoreバージョンと機能、AccessorySetupKitによるペアリング要件を出版前に再確認します。

### 時間に合わせてデータを届ける

LE Audioは、GATT通信の延長として詳説しません。通常のACLデータとは異なる、時間制約を持つデータ経路を追加した例として概要を扱います。

- LE Isochronous Channelsを使うこと
- 音声データそのものをGATTで運ばないこと
- 左右のイヤホンへ同期した別のストリームを送れること
- ブロードキャスト音声
- GATTは能力の公開やストリーム制御などに使われること

LC3の詳細、CIS/BISのパケット構造、オーディオサービスの状態機械、製品ごとの音質比較には入りません。本書の中心であるGATTベースの周辺機器開発から外れるため、基本的には概要に留めます。

## レイヤーの扱い方

レイヤー構造は捨てません。ただし、章の順序には使わず、機能の位置を確認する地図として使います。

現在のレイヤー構造を、最初から自明だった分類として説明しません。初期のBLE設計ではL2CAPではなく、Attribute Protocolとシグナリングを多重化する制約の大きいProtocol Adaptation Layerが検討されていました。L2CAPの追加は、実装の再利用、分割と再構成、将来の拡張性を得る一方で、メモリーと消費電力の負担を増やす選択でした。設計グループ内で意見が分かれた後、コストを定量化した検討を経てL2CAPが採用されています。

ATTとGATTの分離にも、仕様を明確にするための設計判断があります。Attributeの概念は当初、コア仕様外のワーキンググループで作られ、コア仕様へ統合するときに、抽象的なプロトコルであるATTと、その使い方を定める汎用プロファイルであるGATTへ分けられました。実際の通信では密接に組み合わさる二つを仕様上分離した理由を知ると、ATT PDUとGATT Procedureを同じものとして扱わずに読めます。

こうした成立経緯は、現行仕様の要件を置き換える根拠には使いません。Bluetooth Core Specification v6.3を規範的な根拠とし、`Bluetooth Low Energy: The Developer's Handbook`は、仕様の分類だけからは見えにくい設計上の選択とトレードオフを理解する補助資料として使います。

各機能では、必要に応じて次の点を示します。

- 基本経路のどの層を変更または追加するか
- 通信する双方に対応が必要か
- 必須機能かオプション機能か
- Feature Exchangeなどで対応を確認する必要があるか
- アプリケーション、Host、Controller、無線回路のどこに影響するか
- 従来方式との互換性をどのように保つか

仕様書のフィールドや状態機械は、機能の理解や設計判断に必要な範囲だけ使います。

## 第4章との境界

第3章は、データを運ぶ能力そのものを拡張する技術を扱います。第4章は、GATT上で製品のデータと振る舞いを設計し、長期間運用する方法を扱います。

ATT MTU、L2CAP、HCIバッファーなどは、通信速度を説明する第3章と、アプリケーションのデータ設計を説明する第4章の両方に関係します。重複して詳説せず、次のように役割を分けます。

- 第3章では、パケットの長さ、分割、PHY、接続イベント、バッファーが実効速度へどう影響するかを説明します。
- 第4章では、キャラクタリスティクスの値、Write、Notify、アプリケーションレベルのACKなどをどう設計するかを説明します。

Channel SoundingやLE Audioは、GATTとは別のデータ経路や無線手順を持つため、第4章へ移しません。GATTが制御や能力の公開に使われる場合だけ関係を示します。

## 後続章へ渡すもの

- 第6章では、nRF Connect SDKでPHY、Data Length、接続パラメーターなどを設定するとき、本章の性能上の意味を参照します。
- 第7章では、高速PHY、Coded PHY、アドバタイジング方式、接続イベントが消費電力へ与える影響を参照します。
- 第8章では、iOSから利用できる機能とOSが隠す機能を区別し、Channel Sounding APIを実装面から扱います。
- 第6章ではLegacy Advertisingによる非接続送信を実装し、第9章では受信側のプラットフォーム差を確認します。
- 第7章では、OTA転送速度をATT MTU、Data Length、PHY、バッファーの組み合わせとして扱い、パケットキャプチャーからPHY、PDU、再送、データ長、接続イベントを読み解きます。

## 執筆時の判断基準

- 機能名ではなく、どの制約を解決するかから説明を始めます。
- 「高速」「長距離」「高精度」だけで終わらず、失うものと必要な対応を示します。
- コア仕様上の機能、Controllerの実装、OSが公開するAPI、製品側の設計を区別します。
- 対応バージョンだけで機能を利用できると断定せず、オプション機能と双方の対応を確認します。
- 第1章の進化の説明とは重複させません。第1章は利用場面が広がった理由、本章は技術が基本経路のどこをどう変えたかを説明します。
- 仕様はCore v6.3を基準にし、AppleのベータAPIと対応機器は出版前に再確認します。

## 確認する公式資料

- Bluetooth SIG, Bluetooth Core Specification v6.3
  <https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Core_v6.3/out/en/index-en.html>
- Robin Heydon, *Bluetooth Low Energy: The Developer's Handbook*, Chapter 9 “Logical Link Control and Adaptation Protocol” and Chapter 10 “Attributes”
- Apple, “Measuring distance between devices using Channel Sounding”
  <https://developer.apple.com/documentation/corebluetooth/measuring-distance-between-devices-using-channel-sounding>
- Apple, WWDC26 “Find your accessory with Bluetooth Channel Sounding”
  <https://developer.apple.com/videos/play/wwdc2026/369/>
