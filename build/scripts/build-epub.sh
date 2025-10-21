#!/usr/bin/env bash
# Build EPUB format from manuscript
# Uses Docker to ensure consistent build environment

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
DOCKER_IMAGE="bleinaction-pandoc:latest"
BUILD_DIR="$(cd "$(dirname "$0")/.." && pwd)"
PROJECT_ROOT="$(cd "$BUILD_DIR/.." && pwd)"
MANUSCRIPT_DIR="$PROJECT_ROOT/manuscript"
OUTPUT_DIR="$PROJECT_ROOT/output/epub"
BUILD_LOG="$PROJECT_ROOT/output/build-logs/epub-build-$(date +%Y%m%d-%H%M%S).log"

echo "=== Building EPUB Format ==="
echo "Project root: $PROJECT_ROOT"
echo "Build log: $BUILD_LOG"
echo ""

# Create output directories
mkdir -p "$OUTPUT_DIR"
mkdir -p "$(dirname "$BUILD_LOG")"

# Check if Docker image exists
if ! docker image inspect "$DOCKER_IMAGE" &> /dev/null; then
    echo -e "${YELLOW}Docker image not found. Building...${NC}"
    cd "$PROJECT_ROOT"
    docker build -t "$DOCKER_IMAGE" .
    if [ $? -ne 0 ]; then
        echo -e "${RED}Failed to build Docker image${NC}"
        exit 1
    fi
fi

# Read chapter list (skip comments and empty lines)
CHAPTERS=()
while IFS= read -r line; do
    # Skip comments and empty lines
    if [[ ! "$line" =~ ^# ]] && [[ -n "${line// }" ]]; then
        CHAPTERS+=("$line")
    fi
done < "$MANUSCRIPT_DIR/chapters.txt"

if [ ${#CHAPTERS[@]} -eq 0 ]; then
    echo -e "${YELLOW}Warning: No chapters found in chapters.txt${NC}"
    echo "  Creating empty book for testing purposes"
fi

# Build chapter file list for pandoc
CHAPTER_FILES=""
for chapter in "${CHAPTERS[@]}"; do
    CHAPTER_FILES="$CHAPTER_FILES manuscript/$chapter"
done

# Pandoc command
echo "Running Pandoc..."
docker run --rm \
    --volume "$PROJECT_ROOT:/data" \
    --workdir /data \
    "$DOCKER_IMAGE" \
    pandoc $CHAPTER_FILES \
    --defaults=build/config/epub.yml \
    --output=output/epub/BLEInAction.epub \
    2>&1 | tee "$BUILD_LOG"

# Check build result
if [ ${PIPESTATUS[0]} -eq 0 ]; then
    echo ""
    echo -e "${GREEN}✅ EPUB build successful!${NC}"
    echo ""
    echo "Output file: $OUTPUT_DIR/BLEInAction.epub"
    echo "Build log: $BUILD_LOG"
    
    # Show file size
    if [ -f "$OUTPUT_DIR/BLEInAction.epub" ]; then
        SIZE=$(du -h "$OUTPUT_DIR/BLEInAction.epub" | cut -f1)
        echo "File size: $SIZE"
    fi
else
    echo ""
    echo -e "${RED}❌ EPUB build failed${NC}"
    echo "Check build log for details: $BUILD_LOG"
    exit 1
fi
