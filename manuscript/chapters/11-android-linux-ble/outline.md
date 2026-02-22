# 第11章 アウトライン: Android BLEとLinux BLE — 他プラットフォームの実装概要

## 章の目的

iOS（第9章）とWeb（第10章）に続き、AndroidとLinux（Raspberry Pi等）でのBLE
セントラル実装の概要を把握する。各プラットフォームのAPI設計思想の違いと、
同じペリフェラルにアクセスするコードを比較する。

## 対象読者の前提

- 第4章（ATT/GATT）を読了済み
- Javaのコールバックパターンを理解している（Android節）
- Pythonの基本を理解している（Linux節）
- 深い実装ではなく「どう動くかの概要」を学ぶ章

## セクション構成

| セクション | タイトル | ページ目安 |
|---|---|---|
| 11.1 | Android BLE APIの全体構成 | 3-4p |
| 11.2 | スキャンと接続の実装 | 4-5p |
| 11.3 | GATT操作とAndroid固有の問題 | 4-5p |
| 11.4 | Linux BLEとBlueZ | 3-4p |
| 11.5 | Python bleakライブラリ | 3-4p |
| 11.6 | プラットフォーム比較とまとめ | 3-4p |

**合計: 20〜26ページ**

## キーコンセプト

- Android: `BluetoothLeScanner`, `BluetoothGatt`, `BluetoothGattCallback`
- AndroidのBond（ボンディング）問題
- Coroutine/Flow での非同期BLE実装（jetpack）
- Linux: BlueZ, `bluetoothctl`, `hcitool`, `gatttool`
- Python `bleak` ライブラリ（async/await対応のクロスプラットフォームBLEライブラリ）

## ファイルリスト

- `11.1-android-overview.md`
- `11.2-android-scan-connect.md`
- `11.3-android-gatt-issues.md`
- `11.4-linux-bluez.md`
- `11.5-python-bleak.md`
- `11.6-platform-comparison.md`
