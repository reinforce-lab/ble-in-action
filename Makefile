# ===========================================================================
# BLEInAction – Makefile  (local pandoc, no Docker)
# ===========================================================================

# macOS BasicTeX / MacTeX の PATH を追加
export PATH := /Library/TeX/texbin:$(PATH)

.PHONY: help epub pdf pdf-ch all validate clean check-pandoc

# Default target
help:
	@echo "BLEInAction Build System (local pandoc)"
	@echo ""
	@echo "  make epub         Build EPUB"
	@echo "  make pdf          Build PDF  (requires lualatex)"
	@echo "  make pdf-ch CH=3  Build PDF for a single chapter (fast review)"
	@echo "  make all          Build EPUB + PDF"
	@echo "  make validate     Validate EPUB with epubcheck"
	@echo "  make clean        Remove generated output files"
	@echo ""

# --------------------------------------------------------------------------
# Configuration
# --------------------------------------------------------------------------
MANUSCRIPT_DIR := manuscript
CHAPTERS_TXT   := $(MANUSCRIPT_DIR)/chapters.txt
METADATA       := $(MANUSCRIPT_DIR)/metadata.yml
CSS            := build/templates/epub-styles.css
LATEX_HEADER   := build/templates/latex-preamble.tex
COVER_IMAGE    := $(MANUSCRIPT_DIR)/images/cover.png

EPUB_DIR  := output/epub
PDF_DIR   := output/pdf
EPUB_FILE := $(EPUB_DIR)/BLEInAction.epub
PDF_FILE  := $(PDF_DIR)/BLEInAction.pdf

# Read chapter list from chapters.txt (skip comments and blank lines)
CHAPTERS := $(addprefix $(MANUSCRIPT_DIR)/,\
  $(shell grep -v '^\#' $(CHAPTERS_TXT) | grep -v '^\s*$$'))

# Pandoc defaults files (format-specific settings are here)
PDF_DEFAULTS  := build/config/pdf.yml
EPUB_DEFAULTS := build/config/epub.yml

# --------------------------------------------------------------------------
# Pre-flight check
# --------------------------------------------------------------------------
check-pandoc:
	@command -v pandoc >/dev/null 2>&1 || { \
		echo "❌ pandoc が見つかりません。"; \
		echo "   brew install pandoc"; \
		exit 1; }

# --------------------------------------------------------------------------
# EPUB
# --------------------------------------------------------------------------
epub: check-pandoc $(EPUB_FILE)

$(EPUB_FILE): $(CHAPTERS) $(METADATA) $(CSS) $(CHAPTERS_TXT) $(EPUB_DEFAULTS)
	@mkdir -p $(EPUB_DIR)
	@echo "=== Building EPUB ==="
	pandoc $(CHAPTERS) \
		--defaults=$(EPUB_DEFAULTS) \
		$(if $(wildcard $(COVER_IMAGE)),--epub-cover-image=$(COVER_IMAGE)) \
		--output=$@
	@echo ""
	@echo "✅ EPUB build complete: $@ ($$(du -h $@ | cut -f1))"

# --------------------------------------------------------------------------
# PDF  (requires lualatex)
# --------------------------------------------------------------------------
pdf: check-pandoc $(PDF_FILE)

$(PDF_FILE): $(CHAPTERS) $(METADATA) $(LATEX_HEADER) $(CHAPTERS_TXT) $(PDF_DEFAULTS)
	@command -v lualatex >/dev/null 2>&1 || { \
		echo "❌ lualatex が見つかりません。PATH=/Library/TeX/texbin を確認してください。"; \
		echo "   brew install --cask mactex  または  brew install basictex"; \
		exit 1; }
	@mkdir -p $(PDF_DIR)
	@echo "=== Building PDF (B5 / jlreq / 50字×40行) ==="
	pandoc $(CHAPTERS) \
		--defaults=$(PDF_DEFAULTS) \
		--output=$@
	@echo ""
	@echo "✅ PDF build complete: $@ ($$(du -h $@ | cut -f1))"

# --------------------------------------------------------------------------
# PDF – single chapter  (make pdf-ch CH=3)
# --------------------------------------------------------------------------
CH ?=
CH_PAD  = $(shell printf '%02d' $(CH))
CH_DIR  = chapters/$(CH_PAD)-
CH_FILES = $(addprefix $(MANUSCRIPT_DIR)/,\
  $(shell grep '^$(CH_DIR)' $(CHAPTERS_TXT)))
CH_PDF  = $(PDF_DIR)/ch$(CH_PAD).pdf

pdf-ch: check-pandoc
	@if [ -z "$(CH)" ]; then \
		echo "❌ 章番号を指定してください。例: make pdf-ch CH=3"; exit 1; fi
	@if [ -z "$(CH_FILES)" ]; then \
		echo "❌ 第$(CH)章のファイルが見つかりません。"; exit 1; fi
	@command -v lualatex >/dev/null 2>&1 || { \
		echo "❌ lualatex が見つかりません。"; exit 1; }
	@mkdir -p $(PDF_DIR)
	@echo "=== Building PDF – 第$(CH)章 (review) ==="
	pandoc $(CH_FILES) \
		--defaults=$(PDF_DEFAULTS) \
		-V chapternumber=$(CH) \
		--output=$(CH_PDF)
	@echo ""
	@echo "✅ Chapter PDF: $(CH_PDF) ($$(du -h $(CH_PDF) | cut -f1))"

# --------------------------------------------------------------------------
# All
# --------------------------------------------------------------------------
all: epub pdf
	@echo ""
	@echo "✅ All formats built"
	@ls -lh $(EPUB_FILE) $(PDF_FILE) 2>/dev/null

# --------------------------------------------------------------------------
# Validate EPUB
# --------------------------------------------------------------------------
validate:
	@if [ ! -f $(EPUB_FILE) ]; then \
		echo "❌ $(EPUB_FILE) が見つかりません。先に make epub を実行してください。"; \
		exit 1; \
	fi
	@command -v epubcheck >/dev/null 2>&1 || { \
		echo "❌ epubcheck が見つかりません。"; \
		echo "   brew install epubcheck"; \
		exit 1; }
	epubcheck $(EPUB_FILE)

# --------------------------------------------------------------------------
# Clean
# --------------------------------------------------------------------------
clean:
	rm -f $(EPUB_FILE) $(PDF_FILE)
	rm -rf output/build-logs/*
	@echo "✅ Cleaned output files"
