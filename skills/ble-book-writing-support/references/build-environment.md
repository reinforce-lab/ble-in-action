# BLEInAction ビルド環境構築

この参照資料は、macOSで本書のEPUB/PDF製本環境を新規構築または修復するときにだけ使用する。通常のビルドコマンドはリポジトリ直下の `Makefile` を正本とする。

## 必要なツール

| ツール | 用途 | インストール例 |
|---|---|---|
| Homebrew | パッケージ管理 | <https://brew.sh> |
| pandoc 3.x | MarkdownからEPUB/PDFへ変換 | `brew install pandoc` |
| pandoc-crossref | 図表・章節の相互参照 | `brew install pandoc-crossref` |
| BasicTeXまたはMacTeX | LuaLaTeXによるPDF生成 | `brew install --cask basictex` または `brew install --cask mactex` |
| epubcheck | EPUB検証 | `brew install epubcheck` |

## セットアップ

Pandocとcrossrefをインストールする。

```bash
brew install pandoc pandoc-crossref
pandoc --version
pandoc-crossref --version
```

`pandoc-crossref` は実行するPandocと互換性のある版が必要である。`compiled with pandoc ...` という不一致警告が出る状態は、成果物が生成されても成功とみなさない。

容量を抑える場合はBasicTeXを使う。

```bash
brew install --cask basictex
```

不足パッケージを個別管理したくない場合はMacTeXを使う。どちらか一方でよい。

```bash
brew install --cask mactex
```

BasicTeXを選んだ場合だけ、本書で使うパッケージを追加する。

```bash
sudo tlmgr update --self
sudo tlmgr install collection-luatex collection-langjapanese
sudo tlmgr install luatexja haranoaji haranoaji-extra framed titlesec tex-gyre
```

TeX Liveの年次更新でローカルとリモートの世代が合わない場合は、BasicTeXまたはMacTeX自体を更新する。異なる年のリポジトリを無理に混在させない。

## 確認

```bash
pandoc --version
pandoc-crossref --version
/Library/TeX/texbin/lualatex --version
/Library/TeX/texbin/kpsewhich jlreq.cls
/Library/TeX/texbin/kpsewhich luatexja-fontspec.sty
/Library/TeX/texbin/kpsewhich HaranoAjiGothic-Regular.otf
/Library/TeX/texbin/kpsewhich texgyreheros-regular.otf
```

`kpsewhich` の各行がパスを返すことを確認する。HomebrewでPandocを更新したときはcrossrefも更新する。

```bash
brew update
brew upgrade pandoc pandoc-crossref
```

## ビルド

```bash
make epub
make pdf
make pdf-ch CH=3
make pdf-ch CH=3 LAYOUT=1
make validate
```

終了コードが0であり、crossrefの互換性警告、画像欠落、参照未解決がないことまで確認する。ファイルが生成されたことだけを成功条件にしない。

## 主なトラブル

### pandoc-crossrefとPandocの不一致

```bash
brew update
brew upgrade pandoc pandoc-crossref
make epub
make pdf
```

### lualatexが見つからない

```bash
export PATH="/Library/TeX/texbin:$PATH"
/Library/TeX/texbin/lualatex --version
```

`Makefile` はこのPATHを追加済みである。

### `.sty not found`

エラーに出たファイルを提供するTeX Liveパッケージを特定して追加する。

```bash
sudo tlmgr install <package-name>
```

### 画像が見つからない

画像パスが `manuscript/` またはdefaultsの `resource-path` から解決できるか確認する。プレースホルダーでも出版用ビルドでは欠落を許容しない。

### EPUB検証

```bash
make epub
brew install epubcheck
make validate
```

## 一次資料

- [Pandoc User's Guide](https://pandoc.org/MANUAL.html)
- [LuaTeX-ja](https://ctan.org/pkg/luatexja)
- [Harano Aji Fonts](https://github.com/trueroad/HaranoAjiFonts)
- [MacTeX / BasicTeX](https://www.tug.org/mactex/morepackages.html)
- [pandoc-crossref Homebrew Formula](https://formulae.brew.sh/formula/pandoc-crossref)
