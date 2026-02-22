# ===========================================================================
# BLEInAction – Makefile  (local pandoc, no Docker)
# ===========================================================================

# macOS BasicTeX / MacTeX の PATH を追加
export PATH := /Library/TeX/texbin:$(PATH)

.PHONY: help epub pdf all validate clean check-pandoc

# Default target
help:
	@echo "BLEInAction Build System (local pandoc)"
	@echo ""
	@echo "  make epub       Build EPUB"
	@echo "  make pdf        Build PDF  (requires lualatex)"
	@echo "  make all        Build EPUB + PDF"
	@echo "  make validate   Validate EPUB with epubcheck"
	@echo "  make clean      Remove generated output files"
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

# Common pandoc flags
PANDOC_INPUT_FMT := markdown+smart+footnotes+fenced_code_blocks+inline_code_attributes+pipe_tables
PANDOC_COMMON := \
	--metadata-file=$(METADATA) \
	--from=$(PANDOC_INPUT_FMT) \
	--standalone \
	--toc --toc-depth=2 \
	--number-sections \
	--highlight-style=tango \
	--resource-path=.:$(MANUSCRIPT_DIR):$(MANUSCRIPT_DIR)/images

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

$(EPUB_FILE): $(CHAPTERS) $(METADATA) $(CSS) $(CHAPTERS_TXT)
	@mkdir -p $(EPUB_DIR)
	@echo "=== Building EPUB ==="
	pandoc $(CHAPTERS) \
		$(PANDOC_COMMON) \
		--to=epub3 \
		--split-level=2 \
		$(if $(wildcard $(COVER_IMAGE)),--epub-cover-image=$(COVER_IMAGE)) \
		--css=$(CSS) \
		--mathml \
		--output=$@
	@echo ""
	@echo "✅ EPUB build complete: $@ ($$(du -h $@ | cut -f1))"

# --------------------------------------------------------------------------
# PDF  (requires lualatex)
# --------------------------------------------------------------------------
pdf: check-pandoc $(PDF_FILE)

$(PDF_FILE): $(CHAPTERS) $(METADATA) $(LATEX_HEADER) $(CHAPTERS_TXT)
	@command -v lualatex >/dev/null 2>&1 || { \
		echo "❌ lualatex が見つかりません。PATH=/Library/TeX/texbin を確認してください。"; \
		echo "   brew install --cask mactex  または  brew install basictex"; \
		exit 1; }
	@mkdir -p $(PDF_DIR)
	@echo "=== Building PDF (B5 / jlreq / Re:VIEW style) ==="
	pandoc $(CHAPTERS) \
		$(PANDOC_COMMON) \
		--to=latex \
		--pdf-engine=lualatex \
		--include-in-header=$(LATEX_HEADER) \
		-V documentclass=jlreq \
		-V classoption=book \
		-V classoption=lualatex \
		-V classoption=oneside \
		-V papersize=b5 \
		-V fontsize=10pt \
		-V geometry:left=22mm \
		-V geometry:right=18mm \
		-V geometry:top=25mm \
		-V geometry:bottom=22mm \
		-V geometry:includehead \
		-V geometry:includefoot \
		--output=$@
	@echo ""
	@echo "✅ PDF build complete: $@ ($$(du -h $@ | cut -f1))"

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
