# Quick Start: Creating the Technical Writing Style Guide

**Feature**: 002-technical-writing-style-guide  
**Audience**: Documentation authors, editors  
**Time to Complete**: 3-4 hours  
**Prerequisites**: Research findings, access to publisher style guides

## Overview

This guide walks through creating a ~300-line technical writing style guide for the BLE In Action book. The style guide will define Japanese grammar conventions, punctuation rules, technical element formatting, and citation standards based on established publisher formats.

## What You'll Create

```
docs/
└── writing-style-guide.md    # Main deliverable (~300 lines)
```

**Deliverable Characteristics**:
- **Format**: Pandoc-flavored Markdown
- **Language**: Japanese with English technical terms
- **Length**: 250-350 lines
- **Sections**: 8 major sections covering grammar, formatting, citations
- **Examples**: Correct/incorrect examples for each major rule
- **Citations**: Working URLs to O'Reilly, Manning, IEEE, ACM style guides

## Step-by-Step Instructions

### Step 1: Create the File Structure (5 minutes)

```bash
# From repository root
mkdir -p docs
touch docs/writing-style-guide.md
```

**Expected result**: Empty style guide file ready for content

### Step 2: Add Header and Introduction (15 minutes)

Create the document header and introduction section:

```markdown
# BLE In Action 執筆スタイルガイド

**バージョン**: 1.0.0  
**最終更新**: 2025-10-21  
**対象**: 本書の著者および編集者

## 1. はじめに

このスタイルガイドは、「BLE In Action」の執筆における文章スタイル、技術用語の扱い、図表・コードの書式、引用方法を定めたものです。

### 1.1 目的

- 章間での表記ゆれを防止し、一貫性を保つ
- 読者にとって理解しやすい文章構成を実現する
- 技術的正確性と可読性を両立させる
- 既存の技術出版の標準に準拠する

### 1.2 参考にした出版社ガイドライン

本ガイドは以下の業界標準を参考にしています:
- [O'Reilly Media Style Guide](https://oreillymedia.github.io/production-resources/styleguide/)
- [Manning Publications Manuscript Guidelines](https://manning.com/manuscript-guidelines)
- [IEEE Editorial Style Manual](https://journals.ieeeauthorcenter.ieee.org/your-role-in-article-production/ieee-editorial-style-manual/)
- 文化庁「公用文作成の考え方」
```

**What this achieves**: Sets expectations, documents authority, provides context

### Step 3: Define Basic Writing Style (60 minutes)

Add Section 2 covering Japanese grammar and punctuation:

```markdown
## 2. 基本的な文章スタイル

### 2.1 文体と敬体

**原則**: 「です・ます」調を使用します。

**正例**:
```
BLEは低消費電力を実現した無線通信規格です。
接続を確立するには、広告をスキャンします。
```

**誤例**:
```
×  BLEは低消費電力を実現した無線通信規格である。（論文調）
×  BLEは低消費電力を実現した無線通信規格だ。（会話調）
```

### 2.2 助詞の使い方（てにおは）

#### は vs が
- **は**: トピックを示す（主題の提示）
- **が**: 主語を強調する、新情報を導入する

**正例**:
```
ペリフェラルデバイスは広告を送信します。（一般的な説明）
広告を送信するのがペリフェラルデバイスです。（強調）
```

[Continue with を、に、で、と usage rules with examples...]

### 2.3 句読点の規則

#### 読点（、）の使い方
- 文節の区切りに使用
- 意味の取り違えを防ぐために挿入

**正例**:
```
BLE機器は、スマートフォンやPCと接続できます。
接続後、データの送受信が可能になります。
```

#### 句点（。）の使い方
- 文末に使用
- コード内や数式内では使用しない

[Continue with quotation marks, parentheses rules...]

### 2.4 引用符とカッコの使い分け

| 記号 | 用途 | 例 |
|------|------|-----|
| 「」 | 日本語の引用 | 仕様書には「広告間隔は20ms以上」と記載されています |
| "" | 英語の引用、技術用語の強調 | "Advertising Interval"パラメータを設定します |
| () | 補足説明、英語正式名称 | BLE (Bluetooth Low Energy) |
| [] | 引用番号、オプション引数 | 詳細は文献[1]を参照 |

```

**What this achieves**: Establishes fundamental writing conventions with clear examples

### Step 4: Add Technical Term Guidelines (40 minutes)

Add Section 3 defining how to handle technical terminology:

