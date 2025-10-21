#!/usr/bin/env bash
# Setup script for BLEInAction build environment
# Uses Docker to avoid 2GB local LaTeX installation

set -e  # Exit on error

echo "=== BLEInAction Build Environment Setup ==="
echo ""

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed"
    echo ""
    echo "Please install Docker Desktop from:"
    echo "  https://www.docker.com/products/docker-desktop"
    echo ""
    exit 1
fi

echo "✅ Docker is installed"

# Check if Docker is running
if ! docker info &> /dev/null; then
    echo "❌ Docker is not running"
    echo ""
    echo "Please start Docker Desktop and try again"
    exit 1
fi

echo "✅ Docker is running"

# Build custom pandoc image with Japanese support
echo ""
echo "Building custom Pandoc image with Japanese font support..."
echo "(This will take several minutes on first run)"
echo ""
echo "Detected platform: $(uname -m)"
if [[ "$(uname -m)" == "arm64" ]]; then
    echo "Note: Using AMD64 emulation on Apple Silicon (pandoc/latex native ARM64 not available)"
fi
echo ""

docker build -t bleinaction-pandoc:latest .

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Build environment ready!"
    echo ""
    echo "You can now use the following commands:"
    echo "  - make build-epub   # Build EPUB format"
    echo "  - make build-pdf    # Build PDF format"
    echo "  - make build-all    # Build all formats"
    echo "  - make validate     # Validate EPUB"
    echo ""
else
    echo ""
    echo "❌ Failed to build Docker image"
    echo ""
    echo "Please check the error messages above"
    exit 1
fi
