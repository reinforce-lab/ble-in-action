# 第6章: ペリフェラル実装

## 章の概要

nRF52840上でBLEペリフェラルの全機能を実装する。第5章のHello World（アドバタイジング送信）をベースに、カスタムGATTサービスへの接続・Read/Write/Notify・接続管理を一通り実装することで、実際の製品開発に直結するファームウェアパターンを習得する。

**想定ページ数**: 30-35ページ  
**前提章**: 第4章（ATT/GATT理論）、第5章（nRF52840開発環境）

---

## 節構成

### 6.1 接続可能アドバタイジング（2-3ページ）

- `BT_LE_ADV_CONN` パラメータの意味と `BT_LE_ADV_NCONN` との違い
- アドバタイジング間隔（interval）の設定と消費電力のトレードオフ
- Advertisement Data と Scan Response Data の使い分け
- `bt_le_adv_start()` パラメータ全解説

### 6.2 カスタムサービスの定義（5-6ページ）

- `BT_GATT_SERVICE_DEFINE` マクロでサービスを静的定義する方法
- カスタム128-bit UUIDの生成と `BT_UUID_DECLARE_128` の使い方
- サービス宣言→キャラクタリスティック宣言の構造
- `BT_GATT_CHARACTERISTIC` の引数（UUID/Properties/Permissions/value_cb）

### 6.3 Readキャラクタリスティックの実装（4-5ページ）

- `BT_GATT_PERM_READ` / `BT_GATT_CHRC_READ` の設定
- Read callbackの実装：`ssize_t read_cb(conn, attr, buf, len, offset)`
- `bt_gatt_attr_read()` ヘルパーの活用
- センサー値（温度・バッテリーレベル）を返すサンプル

### 6.4 Writeキャラクタリスティックの実装（4-5ページ）

- `BT_GATT_PERM_WRITE` / `BT_GATT_CHRC_WRITE` の設定
- Write callbackの実装：`ssize_t write_cb(conn, attr, buf, len, offset, flags)`
- フラグの種類（`BT_GATT_WRITE_FLAG_PREPARE` / `BT_GATT_WRITE_FLAG_EXECUTE`）
- LED制御・設定値書き込みのサンプル

### 6.5 Notifyの実装とCCCD管理（6-7ページ）

- `BT_GATT_CHRC_NOTIFY` プロパティの追加
- `BT_GATT_CCC` マクロによるClient Characteristic Configuration Descriptor（CCCD）定義
- `ccc_cfg_changed()` コールバックで通知ON/OFFを検知する
- `bt_gatt_notify()` によるサーバ起点の値送信
- CCCDの状態管理（bonding対応のためのpersistence）

### 6.6 接続管理とコールバック（4-5ページ）

- `bt_conn_cb_register()` による接続・切断コールバックの登録
- `connected()` / `disconnected()` でLED点灯・アドバタイジング再開
- 接続パラメータ（interval / latency / timeout）の取得と変更要求
- 最大接続数の設定（`CONFIG_BT_MAX_CONN`）

### 6.7 まとめと第7章への橋渡し（1-2ページ）

- 完成したペリフェラルの全体構成図
- 実装パターンのまとめ（Read/Write/Notify × Kconfig・GATT定義・コールバック）
- 第7章予告：同じペリフェラルの消費電力を最適化する
