# 第5章: nRF52840開発環境 — 詳細アウトライン

**概要**: Nordic Semiconductor nRF52840 + nRF Connect SDK 3.0の開発環境を一から構築し、BLEアドバタイジングを動かすところまでを実走する  
**想定ページ数**: 20〜24ページ  
**前提章**: 第2章  
**ファイル**: `manuscript/chapters/05-nrf52840-setup/`

### 章の構成方針

Part 3「ファームウェア開発編」の入口となる章。このの章では「手を動かして動くものを作る」ことを最優先にし、コンセプトより先にコマンドとコードの実感を持ってもらう。nRF52840 DKというボードを使い、nRF Connect SDKのセットアップからBLEアドバタイジング送信まで一直線に進む。

---

## 節構成

#### 5.1 nRF52840と開発環境の全体像
**ファイル**: `5.1-overview.md`  
**概要**:
- nRF52840を選ぶ理由：Cortex-M4F + BLE 5.3 + USB + 豊富なGPIO。Nordic Semiconductorの立ち位置（第4章のController/Host分業のうちController SoC側）
- nRF Connect SDK 3.0の構成：Zephyr RTOS + Nordic HAL + Bluetooth stack + nRF Connect toolchain
- 開発ツール全体像：VS Code + nRF Connect for VS Code + nRF Connect for Desktop + J-Link/nRF9160 DK
- この章のゴール：SDK install → プロジェクト作成 → BLEアドバタイジング送信

**想定ページ数**: 2〜3ページ

---

#### 5.2 開発環境のセットアップ
**ファイル**: `5.2-sdk-setup.md`  
**概要**:
- 前提ソフトウェア：VS Code / Git / nRF Connect for Desktop
- nRF Connect Toolchain Manager でツールチェーンをインストール（GCC Arm Embedded + CMake + Ninja + west）
- nRF Connect SDK をインストール（nRF Connect for Desktop → Toolchain Manager → Install SDK v3.0）
- `west` コマンドの役割：Zephyrプロジェクトのビルドシステム
- トラブルシューティング：Windowsのパス長制限、macOSのCommand Line Tools不足、proxy環境下のgit

**想定ページ数**: 4〜5ページ

---

#### 5.3 nRF52840 DKのボード接続とデバッガ操作
**ファイル**: `5.3-board-setup.md`  
**概要**:
- nRF52840 DK（PCA10056）のボード構成：SoC本体 / オンボードJ-Link / USBコネクタ / ボタン・LED4系統
- J-Link / nRF Command Line Tools のインストール
- PC接続時の確認：`nrfjprog --ids` でボードが認識されるか
- RTT Logger（リアルタイムのデバッグシリアル出力）の確認方法
- `west flash` と `west debug` の基本操作

**想定ページ数**: 3〜4ページ

---

#### 5.4 最初のプロジェクト——BLEアドバタイジングのHello World
**ファイル**: `5.4-hello-ble.md`  
**概要**:
- `peripheral` サンプルを使ったプロジェクト作成（nRF Connect for VS Code → Create new application from sample）
- `prj.conf` の主要設定（`CONFIG_BT=y` / `CONFIG_BT_PERIPHERAL=y` / `CONFIG_BT_DEVICE_NAME` 等）
- `main.c` のコード読解：`bt_enable()` / `bt_le_adv_start()` の2ステップ
- 広告パケットのペイロード定義：`BT_DATA` マクロで AD Structure を作る
- ビルド・書き込み・動作確認：nRF Connect for Mobile からデバイス名が見えるか

**想定ページ数**: 5〜6ページ

---

#### 5.5 Zephyrのプロジェクト構造とビルドシステム
**ファイル**: `5.5-project-structure.md`  
**概要**:
- nRF Connect SDK プロジェクトの最小構成：`CMakeLists.txt` / `prj.conf` / `src/main.c`
- `prj.conf`（Kconfig）とビルドオプションの仕組み：`CONFIG_*` フラグが実際にどのソースを有効化するか
- `CMakeLists.txt`：ターゲットボードの指定（`-DBOARD=nrf52840dk_nrf52840`）
- ビルド成果物：`build/zephyr/zephyr.hex` / `.elf` の構造
- ロギング（`LOG_INF` / `LOG_ERR`）とRTT経由のシリアル出力

**想定ページ数**: 3〜4ページ

---

#### 5.6 まとめと第6章への橋渡し
**ファイル**: `5.6-summary.md`  
**概要**:
- 本章で構築した開発環境の全体図（ボード↔PC↔SDK↔VS Code）
- 第6章の予告：この章のHello Worldをベースに、カスタムサービスとキャラクタリスティックを実装する

**想定ページ数**: 1〜2ページ

---

**第5章合計**: 18〜24ページ

---

## 主要ソース

| ファイル | 対応節 | 内容 |
|---|---|---|
| `hoge/08_Hardware.re` | 5.1 | SoC選択の考え方、無線モジュール vs SoC一体、電波法認証の概要 |
| `hoge/09_ProtocolStack.re` | 5.1 | Controller/Host分離とSoC内での一体実装 |
