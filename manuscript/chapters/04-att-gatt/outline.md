# 第4章: ATT・GATT・プロファイル — 詳細アウトライン

**概要**: 接続の上でデータをどう表現し・どうやり取りするかを学ぶ。ATTコマンドの種類、GATTの4層階層、標準プロファイルの実装パターンまでを積み上げる  
**想定ページ数**: 28〜33ページ  
**前提章**: 第3章  
**ファイル**: `manuscript/chapters/04-att-gatt/`

### 章の構成方針

第3章では「電波から接続確立まで」のコントローラ側を学んだ。この章では接続後のデータのやり取りを担う**ATT（Attribute Protocol）**と**GATT（Generic Attribute Profile）**を扱う。ATTは「どうデータをやり取りするコマンドか」、GATTは「どうデータを構造化するか」の層。第2章で使った Read / Write / Notify / Indicate がATTコマンドとして実際には何を送受信しているかを説明し、サービス・キャラクタリスティック・ディスクリプタの3層構造をATTテーブルの視点で理解する。

ATT/GATT がなぜこの位置にあるかは、**BLE規格が意図した役割分担**に由来する。規格はスタックを**HCI（Host Controller Interface）**で上下に分割し、Controller（RF・リンク層）とHost（L2CAP以上）を別々の実装体として定義した。この境界があるから、半導体ベンダーはRFチップや SoC として Controller 側を製品化でき、OS ベンダー（Apple・Google・Microsoft・Linux BlueZ）は Host スタックをソフトウェアとして独立して実装できる。USB BLE ドングルはまさにその証で、RF 回路を一切持たない既存の PC であっても Controller チップ1個を USB で接続するだけで BLE に対応できる。ATT/GATT はその境界より上——完全にソフトウェア実装の世界——に置かれているため、新しいプロファイルの追加やバグ修正がファームウェアアップデートなしに可能になる。

```
[BLEスタック全体と本章の位置づけ]

  ┌─────────────────────────────────────────┐  ← OSベンダー・アプリ開発者の領域
  │  アプリケーション / プロファイル          │    4.6節（標準プロファイル・設計パターン）
  ├─────────────────────────────────────────┤
  │  GATT（Generic Attribute Profile）       │    4.4〜4.5節（サービス・キャラクタリスティック・ディスクリプタ）
  ├─────────────────────────────────────────┤
  │  ATT（Attribute Protocol）               │    4.2〜4.3節（アトリビュート構造・コマンド種別）
  ├─────────────────────────────────────────┤
  │  L2CAP / SMP / GAP                      │    第3章（GAP）・本章で軽く触れる
  ╠═════════════════════════════════════════╣ ← HCI境界（USB / UART / SPI）
  │  HCI（Host Controller Interface）        │    コマンド・イベント・ACLデータを交換
  ├─────────────────────────────────────────┤
  │  リンク層 / 物理層（RF）                  │    第3章・半導体ベンダーの領域
  └─────────────────────────────────────────┘  ← SoCまたは独立したコントローラチップ

  ※ HCI境界より上がHostスタック（ソフトウェア）、下がController（ハードウェア寄り）
  ※ USB BLEドングルはControllerチップ単体で出荷され、HostはPC/スマートフォンのOSが担う
```


## 節構成

#### 4.1 ATTとGATTの位置づけ——接続の上に乗るデータプロトコル
**ファイル**: `4.1-att-gatt-overview.md`  
**概要**:
- 第3章の接続確立の先：MasterとSlaveがCONNECT\_INDで接続した「その後」がこの章
- ATTとGATTの分離の経緯：クラシックBluetoothでは1層だったモノがBLEで分割された
  - ATT = 通信プロトコル（アドレス＋タグ付き値の読み書きコマンド集）
  - GATT = データ構造の定義（サービス・キャラクタリスティック・ディスクリプタの階層）
