# 第12章 ビーコン実装 アウトライン

## 章の目標
- iBeaconの仕様を理解する
- Android側のFind Hub Networkと、一般のBLEスキャンとの違いを理解する
- nRF52840をBLEビーコンとして動作させるファームウェアを実装する
- iOSアプリでiBeaconを受信して距離推定・イベントトリガーを行う
- Androidアプリでビーコンをスキャンして表示する

## 節構成

| 節 | タイトル | 主要トピック |
|---|---|---|
| 12.1 | ビーコンとは | iBeacon、Find Hub Network、ADV_NONCONN_IND |
| 12.2 | nRF52840 ビーコン実装 | Zephyr BT_LE_ADV_NCONN, ad_data, iBeacon構造体 |
| 12.3 | iOSでのビーコン受信 | CLBeaconRegion, CLLocationManager, ranging, 近接判定 |
| 12.4 | Androidでのビーコン受信 | ScanFilter + ScanRecord, iBeacon解析, AltBeacon |
| 12.5 | まとめ | ユースケース一覧、ビーコン vs 接続型BLEの選択 |

## 想定ページ数
20-24ページ

## 前提章
第6章（ペリフェラル実装）、第9章（iOS Core Bluetooth）
