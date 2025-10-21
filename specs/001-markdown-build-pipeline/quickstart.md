# Quickstart Guide: Markdown Build Pipeline Setup

**Feature**: Markdown Build Pipeline for Kindle Publishing  
**Date**: 2025-10-21  
**Audience**: Authors setting up the writing and build environment for the first time  
**Time to Complete**: 30-45 minutes

## Prerequisites

- macOS 12+ (for this guide; Linux/Windows instructions similar)
- Command-line familiarity (Terminal)
- Git installed
- VS Code installed
- Internet connection for downloading dependencies (~2GB)

## Step 1: Install Core Dependencies (15-20 minutes)

### 1.1 Install Homebrew (if not already installed)

```bash
# Check if Homebrew is installed
which brew

# If not installed, install it:
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 1.2 Install Pandoc

```bash
# Install Pandoc (universal document converter)
brew install pandoc

# Verify installation
pandoc --version
# Expected output: pandoc 3.x or higher
```

### 1.3 Install LaTeX Distribution

```bash
# Install BasicTeX (minimal LaTeX, ~400MB)
# For full MacTeX (~4GB), use: brew install --cask mactex
brew install --cask basictex

# Add LaTeX to PATH (add to ~/.zshrc or ~/.bash_profile)
export PATH="/Library/TeX/texbin:$PATH"

# Reload shell configuration
source ~/.zshrc  # or source ~/.bash_profile

# Verify installation
xelatex --version

# Install additional LaTeX packages needed for Japanese text
sudo tlmgr update --self
sudo tlmgr install collection-langjapanese
sudo tlmgr install luatexja
sudo tlmgr install fancyhdr geometry titlesec tocloft
```

**Note**: Full MacTeX includes more packages but is 4GB. BasicTeX + manual packages is recommended for this project.

### 1.4 Install EPUB Validator

```bash
# Install epubcheck (requires Java)
brew install epubcheck

# Verify installation
epubcheck --version
```

### 1.5 Install Optional Tools

```bash
# Calibre (ebook management and conversion testing)
brew install --cask calibre

# Kindle Previewer (Amazon's official EPUB testing tool)
# Download from: https://www.amazon.com/Kindle-Previewer/b?ie=UTF8&node=21381691011
# Install the downloaded DMG manually
```

## Step 2: Configure VS Code (5-10 minutes)

### 2.1 Install Recommended Extensions

Open VS Code and install these extensions (Cmd+Shift+X):

1. **Markdown All in One** (`yzhang.markdown-all-in-one`)
   - TOC generation
   - Keyboard shortcuts
   - List editing

2. **Markdown Preview Enhanced** (`shd101wyy.markdown-preview-enhanced`)
   - Advanced preview with Pandoc support
   - Export to PDF/HTML
   - Code execution

3. **Code Spell Checker** (`streetsidesoftware.code-spell-checker`)
   - English spell checking

4. **Japanese Language Pack for VS Code** (`ms-ceintl.vscode-language-pack-ja`)
   - Japanese UI (optional)

5. **markdownlint** (`davidanson.vscode-markdownlint`)
   - Markdown syntax checking

### 2.2 Configure VS Code Settings

Create or edit `.vscode/settings.json` in your project:

```json
{
  "markdown.preview.breaks": true,
  "markdown.preview.typographer": true,
  "markdown-preview-enhanced.enableExtendedTableSyntax": true,
  "markdown-preview-enhanced.codeBlockTheme": "github.css",
  "files.encoding": "utf8",
  "files.autoGuessEncoding": false,
  "[markdown]": {
    "editor.wordWrap": "on",
    "editor.quickSuggestions": {
      "comments": "off",
      "strings": "off",
      "other": "off"
    }
  },
  "cSpell.language": "en,ja",
  "cSpell.enabledLanguageIds": [
    "markdown"
  ]
}
```

### 2.3 Create Build Tasks

Create `.vscode/tasks.json`:

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Build EPUB",
      "type": "shell",
      "command": "./build/scripts/build-epub.sh",
      "group": {
        "kind": "build",
        "isDefault": true
      },
      "problemMatcher": []
    },
    {
      "label": "Build PDF",
      "type": "shell",
      "command": "./build/scripts/build-pdf.sh",
      "group": "build",
      "problemMatcher": []
    },
    {
      "label": "Build All",
      "type": "shell",
      "command": "./build/scripts/build.sh",
      "group": "build",
      "problemMatcher": []
    },
    {
      "label": "Validate EPUB",
      "type": "shell",
      "command": "./build/scripts/validate.sh",
      "problemMatcher": []
    }
  ]
}
```