- ATTサーバ / ATTクライアントの役割：リンク層のMaster/Slaveとは無関係
- GATTとアプリケーションの分離が「カスタムプロファイルでもBluetooth認証を受けられる」ことを可能にする仕組み
- この章の構成マップ：ATTの構造（4.2節）→ コマンド種別（4.3節）→ GATTの4層（4.4〜4.5節）→ 実装パターン（4.6節）

**コラム：USB ドングルが成立する理由——HCI が切り分けるコントローラとホスト**
- BLE規格の「HCI（Host Controller Interface）」境界の技術的意味：物理層・リンク層（Controller）とL2CAP以上（Host）を完全分離
- HCI の物理伝送路は規格が複数定義している：USB / UART（H4）/ BCSP / 3線UART、いずれも同じHCIコマンド・イベント体系
- これにより生まれた**組織的分業**：
  - 半導体ベンダー（Nordic、Qualcomm、Texas Instruments など）→ Controller チップ・SoCを製品化。RF回路設計とリンク層FWに集中
  - OSベンダー（Apple、Google、Microsoft、Linux BlueZ コミュニティ）→ Hostスタックをソフトウェアとして実装・更新。ハードウェア不問
- **漸進的ハードウェア対応**の実現：既存PCやサーバにRF回路を追加しなくても、USB BLEドングル1個で対応が完結。RF設計の難しさを一段階隔離できる
- ATT/GATTはHostスタック内のピュアソフトウェア層であるため、新しいプロファイル仕様への対応・バグ修正がOSアップデートだけで可能
- 対比：Wi-FiはHCIのような標準化された分割境界を持たないため、ベンダー独自ドライバが必要になる

**想定ページ数**: 3〜4ページ


#### 4.2 アトリビュートの構造——ハンドル・タイプ・バリュー・パーミッション
**ファイル**: `4.2-attribute-structure.md`  
**概要**:
- アトリビュートの4要素の定義と役割：
  - **Handle（ハンドル）**：2バイト（0x0001〜0xFFFF）のアドレス。ATTクライアントがアクセスに使う唯一のキー
  - **Type（タイプ）**：アトリビュートの種別を表す UUID（128ビット）。SIG標準サービス/キャラクタリスティックには16ビット短縮UUIDが割り当てられている。変換ベースUUID：`0000xxxx-0000-1000-8000-00805F9B34FB`
  - **Value（バリュー）**：0〜512バイトの任意データ。エンディアンは上位層（GATT/プロファイル仕様）が決める
  - **Permission（パーミッション）**：Read可/Write可などのアクセス制御。ATTのコマンドから直接は読めない（エラーレスポンスで間接的に知る）
- ATT MTU：
  - デフォルト23バイト（実データ最大 22バイト = MTU - 1）
  - Exchange MTU Request/Responseで拡大可能（BLE 4.2以降、最大512バイト）
  - MTU設定がデータ転送効率に直結する（大きなバリューの読み書き回数を減らせる）
- ロング・アトリビュート：バリューが(MTU-1)オクテットを超える場合、複数トランザクションで分割読み書き

**想定ページ数**: 3〜4ページ


#### 4.3 ATTコマンドの種別——Request/Response/Notify/Indicateの実装
**ファイル**: `4.3-att-commands.md`  
**概要**:
- ATT PDUの4種類の交換パターン（フロー制御の有無が重要）：
  - **Request / Response**：クライアント→サーバ。1対1トランザクション。同時実行は1つのみ。30秒でタイムアウト → 切断
  - **Indication / Confirmation**：サーバ→クライアント。同様のトランザクション。確認応答あり
  - **Command**（Write Without Response相当）：クライアント→サーバ。応答なし・フロー制御なし
  - **Notification**（Notify相当）：サーバ→クライアント。応答なし・フロー制御なし
- Find系リクエスト（GATTサービス探索に使う）：
  - `Find Information Request/Response`：ハンドル範囲を指定してハンドル＋タイプの一覧を取得
  - `Find By Type Value Request/Response`：タイプとバリューを指定した検索（プライマリサービスの検索に使う）
