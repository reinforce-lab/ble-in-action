# 第12章 ビーコン実装 アウトライン

## 章の目標
- iBeacon / Eddystoneの仕様を理解する
- nRF52840をBLEビーコンとして動作させるファームウェアを実装する
- iOSアプリでiBeaconを受信して距離推定・イベントトリガーを行う
- Androidアプリでビーコンをスキャンして表示する

## 節構成

| 節 | タイトル | 主要トピック |
|---|---|---|
| 12.1 | ビーコンとは | iBeacon / Eddystone の仕様、ADV_NONNDコネクタブル広告 |
| 12.2 | nRF52840 ビーコン実装 | Zephyr BT_LE_ADV_NCONN, ad_data, iBeacon構造体 |
| 12.3 | iOSでのビーコン受信 | CLBeaconRegion, CLLocationManager, ranging, 近接判定 |
| 12.4 | Androidでのビーコン受信 | ScanFilter + ScanRecord, iBeacon解析, AltBeacon |
| 12.5 | Eddystone-URL | Eddystone フレーム形式, Chrome Physical Web |
| 12.6 | まとめ | ユースケース一覧、ビーコン vs 接続型BLEの選択 |

## 想定ページ数
20-24ページ

## 前提章
第6章（ペリフェラル実装）、第9章（iOS Core Bluetooth）
