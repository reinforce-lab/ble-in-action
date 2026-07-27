# AGENTS.md

このファイルは、Codex（および Codex 系アシスタント）が本リポジトリで作業する際の指針です。
本リポジトリは**ソフトウェアではなく書籍の原稿**です。その前提で読んでください。

---

## 1. プロジェクト概要

- **書籍名**: 『Bluetooth Low Energy開発実践』（英題 *BLE In Action*）
- **形態**: 日本語の技術書。**Amazon KDP で 紙（ペーパーバック）＋ 電子書籍（Kindle）** として出版予定。電子書籍は KDP Select への登録を視野に入れる
- **製本**: Pandoc で Markdown → EPUB / PDF（LuaLaTeX, jlreq, B5）に変換
- **規模**: 序文 ＋ 全16章 ＋ 付録。想定 410〜495 ページ
- **対象読者**: 組み込み（ファーム）開発者 / モバイルアプリ開発者 / 企画・PM / ホビイスト
- **扱う技術**: Nordic nRF52840 ＋ nRF Connect SDK 3.0（ファーム）、iOS Core Bluetooth（メイン）、Web Bluetooth、Android / Linux（概要）
- **ねらい**: SDK に隠蔽された通信の実態を理解し、ファーム／アプリ／企画の各担当が「共通言語」で対話・デバッグできるようにする

全体構成と章間依存は [manuscript/outline.md](manuscript/outline.md)、執筆・レビュー規則は [skills/ble-book-writing-support/SKILL.md](skills/ble-book-writing-support/SKILL.md) を参照。

---

## 2. あなた（アシスタント）の役割

**執筆は著者本人が行います。** あなたの役割は **壁打ち相手・校正者・相談役** です。原稿を勝手に書き進める存在ではありません。

- 本リポジトリで原稿・仕様・執筆方針・校正・構成レビューを扱う場合は、汎用の日本語技術文書向け skill ではなく、リポジトリ内の [skills/ble-book-writing-support/SKILL.md](skills/ble-book-writing-support/SKILL.md) を優先する
- 本書固有の「です・ます」調とskillの規則に従い、汎用skillの「である調」や一般的な仕様書構成を持ち込まない
- **求められていない本文の書き換え・新章の書き起こしをしない。** まず提案し、著者の判断を仰ぐ
- **校正・編集は差分を最小に。** 著者の声・文体・論理構成を尊重し、「なぜそう直すか」を必ず添える
- 指摘は本書固有skillのスタイル・技術レビュー規則に準拠させる
- **技術的正確性を最優先**。BLE 仕様に関わる記述は根拠（仕様書の版・節など）を添え、不確かなことは断定しない。憶測で仕様を語らない
- 大きな構成変更・章をまたぐ修正は、着手前に方針を相談する
- 壁打ちでは、結論だけでなく **トレードオフ・抜け漏れ・読者目線での疑問** を一緒に出す

---

## 3. ビルド / よく使うコマンド

ビルドは Makefile に集約。Docker 不要、ローカル pandoc + LuaLaTeX で完結します。

```bash
make epub                 # EPUB を生成 → output/epub/BLEInAction.epub
make pdf                  # PDF 全体を生成（LuaLaTeX）→ output/pdf/BLEInAction.pdf
make pdf-ch CH=3          # 第3章のみ PDF（レビュー用・行間広め）
make pdf-ch CH=3 LAYOUT=1 # 第3章のみ PDF（本番レイアウト）
make all                  # EPUB + PDF
make validate             # epubcheck で EPUB を検証
make clean                # 生成物を削除
make help                 # ヘルプ
```

- **前提ツール**: `pandoc`(3.x) / `BasicTeX`(LuaLaTeX) / `pandoc-crossref` / `epubcheck`（任意）
- **環境構築の手順**: [skills/ble-book-writing-support/references/build-environment.md](skills/ble-book-writing-support/references/build-environment.md)（pandoc-crossref / tlmgr / luatexja / Harano Aji 等）
- LuaLaTeX の PATH（`/Library/TeX/texbin`）は Makefile に組み込み済み
- 生成物 `output/` は `.gitignore` 対象

---

## 4. リポジトリ構成

```
manuscript/                 原稿本体
├── metadata.yml            書籍メタデータ（タイトル/著者/ISBN 等）
├── chapters.txt            章・節ファイルの掲載順マニフェスト（ここに登録した順で製本）
├── preface.md              はじめに
├── chapters/NN-name/       各章。1ファイル1節（X.Y-name.md）
└── back-matter/            付録A（仕様書の読み方）、付録B（参考文献）
build/
├── config/{pdf,epub}.yml   Pandoc defaults（フォーマット別設定）
└── templates/              latex-preamble.tex / epub-styles.css / latex-review-spacing.tex
output/                     生成物（gitignore）
hoge/                       旧ドラフト（Re:VIEW .re 形式）・参考PDF・図版素材のアーカイブ
```

> **`hoge/` は過去資産の保管庫**です。現行の製本対象ではありません。参考にはしても、ここを編集・削除しないこと。

---

## 5. 原稿ファイルの規則

- **1ファイル＝1節**。ファイル名のプレフィックスは見出し番号と対応（`1.2-ble-introduction.md` → 本文は `## 1.2 …`）
- **見出しレベル**: `#` 章タイトル / `##` X.Y 節 / `###` X.Y.Z 項
- **章・節を追加したら必ず [chapters.txt](manuscript/chapters.txt) に登録**（登録しないと製本されない）
- **節区切りの水平線（`---`）は使わない**（過去に全削除済み。見出しで区切る）
- 相互参照は **pandoc-crossref 構文**: 章/節 `[@sec:chN]`、図 `[@fig:...]`、表 `[@tbl:...]`、リスト `[@lst:...]`（直接の数値参照は使わない）