- Read系リクエスト（6種）：
  - `Read`：1ハンドル指定、最大(MTU-1)バイト
  - `Read Multiple`：複数ハンドルを指定して1トランザクションで取得（固定長バリュー向け）
  - `Read Blob`：オフセット指定でロング・アトリビュートを分割読み出し
  - `Read By Type`：タイプを指定してハンドル+バリューの一覧を取得（キャラクタリスティック値の一括読み出しに便利）
  - `Read By Group Type`：グループ型（プライマリサービスなど）の範囲を取得
- Write系リクエスト（5種）：
  - `Write Request/Response`：サーバが確実に処理する書き込み（最大 MTU-3 バイト）
  - `Write Command`：応答なし書き込み。コントロールポイントの操作指示に使う
  - `Prepare Write / Execute Write`：ロング・アトリビュートの信頼性重視の書き込み（キュー経由）
  - `Signed Write Command`：暗号化不使用時の信頼性確認付き書き込み（シグネチャ検証）
- Notification / Indication：
  - `Handle Value Notification`：サーバ→クライアント、応答なし（=Notify）
  - `Handle Value Indication/Confirmation`：応答あり（=Indicate）
  - 第2章の「なぜNotifyにはCCCDへの書き込みが必要か」が、ATTの仕組みとしてここで説明できる

**エピソード：「ATTタイムアウトの30秒ルール」**
- 1トランザクションが30秒タイムアウトすると切断するBLE仕様の実際の動作
- 第2章2.5節で「Notifyが届かない原因」として登場した問題との接続
- ファームウェアの処理に時間がかかる場合の対処法：ロングタスクは別スレッドへ

**想定ページ数**: 5〜6ページ


#### 4.4 GATTの4層階層——Profile・Service・Characteristic・Descriptor
**ファイル**: `4.4-gatt-hierarchy.md`  
**概要**:
- GATTの4層の定義と役割の整理：
  - **Profile（プロファイル）**：サービスの組み合わせによる機器の振る舞い仕様。アプリ層。Bluetooth SIG採択プロファイルとカスタムプロファイルの2種
  - **Service（サービス）**：デバイスの独立した1つの機能単位。キャラクタリスティックの集合。UUIDで識別
    - Primary Service（外部に公開）/ Secondary Service（他サービスから参照される共有定義）
    - Included Service（サービスの継承・拡張の仕組み）
  - **Characteristic（キャラクタリスティック）**：ATTテーブル上の3アトリビュートの組で表現
    - Declaration（Type 0x2803）：Properties + Value Handle + UUID
    - Value：実際のデータ
    - Descriptor（0個以上）：バリューの補足情報
  - **Characteristic Properties（プロパティ）**の8ビットフラグ：Read / Write Without Response / Write / Notify / Indicate / Broadcast / Auth Signed Write / Extended Properties
- ATTテーブルとGATT階層の対応：ハンドル番号の連続配置でサービスとキャラクタリスティックをグループ化する仕組み
- 第2章のGATT図をATTテーブルの行として再解釈する：UUIDとハンドルが1対1で対応していることを示す

**想定ページ数**: 4〜5ページ


#### 4.5 ディスクリプタの種類と実践的使い方
**ファイル**: `4.5-descriptors.md`  
**概要**:
- ディスクリプタのカテゴリ：バリューの補足情報（型・単位）と振る舞い設定（CCCD/SCCD）の2分類
- **CCCD（Client Characteristic Configuration Descriptor、UUID: 0x2902）**：最重要ディスクリプタ
  - 2ビット（bit0: Notification, bit1: Indication）
  - クライアント固有設定：同じサーバに複数クライアントが接続していてもCCCDはクライアントごとに独立
  - **ボンディングなしの場合は接続ごとに0（無効）にリセット**される仕様 → 「再接続したらNotifyが届かなくなった」の原因
  - ボンディングありの場合はCCCDの設定がフラッシュ保存される
