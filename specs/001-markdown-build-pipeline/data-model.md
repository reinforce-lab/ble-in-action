# Data Model: Build Configuration Schema

**Feature**: Markdown Build Pipeline for Kindle Publishing  
**Date**: 2025-10-21  
**Purpose**: Define the structure of configuration files, metadata, and build artifacts for the book publishing system

## Overview

This document defines the data structures used throughout the build pipeline. Since this is a book publishing system rather than a traditional application, the "data model" consists of configuration files, metadata structures, and artifact organization.

## Core Entities

### 1. Book Metadata (`metadata.yml`)

YAML file containing book-level information used by Pandoc for EPUB and PDF generation.

**Location**: `manuscript/metadata.yml`

**Schema**:
```yaml
---
title: "BLE In Action: 実践Bluetooth Low Energy開発"
subtitle: "マルチプラットフォーム対応の無線通信技術入門"
author:
  - name: "著者名"
    affiliation: "所属（オプション）"
language: ja-JP
date: "2025-10-21"
publisher: "Amazon Kindle Direct Publishing"
rights: "© 2025 著者名. All rights reserved."
isbn:
  epub: "978-XXXXXXXXXX"  # EPUB ISBN
  print: "978-XXXXXXXXXX"  # Print ISBN
cover-image: "images/cover.png"
description: |
  Bluetooth Low Energyを活用した技術開発の実践ガイド。
  組込みシステム、スマートフォン、デスクトップアプリケーションまで、
  マルチプラットフォームでBLE通信を実現する開発力を習得できます。
keywords:
  - Bluetooth
  - BLE
  - IoT
  - 組込み開発
  - モバイル開発
version: "1.0.0"
```

**Field Definitions**:
- `title`: Main book title (required)
- `subtitle`: Subtitle for additional context (optional)
- `author`: List of authors with name and optional affiliation
- `language`: ISO 639-1 language code (ja-JP for Japanese)
- `date`: Publication or revision date (YYYY-MM-DD)
- `publisher`: Publishing entity
- `rights`: Copyright statement
- `isbn.epub`: ISBN for ebook edition
- `isbn.print`: ISBN for print edition
- `cover-image`: Relative path to cover image (recommended: 1600x2400px PNG/JPEG)
- `description`: Book description for KDP listing (max 4000 characters)
- `keywords`: Search keywords for discoverability
- `version`: Semantic version for tracking revisions

### 2. Chapter Manifest (`chapters.txt`)

Defines the order of chapters for book assembly.

**Location**: `manuscript/chapters.txt`

**Format**:
```
chapters/01-introduction.md
chapters/02-ble-basics.md
chapters/03-gatt-architecture.md
chapters/04-peripheral-development.md
chapters/05-central-development.md
chapters/06-ios-ble-programming.md
chapters/07-android-ble-programming.md
chapters/08-embedded-ble-firmware.md
chapters/09-debugging-techniques.md
chapters/10-performance-optimization.md
chapters/11-security-considerations.md
chapters/12-real-world-applications.md
appendix/a-hardware-reference.md
appendix/b-tools-and-resources.md
```

**Purpose**:
- Explicit chapter ordering (not relying on filesystem sort)
- Easy reordering without renaming files
- Supports different orderings for drafts vs final publication

### 3. Chapter File (`chapters/*.md`)

Individual Markdown file representing one chapter.

**Location**: `manuscript/chapters/[##-chapter-name].md`

**Structure**:
```markdown
# Chapter [Number]: [Title]

## Learning Objectives
- Objective 1
- Objective 2
- Objective 3

## Prerequisites
Knowledge required from previous chapters.

## [Section 1]
Content...

### Code Example: [Description]
```language
code here
```

Explanation of code...

## Common Issues
- Issue 1: Solution
- Issue 2: Solution

## Summary
Key takeaways...

## Exercises
1. Exercise 1
2. Exercise 2
```

**Conventions**:
- Level 1 heading (`#`) for chapter title
- Level 2 headings (`##`) for major sections
- Level 3 headings (`###`) for subsections
- Code blocks with language identifier for syntax highlighting
- Images referenced with relative paths: `![Caption](../images/diagrams/architecture.png)`

### 4. Build Configuration (`build/config/build.yml`)

Pandoc build options and customization settings.

**Location**: `build/config/build.yml`

**Schema**:
```yaml
epub:
  template: "build/templates/epub-template.html"
  css: "build/templates/epub-styles.css"
  toc-depth: 3
  epub-cover-image: "manuscript/images/cover.png"
  epub-metadata: "manuscript/metadata.yml"
  number-sections: true
  top-level-division: chapter

pdf:
  template: "build/templates/latex-template.tex"
  pdf-engine: xelatex
  toc: true
  toc-depth: 3
  number-sections: true
  top-level-division: chapter
  geometry:
    - papersize=a5
    - margin=2cm
  mainfont: "Hiragino Mincho ProN"  # Japanese font
  monofont: "Menlo"  # Code font
  fontsize: 10pt
  linestretch: 1.3

validation:
  epubcheck: true
  kindle-previewer: true

output:
  epub-file: "output/epub/BLEInAction.epub"
  pdf-file: "output/pdf/BLEInAction.pdf"
  validation-report: "output/validation-reports/report.txt"
```

### 5. Build Artifacts

Generated files during and after build process.

**Directory Structure**:
```
output/
├── epub/
│   ├── BLEInAction.epub           # Final EPUB for KDP
│   └── BLEInAction-draft.epub     # Draft with debugging enabled
├── pdf/
│   ├── BLEInAction.pdf            # Final PDF for KDP
│   └── BLEInAction-draft.pdf      # Draft for review
├── validation-reports/
│   ├── epubcheck-report.txt       # EPUB validation results
│   └── kindle-previewer.log       # Kindle Previewer test results
└── build-logs/
    ├── epub-build.log             # Build process logs
    └── pdf-build.log
```

