# BLE In Action 執筆スタイルガイド

**バージョン**: 1.0.0  
**最終更新**: 2025-10-23  
**対象**: 本書の著者および編集者

## 1. はじめに

このスタイルガイドは、「BLE In Action」の執筆における文章スタイル、技術用語の扱い、図表・コードの書式、引用方法を定めたものです。

### 1.1 目的

- 章間での表記ゆれを防止し、一貫性を保つ
- 読者にとって理解しやすい文章構成を実現する
- 技術的正確性と可読性を両立させる
- 既存の技術出版の標準に準拠する

### 1.2 参考にした出版社ガイドライン

- [O'Reilly Media Style Guide](https://oreillymedia.github.io/production-resources/styleguide/) - プログラミング書籍のスタイル標準
- [Manning Publications Manuscript Guidelines](https://manning.com/manuscript-guidelines) - 技術書の構成とコード例
- [IEEE Editorial Style Manual](https://journals.ieeeauthorcenter.ieee.org/your-role-in-article-production/ieee-editorial-style-manual/) - 学術論文の標準
- [文化庁「公用文作成の考え方」(2021)](https://www.bunka.go.jp/seisaku/bunkashingikai/kokugo/kokugo/kokugo_75/pdf/93476601_01.pdf) - 現代日本語の公文書基準

## 2. 基本的な文章スタイル

### 2.1 文体と敬体

**原則**: 「です・ます」調を使用します。

**正例**:
```
BLEは低消費電力を実現した無線通信規格です。
接続を確立するには、広告をスキャンします。
```

**誤例**:
```
×  BLEは低消費電力を実現した無線通信規格である。（論文調）
×  BLEは低消費電力を実現した無線通信規格だ。（会話調）
```

**理由**: 読者に親しみやすく、かつ専門的な内容を明確に伝えるために、です・ます調が最適です。

### 2.2 助詞の使い方（てにおは）

| 助詞 | 用途 | 例 |
|------|------|-----|
| は | トピック（主題） | ペリフェラルデバイス**は**広告を送信します |
| が | 主語の強調 | 広告を送信するの**が**ペリフェラルデバイスです |
| を | 直接目的語 | 広告**を**スキャンします |
| に | 方向・対象 | ペリフェラル**に**接続します |
| で | 手段・場所 | Bluetooth LE**で**通信します |
| と | 引用・並列 | 「20ms以上」**と**記載されています |

### 2.3 句読点の規則

- **読点（、）**: 文節の区切り、意味の取り違えを防ぐ
  - 正例: `BLE機器は、スマートフォンやPCと接続できます。`
  - 正例: `接続後、データの送受信が可能になります。`
  
- **句点（。）**: 文末に使用（コード内や数式内では不要）
  - 正例: `GATTは、BLEデバイス間のデータ交換構造を定義します。`

### 2.4 引用符とカッコの使い分け

| 記号 | 用途 | 例 |
|------|------|-----|
| 「」 | 日本語の引用、強調 | 仕様書には「広告間隔は20ms以上」と記載されています |
| "" | 英語の引用、技術用語の強調 | "Advertising Interval"パラメータを設定します |
| () | 補足説明、英語正式名称 | BLE (Bluetooth Low Energy) |
| [] | 引用番号、オプション引数 | 詳細は文献[1]を参照 |
| {} | コード内の波カッコ | `{ .min_interval = 100 }` |

**使い分けの原則**:
- 日本語テキストの引用: 「」を使用
- 英語や技術用語の引用: ""を使用
- 正式名称や読み方の補足: ()を使用
- 参考文献の番号: []を使用

## 3. 技術用語の扱い

### 3.1 英語技術用語の表記

**原則**: BLE標準化用語は英語のまま使用し、初出時に日本語説明を付加します。

**初出時の書式**:
```markdown
GATT (Generic Attribute Profile、汎用属性プロファイル) は、BLEデバイス間のデータ交換構造を定義します。
```

**2回目以降**:
```markdown
GATTプロファイルには複数のサービスが含まれます。
GATTサーバーとGATTクライアントの役割があります。
```

**正例**:
```
UUID (Universally Unique Identifier、汎用一意識別子) は、サービスやキャラクタリスティックを識別します。
各Characteristicには固有のUUIDが割り当てられます。
```

### 3.2 略語の定義

初出時に必ず展開形を示します。

| 略語 | 展開形 | 日本語 |
|------|--------|--------|
| BLE | Bluetooth Low Energy | ブルートゥース・ロー・エナジー |
| GATT | Generic Attribute Profile | 汎用属性プロファイル |
| GAP | Generic Access Profile | 汎用アクセスプロファイル |
| UUID | Universally Unique Identifier | 汎用一意識別子 |
| MTU | Maximum Transmission Unit | 最大転送単位 |
| RSSI | Received Signal Strength Indicator | 受信信号強度インジケータ |

**使用例**: `BLE (Bluetooth Low Energy) は、Bluetooth 4.0で導入された低消費電力通信規格です。`

### 3.3 カタカナ表記

**原則**: 一般的なカタカナ表記に従いますが、技術APIは英語を推奨します。

**カタカナ化する用語**:
- ペリフェラル（peripheral）
- セントラル（central）
- スキャン（scan）
- アドバタイジング（advertising）
- ペアリング（pairing）

**英語のまま使用する用語**:
- API名: `startAdvertising()`, `scanForPeripherals()`
- 技術用語: Characteristic, Service, Descriptor
- プロトコル名: GATT, GAP, ATT

**正例**:
```markdown
ペリフェラルデバイスがアドバタイジングを開始します。
`startAdvertising()`メソッドを呼び出します。
Characteristicの値を読み取ります。
```

**誤例**:
```markdown
×  Peripheralデバイスがadvertisingを開始します。（混在）
×  「スタートアドバタイジング」メソッドを呼び出します。（API名のカタカナ化）
```

**技術APIは英語のまま**:
```c
// 正例: 英語API名に日本語コメント
void startAdvertising(void) {
    // 広告を開始
}
```

## 4. コードの書式

### 4.1 インラインコード

`` `バッククォート` ``で囲みます。

**正例**: `startAdvertising()`関数、変数`connectionInterval`、UUIDは`0x180D`

### 4.2 コードブロック

言語名を指定したフェンスドコードブロックを使用:

```c
#include <bluetooth/bluetooth.h>

void start_advertising(void) {
    // 広告パラメータを設定
    adv_params.interval_min = 100;
    bt_le_adv_start(&adv_params);  // 広告を開始
}
```

**サポート言語**: `c`, `python`, `swift`, `bash`

**コメント**:
- C/C++: `//`, `/* */`
- Python: `#`, `""" """`
- Swift: `//`, `/* */`
- 日本語コメント推奨

### 4.3 コマンドライン

シェルコマンドには`bash`を指定:

```bash
# デバイスをスキャン
hcitool lescan

# 接続を確立
gatttool -b AA:BB:CC:DD:EE:FF -I
```

**コマンド出力例**:
```
$ hcitool lescan
LE Scan ...
AA:BB:CC:DD:EE:FF Heart Rate Monitor
```

## 5. 図表の書式

### 5.1 図のキャプション

```markdown
![図1-1: BLEのプロトコルスタック構造](images/ble-protocol-stack.png)

**図1-1: BLEのプロトコルスタック構造**  
BLEは、物理層からアプリケーション層まで複数の階層で構成されます。
```

**形式**: `図{章番号}-{図番号}: タイトル`

### 5.2 表のキャプション

```markdown
**表1-1: 広告パケットのタイプ**

| タイプ | 値 | 説明 |
|--------|-----|------|
| ADV_IND | 0x00 | 接続可能な非指向性広告 |
| ADV_DIRECT_IND | 0x01 | 接続可能な指向性広告 |
```

**ルール**:
- ヘッダー行を必ず含める
- 列の区切りは`|`
- 数値は右揃え、テキストは左揃え

### 5.3 図表の参照

**正例**: `BLEのプロトコルスタックは、図1-1に示すように複数の階層で構成されます。`

## 6. 数式の書式

### 6.1 インライン数式

文中の数式には`$...$`（Pandoc KaTeX記法）:

**正例**: `接続間隔は$T = 1.25 \times N$ミリ秒で計算されます（$N$は7.5〜4000の整数）。`

### 6.2 ディスプレイ数式

独立した数式には`$$...$$`:

```markdown
信号強度と距離の関係:

$$
\text{RSSI} = -10n \log_{10}(d) + A
$$

ここで、$n$は伝播定数、$d$は距離（m）、$A$は1m地点でのRSSI値。
```

### 6.3 単位の表記

数値と単位の間にスペース（例外: %は直接付ける）:

| 正例 | 誤例 |
|------|------|
| 100 ms | 100ms |
| 2.4 GHz | 2.4GHz |
| -20 dBm | -20dBm |
| 95% | 95 % |

## 7. 引用と参考文献

### 7.1 参考文献の引用

本文中は`[番号]`形式:

**正例**: `BLE 5.0では、通信距離が最大4倍に拡張されました[1]。`

### 7.2 参考文献リスト

章末または巻末に引用番号順:

```markdown
## 参考文献

[1] Bluetooth SIG, "Bluetooth Core Specification Version 5.4", December 2023.  
    https://www.bluetooth.com/specifications/specs/core-specification-5-4/

[2] Heydon, R., "Bluetooth Low Energy: The Developer's Handbook", Prentice Hall, 2012.

[3] Apple Inc., "Core Bluetooth Programming Guide", 2023.  
    https://developer.apple.com/library/archive/documentation/NetworkingInternetWeb/Conceptual/CoreBluetooth_concepts/
```

### 7.3 Webリソースの引用

URL、タイトル、アクセス日を記載:

```markdown
[4] Bluetooth SIG, "GATT Specifications", https://www.bluetooth.com/specifications/gatt/  
    （2025年10月23日アクセス）
```

### 7.4 コードの引用元

サンプルコードの出典を明記:

```markdown
次のコードは、Nordic Semiconductor社のnRF52サンプルを参考にしています。

​```c
// 出典: Nordic Semiconductor nRF5 SDK
// https://github.com/NordicSemiconductor/nRF5-SDK
static void advertising_init(void) {
    // 実装
}
​```
```

## 8. チェックリスト

執筆後、以下を確認してください:

**文章スタイル**:
- [ ] です・ます調
- [ ] 助詞が正しい
- [ ] 句読点が適切
- [ ] 引用符とカッコの使い分け

**技術用語**:
- [ ] 初出時に日本語説明
- [ ] 略語の展開形あり
- [ ] カタカナ表記統一
- [ ] API名は英語

**コード**:
- [ ] インラインコードにバッククォート
- [ ] コードブロックに言語名
- [ ] 日本語説明あり

**図表**:
- [ ] すべての図表に番号とキャプション
- [ ] 本文中で参照

**数式**:
- [ ] 適切な記法（$...$または$$...$$）
- [ ] 変数の説明
- [ ] 単位記載（スペース付き）

**引用**:
- [ ] 引用に[番号]
- [ ] 参考文献リスト（引用順）
- [ ] Webリソースにアクセス日
- [ ] コードの出典明記

---

**改訂履歴**:
- 1.0.0 (2025-10-23): 初版リリース