- **SCCD（Server Characteristic Configuration Descriptor）**：サーバ側のブロードキャスト設定（broadcast AD typeとの連携）
- **Characteristic User Descriptor**：人間可読の説明文字列。Writable auxiliariesビットで書き込みも可能（自分でラベルを付ける用途）
- **Characteristic Presentation Format**：型（Boolean / uint8 / sint16 / IEEE-754 float ...）+ 指数 + 単位（UUID）+ NamespaceとDescription。汎用クライアントが仕様書なしにデータを表示するための情報
- **Characteristic Aggregation Format**：複数Characteristicを組み合わせた値（例：緯度+経度のペア）の定義

**コラム：CCCDを書き忘れるとNotifyは届かない**
- 第2章2.5節「エピソード：CCCDへの書き込み忘れ」への回答
- ATTレベルで見ると「サーバはCCCDのビットが0なのでNotificationを送信しない」というシンプルな仕様
- SDKのAPIで購読設定を完結しているフレームワークでは意識しにくいが、ロウレベルのATTログを見ると明確

**想定ページ数**: 4〜5ページ


#### 4.6 GATTプロファイルの実装パターン——標準プロファイルとカスタム設計
**ファイル**: `4.6-profiles.md`  
**概要**:
- GATTサービスの探索シーケンスをATTコマンドで追う：
  1. `Read By Group Type`でプライマリサービス一覧を取得
  2. `Find Characteristic`で各サービスのキャラクタリスティック一覧を取得
  3. `Find Information`でディスクリプタ（CCCD等）を検出
  4. Notify設定が必要なキャラクタリスティックのCCCDに `Write Request` で 0x0001 を書き込む
- Bluetooth SIG標準プロファイルの3例（実装の参考として）：

| プロファイル | サービスUUID | 主なキャラクタリスティック |
|---|---|---|
| Device Information | 0x180A | Manufacturer Name (0x2A29), Model Number (0x2A24), Firmware Rev (0x2A26) |
| Battery Service | 0x180F | Battery Level (0x2A19)：0〜100%、Notify可 |
| Heart Rate | 0x180D | Heart Rate Measurement (0x2A37)：フラグ+心拍値、Notify必須 |

- キャラクタリスティック設計の3分類指針（第2章からの再整理）：
  - **外部センサー値**：ReadとNotifyを持つ。主にサーバ側から変化する
  - **デバイス内部状態**：Read専用。クライアントが参照するだけ
  - **コントロールポイント**：Write（またはWrite Without Response）専用。Readは持たない

**エピソード：nRF Connectでサービスを読む**
- スマートフォンの `nRF Connect for Mobile` で実際のBLEデバイスに接続してサービス一覧を見ると、ATTテーブルの中身がGATT階層として表示される
- 「UUID横の▼アイコンをタップするとRead発行、🔔アイコンでCCCD書き込み」——第2章で抽象的に見た操作がATTコマンドであることが一目でわかる
- デバイス情報サービスのManufacturer Nameを読んでみると、ベンダー名が返ってくる

**想定ページ数**: 5〜6ページ


#### 4.7 まとめと第5章への橋渡し
**ファイル**: `4.7-summary.md`  
**概要**:
- 本章で学んだATT/GATTの構造をスタック全体に位置づける（第3章の物理層〜GAPとの接続）
- 重要用語一覧（ATT・GATT関連の主要語を表形式で整理）
- 第5章（nRF52840ファームウェア開発）の予告：この章で学んだGATTテーブルを実際にnRF5 SDKで実装するとどう書くかを学ぶ

**想定ページ数**: 1〜2ページ


**第4章合計**: 24〜31ページ


## 主要ソース（hoge/ 内の既存原稿）

| ファイル | 対応節 | 内容 |
|---|---|---|
| `hoge/06_GATT.re` | 4.1〜4.6 | ATT/GATTの仕様（アトリビュート構造、全コマンド種別、サービス・キャラクタリスティック・全ディスクリプタ、Included Service、懐中電灯の設計例） |
| `hoge/03_BLEOverview.re` | 4.1 | BLEスタック全体像、GATTとアプリケーションの分離の意義 |
| `hoge/09_ProtocolStack.re` | 4.1, 4.4 | L2CAPからGATTまでの積み上げ |
