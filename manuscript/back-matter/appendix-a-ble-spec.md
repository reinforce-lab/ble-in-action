# 付録A: BLE仕様書の読み方

<!-- topic: Bluetooth SIG仕様書, Core Specification, GATT割り当て番号, 仕様書の構成 -->


## Bluetooth SIG 仕様書とは

Bluetooth の技術仕様は **Bluetooth SIG (Special Interest Group)** が策定し、公式サイトで無償公開しています。

- **公式URL**: [https://www.bluetooth.com/specifications/specs/](https://www.bluetooth.com/specifications/specs/)

主な仕様書:

| 仕様書 | 内容 |
|---|---|
| **Core Specification** | BLEの全プロトコルスタック（PHY〜ATT） |
| **GATT Specification Supplement (GSS)** | 標準CharacteristicのフォーマットとUUID定義 |
| **Assigned Numbers** | UUID、会社ID、広告データタイプの番号割り当て |
| **Bluetooth Profile (各種)** | HRS、CTS、FMPなどプロファイル仕様 |


## Core Specification の構造

Core Specification 5.4 は約3,200ページに及ぶ巨大な文書です。目的に応じて参照するパートを絞ることが重要です。

```
Vol 1: Architecture & Terminology
  ├─ BLEの全体像とレイヤー構成を把握するための概要
  └─ 最初にここを読むと理解が深まる

Vol 2: BR/EDR Controller
  └─ Classic Bluetooth（BR/EDR）の仕様。BLE開発では基本的に不要

Vol 3: Host
  ├─ Part A: Logical Link Control and Adaptation Protocol (L2CAP)
  ├─ Part C: Generic Access Profile (GAP)
  │     → アドバタイズ、接続フロー、セキュリティモードの定義
  ├─ Part F: Attribute Protocol (ATT)
  │     → ATT PDUの詳細（Read Request/Response, Write Command...）
  ├─ Part G: Generic Attribute Profile (GATT)
  │     → Serviceの発見、CharacteristicのR/W、Notifyのフロー
  └─ Part H: Security Manager Protocol (SMP)
        → ペアリング、ボンディング、暗号化の詳細

Vol 4: Controller
  ├─ Part A: Radio Specification
  │     → 2.4GHz帯、-20dBm〜+20dBm、AFH...
  ├─ Part B: Baseband
  └─ Part E: HCI (Host Controller Interface)
        → パケットフォーマット、HCIコマンド一覧

Vol 6: Low Energy Controller
  ├─ Part B: Link Layer Specification
  │     → アドバタイズPDU、接続フロー、チャネル選択アルゴリズム
  └─ Part D: Link Layer Timing
        → Connection Interval、Window Size、Supervision Timeout
```


## よく参照するセクション

### アドバタイズデータの構造を調べたい

1. **Core Spec Vol 3, Part C (GAP)** → Section 11: Advertising and Scan Response Data Format
2. **Assigned Numbers** → Section 2.3: Generic Access Profile / 広告データタイプ一覧

### 独自Serviceを設計したい

1. **GATT Specification Supplement (GSS)** → 標準Characteristicの一覧と使い方
2. **Core Spec Vol 3, Part G (GATT)** → Section 4: GATT Feature Requirements

### 接続パラメータの範囲を確認したい

1. **Core Spec Vol 6, Part B (Link Layer)** → Section 4.5: Connection Setup

```
Connection Interval   : 7.5ms 〜 4000ms (単位: 1.25ms)
Slave Latency        : 0 〜 499 (スキップできるConnection Eventの数)
Supervision Timeout  : 100ms 〜 32000ms (単位: 10ms)
制約: Supervision Timeout > Interval × (1 + Latency) × 2
```

### ATT PDU のフォーマットを確認したい

1. **Core Spec Vol 3, Part F (ATT)** → Section 3: PDU Overview

```
例: ATT Read Request (0x0A)
  Octet 0: Opcode (1 byte) = 0x0A
  Octet 1-2: Attribute Handle (2 bytes)

例: ATT Notification (0x1B)
  Octet 0: Opcode (1 byte) = 0x1B
  Octet 1-2: Attribute Handle (2 bytes)
  Octet 3+: Attribute Value (0〜(ATT_MTU-3) bytes)
```


## GATT Specification Supplement の使い方

GSS には Bluetooth SIG が定義する標準 Characteristic が列挙されています。

```
例: Temperature Characteristic (UUID: 0x2A6E)
  Fields:
    Temperature (sint16, 0.01 °C単位)
  備考: -273.15°C = 0x8000 (Not Available)
```

自分で Characteristic のフォーマットを決める前に、GSS で既定義のものがないか確認しましょう。標準を使うとベンダー非依存で相互運用性が高まります。


## Assigned Numbers の使い方

**Assigned Numbers** には UUID、会社ID（Company Identifier）、広告データタイプなどの数値割り当てが記載されています。

よく調べる内容:

| カテゴリ | 用途 | 例 |
|---|---|---|
| Company Identifiers | メーカー固有広告データのID確認 | Apple = 0x004C |
| Service UUIDs | 標準サービスのUUID確認 | Battery Service = 0x180F |
| Characteristic UUIDs | 標準CharacteristicのUUID | Battery Level = 0x2A19 |
| GAP Data Types | 広告データタイプ番号 | Complete Local Name = 0x09 |

```
Assigned Numbers ダウンロード先:
https://www.bluetooth.com/specifications/assigned-numbers/
（PDFとXML両方あり。XMLはプログラムからの参照に便利）
```


## SDK ドキュメントとの使い分け

```
仕様書を読む場面:
  - 標準外の挙動を実装したいとき（ATT拡張など）
  - SDKのAPIが何を実装しているか原理を確認したいとき
  - プラットフォーム間の相互運用性を確認したいとき

SDKドキュメントを読む場面:
  - 実装の手順（コード例、Kconfigオプション）を調べるとき
  - バグや既知の問題（Limitations）を確認するとき
  - ビルドエラーの原因を調べるとき

まず SDKドキュメントを読み、原理を確認したいときに仕様書を参照する、
という流れが効率的です。
```


## Core Specificationのバージョン間差分の読み方

Core Specificationはバージョンごとに大幅に拡張されています。たとえばリンク層の仕様は、BLE 4.2では約90ページだったものが、5.x系では200ページを超えています。初めて仕様書を開いたときにこの分量に圧倒されるかもしれませんが、BLE 4.0/4.2からの差分を意識すると読みやすくなります。

主なバージョンごとの変更点:

| バージョン | 主な追加/変更 |
|---|---|
| **4.0** | BLE初版。PHY・LL・ATT・GATT・SMP・GAP の基本スタック |
| **4.1** | Slave（ペリフェラル）が複数のMasterに接続可能に。Connection Parameter Update |
| **4.2** | Data Length Extension（ペイロード251バイト）、LE Secure Connections、LE Privacy 1.2 |
| **5.0** | 2M PHY（2Mbps）、LE Coded PHY（Long Range）、Extended Advertising |
| **5.1** | Direction Finding（AoA/AoD：到来角度検知） |
| **5.2** | LE Audio / Isochronous Channels、Power Control、Enhanced ATT |
| **5.3** | Channel Classification Enhancement、Connection Subrating |
| **5.4** | PAwR（Periodic Advertising with Responses）、Encrypted Advertising Data |

実装で特に注意すべきは、**使用するSoC/モジュールが対応しているCore Specバージョン**によって使える機能が異なることです。nRF52840はBluetooth 5.0対応ですが、5.2以降のIsochronous Channelsには対応していません（nRF5340が対応）。SDKが対応していても、チップのコントローラが非対応であれば使えないため、データシートの対応バージョンを必ず確認してください。

<!-- TBD: Core Spec 6.0の変更点が公開されたら追記 -->


**付録B** では本書で参照した公式仕様書・技術書・Webリソースの一覧を掲載しています。
