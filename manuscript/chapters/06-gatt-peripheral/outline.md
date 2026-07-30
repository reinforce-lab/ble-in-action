# 第6章「接続できるGATTペリフェラルを作る」執筆方針

## この章の役割

第4章で整理したGATTインターフェースをZephyrへ実装します。Read、Write、NotifyをAPIごとに並べるだけでなく、状態、設定、コマンド、イベントがファームウェアでどのように異なるかを示します。

## 共通題材

センサー付きライトの最小版を作ります。

- LED State: 現在状態
- Measurement Interval: 設定
- Command Request／Command Response: 処理の依頼と結果
- Device Event: 製品で発生した事実

## 節構成

### 6.0 第4章の仕様を実装へ渡す
### 6.1 接続可能アドバタイジングを開始する
### 6.2 ServiceとCharacteristicを定義する
### 6.3 状態をReadで公開する
### 6.4 設定とCommand RequestをWriteで受け取る
### 6.5 状態、応答、イベントをNotify／Indicateする
### 6.6 接続、切断、CCCDを管理する
### 6.7 GATTインターフェースと実装を照合する

## 既存原稿の扱い

現行の第6章本文を利用できます。第4章で追加したCommand Request／Responseと、ATTの受付結果と製品処理の完了を分ける説明を追加します。
