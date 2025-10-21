.PHONY: help setup build-epub build-pdf build-all validate clean docker-build

# Default target: show help
help:
	@echo "BLEInAction Build System"
	@echo ""
	@echo "Available targets:"
	@echo "  make setup       - Build Docker image with Japanese font support"
	@echo "  make build-epub  - Build EPUB format"
	@echo "  make build-pdf   - Build PDF format with Japanese fonts"
	@echo "  make build-all   - Build all formats (EPUB + PDF)"
	@echo "  make validate    - Validate EPUB with epubcheck"
	@echo "  make clean       - Remove generated files"
	@echo "  make docker-build - Rebuild Docker image"
	@echo ""

# Build Docker image
setup:
	@echo "Setting up build environment..."
	@./build/scripts/setup.sh

# Alias for setup
docker-build: setup

# Build EPUB
build-epub:
	@./build/scripts/build-epub.sh

# Build PDF
build-pdf:
	@./build/scripts/build-pdf.sh

# Build all formats
build-all: build-epub build-pdf
	@echo ""
	@echo "✅ All formats built successfully"
	@echo ""
	@echo "Output files:"
	@ls -lh output/epub/*.epub 2>/dev/null || echo "  (no EPUB files)"
	@ls -lh output/pdf/*.pdf 2>/dev/null || echo "  (no PDF files)"

# Validate EPUB (requires epubcheck)
validate:
	@echo "=== Validating EPUB ==="
	@if [ -f output/epub/BLEInAction.epub ]; then \
		if command -v epubcheck &> /dev/null; then \
			epubcheck output/epub/BLEInAction.epub; \
		else \
			echo "❌ epubcheck not installed"; \
			echo ""; \
			echo "Install via:"; \
			echo "  brew install epubcheck  (macOS)"; \
			echo "  Or download from: https://github.com/w3c/epubcheck"; \
			exit 1; \
		fi \
	else \
		echo "❌ EPUB file not found. Run 'make build-epub' first."; \
		exit 1; \
	fi

# Clean generated files
clean:
	@echo "Cleaning output files..."
	@rm -rf output/epub/*.epub
	@rm -rf output/pdf/*.pdf
	@rm -rf output/build-logs/*
	@echo "✅ Clean complete"