```markdown
## 3. 技術用語の扱い

### 3.1 英語技術用語の表記

**原則**: BLE標準化用語は英語のまま使用し、初出時に日本語説明を付加します。

**初出時の書式**:
```markdown
GATT (Generic Attribute Profile、汎用属性プロファイル) は、BLEデバイス間のデータ交換構造を定義します。
```

**2回目以降**:
```markdown
GATTプロファイルには複数のサービスが含まれます。
```

### 3.2 略語の定義

初出時に必ず展開形を示します:

| 略語 | 展開形 | 日本語 | 初出例 |
|------|--------|--------|---------|
| BLE | Bluetooth Low Energy | ブルートゥース・ロー・エナジー | BLE (Bluetooth Low Energy) |
| GATT | Generic Attribute Profile | 汎用属性プロファイル | GATT (Generic Attribute Profile) |
| UUID | Universally Unique Identifier | 汎用一意識別子 | UUID (Universally Unique Identifier) |

[Continue with more terms...]

### 3.3 カタカナ表記

**原則**: 一般的なカタカナ表記に従いますが、技術用語は英語を推奨します。

**例**:
- ペリフェラル（peripheral）
- セントラル（central）
- スキャン（scan）

**技術APIは英語のまま**:
```markdown
`startAdvertising()`メソッドを呼び出します。
```
```

**What this achieves**: Ensures consistent handling of English/Japanese terminology mix

### Step 5: Define Figure and Table Formatting (50 minutes)

Add Section 4 covering visual element formatting:

