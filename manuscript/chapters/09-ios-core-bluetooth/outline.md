# 第9章 アウトライン: iOSアプリからBLEデバイスを操作する — Core Bluetooth

## 章の目的

iOSがBluetooth LEを扱うしくみを内部アーキテクチャから理解し、
CBCentralManager を中心としたAPIを使って、スキャン・接続・サービス発見・
読み書き・Notify受信の一連のフローを実装できるようにする。
またバックグラウンドモードの制約と正しい使い方を示す。

## 対象読者の前提

- 第4章（ATT/GATT）を読了済み
- Swift の基本文法を理解している
- nRF52840 側のペリフェラル実装（第6章）が完成していること

## セクション構成

| セクション | タイトル | ページ目安 |
|---|---|---|
| 9.1 | Core Bluetooth フレームワーク概要 | 4-5p |
| 9.2 | CBCentralManager の初期化と状態管理 | 4-5p |
| 9.3 | デバイスのスキャンと発見 | 5-6p |
| 9.4 | サービスとキャラクタリスティクスの発見 | 5-6p |
| 9.5 | Read / Write の実装 | 5-6p |
| 9.6 | Notify の受信 | 4-5p |
| 9.7 | バックグラウンドモードと電力消費 | 4-5p |
| 9.8 | まとめと第10章への橋渡し | 2-3p |

**合計: 33〜41ページ**

## キーコンセプト

- BTServer デーモンと IPC アーキテクチャ
- CBCentralManager / CBPeripheral / CBService / CBCharacteristic
- デリゲートパターン（CBCentralManagerDelegate / CBPeripheralDelegate）
- CBUUID の 16bit 短縮形と 128bit カスタム UUID
- ATT_MTU = 23 バイト（ペイロード 20 バイト）の制約
- Notify vs Indicate の違い、Subscription 管理
- バックグラウンドスキャン周期 12 分制限

## ファイルリスト

- `9.1-framework-overview.md`
- `9.2-centralmanager.md`
- `9.3-scanning.md`
- `9.4-service-discovery.md`
- `9.5-read-write.md`
- `9.6-notify.md`
- `9.7-background.md`
- `9.8-summary.md`