## Step 3: Create Sample Project Structure (5 minutes)

### 3.1 Create Directory Structure

```bash
# Navigate to project root
cd /Users/u_akihiro/Desktop/BLEInAction

# Create manuscript directories
mkdir -p manuscript/chapters
mkdir -p manuscript/images/{diagrams,screenshots}
mkdir -p manuscript/code-examples/{embedded,ios,android}

# Create build directories
mkdir -p build/{scripts,templates,config}

# Create output directories (these will be gitignored)
mkdir -p output/{epub,pdf,validation-reports,build-logs}
```

### 3.2 Create Sample Metadata File

Create `manuscript/metadata.yml`:

```yaml
---
title: "BLE In Action: 実践Bluetooth Low Energy開発"
subtitle: "マルチプラットフォーム対応の無線通信技術入門"
author:
  - name: "著者名"
language: ja-JP
date: "2025-10-21"
publisher: "Amazon Kindle Direct Publishing"
rights: "© 2025 著者名. All rights reserved."
description: |
  Bluetooth Low Energyを活用した技術開発の実践ガイド。
keywords:
  - Bluetooth
  - BLE
  - IoT
version: "1.0.0"
---
```

### 3.3 Create Sample Chapter

Create `manuscript/chapters/01-introduction.md`:

```markdown
# Chapter 1: Introduction to Bluetooth Low Energy

## Learning Objectives

- Understand the fundamentals of BLE technology
- Learn the differences between Classic Bluetooth and BLE
- Identify use cases for BLE in modern applications

## Prerequisites

- Basic understanding of wireless communication concepts
- Familiarity with at least one programming language

## What is Bluetooth Low Energy?

Bluetooth Low Energy (BLE), introduced in Bluetooth 4.0 (2010), is a wireless personal area network technology designed for novel applications in healthcare, fitness, security, and home entertainment.

### Key Characteristics

- **Low Power Consumption**: Devices can run for months or years on a coin cell battery
- **Short-range Communication**: Typically 10-50 meters
- **Data Transfer**: Optimized for small, periodic data transmission

## Comparison: Classic Bluetooth vs BLE

| Feature | Classic Bluetooth | Bluetooth Low Energy |
|---------|-------------------|---------------------|
| Power Consumption | High | Very Low |
| Data Rate | Up to 3 Mbps | Up to 2 Mbps (BLE 5.0) |
| Pairing Time | ~6 seconds | <6 milliseconds |
| Use Cases | Audio streaming, file transfer | Sensors, beacons, fitness trackers |

## BLE Architecture Overview

```
┌─────────────────────────────────────┐
│         Application Layer           │
├─────────────────────────────────────┤
│        GATT (Generic Attribute)     │
├─────────────────────────────────────┤
│         ATT (Attribute Protocol)    │
├─────────────────────────────────────┤
│        L2CAP (Logical Link)         │
├─────────────────────────────────────┤
│         Link Layer                  │
├─────────────────────────────────────┤
│         Physical Layer              │
└─────────────────────────────────────┘
```

## Common Issues

- **Range Limitations**: BLE signal strength decreases with obstacles (walls, metal)
  - **Solution**: Position devices for line-of-sight when possible, or use repeaters

- **Connection Drops**: Interference from Wi-Fi and other 2.4GHz devices
  - **Solution**: Use adaptive frequency hopping, minimize interference sources

## Summary

- BLE is designed for low-power, short-range wireless communication
- Key advantage over Classic Bluetooth: dramatically reduced power consumption
- GATT-based architecture enables flexible service and characteristic definitions
- Ideal for IoT, wearables, and battery-powered devices

## Exercises

1. Research three consumer products that use BLE. Identify their primary use cases.
2. Calculate expected battery life for a BLE sensor transmitting 20 bytes every 10 seconds from a 220mAh coin cell.
3. Compare the specifications of Bluetooth 4.0, 4.2, and 5.0. What are the key differences?
```

