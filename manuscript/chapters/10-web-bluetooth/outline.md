# 第10章 アウトライン: ブラウザからBLEデバイスを操作する — Web Bluetooth API

## 章の目的

Web Bluetooth APIを使ってWebブラウザから直接BLEデバイスと通信する方法を解説する。
Webアプリからnative appなしにBLEデバイスをコントロールできる仕組みと、
そのセキュリティモデル・制約・実用的なユースケースを理解する。

## 対象読者の前提

- 第4章（ATT/GATT）を読了済み
- JavaScriptのPromise / async/awaitを理解している
- 第6章のnRF52840ペリフェラル（同じカスタムサービス）を使う

## セクション構成

| セクション | タイトル | ページ目安 |
|---|---|---|
| 10.1 | Web Bluetooth API概要とブラウザサポート | 4-5p |
| 10.2 | デバイス選択: requestDevice() | 4-5p |
| 10.3 | 接続とGATT探索 | 4-5p |
| 10.4 | Read / Write の実装 | 4-5p |
| 10.5 | Notifyのサブスクリプション | 3-4p |
| 10.6 | 制約と実用ユースケース、まとめ | 4-5p |

**合計: 23〜29ページ**

## キーコンセプト

- User Gesture ガード（ユーザー操作なしに requestDevice 不可）
- HTTPS必須（localhost は例外）
- Promiseチェーン / async-await パターン
- デバイス選択UIはOSシステムダイアログ（アプリ側でカスタマイズ不可）
- ブラウザサポート: Chrome/Edge OK / Safari ✗ / iOS Chrome ✗
- Core Bluetooth（第9章）との概念対応関係

## ファイルリスト

- `10.1-overview.md`
- `10.2-request-device.md`
- `10.3-connect-gatt.md`
- `10.4-read-write.md`
- `10.5-notify.md`
- `10.6-limitations-summary.md`
