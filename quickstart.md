# BLEInAction ビルド環境 クイックスタート

**更新日**: 2026-02-22
**ビルド方式**: ローカル pandoc + LuaLaTeX（Docker 不要）

---

## 必要なツール

| ツール | 用途 | インストール |
|--------|------|-------------|
| **Homebrew** | パッケージ管理 | https://brew.sh |
| **pandoc** | Markdown → EPUB / PDF 変換 | `brew install pandoc` |
| **BasicTeX** | LuaLaTeX（PDF 生成） | `brew install --cask basictex` |
| **epubcheck** | EPUB バリデーション（任意） | `brew install epubcheck` |
| **VS Code** | エディタ（推奨） | https://code.visualstudio.com |

---

## セットアップ手順

### 1. pandoc のインストール

```bash
brew install pandoc
pandoc --version   # 3.x を確認
```

### 2. BasicTeX のインストール

```bash
brew install --cask basictex
```

インストール後、**ターミナルを再起動**するか PATH を通す：

```bash
export PATH="/Library/TeX/texbin:$PATH"
```

> **Note**: Makefile には上記の PATH 設定が組み込み済みなので、`make` コマンドでは自動的に認識されます。
> シェルで直接 `lualatex` を使いたい場合は `~/.zshrc` に追加してください。

### 3. LaTeX パッケージのインストール

BasicTeX は最小構成なので、日本語 PDF ビルドに必要なパッケージを追加します：

```bash
# tlmgr 自体を更新
sudo tlmgr update --self

# 日本語組版 + フォント
sudo tlmgr install luatexja haranoaji haranoaji-extra collection-langjapanese

# LuaTeX 関連
sudo tlmgr install collection-luatex

# LaTeX パッケージ（preamble で使用）
sudo tlmgr install framed titlesec tex-gyre
```

### 4. インストール確認

```bash
# pandoc
pandoc --version

# lualatex
/Library/TeX/texbin/lualatex --version

# luatexja パッケージ
kpsewhich luatexja.sty
# → パスが表示されれば OK

# Harano Aji フォント
kpsewhich HaranoAjiMincho-Regular.otf
# → パスが表示されれば OK
```

---

## ビルドコマンド

```bash
# EPUB をビルド
make epub
# → output/epub/BLEInAction.epub

# PDF をビルド（LuaLaTeX）
make pdf
# → output/pdf/BLEInAction.pdf

# EPUB + PDF を両方ビルド
make all

# EPUB をバリデーション（epubcheck 必要）
make validate

# 生成ファイルを削除
make clean

# ヘルプ
make help
```

### VS Code からビルド

`Cmd+Shift+B` でビルドタスクメニューが表示されます：

- **Build EPUB**（デフォルト）
- **Build PDF**
- **Build All (EPUB + PDF)**
- **Validate EPUB**

---

## 原稿の書き方

### 新しい章を追加する

1. `manuscript/chapters/XX-chapter-name/` にマークダウンファイルを作成
2. `manuscript/chapters.txt` にパスを追加：
   ```
   chapters/XX-chapter-name/X.1-section.md
   ```
3. `make epub` または `make pdf` で確認

### 章テンプレート

```markdown
# 第X章 タイトル

## X.1 セクション

日本語テキストに **BLE**、**GATT** などの技術用語を混在。

### コード例（C）

\```c
#include <zephyr/bluetooth/bluetooth.h>
\```

### コード例（Swift）

\```swift
import CoreBluetooth
\```

### 画像

![キャプション](../images/diagrams/diagram.png)

### 表

| 項目 | 説明 |
|------|------|
| BLE  | Bluetooth Low Energy |
```

---

## プロジェクト構成

```
BLEInAction/
├── manuscript/
│   ├── metadata.yml           # 書籍メタデータ
│   ├── chapters.txt           # 章の順序定義
│   ├── preface.md             # まえがき
│   ├── chapters/              # 各章のマークダウン
│   │   ├── 01-what-is-ble/
│   │   ├── 02-ble-basic/
│   │   └── ...
│   ├── back-matter/           # 付録
│   └── images/                # 画像・図版
├── build/
│   ├── config/
│   │   ├── epub.yml           # EPUB 用 pandoc defaults
│   │   └── pdf.yml            # PDF 用 pandoc defaults
│   └── templates/
│       ├── epub-styles.css    # EPUB スタイルシート
│       └── latex-preamble.tex # PDF 用 LaTeX プリアンブル
├── output/                    # 生成物（.gitignore 対象）
│   ├── epub/
│   └── pdf/
├── Makefile                   # ビルドコマンド定義
└── .vscode/
    ├── settings.json
    ├── tasks.json             # ビルドタスク
    └── extensions.json
```

---

## トラブルシューティング

### `lualatex` が見つからない

BasicTeX のパスが通っていません：

```bash
export PATH="/Library/TeX/texbin:$PATH"
# 恒久的に設定するなら:
echo 'export PATH="/Library/TeX/texbin:$PATH"' >> ~/.zshrc
```

### PDF ビルドで `.sty not found`

LaTeX パッケージが不足しています。例：

```bash
# エラーメッセージから不足パッケージ名を確認して:
sudo tlmgr install <package-name>
```

### PDF で絵文字が表示されない

Harano Aji フォントに絵文字グリフが含まれていないため、原稿中の ✅ ❌ などは PDF では表示されません。
原稿では絵文字の代わりにテキスト（「OK」「NG」など）を使ってください。

### EPUB バリデーションエラー

```bash
# epubcheck をインストール
brew install epubcheck

# バリデーション実行
make validate
```

---

## 参考リンク

- [Pandoc User's Guide](https://pandoc.org/MANUAL.html)
- [LuaTeX-ja ドキュメント](https://ctan.org/pkg/luatexja)
- [Harano Aji Fonts](https://github.com/trueroad/HaranoAjiFonts)
- [BasicTeX (TeX Live)](https://www.tug.org/mactex/morepackages.html)
