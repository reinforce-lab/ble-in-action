# 第6章「接続できるGATTペリフェラルを開発する」執筆方針

## この章の役割

第5章で成立させた開発ループを使い、第4章で設計したGATTインターフェースをnRF Connect SDKへ実装します。APIを個別に紹介するのではなく、接続、状態の取得、設定変更、コマンド実行、イベント通知が一つのサンプルとして動くところまで段階的に作ります。

この章では物理センサーをまだ必須にしません。値をソフトウェアで生成できる状態にして、BLE通信部分だけを汎用ツールから確認できるようにします。

## 説明の流れ

```text
第4章のGATTインターフェース仕様
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

### 6.0 GATT仕様から実装を始める
### 6.1 接続可能アドバタイジングを開始する
### 6.2 ServiceとCharacteristicを定義する
### 6.3 現在状態をReadで公開する
### 6.4 設定とCommand RequestをWriteで受け取る
### 6.5 状態、Command Response、イベントをNotify／Indicateする
### 6.6 接続、切断、CCCDを管理する
### 6.7 汎用ツールから一連の操作を確認する
### 6.8 GATT通信の骨格を第7章へ渡す

## 第4章・第7章との境界

- 第4章は、Attribute、Value形式、操作、完了条件を製品の契約として定義します。
- 第6章は、その契約をZephyrのGATT定義とコールバックへ対応づけます。
- 第7章は、実際のセンサー、割り込み、製品内部の状態をこのGATT実装へ接続します。

## 既存原稿の扱い

現行の第6章本文を利用します。Read、Write、Notifyの並列的な説明を、同じサンプルが段階的に完成する説明へ組み直します。ATTの受付結果と製品上の処理完了を分け、Command Request／Responseを実装へ反映します。
