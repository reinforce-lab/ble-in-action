# BLEInAction ビルド環境構築

**更新日**: 2026-06-20
**対象環境**: macOS
**ビルド方式**: ローカル pandoc + LuaLaTeX（Docker 不要）

この文書は、本書の EPUB / PDF をローカルで生成するための環境構築手順です。
原稿の書き方は [writing-style-guide.md](writing-style-guide.md)、執筆理念は [book-constitution.md](book-constitution.md) を参照してください。

---

## 必要なツール

| ツール | 用途 | インストール例 |
|--------|------|----------------|
| Homebrew | パッケージ管理 | https://brew.sh |
| pandoc 3.x | Markdown から EPUB / PDF へ変換 | `brew install pandoc` |
| pandoc-crossref | 図表・章節の相互参照 | `brew install pandoc-crossref` |
| BasicTeX | LuaLaTeX による PDF 生成 | `brew install --cask basictex` |
| epubcheck | EPUB バリデーション（任意） | `brew install epubcheck` |
| VS Code | エディタ（任意） | https://code.visualstudio.com |

---

## セットアップ手順

### 1. pandoc と pandoc-crossref をインストールする

```bash
brew install pandoc pandoc-crossref
```

インストール後、バージョンを確認します。

```bash
pandoc --version
pandoc-crossref --version
```

`pandoc` は 3.x 系を前提にしています。

### 2. BasicTeX をインストールする

```bash
brew install --cask basictex
```

インストール後、ターミナルを再起動するか、現在のシェルに TeX の PATH を追加します。

```bash
export PATH="/Library/TeX/texbin:$PATH"
```

`Makefile` にはこの PATH 設定を組み込み済みです。`make pdf` や `make pdf-ch` から実行する場合は、通常は追加設定なしで `lualatex` を認識します。
シェルから `lualatex` や `tlmgr` を直接使う場合は、必要に応じて `~/.zshrc` に追加してください。

### 3. 日本語 PDF 用の LaTeX パッケージを追加する

BasicTeX は最小構成なので、日本語組版と本書の LaTeX テンプレートで使うパッケージを追加します。

```bash
sudo tlmgr update --self
sudo tlmgr install luatexja haranoaji haranoaji-extra collection-langjapanese
sudo tlmgr install collection-luatex
sudo tlmgr install framed titlesec tex-gyre
```

TeX Live の年次更新直後など、`tlmgr` がローカル環境とリモートリポジトリの世代差で失敗することがあります。その場合は BasicTeX の更新、または MacTeX / BasicTeX の再インストールを検討してください。

### 4. インストール結果を確認する

```bash
pandoc --version
pandoc-crossref --version
/Library/TeX/texbin/lualatex --version
kpsewhich luatexja.sty
kpsewhich HaranoAjiMincho-Regular.otf
```

`kpsewhich` がファイルパスを表示すれば、対象パッケージまたはフォントを TeX が認識しています。

---

## ビルド確認

最初は EPUB、次に PDF の順で確認します。

```bash
make epub
make pdf
```

成果物は次に出力されます。

```text
output/epub/BLEInAction.epub
output/pdf/BLEInAction.pdf
```

章単位で PDF を確認する場合は、次の形式を使います。

```bash
make pdf-ch CH=3
make pdf-ch CH=3 LAYOUT=1
```

`LAYOUT=1` を指定しない場合は、レビュー用の行間広めレイアウトになります。

EPUB を検証する場合は、`epubcheck` をインストールしたうえで次を実行します。

```bash
make validate
```

---

## トラブルシューティング

### `pandoc-crossref` が見つからない

`pandoc-crossref` は pandoc のフィルターとして使います。未インストールの場合、図表や章節の相互参照処理で失敗します。

```bash
brew install pandoc-crossref
pandoc-crossref --version
```

### `lualatex` が見つからない

TeX の PATH を確認します。

```bash
export PATH="/Library/TeX/texbin:$PATH"
/Library/TeX/texbin/lualatex --version
```

`make pdf` から実行しても見つからない場合は、BasicTeX のインストール状態を確認してください。

### PDF ビルドで `.sty not found` が出る

LaTeX パッケージが不足しています。エラーメッセージに出た `.sty` 名からパッケージを特定し、`tlmgr` で追加します。

```bash
sudo tlmgr install <package-name>
```

本書で最低限必要なパッケージは、セットアップ手順の `tlmgr install` にまとめています。

### PDF で絵文字が表示されない

Harano Aji フォントには絵文字グリフが含まれていません。
原稿では絵文字の代わりに「OK」「NG」などのテキストを使います。

### EPUB バリデーションで失敗する

先に EPUB を生成したうえで、`epubcheck` が入っているか確認します。

```bash
make epub
brew install epubcheck
make validate
```

---

## 参考リンク

- [Pandoc User's Guide](https://pandoc.org/MANUAL.html)
- [LuaTeX-ja ドキュメント](https://ctan.org/pkg/luatexja)
- [Harano Aji Fonts](https://github.com/trueroad/HaranoAjiFonts)
- [BasicTeX (TeX Live)](https://www.tug.org/mactex/morepackages.html)