### 3.4 Create Chapter Manifest

Create `manuscript/chapters.txt`:

```
chapters/01-introduction.md
```

## Step 4: Create Build Scripts (5 minutes)

### 4.1 Main Build Script

Create `build/scripts/build.sh`:

```bash
#!/usr/bin/env bash
set -e

# Build script for BLE In Action book
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$PROJECT_ROOT"

echo "🔨 Building BLE In Action..."

# Build EPUB
echo "📘 Building EPUB..."
./build/scripts/build-epub.sh

# Build PDF
echo "📕 Building PDF..."
./build/scripts/build-pdf.sh

# Validate
echo "✅ Validating outputs..."
./build/scripts/validate.sh

echo "✨ Build complete!"
echo "EPUB: output/epub/BLEInAction.epub"
echo "PDF: output/pdf/BLEInAction.pdf"
```

### 4.2 EPUB Build Script

Create `build/scripts/build-epub.sh`:

```bash
#!/usr/bin/env bash
set -e

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$PROJECT_ROOT"

# Read chapter list
CHAPTERS=$(cat manuscript/chapters.txt | sed 's/^/manuscript\//')

# Build EPUB
pandoc $CHAPTERS \
  --from markdown \
  --to epub3 \
  --output output/epub/BLEInAction.epub \
  --metadata-file manuscript/metadata.yml \
  --toc \
  --toc-depth=3 \
  --number-sections \
  --top-level-division=chapter

echo "✅ EPUB built: output/epub/BLEInAction.epub"
```

### 4.3 PDF Build Script

Create `build/scripts/build-pdf.sh`:

```bash
#!/usr/bin/env bash
set -e

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$PROJECT_ROOT"

# Read chapter list
CHAPTERS=$(cat manuscript/chapters.txt | sed 's/^/manuscript\//')

# Build PDF
pandoc $CHAPTERS \
  --from markdown \
  --to pdf \
  --output output/pdf/BLEInAction.pdf \
  --metadata-file manuscript/metadata.yml \
  --pdf-engine=xelatex \
  --toc \
  --toc-depth=3 \
  --number-sections \
  --top-level-division=chapter

echo "✅ PDF built: output/pdf/BLEInAction.pdf"
```

### 4.4 Validation Script

Create `build/scripts/validate.sh`:

```bash
#!/usr/bin/env bash
set -e

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$PROJECT_ROOT"

EPUB_FILE="output/epub/BLEInAction.epub"
REPORT_FILE="output/validation-reports/epubcheck-report.txt"

if [ ! -f "$EPUB_FILE" ]; then
  echo "❌ EPUB file not found: $EPUB_FILE"
  echo "Run build-epub.sh first."
  exit 1
fi

echo "🔍 Validating EPUB with epubcheck..."
epubcheck "$EPUB_FILE" | tee "$REPORT_FILE"

if [ $? -eq 0 ]; then
  echo "✅ EPUB validation passed!"
else
  echo "❌ EPUB validation failed. See $REPORT_FILE for details."
  exit 1
fi
```

### 4.5 Make Scripts Executable

```bash
chmod +x build/scripts/*.sh
```

## Step 5: Test Build (5 minutes)

### 5.1 Run First Build

```bash
# From project root
./build/scripts/build.sh
```

**Expected Output**:
```
🔨 Building BLE In Action...
📘 Building EPUB...
✅ EPUB built: output/epub/BLEInAction.epub
📕 Building PDF...
✅ PDF built: output/pdf/BLEInAction.pdf
✅ Validating outputs...
🔍 Validating EPUB with epubcheck...
Validating against EPUB version 3.0
No errors or warnings detected.
✅ EPUB validation passed!
✨ Build complete!
EPUB: output/epub/BLEInAction.epub
PDF: output/pdf/BLEInAction.pdf
```

