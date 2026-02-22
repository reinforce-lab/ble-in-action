# 第14章 OTA（DFU）実装 アウトライン

## 章の目標
- DFU（Device Firmware Update）の仕組みとBootloaderの役割を理解する
- nRF52840で MCUboot + SUIT ベースのDFUを設定する
- DFUパッケージ（.zip）を作成してiOSから転送する
- よくあるDFUトラブルの原因と解決法を習得する

## 節構成

| 節 | タイトル | 主要トピック |
|---|---|---|
| 14.1 | DFUの仕組みとBootloader | OTA DFUフロー, Bootloaderの役割, イメージスロット |
| 14.2 | MCUbootの設定 | CONFIG_BOOTLOADER_MCUBOOT, パーティションテーブル |
| 14.3 | DFUパッケージの作成 | west sign, nrfutil pkg generate, .zip構成 |
| 14.4 | Nordic DFUプロトコル | DFU OBJECTタイプ, チャンク転送, CRC検証 |
| 14.5 | iOSからのDFU実行 | iOSアプリ, DFU Library, 進捗表示 |
| 14.6 | トラブルシューティング | ブロック更新失敗, MTU設定, リカバリモード |
| 14.7 | まとめ | 本番DFUのベストプラクティス |

## 想定ページ数
30-36ページ（重点解説章）

## 前提章
第5章（nRF52840セットアップ）、第6章（ペリフェラル実装）、第8章（外部チップ連携）、第9章（iOS Core Bluetooth）