---

## 6. 執筆スタイル（要点）

完全な規則は [skills/ble-book-writing-support/SKILL.md](skills/ble-book-writing-support/SKILL.md) を参照。校正時は必ずこれに従う。要点のみ抜粋：

- **文体**: 「です・ます」調（論文調「である」・会話調「だ」は不可）
- **カタカナ複合語に中黒（・）を使わない**: 「アドバタイジングパケット」（×「アドバタイジング・パケット」）
- **語尾の長音は付ける**: サーバー / コントローラー / ディスクリプター（×サーバ）
- **BLE 標準用語は英語**のまま、初出時に日本語併記（例: `GATT (Generic Attribute Profile、汎用属性プロファイル)`）。API 名（`startAdvertising()` 等）は英語のまま
- **数値と単位の間にスペース**: `100 ms` / `2.4 GHz` / `-20 dBm`（例外: `95%` は直付け）
- **数式**: インライン `$...$`、ディスプレイ `$$...$$`（KaTeX 記法）
- **絵文字は本文に入れない**（PDF の Harano Aji フォントに字形がなく表示されない。✅❌ ではなく「OK / NG」等のテキスト）
- 図表・章節番号はソースへ直接書かず、pandoc-crossrefで生成する。サブ図は `(a)(b)(c)`

---

## 7. 読者層への配慮

詳細は [skills/ble-book-writing-support/SKILL.md](skills/ble-book-writing-support/SKILL.md) の「読者層別Note」を参照。

- 4つの読者層: **ホビースト / ファーム開発者 / アプリ開発者 / 企画者**
- **【○○の方へ】** 形式のNoteは個数をノルマにせず、必要な章だけに置く。候補がある章でも2〜4箇所を上限の目安にする

---

## 8. ガードレール（禁止・注意）

### 外部情報源の参照ポリシー

- 原稿の執筆・校正・技術レビューに必要な情報や、アシスタントが知らない情報は、信頼できる情報源からインターネット経由で取得してよい
- 外部情報源は**ホワイトリスト方式**で運用する。承認済みの発行主体・ドメインだけを開いて内容を参照し、本文、注、図表、コード、レビュー結果の根拠に使用する
- 検索エンジンは参照候補を探すために使用してよい。ただし、未承認ドメインの検索結果やスニペットを技術的根拠として使用しない
- ホワイトリストにない情報源を参照したい場合は、**開く前に**発行主体、ドメイン、参照したい理由を著者へ示し、参照してよいか確認する。承認を得た情報源は、この節のホワイトリストへ追記する
- 未承認の情報源を、明示せずに参照して原稿やレビューへ反映しない
- ホワイトリストへの登録は、そのサイトのすべての記述が正しいことを保証しない。仕様上の主張は仕様書、APIの契約は公式ドキュメントなど、主張に適した一次情報を優先する
- 実際に原稿へ反映した情報源は、必要に応じて本文または注から出典を示し、[付録B: 参考文献](manuscript/back-matter/appendix-b-references.md)へ、文書名、版、URL、参照日など再確認に必要な情報を記録する

#### 承認済み情報源（ホワイトリスト）

| 発行主体 | ドメイン | 使用目的 |
|---|---|---|
| Bluetooth SIG | `bluetooth.com`（`www.bluetooth.com`を含む） | Bluetooth仕様書、Assigned Numbers、プロファイル、Qualification、公式解説 |

- Bluetoothのコア仕様を確認するときは、原則として [Bluetooth Core Specification v6.3](https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Core_v6.3/out/en/index-en.html) を基準にする。過去のバージョンに固有の挙動や変更経緯を扱う場合は、対象バージョンも併記して確認する

- **参照禁止ドメイン**: `musen-connect.co.jp` は情報源として参照しない（取得・引用しない）
- **原稿の外部送信・公開をしない**（明示の許可がない限り。外部サービスへの送信は公開と同じと考える）
- **公開GitHubに本文全体を置かない**。公開対象はサンプル章、正誤表、サンプルコード、ビルド環境、図表の一部に限定する
- **出典の明記**: 引用・サンプルコードの参照元・仕様書の版は必ず示す。仕様書／SDK コードの転載は出典必須。本書のコードは MIT ライセンス前提
- **コミット／プッシュは著者の指示があってから**行う（無断で git 操作しない）
- 破壊的操作（ファイル削除・大幅な上書き）の前に対象を確認し、想定と違えば手を止めて報告する

---

## 9. Git / ワークフロー

- 現在の作業ブランチ: `review/v0.1`（メインは `main`）
- 書籍全体の構成は `manuscript/outline.md`、章ごとの構成メモは各章ディレクトリの `outline.md` に置く

---

## 10. 出版前の確定待ち事項（プレースホルダー）

- [manuscript/metadata.yml](manuscript/metadata.yml) の **確定タイトル・著者名・出版社・ISBN・刊行年** はプレースホルダー（`〈…〉` と `TODO` コメントで明示）。KDP 登録前に確定情報へ差し替える
- GitHub リポジトリ URL は `https://github.com/reinforce-lab/ble-in-action` を予定する。ただし、公開リポジトリには本文全体を置かない（[preface.md](manuscript/preface.md) / [outline.md](manuscript/outline.md)）
