# Use latest TeX Live image and install Pandoc on top
# This avoids version mismatch issues with pandoc/latex base image
FROM texlive/texlive:latest

# Install Pandoc and Japanese fonts
RUN apt-get update && \
    apt-get install -y \
    wget \
    fonts-noto-cjk \
    fonts-noto-color-emoji \
    && rm -rf /var/lib/apt/lists/*

# Install latest Pandoc from GitHub releases
# Detect architecture and download appropriate package
RUN PANDOC_VERSION=3.4 && \
    ARCH=$(dpkg --print-architecture) && \
    wget -q https://github.com/jgm/pandoc/releases/download/${PANDOC_VERSION}/pandoc-${PANDOC_VERSION}-1-${ARCH}.deb && \
    dpkg -i pandoc-${PANDOC_VERSION}-1-${ARCH}.deb && \
    rm pandoc-${PANDOC_VERSION}-1-${ARCH}.deb

# Install Japanese LaTeX support packages
RUN tlmgr install \
    collection-langjapanese \
    xecjk \
    luatexja \
    bxjscls \
    titlesec \
    fancyhdr

# Set working directory
WORKDIR /data

# Default to xelatex for Japanese support
ENV PANDOC_PDF_ENGINE=xelatex
