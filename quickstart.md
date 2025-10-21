# BLEInAction Build System Quick Start

**Date**: 2025-01-21  
**Status**: MVP Ready  
**Docker Approach**: Japanese fonts via pandoc/latex:3.4

---

## Prerequisites

1. **Docker Desktop** (required)
   - Download: https://www.docker.com/products/docker-desktop
   - Verify: `docker --version`
   - **Apple Silicon (M1/M2/M3)**: Docker Desktop automatically enables Rosetta 2 emulation for AMD64 images

2. **VS Code** (recommended)
   - With extensions: Markdown All in One, Markdown Preview Enhanced, Code Spell Checker

---

## First-Time Setup

```bash
# Clone repository (if not already done)
cd /Users/u_akihiro/Desktop/BLEInAction

# Build Docker image with Japanese fonts (~2GB, takes 5-10 minutes)
make setup

# This creates: bleinaction-pandoc:latest
# Includes: pandoc, xelatex, Noto CJK fonts, collection-langjapanese
```

---

## Building the Book

### Build EPUB

```bash
make build-epub
```

**Output**: `output/epub/BLEInAction.epub`

### Build PDF

```bash
make build-pdf
```

**Output**: `output/pdf/BLEInAction.pdf` (Japanese-enabled via xelatex)

### Build All Formats

```bash
make build-all
```

### Validate EPUB

```bash
# Install epubcheck first (if not installed)
brew install epubcheck

# Run validation
make validate
```

---

## Writing Content

### Create New Chapter

1. Create markdown file: `manuscript/chapters/XX-chapter-name.md`
2. Add to `manuscript/chapters.txt`:
   ```
   chapters/XX-chapter-name.md
   ```
3. Write content with Japanese + English mixed text
4. Preview in VS Code (Cmd+Shift+V)

### Chapter Template

```markdown
# 第X章 タイトル

## セクション1

日本語テキスト with **BLE**, **GATT**, **UUID** technical terms.

### Code Example (C)

\```c
#include <zephyr/bluetooth/bluetooth.h>
// Your code here
\```

### Code Example (Swift)

\```swift
import CoreBluetooth
// Your code here
\```

### Code Example (Kotlin)

\```kotlin
import android.bluetooth.*
// Your code here
\```

### Images

![Caption](../images/diagrams/your-diagram.png)

### Tables

| 列1 | 列2 | 列3 |
|-----|-----|-----|
| データ1 | データ2 | データ3 |
```

---

## Project Structure

```
BLEInAction/
├── manuscript/
│   ├── metadata.yml           # Book metadata (title, author, fonts, etc.)
│   ├── chapters.txt           # Chapter ordering
│   ├── chapters/
│   │   └── 01-introduction.md # Sample chapter
│   └── images/
│       ├── cover.png          # TODO: Create 1600x2400px
│       └── diagrams/
├── build/
│   ├── scripts/
│   │   ├── setup.sh           # Docker image builder
│   │   ├── build-epub.sh      # EPUB builder
│   │   └── build-pdf.sh       # PDF builder
│   ├── config/
│   │   └── build.yml          # Pandoc configuration
│   └── templates/
│       ├── epub-styles.css    # EPUB styling
│       └── latex-preamble.tex # Japanese font setup for PDF
├── output/                    # Generated files (gitignored)
│   ├── epub/
│   ├── pdf/
│   ├── validation-reports/
│   └── build-logs/
├── Dockerfile                 # Custom pandoc+Japanese fonts
├── Makefile                   # Build commands
└── .vscode/
    ├── settings.json          # UTF-8, Japanese spellcheck
    ├── tasks.json             # Build tasks (Cmd+Shift+B)
    └── extensions.json        # Recommended extensions
```

---

## VS Code Integration

### Build Tasks (Cmd+Shift+B)

1. **Build EPUB (default)**: Fastest preview
2. **Build PDF**: Full Japanese rendering test
3. **Build All (EPUB + PDF)**: Complete validation
4. **Validate EPUB**: Amazon KDP compatibility check
5. **Docker Build All**: Ensures Docker image is ready

### Keyboard Shortcuts

- `Cmd+Shift+V`: Markdown preview
- `Cmd+Shift+B`: Build menu
- `Cmd+K V`: Preview side-by-side

---

## Troubleshooting

### Docker Image Not Found

```bash
make setup
```

### Build Fails: Permission Denied

```bash
# Scripts need execute permissions
chmod +x build/scripts/*.sh
```

### PDF Build Fails: Font Not Found

```bash
# Rebuild Docker image with updated fonts
docker build -t bleinaction-pandoc:latest .
```

**Note for Apple Silicon users**: The pandoc/latex base image runs in AMD64 emulation mode. This is normal and doesn't affect functionality, but initial builds may take 10-15 minutes.

### EPUB Validation Fails

```bash
# Check validation report
cat output/validation-reports/validation.txt
```

### Japanese Text Not Rendering in PDF

1. Check `manuscript/metadata.yml`:
   ```yaml
   pdf-engine: xelatex
   CJKmainfont: "Noto Serif CJK JP"
   ```
2. Rebuild Docker image:
   ```bash
   make docker-build
   ```

---

## Useful Commands

```bash
# View build log
tail -f output/build-logs/epub-build-*.log

# Clean all outputs
make clean

# Rebuild Docker image (after Dockerfile changes)
docker build -t bleinaction-pandoc:latest .

# Test Japanese fonts in Docker
docker run --rm bleinaction-pandoc:latest fc-list | grep -i noto

# Check Docker image size
docker images bleinaction-pandoc

# Remove old build logs (keep last 10)
ls -t output/build-logs/*.log | tail -n +11 | xargs rm
```

---

## Next Steps

1. **Create cover image**: `manuscript/images/cover.png` (1600x2400px)
2. **Create diagrams**: Use Draw.io, PlantUML, or Mermaid
3. **Write chapters**: Follow chapter template above
4. **Test builds frequently**: Catch issues early
5. **Validate EPUB**: Before publishing to Amazon KDP

---

## Amazon KDP Requirements

### EPUB

- ✅ EPUB 3.0 format (Pandoc default)
- ✅ UTF-8 encoding (configured)
- ✅ Validated with epubcheck (via `make validate`)
- ⚠️ TODO: Create cover image (1600x2400px minimum)

### PDF

- ✅ A5 papersize (configured)
- ✅ 2cm margins (configured)
- ✅ Japanese font support (Noto CJK)
- ✅ Embedded fonts (automatic)
- ⚠️ TODO: Interior review via KDP Print Preview

---

## Support

- **Pandoc Manual**: https://pandoc.org/MANUAL.html
- **Docker Issues**: Check `output/build-logs/`
- **Japanese Font Issues**: Research doc in `specs/001-markdown-build-pipeline/docker-japanese-fonts-research.md`
- **EPUB Spec**: http://idpf.org/epub/30
