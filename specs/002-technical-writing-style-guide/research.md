# Research: Technical Writing Style Guide

**Feature**: 002-technical-writing-style-guide  
**Date**: 2025-10-21  
**Purpose**: Research established technical publisher style guidelines, Japanese technical writing conventions, and formatting standards for the BLE In Action style guide

## Research Questions

1. What are the standard Japanese grammar and punctuation conventions for technical writing?
2. What style guidelines do major technical publishers (O'Reilly, Manning, IEEE, ACM) provide?
3. How should figures, tables, equations, and code blocks be formatted in technical books?
4. What citation formats are standard for technical documentation?
5. How should technical terms and abbreviations be handled in Japanese technical writing?

---

## 1. Japanese Technical Writing Conventions

### Decision: Use standard academic/technical Japanese with specific formatting rules

**Rationale**: 
- Technical books in Japanese follow academic conventions with some industry-specific adaptations
- Need consistency with existing Japanese technical literature while maintaining readability
- Modern technical writing in Japanese increasingly uses western punctuation for code and technical terms

**Key Conventions Identified**:

1. **Particles (てにおは)**:
   - Use は (wa) for topics, が (ga) for subjects requiring emphasis
   - を (wo) for direct objects, に (ni) for direction/indirect objects
   - で (de) for location/means, と (to) for quotation/accompaniment
   - Reference: [日本語の助詞の使い方](https://www.bunka.go.jp/kokugo_nihongo/)

2. **Punctuation**:
   - Japanese full-width comma (、) and period (。) for Japanese text
   - Western comma (,) and period (.) inside code blocks and technical expressions
   - Quotation marks: 「」for Japanese quotes, "" for English terms
   - Reference: [くぎり符号の使ひ方〔句読法〕（案）](https://www.bunka.go.jp/kokugo_nihongo/sisaku/joho/joho/kijun/sanko/kugiri/)

3. **Tone and Voice**:
   - Use です/ます (desu/masu) form for formal technical writing
   - Prefer active voice: ×「実装される」→ ○「実装します」
   - Avoid excessive honorifics (humble form) in instructional content
   - Use second person sparingly: prefer "開発者は" over "あなたは"

**Alternatives Considered**:
- Casual である (de aru) form - rejected as too informal for professional technical book
- Highly formal academic style - rejected as too distant for practical learning content

**Sources**:
- 文化庁「公用文作成の考え方」(2021) - https://www.bunka.go.jp/seisaku/bunkashingikai/kokugo/kokugo/kokugo_75/pdf/93476601_01.pdf
- 理科系の作文技術 (木下是雄) - Classic Japanese technical writing guide
- JIS X 0208 日本語情報処理 - Character and typography standards

---

## 2. Technical Publisher Style Guidelines

### Decision: Synthesize conventions from O'Reilly, Manning, IEEE with Japanese adaptations

**Rationale**:
- These publishers represent industry standards for technical books
- O'Reilly's style particularly respected for programming books
- IEEE provides academic rigor for protocol specifications
- Need to adapt English-language conventions for Japanese context

**Publisher Guidelines Analyzed**:

#### O'Reilly Media Style Guide
- **URL**: https://oreillymedia.github.io/production-resources/styleguide/
- **Key Conventions**:
  - Code formatting: monospace font, syntax highlighting by language
  - Figure captions: Below figures, numbered sequentially per chapter
  - Code listings: Include language identifier, line numbers for long examples
  - Cross-references: Chapter and section numbers with titles
  
**Relevant Excerpts**:
- "Use sentence case for all headings"
- "Code in text appears in monospace font"
- "Figures are numbered by chapter (e.g., Figure 3-1, Figure 3-2)"

#### Manning Publications Style Guide
- **URL**: https://manning.com/manuscript-guidelines
- **Key Conventions**:
  - Callouts in code: numbered annotations explaining specific lines
  - Sidebars: For deep dives that don't interrupt main flow
  - Note/Warning/Tip boxes: Formatted consistently with icons
  - Running code: Emphasis on complete, executable examples

**Relevant Excerpts**:
- "All code samples must compile and run successfully"
- "Use callouts to explain important lines without breaking flow"

#### IEEE Editorial Style Manual
- **URL**: https://journals.ieeeauthorcenter.ieee.org/your-role-in-article-production/ieee-editorial-style-manual/
- **Key Conventions**:
  - Equations: Centered, numbered on right margin in parentheses
  - Tables: Caption above table, numbered by section
  - Abbreviations: Define on first use, maintain consistency
  - References: Numbered citation style with bibliography

**Relevant Excerpts**:
- "Equations should be numbered consecutively, e.g., (1), (2)"
- "Define all symbols and abbreviations the first time they appear"
- "Table captions appear above the table"

#### ACM Publications Guidelines
- **URL**: https://www.acm.org/publications/authors/reference-formatting
- **Key Conventions**:
  - Citation format: Author-year or numbered references
  - Code blocks: Language-specific formatting with clear delineation
  - Algorithms: Pseudocode format for clarity

**Relevant Excerpts**:
- "Use consistent formatting for code throughout the manuscript"

**Synthesis for BLE In Action**:
- Figures: Below, numbered per chapter (O'Reilly convention)
- Tables: Above, numbered per chapter (IEEE convention)
- Code: Language-tagged, syntax highlighted, complete examples (Manning emphasis)
- Equations: Centered, numbered on right (IEEE convention)
- Citations: Numbered with URLs for web resources

**Alternatives Considered**:
- Figure captions above - rejected for consistency with programming books
- Unnumbered sections - rejected for ease of cross-referencing
- Author-year citations - rejected as less compact for technical references

---

## 3. Formatting Standards for Technical Elements

### Decision: Pandoc Markdown with LaTeX extensions for equations

**Rationale**:
- Existing build pipeline (001-markdown-build-pipeline) uses Pandoc
- LaTeX provides professional-quality equation typesetting
- Markdown keeps source readable and maintainable
- Syntax highlighting supported natively by Pandoc

**Format Specifications**:

#### Figures
```markdown
![図3-1: BLE接続のシーケンス図](images/ble-connection-sequence.png){#fig:ble-connection width=80%}

**図3-1**: BLE接続のシーケンス図。セントラルデバイスとペリフェラルデバイス間の接続確立手順を示します。
```

**Conventions**:
- File naming: `kebab-case.png` or `kebab-case.svg`
- Resolution: 300 DPI for raster images, SVG preferred for diagrams
- Width: 60-80% of text width for readability
- Caption: Below image, includes figure number and description

#### Tables
```markdown
: 表2-1: Bluetooth LEとBluetooth Classicの比較 {#tbl:ble-vs-classic}

| 項目 | Bluetooth LE | Bluetooth Classic |
|------|-------------|-------------------|
| 消費電力 | 低 | 高 |
| データレート | 1 Mbps | 3 Mbps |
| 距離 | 50-100m | 10-30m |
```

**Conventions**:
- Caption: Above table (Pandoc syntax with `: ` prefix)
- Headers: Bold by default in Pandoc markdown
- Alignment: Left-align text, right-align numbers
- Cell format: Use full-width characters for Japanese, half-width for numbers/code

#### Equations
```markdown
BLE接続インターバルは以下の式で計算されます:

$$
T_{connection} = N_{interval} \times 1.25\text{ ms}
$$ {#eq:connection-interval}

ここで、$N_{interval}$は接続イベントカウント（6～3200の整数値）です。
```

**Conventions**:
- Block equations: `$$...$$` with optional label `{#eq:label}`
- Inline equations: `$...$` for variables in text
- Numbering: Automatic via Pandoc with `--number-sections`
- Symbols: Use LaTeX commands, define custom macros if needed

#### Code Blocks
```markdown
リスト3-1: ペリフェラルの広告開始

```c
// Nordic nRF52 SDK example
void advertising_start(void) {
    uint32_t err_code;
    
    err_code = sd_ble_gap_adv_start(m_adv_handle, APP_BLE_CONN_CFG_TAG);
    APP_ERROR_CHECK(err_code);
    
    NRF_LOG_INFO("Advertising started.");
}
``` ``` (remove space before last ```)

**Conventions**:
- Language tag: Required for syntax highlighting (c, swift, kotlin, python, etc.)
- Line numbers: Enable for code >10 lines via Pandoc options
- Caption: Above code block with "リスト" prefix
- Comments: Translate to Japanese or keep English technical comments as-is
- Width: Keep lines <80 characters when possible

**Configuration in build pipeline**:
```yaml
# pdf.yml additions needed
listings: true
highlight-style: tango
number-sections: true
```

**Sources**:
- Pandoc Manual: https://pandoc.org/MANUAL.html#extension-fenced_code_attributes
- LaTeX Math Symbols: https://www.ctan.org/tex-archive/info/symbols/comprehensive/
- Mermaid for diagrams: https://mermaid.js.org/ (optional, for flowcharts)

**Alternatives Considered**:
- reStructuredText - rejected as less widely supported than Markdown
- AsciiDoc - rejected as Pandoc Markdown already in use
- Inline SVG - rejected as harder to maintain than image files

---

## 4. Citation and Reference Formats

### Decision: Numbered references with URLs for online sources

**Rationale**:
- Numbered citations are compact and don't disrupt reading flow
- URLs essential for accessing online technical documentation
- Hybrid format accommodates both traditional books and web resources
- Consistent with IEEE style adapted for technical books

**Citation Format**:

#### In-Text Citations
```markdown
Bluetooth 5.0仕様書によると[1]、LE 2M PHYは従来の1Mbpsの2倍のデータレートを提供します。
```

#### Bibliography Entry Format
```markdown
## 参考文献

[1] Bluetooth SIG. "Bluetooth Core Specification Version 5.0" (2016). 
    https://www.bluetooth.com/specifications/specs/core-specification-5-0/
    - Bluetooth 5.0の完全な技術仕様。PHY層の詳細について第6章を参照。

[2] O'Reilly, Tim. "Programming iOS 14" O'Reilly Media (2021).
    https://www.oreilly.com/library/view/programming-ios-14/9781492092162/
    - iOS CoreBluetoothフレームワークの実装パターン。

[3] Nordic Semiconductor. "nRF52 Series Product Specification v1.4" (2020).
    https://infocenter.nordicsemi.com/pdf/nRF52832_PS_v1.4.pdf
    - nRF52チップのハードウェア仕様とBLEスタック実装の詳細。
```

**Convention Details**:
- **Format**: `[N] Author. "Title" Publisher/Source (Year). URL`
- **URL**: Full URL on new line with 4-space indent
- **Summary**: Brief (1 sentence) description of relevance with hyphen prefix
- **Online-only**: Omit publisher if web-native resource
- **Access date**: Not required for stable specifications (include for wikis/blogs)

#### Short-form References (For Style Guide Itself)
For lengthy standards documents, provide summary:

```markdown
完全なガイドラインは[IEEE Editorial Style Manual](https://journals.ieeeauthorcenter.ieee.org/your-role-in-article-production/ieee-editorial-style-manual/)を参照してください。主要なポイント:
- 略語は初出時に定義
- 方程式は連番を付けて右寄せ
- 図表は本文中で必ず参照すること
```

**Sources**:
- IEEE Reference Guide: https://ieeeauthorcenter.ieee.org/wp-content/uploads/IEEE-Reference-Guide.pdf
- Chicago Manual of Style (Online) - https://www.chicagomanualofstyle.org/
- APA 7th Edition - https://apastyle.apa.org/ (reference format)

**Alternatives Considered**:
- Author-year (Harvard) style - rejected as takes more space inline
- Footnotes for URLs - rejected as breaks reading flow more than numbered refs
- No summaries - rejected as cited documents are often lengthy

---

## 5. Technical Term Handling

### Decision: Keep English technical terms in原語, provide Japanese読み仮名 on first use

**Rationale**:
- BLE terminology is standardized in English (GATT, UUID, Characteristic, etc.)
- Japanese transliterations can be ambiguous or awkward
- Industry practice is to use English terms with Japanese explanations
- Acronyms are widely understood in original form

**Term Handling Rules**:

#### First Use Pattern
```markdown
BLE (Bluetooth Low Energy、ブルートゥース・ロー・エナジー) は低消費電力を実現した無線通信規格です。

GATT (Generic Attribute Profile) は、BLEデバイス間のデータ交換構造を定義します。
```

**Format**: `English (Japanese translation、読み仮名)`
- Acronym expanded in English with Japanese reading
- Full term in parentheses on first use only
- Subsequent uses: English acronym alone

#### Subsequent Uses
```markdown
GATTプロファイルには複数のサービスが含まれます...
```

**Format**: English acronym + Japanese particle (は、を、に, etc.)

#### English Terms in Text
```markdown
Characteristicの値を読み取るには、`read()`メソッドを使用します。
```

**Conventions**:
- Technical API terms: Keep English, use monospace font
- Common concepts: Use English acronym with Japanese explanation
- Code identifiers: Always English (camelCase, snake_case as per language)

#### Abbreviation Table (First Chapter)
Create a reference table for quick lookup:

```markdown
## 用語集

| 略語 | 英語正式名称 | 日本語 | 説明 |
|------|------------|--------|------|
| BLE | Bluetooth Low Energy | ブルートゥース・ロー・エナジー | 低消費電力無線通信規格 |
| GATT | Generic Attribute Profile | 汎用属性プロファイル | データ構造定義 |
| UUID | Universally Unique Identifier | 汎用一意識別子 | サービス/特性の識別子 |
```

**Romanization Rules**:
- Use standard Hepburn romanization for Japanese terms appearing in code
- Example: `onsen_sensor` not `onsenn_sensor`
- Keep technical terms in English even when Japanese equivalent exists

**Mixed-Language Code Comments**:
```c
// BLE接続パラメータの設定
ble_gap_conn_params_t conn_params = {
    .min_conn_interval = MSEC_TO_UNITS(100, UNIT_1_25_MS),  // 最小接続間隔
    .max_conn_interval = MSEC_TO_UNITS(200, UNIT_1_25_MS),  // 最大接続間隔
    .slave_latency     = 0,                                  // スレーブレイテンシ
    .conn_sup_timeout  = MSEC_TO_UNITS(4000, UNIT_10_MS)    // 接続監視タイムアウト
};
```

**Convention**: English code with Japanese comments, or minimal English comments if code is self-explanatory

**Sources**:
- Bluetooth SIG Trademark Guidelines: https://www.bluetooth.com/develop-with-bluetooth/build/brand-guide/
- JIS Z 8301 規格票の様式 (Standard forms for Japanese technical docs)
- Apple Developer Documentation (Japanese): https://developer.apple.com/jp/documentation/ (example of term handling)

**Alternatives Considered**:
- Full Japanese translation of technical terms - rejected as non-standard and confusing
- English-only - rejected as inaccessible for some readers
- Romanized technical terms - rejected as loses precision

---

## Implementation Notes

### Style Guide Structure (Recommended Outline)

Based on research, the 300-line style guide should follow this structure:

```markdown
# BLE In Action 執筆スタイルガイド

## 1. はじめに (20 lines)
- このガイドの目的
- 対象読者（著者・編集者）
- バージョン管理

## 2. 基本的な文章スタイル (60 lines)
- 2.1 文体と敬体（です・ます調）
- 2.2 助詞の使い方（てにおは）
- 2.3 句読点の規則
- 2.4 引用符とカッコの使い分け

## 3. 技術用語の扱い (40 lines)
- 3.1 英語技術用語の表記
- 3.2 略語の定義と初出ルール
- 3.3 カタカナ表記のガイドライン

## 4. 図表の挿入 (50 lines)
- 4.1 図（Figure）の書式
- 4.2 表（Table）の書式
- 4.3 キャプションのスタイル
- 4.4 クロスリファレンス

## 5. コードの書式 (50 lines)
- 5.1 インラインコード
- 5.2 コードブロック
- 5.3 構文ハイライト
- 5.4 コメントの言語選択

## 6. 数式の書式 (30 lines)
- 6.1 インライン数式
- 6.2 ディスプレイ数式
- 6.3 変数と記号の命名

## 7. 引用と参考文献 (30 lines)
- 7.1 本文中の引用
- 7.2 参考文献リストの書式
- 7.3 URLの記載方法

## 8. 参考資料 (20 lines)
- 主要な出版社スタイルガイドへのリンク
- 追加リソース
```

### Validation Checklist

To verify the style guide meets success criteria:

- [ ] Length: 250-350 lines (SC-004)
- [ ] Examples: 95% of rules have examples (SC-002)
- [ ] Citations: All external URLs accessible (SC-003)
- [ ] Publishers: O'Reilly, Manning, IEEE, ACM referenced with URLs (SC-005)
- [ ] Summaries: Multi-page sources have 1-3 sentence summaries (SC-006)
- [ ] Language: Written in Japanese (FR-012)
- [ ] Coverage: All 15 functional requirements addressed

### Next Steps for Implementation Phase

1. Create `docs/writing-style-guide.md` using research findings
2. Organize content following recommended structure
3. Add examples for each major rule (正例/誤例 format)
4. Validate all external URLs are accessible
5. Review against functional requirements FR-001 through FR-015
6. Measure length and adjust if needed (250-350 line target)

---

## Research Summary

**Key Decisions Made**:
1. ✅ Japanese conventions: です・ます form, full-width punctuation for Japanese text
2. ✅ Publisher synthesis: O'Reilly + IEEE hybrid approach for technical books
3. ✅ Format standards: Pandoc Markdown with LaTeX equations
4. ✅ Citations: Numbered references with URLs and summaries
5. ✅ Technical terms: English acronyms with Japanese explanations on first use

**All NEEDS CLARIFICATION items resolved**: Ready to proceed to Phase 1 design artifacts.