### 5.2 Open Generated Files

```bash
# Open EPUB in Calibre or Apple Books
open output/epub/BLEInAction.epub

# Open PDF in Preview
open output/pdf/BLEInAction.pdf
```

### 5.3 Verify Output Quality

**EPUB Checklist**:
- [ ] Opens without errors
- [ ] Table of contents displays correctly
- [ ] Chapter 1 content is readable
- [ ] Code blocks are formatted with monospace font
- [ ] Japanese text renders correctly

**PDF Checklist**:
- [ ] Opens without errors
- [ ] Table of contents is generated
- [ ] Page numbers are present
- [ ] Japanese text renders correctly with proper font
- [ ] Code blocks are readable

## Step 6: VS Code Build Integration (2 minutes)

### 6.1 Build from VS Code

1. Open VS Code in project directory: `code .`
2. Press `Cmd+Shift+B` (Build command)
3. Select "Build All" from task list
4. View build output in integrated terminal

### 6.2 Create Keyboard Shortcuts (Optional)

Add to `.vscode/keybindings.json`:

```json
[
  {
    "key": "cmd+shift+e",
    "command": "workbench.action.tasks.runTask",
    "args": "Build EPUB"
  },
  {
    "key": "cmd+shift+p",
    "command": "workbench.action.tasks.runTask",
    "args": "Build PDF"
  }
]
```

## Troubleshooting

### Issue: `pandoc: command not found`

**Solution**: Ensure Homebrew bin directory is in PATH:
```bash
export PATH="/opt/homebrew/bin:$PATH"  # Apple Silicon Macs
# or
export PATH="/usr/local/bin:$PATH"     # Intel Macs
```

### Issue: `xelatex: command not found`

**Solution**: Add LaTeX to PATH:
```bash
export PATH="/Library/TeX/texbin:$PATH"
source ~/.zshrc
```

### Issue: Japanese text doesn't render in PDF

**Solution**: Install Japanese font packages:
```bash
sudo tlmgr install collection-langjapanese
```

### Issue: EPUB validation fails with "mimetype file incorrect"

**Solution**: This is usually a Pandoc bug. Try rebuilding or updating Pandoc:
```bash
brew upgrade pandoc
```

### Issue: Build scripts permission denied

**Solution**: Make scripts executable:
```bash
chmod +x build/scripts/*.sh
```

## Next Steps

After completing this quickstart:

1. **Add Content**: Create additional chapters in `manuscript/chapters/`
2. **Update Metadata**: Edit `manuscript/metadata.yml` with your book details
3. **Add Images**: Place images in `manuscript/images/` and reference them in chapters
4. **Customize Templates**: Modify EPUB CSS and LaTeX templates in `build/templates/`
5. **Test on Kindle**: Use Amazon's Kindle Previewer to test EPUB rendering
6. **Set Up Git**: Initialize Git repository and commit your work
7. **Plan CI**: Review GitHub Actions workflow for automated builds

## Success Criteria Validation

Verify you've met the success criteria from the spec:

- **SC-001**: ✅ Created sample chapter, previewed in VS Code within 30 seconds
- **SC-002**: ✅ Built 1-chapter manuscript in under 2 minutes
- **SC-003**: ✅ EPUB passes epubcheck validation
- **SC-004**: ⏳ PDF visual inspection needed for print specs
- **SC-005**: ✅ Can modify chapter and rebuild immediately
- **SC-006**: ✅ Repeated builds produce consistent output
- **SC-008**: ✅ All dependencies installed in under 15 minutes (excludes LaTeX download time)

## Reference

- **Pandoc Manual**: https://pandoc.org/MANUAL.html
- **EPUB 3 Specification**: https://www.w3.org/publishing/epub3/
- **Amazon KDP Guidelines**: https://kdp.amazon.com/en_US/help/topic/G200735480
- **Project Data Model**: See `data-model.md` for configuration schemas

## Support

For issues or questions:
1. Check build logs in `output/build-logs/`
2. Review validation reports in `output/validation-reports/`
3. Consult Pandoc documentation
4. Open an issue in the project repository