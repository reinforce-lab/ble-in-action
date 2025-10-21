# Docker Japanese Font Research (T007)

Date: 2025-01-21
Status: Complete

## Summary

Investigated Docker-based Pandoc setup with Japanese CJK font support to avoid 2GB local LaTeX installation.

## Key Findings

### Official Pandoc Docker Images

From https://github.com/pandoc/dockerfiles:

1. **pandoc/latex** image includes:
   - Full TeX Live LaTeX installation
   - All packages pandoc might use
   - Libraries needed by LaTeX packages
   - Based on Alpine Linux (small footprint)

2. **pandoc/ubuntu** variant:
   - Also available with Ubuntu base
   - Larger but may have better font support

3. **Image usage pattern**:
   ```bash
   docker run --rm --volume "`pwd`:/data" --user `id -u`:`id -g` pandoc/latex:3.4 README.md -o output.pdf
   ```

### Japanese Font Support

From Pandoc Manual (https://pandoc.org/MANUAL.html):

1. **XeLaTeX Engine** (recommended for Japanese):
   - Supports Unicode natively
   - Uses system fonts via fontspec package
   - CJKmainfont variable for Japanese fonts
   - Example metadata:
     ```yaml
     ---
     mainfont: TeX Gyre Pagella
     CJKmainfont: Noto Serif CJK JP
     ---
     ```

2. **LaTeX packages for Japanese**:
   - `xeCJK` package (for XeLaTeX)
   - `luatexja` package (for LuaLaTeX)
   - `fontspec` for font selection

3. **Ukrainian example from dockerfiles repo**:
   ```dockerfile
   FROM pandoc/latex
   RUN tlmgr install babel-ukrainian
   RUN apk --no-cache add font-linux-libertine
   ```

## Recommended Approach for BLEInAction

### Build Strategy

1. **Use pandoc/latex:3.4 as base**
   - Already includes full LaTeX with xelatex
   - Approximately 2GB but contained in Docker image
   - No local LaTeX installation needed

2. **Add Japanese fonts via custom Dockerfile**:
   ```dockerfile
   FROM pandoc/latex:3.4
   
   # Install Japanese fonts
   RUN apk --no-cache add \
       font-noto-cjk \
       font-noto-emoji
   
   # Install Japanese LaTeX support
   RUN tlmgr install \
       collection-langjapanese \
       xecjk \
       luatexja
   ```

3. **Metadata configuration**:
   ```yaml
   ---
   title: "Bluetooth LE Practical Guide"
   lang: ja
   mainfont: Noto Sans CJK JP
   CJKmainfont: Noto Serif CJK JP
   monofont: Noto Sans Mono CJK JP
   pdf-engine: xelatex
   ---
   ```

### Alternative Fonts

From Alpine packages:
- `font-noto-cjk`: Comprehensive CJK font family (sans/serif)
- `font-ipa`: IPA fonts (Japanese standard)
- `font-vlgothic`: VL Gothic (Japanese monospace)

## Implementation Plan

1. **T008**: Create custom Dockerfile extending pandoc/latex:3.4
2. **T013**: Create latex-preamble.tex with Japanese font configuration
3. **T011**: Set pdf-engine: xelatex in build.yml

## Testing Requirements

1. Test with sample Japanese text chapter
2. Verify:
   - Hiragana, Katakana, Kanji rendering
   - ASCII technical terms (BLE, GATT, UUID)
   - Code blocks with monospace CJK font
   - Image captions in Japanese
   - PDF metadata encoding

## References

- Pandoc Manual: https://pandoc.org/MANUAL.html
- Pandoc Dockerfiles: https://github.com/pandoc/dockerfiles
- TeX Live Japanese packages: https://www.tug.org/texlive/
- Noto CJK Fonts: https://github.com/notofonts/noto-cjk
