# 第6章「nRF52でBLEデバイスを開発する」執筆方針

## この章の役割

第5章で選んだBLE内蔵マイコンの1チップ構成を、nRF52840とnRF Connect SDK 3.0で具体化します。開発環境が動くことをログで確認し、非接続アドバタイジング、接続、GATT Service、Read、Write、Notifyへ段階的に進みます。

APIを並列に紹介するのではなく、一つのプロジェクトで観測できる範囲を増やします。問題が起きたときに、ビルド、書き込み、実行、無線送信、接続、ATT／GATT操作のどの段階で止まったかを分けられる構成にします。

物理センサーはまだ必須にしません。値をソフトウェアで生成し、BLE通信部分だけを汎用ツールから確認できるようにします。

## 説明の流れ

```text
nRF52840 DKでHello World
    ↓
非接続アドバタイジング
    ↓
接続可能アドバタイジング
    ↓
ServiceとCharacteristic
    ↓
状態のRead
    ↓
設定とコマンドのWrite
    ↓
状態、応答、イベントのNotify／Indicate
    ↓
接続とCCCDの管理
    ↓
汎用ツールによる確認
```

## 共通サンプル

- LED State: 現在状態
- Measurement Value: 測定値
- Measurement Interval: 設定
- Command Request／Command Response: 処理の依頼と結果
- Device Event: 製品で発生した事実

## 節構成

### 6.0 nRF52での具体的な開発を始める
### 6.1 nRF52840でHello Worldを動かす
### 6.2 最初のアドバタイジングを観測する
### 6.3 接続可能アドバタイジングを開始する
### 6.4 ServiceとCharacteristicを定義する
### 6.5 状態と設定をReadで公開する
### 6.6 設定とCommand RequestをWriteで受け取る
### 6.7 状態、Command Response、イベントをNotifyし、Indicateとの違いを整理する
### 6.8 接続、切断、CCCDを管理する
### 6.9 GATT通信の骨格を第7章へ渡す

## 第5章・第7章との境界

- 第5章は、製品構成、開発境界、認証、MCU選定、開発環境の仕組みを扱います。
- 第6章は、選んだnRF52840上で開発ループを成立させ、GATT通信の骨格を実装します。
- 第7章は、実際のセンサー、割り込み、製品内部の状態をGATT実装へ接続します。

## 既存原稿の扱い

第5章にあったHello Worldと最初のアドバタイジングを、本章の入口として移動します。従来の第6章本文は、その後に接続可能アドバタイジングとGATT実装を続ける素材として利用します。

本文を整えるときは、既存のRead、Write、Notifyの個別説明を、同じサンプルが段階的に完成する流れへ組み直します。ATTの受付結果と製品上の処理完了を分け、Command Request／Responseを実装へ反映します。