```markdown
## 4. 図表の挿入

### 4.1 図（Figure）の書式

**Markdown構文**:
```markdown
![図3-1: BLE接続のシーケンス図](images/diagrams/ble-connection-sequence.png){#fig:ble-connection width=80%}
```

**キャプションの書き方**:
- 図番号: 「図{章番号}-{連番}」（例: 図3-1、図3-2）
- 位置: 図の下
- 内容: 簡潔な説明（1-2文）

**正例**:
```markdown
![図2-1: GATTプロファイルの階層構造](images/gatt-hierarchy.png){width=70%}

**図2-1**: GATTプロファイルの階層構造。サービス、キャラクタリスティック、ディスクリプタの関係を示します。
```

**画像ファイルの命名規則**:
- 形式: `kebab-case.png` または `.svg`
- 推奨解像度: 300 DPI（印刷用）
- 推奨形式: PNG（写真）、SVG（図表）

### 4.2 表（Table）の書式

**Markdown構文**:
```markdown
: 表2-1: Bluetooth LEとBluetooth Classicの比較 {#tbl:ble-vs-classic}

| 項目 | Bluetooth LE | Bluetooth Classic |
|------|-------------|-------------------|
| 消費電力 | 低 | 高 |
| データレート | 1 Mbps | 3 Mbps |
```

**キャプションの書き方**:
- 表番号: 「表{章番号}-{連番}」
- 位置: 表の上
- 書式: `: 表X-Y: タイトル {#tbl:label}`

[Continue with cross-reference rules...]

### 4.3 クロスリファレンス

**本文中での参照**:
```markdown
図2-1に示すように、GATTは階層構造を持ちます。
詳細は表3-2を参照してください。
```

**自動参照（Pandoc）**:
```markdown
[@fig:ble-connection]に示すように...
[@tbl:comparison]を参照してください。
```
```

**What this achieves**: Standardizes visual element formatting compatible with build pipeline

### Step 6: Add Code Formatting Guidelines (50 minutes)

Add Section 5 defining code block and inline code formatting:

```markdown
## 5. コードの書式

### 5.1 インラインコード

**用途**: 関数名、変数名、短い式

**書式**: バッククォート（`` ` ``）で囲みます。

**正例**:
```markdown
`startAdvertising()`メソッドを呼び出します。
`GATT_MAX_MTU_SIZE`定数は517バイトです。
```

### 5.2 コードブロック

**基本構文**:
````markdown
```c
void advertising_start(void) {
    uint32_t err_code;
    err_code = sd_ble_gap_adv_start(m_adv_handle, APP_BLE_CONN_CFG_TAG);
    APP_ERROR_CHECK(err_code);
}
```
````

**リストとして番号付き**:
````markdown
リスト3-1: 広告開始関数の実装

```c
void advertising_start(void) {
    // BLE広告の開始
    uint32_t err_code = sd_ble_gap_adv_start(m_adv_handle, APP_BLE_CONN_CFG_TAG);
    APP_ERROR_CHECK(err_code);
}
```
````

### 5.3 言語タグ

**必須**: 構文ハイライトのため言語タグを必ず指定します。

**サポート言語**:
- `c` - C言語（Nordic nRF52など）
- `swift` - Swift（iOS）
- `kotlin` - Kotlin（Android）
- `python` - Python（デスクトップツール）
- `json` - JSON（設定ファイル）
- `bash` - シェルスクリプト

### 5.4 コメントの言語

**原則**: 読者の理解を助けるため、日本語コメントを推奨します。

**正例**:
```c
// BLE接続パラメータの設定
ble_gap_conn_params_t conn_params = {
    .min_conn_interval = MSEC_TO_UNITS(100, UNIT_1_25_MS),  // 最小接続間隔: 100ms
    .max_conn_interval = MSEC_TO_UNITS(200, UNIT_1_25_MS),  // 最大接続間隔: 200ms
};
```

**例外**: 一般的な英語コメントは原文のまま可

```

**What this achieves**: Ensures code examples are formatted consistently with syntax highlighting

### Step 7: Add Equation Formatting (30 minutes)

Add Section 6 defining mathematical notation:

```markdown
## 6. 数式の書式

### 6.1 インライン数式

**用途**: 文中の変数や短い式

**書式**: `$...$`で囲みます。

**正例**:
```markdown
接続インターバル$T_{conn}$は、$N_{interval} \times 1.25\text{ ms}$で計算されます。
```

### 6.2 ディスプレイ数式

**用途**: 重要な式、複数行の式

**書式**: `$$...$$`で囲み、必要に応じてラベルを付けます。

**正例**:
```markdown
BLE接続インターバルは以下の式で計算されます:

$$
T_{connection} = N_{interval} \times 1.25\text{ ms}
$$ {#eq:connection-interval}

ここで、$N_{interval}$は接続イベントカウント（6～3200の整数値）です。
```

### 6.3 変数と記号の命名

**変数名**: イタリック体（LaTeXデフォルト）  
**単位**: 立体（`\text{...}`使用）  
**定数**: 立体（`\mathrm{...}`使用）

**例**:
- $T$ - 時間（変数）
- $\text{ms}$ - ミリ秒（単位）
- $\pi$ - 円周率（定数）

**参考**: [LaTeX数式記号一覧](https://www.ctan.org/tex-archive/info/symbols/comprehensive/)
```

**What this achieves**: Defines mathematical notation compatible with LaTeX/Pandoc

### Step 8: Add Citation Guidelines (30 minutes)

Add Section 7 defining reference and citation format:

```markdown
## 7. 引用と参考文献

### 7.1 本文中の引用

**書式**: 番号による引用`[N]`

**正例**:
```markdown
Bluetooth 5.0仕様書[1]によると、LE 2M PHYは従来の2倍のデータレートを提供します。
複数の研究[2,3,4]で効果が実証されています。
```

### 7.2 参考文献リストの書式

**章末または巻末に配置**:

```markdown
## 参考文献

[1] Bluetooth SIG. "Bluetooth Core Specification Version 5.0" (2016).  
    https://www.bluetooth.com/specifications/specs/core-specification-5-0/  
    Bluetooth 5.0の完全な技術仕様。PHY層の詳細について第6章を参照。

[2] O'Reilly, Tim. "Programming iOS 14" O'Reilly Media (2021).  
    https://www.oreilly.com/library/view/programming-ios-14/9781492092162/  
    iOS CoreBluetoothフレームワークの実装パターン。

[3] Nordic Semiconductor. "nRF52 Series Product Specification v1.4" (2020).  
    https://infocenter.nordicsemi.com/pdf/nRF52832_PS_v1.4.pdf  
    nRF52チップのハードウェア仕様とBLEスタック実装の詳細。
```

**書式要素**:
- **番号**: `[N]`で章内連番
- **著者**: 個人名または組織名
- **タイトル**: 引用符で囲む
- **出版情報**: 出版社と年
- **URL**: 別行に記載（4スペースインデント）
- **要約**: 1文で関連性を説明

### 7.3 長文資料の要約

**原則**: ページ数の多い資料は要約とリンクで済ませます。

**正例**:
```markdown
完全なガイドラインは[IEEE Editorial Style Manual](https://journals.ieeeauthorcenter.ieee.org/)を参照してください。主要なポイント:
- 略語は初出時に定義する
- 方程式は連番を付けて右寄せする  
- 図表は本文中で必ず参照すること
```

**参考**:
- [IEEE Reference Guide (PDF)](https://ieeeauthorcenter.ieee.org/wp-content/uploads/IEEE-Reference-Guide.pdf)
- [Chicago Manual of Style Online](https://www.chicagomanualofstyle.org/)
```

**What this achieves**: Standardizes citation format with URLs and summaries

### Step 9: Add Reference Resources (20 minutes)

Add Section 8 listing external style guides:

```markdown
## 8. 参考資料

### 主要な出版社スタイルガイド

- **O'Reilly Media Style Guide**  
  https://oreillymedia.github.io/production-resources/styleguide/  
  プログラミング書籍のスタイル標準。コードと図表の書式が詳細。

- **Manning Publications Manuscript Guidelines**  
  https://manning.com/manuscript-guidelines  
  技術書の構成とコード例の書き方に関するガイドライン。

- **IEEE Editorial Style Manual**  
  https://journals.ieeeauthorcenter.ieee.org/your-role-in-article-production/ieee-editorial-style-manual/  
  学術論文・技術報告書の標準。数式と参考文献の書式が詳細。

### 日本語技術文書の標準

- **文化庁「公用文作成の考え方」(2021)**  
  https://www.bunka.go.jp/seisaku/bunkashingikai/kokugo/kokugo/kokugo_75/pdf/93476601_01.pdf  
  現代日本語の公文書基準。句読点と用字用語の規則。

- **JIS Z 8301 規格票の様式**  
  日本産業規格における技術文書の標準書式。

### Markdown/LaTeX参考資料

- **Pandoc Manual**  
  https://pandoc.org/MANUAL.html  
  Pandoc Markdownの完全な文法リファレンス。

- **LaTeX Math Symbols**  
  https://www.ctan.org/tex-archive/info/symbols/comprehensive/  
  数式記号の一覧（PDF、約400ページ）。

---

**改訂履歴**:
- v1.0.0 (2025-10-21): 初版作成
```

**What this achieves**: Provides authoritative external references for deeper research

### Step 10: Validate the Style Guide (30 minutes)

Run through the validation checklist:

```bash
# Check line count
wc -l docs/writing-style-guide.md
# Expected: 250-350 lines

# Validate all URLs
# Manual check: click each link in preview

# Count examples
# Manual check: grep for "正例" and "誤例" markers

# Verify coverage
# Manual check: all FR-001 through FR-015 addressed
```

**Validation Checklist**:
- [ ] Length between 250-350 lines (SC-004)
- [ ] At least 95% of major rules have examples (SC-002)
- [ ] All external URLs accessible (SC-003)
- [ ] O'Reilly, Manning, IEEE, ACM cited with URLs (SC-005)
- [ ] Lengthy sources summarized with links (SC-006)
- [ ] Written in Japanese (FR-012)
- [ ] All 15 functional requirements covered (FR-001 to FR-015)

---

## Testing the Style Guide

### Manual Testing

1. **Apply to sample chapter**: Have an author write a test section following the guide
2. **Check consistency**: Verify all style rules are unambiguous
3. **Validate examples**: Ensure examples compile/render correctly
4. **Link checking**: Visit all cited URLs to confirm accessibility

### Review Process

1. **Technical review**: Domain expert validates technical accuracy
2. **Editorial review**: Editor checks clarity and completeness
3. **Author feedback**: Collect feedback from chapter authors

---

## Common Issues and Solutions

| Issue | Solution |
|-------|----------|
| Style guide too long (>350 lines) | Remove redundant examples, consolidate similar rules |
| Missing examples for rule | Add正例/誤例 pair showing correct/incorrect usage |
| Broken URL link | Update to current URL or use web.archive.org |
| Ambiguous guideline | Add specific example demonstrating the rule |
| Conflicting publisher standards | Document which standard takes precedence and why |

---

## Next Steps After Completion

1. **Commit to repository**: `git add docs/writing-style-guide.md && git commit -m "Add technical writing style guide"`
2. **Share with authors**: Notify chapter authors of new style guide
3. **Integrate into workflow**: Reference style guide in manuscript README
4. **Schedule review**: Plan quarterly reviews to update as standards evolve
5. **Apply to existing chapters**: Audit existing content for compliance

---

## Success Criteria Verification

After completing all steps, verify:

✅ **SC-001**: Can find guidance in <30 seconds (test with 3 common questions)  
✅ **SC-002**: 95%+ of rules have examples  
✅ **SC-003**: All URLs work (click-test each one)  
✅ **SC-004**: Length 250-350 lines (run `wc -l`)  
✅ **SC-005**: Major publishers cited with URLs  
✅ **SC-006**: Long sources have summaries + links  
✅ **SC-007**: Two reviewers confirm completeness  
✅ **SC-008**: Author feedback positive (survey after 1 month)  
✅ **SC-009**: Reduced style-related revisions (measure in next editing cycle)

**Estimated completion time**: 3-4 hours for initial draft, plus 1-2 hours for review and refinement.
