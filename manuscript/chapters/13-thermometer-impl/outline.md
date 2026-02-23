# 第13章 温度計実装 アウトライン

## 章の目標
- BME280センサーからI2Cで温度・湿度・気圧を取得する
- GATT Notifyで1秒ごとにデータをiOS/Androidに送信する
- iOSアプリ（SwiftUI + Swift Charts）でリアルタイムグラフを表示する
- しきい値設定（Write）と超過アラートの実装

## 節構成

| 節 | タイトル | 主要トピック |
|---|---|---|
| 13.1 | システム構成 | BME280 + nRF52840 + iOS 全体アーキテクチャ |
| 13.2 | ファームウェア: センサー取得 | Zephyr I2C driver, SENSOR_CHAN_AMBIENT_TEMP |
| 13.3 | ファームウェア: GATTサービス | サービス定義, Notify送信, Writeハンドラ |
| 13.4 | iOSアプリ: BLE接続と受信 | CBCentralManager, Notify購読, パース |
| 13.5 | iOSアプリ: リアルタイムグラフ | SwiftUI Charts, データリングバッファ, アニメーション |
| 13.6 | まとめ | 完成システムの動作確認, 拡張アイデア |

## 想定ページ数
22-27ページ

## 前提章
第6章（ペリフェラル実装）、第8章（外部チップ連携）、第9章（iOS Core Bluetooth）