**Artifact Metadata**:
- **EPUB**: Contains embedded metadata from `metadata.yml`, CSS styling, images, chapter XHTML files
- **PDF**: Generated via LaTeX, includes TOC, page numbers, headers/footers per KDP specs
- **Validation Reports**: Text files with validation results, warnings, errors

## File Organization

### Manuscript Directory (`manuscript/`)

```
manuscript/
├── metadata.yml                   # Book metadata
├── chapters.txt                   # Chapter ordering
├── chapters/
│   ├── 01-introduction.md
│   ├── 02-ble-basics.md
│   └── ...
├── images/
│   ├── cover.png
│   ├── diagrams/
│   │   ├── ble-architecture.png
│   │   └── gatt-structure.png
│   └── screenshots/
│       ├── xcode-ble-central.png
│       └── android-studio-setup.png
└── code-examples/
    ├── embedded/
    │   ├── nrf52-peripheral/
    │   └── esp32-beacon/
    ├── ios/
    │   └── BLECentralDemo/
    └── android/
        └── BLEPeripheralApp/
```

### Build System Directory (`build/`)

```
build/
├── scripts/
│   ├── build.sh                   # Main build orchestration
│   ├── build-epub.sh              # EPUB-specific build
│   ├── build-pdf.sh               # PDF-specific build
│   ├── validate.sh                # Post-build validation
│   └── setup.sh                   # Dependency installation
├── templates/
│   ├── epub-template.html         # Pandoc EPUB template
│   ├── epub-styles.css            # EPUB styling
│   ├── latex-template.tex         # Pandoc LaTeX template
│   └── latex-preamble.tex         # LaTeX preamble for Japanese fonts
└── config/
    └── build.yml                  # Build configuration
```

## Data Flow

### Build Process Flow

```
1. Source Assembly
   chapters.txt → Read chapter list
   → For each chapter: Read markdown file
   → Concatenate in order
   ↓
2. Metadata Injection
   metadata.yml → Parse YAML
   → Inject into Pandoc front matter
   ↓
3. Pandoc Conversion
   Combined Markdown + Metadata → Pandoc
   → Apply templates (EPUB: HTML+CSS, PDF: LaTeX)
   → Generate output artifacts
   ↓
4. Post-Processing
   EPUB → epubcheck validation
   PDF → Visual inspection (optional)
   ↓
5. Validation Reports
   Validation results → Text reports
   → Store in output/validation-reports/
```

### CI Build Data Flow

```
Git Repository
   ↓
GitHub Actions triggered
   ↓
Checkout source
   ↓
Docker container (pandoc/latex)
   ↓
Run build scripts
   ↓
Upload artifacts to GitHub
   ↓
(Optional) Deploy to Amazon S3 staging
```

## Validation Rules

### EPUB Validation (epubcheck)

- Must pass EPUB 3.0 specification compliance
- No broken internal links
- Images must be embedded (not external URLs)
- File size < 650MB (KDP limit)
- Cover image present and valid

### PDF Validation (Visual/KDP)

- Page size: A5 or custom (per KDP specs)
- Margins: Minimum 0.5" on all sides
- Images: Minimum 300 DPI for print quality
- Fonts: Embedded or system fonts only
- File size: < 650MB (KDP limit)

### Metadata Validation

- Title: Non-empty, < 200 characters
- Author: Non-empty
- Language: Valid ISO code
- ISBNs: Valid format (13 digits) if provided
- Description: < 4000 characters
- Cover image: 1600x2400px recommended, minimum 1000x1600px

## Error Handling

### Build Failures

**Causes**:
- Missing chapter file listed in chapters.txt
- Invalid Markdown syntax
- Missing image references
- LaTeX compilation errors (PDF builds)

**Response**:
- Build script exits with non-zero code
- Error message shows file and line number
- Partial outputs deleted (clean failure)

### Validation Failures

**Causes**:
- EPUB spec violations (epubcheck)
- Broken links
- Invalid metadata
- File size exceeded

**Response**:
- Validation report generated
- Build marked as failed
- Specific violations listed for correction

## Versioning Strategy

### Manuscript Versioning

- Git commits track all changes
- Semantic versioning in `metadata.yml`
  - MAJOR: New edition (significant content changes)
  - MINOR: New chapters or major revisions
  - PATCH: Corrections, typo fixes

### Artifact Versioning

- Filenames include version: `BLEInAction-v1.0.0.epub`
- Git tags mark release versions: `v1.0.0`
- CI builds include commit SHA in artifact metadata

## Compliance with Constitution

This data model supports the book constitution principles:

- **Self-Contained Examples**: `code-examples/` directory structure allows complete, testable code
- **Cross-Platform Code**: Separate directories for embedded, iOS, Android ensure platform-specific examples are organized
- **Progressive Complexity**: `chapters.txt` defines explicit ordering for building knowledge
- **Technical Accuracy**: `metadata.yml` includes version tracking for specification compliance

## Future Extensions

Potential additions for future iterations:

1. **Translation Support**: Add `translations/` directory with language codes
2. **Multi-Format Output**: Add MOBI, AZW3 generation
3. **Interactive Elements**: Embed video links, QR codes for additional resources
4. **Reader Analytics**: Metadata for tracking which chapters are read (EPUB 3 features)
5. **Collaboration Metadata**: Track contributors, reviewers per chapter