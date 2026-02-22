# 第15章 パケットキャプチャとデバッグ アウトライン

## 章の目標
- nRF Sniffer + Wireshark でBLEパケットをキャプチャ・解析できる
- GATT通信の流れをパケットレベルで理解する
- iOS / Android の各種ログを使ってデバッグできる
- 接続失敗・データ送信失敗を実例で診断・解決できる

## 節構成

| 節 | タイトル | 主要トピック |
|---|---|---|
| 15.1 | デバッグツール概要 | nRF Sniffer, Wireshark, iOS BLE Logger, Android HCI Snoop |
| 15.2 | nRF Sniffer のセットアップ | ファームウェア書き込み, Wireshark plugin, キャプチャ開始 |
| 15.3 | Wireshark でのパケット解析 | 広告パケット解析, GATT接続フロー, ATT PDU読み方 |
| 15.4 | iOS デバッグ手法 | PacketLogger, Core Bluetoothログ, Xcode デバッグ出力 |
| 15.5 | Android HCI Snoop ログ | HCI snoop 有効化, btsnoop_hci.log, Wiresharkで解析 |
| 15.6 | 実例デバッグ | 接続失敗ケース, Notify届かないケース, DFU失敗ケース |

## 想定ページ数
25-30ページ

## 前提章
第3章（BLE概要）、第4章（リンク層）
