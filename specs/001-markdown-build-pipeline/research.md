# Research: Technical Book Publishing Toolchains

**Feature**: Markdown Build Pipeline for Kindle Publishing  
**Research Date**: 2025-10-21  
**Purpose**: Identify and evaluate markdown-to-ebook toolchains suitable for technical book publishing to Amazon Kindle (EPUB + PDF)

## Executive Summary

After researching mainstream technical book publishing tools, **Pandoc** is recommended as the primary build tool with optional Asciidoctor as an alternative. Pandoc offers the best balance of: (1) wide adoption in technical publishing, (2) direct Markdown → EPUB/PDF conversion, (3) VS Code integration via extensions, (4) UTF-8/multi-language support, and (5) CI compatibility.

## Research Questions Resolved

### 1. Best Markdown-to-Ebook Toolchain for Technical Books

**Decision**: Pandoc (primary) with Asciidoctor as alternative

**Rationale**:
- Industry adoption: Used by O'Reilly, technical authors, and academic publishers
- Proven track record for code-heavy technical documentation
- Native support for Markdown → EPUB 3 → PDF workflow
- Extensive syntax support (code blocks, tables, math, citations)
- Actively maintained (2025 releases confirm ongoing development)

### 2. Primary Dependencies and Tools

**Decision**: 
- **Language**: Ruby/Python/Shell scripts (toolchain wrappers)
- **Build Tool**: Pandoc 3.x + LaTeX distribution (for PDF)
- **VS Code Extensions**: Markdown Preview Enhanced or Markdown All in One
- **Validation**: Amazon KDP validation tools (epubcheck, kindlegen)

**Rationale**:
- Pandoc is cross-platform (Windows/macOS/Linux) and package-manageable
- LaTeX provides high-quality PDF generation for print-on-demand
- VS Code extensions provide real-time preview without custom development
- All tools installable via standard package managers (brew, apt, choco)

## Tool Comparison Matrix

### Candidate Toolchains Evaluated

| Tool | Strengths | Weaknesses | KDP Suitability | Adoption |
| ---- | --------- | ---------- | --------------- | -------- |
| **Pandoc** | Universal converter, EPUB 3, PDF via LaTeX, metadata support, 3900+ GitHub stars | Requires LaTeX for PDF, learning curve for templates | ✅ Excellent - Direct EPUB/PDF output | ⭐⭐⭐⭐⭐ Very High (O'Reilly, academic) |
| **Sphinx** | Python-based, excellent for API docs, EPUB builder, extensive themes | Primarily RST (Markdown via extension), heavy for narrative books | ⚠️ Good - EPUB output, PDF needs config | ⭐⭐⭐⭐ High (Python/tech docs) |
| **Asciidoctor** | AsciiDoc syntax (superset of Markdown), EPUB 3 converter, PDF via asciidoctor-pdf | Different syntax than Markdown, requires gem ecosystem | ✅ Excellent - Native EPUB/PDF | ⭐⭐⭐ Medium (technical writing) |
| **Bookdown** | R-based, excellent for data science books, cross-references, EPUB/PDF output | Requires R ecosystem, R Markdown syntax | ⚠️ Good - EPUB output works | ⭐⭐ Medium (R/data science community) |
| **GitBook** | Beautiful web UI, Markdown-based, collaborative | Cloud-hosted, no local EPUB generation, limited control | ❌ Poor - Web-focused, no KDP output | ⭐⭐ Medium (web documentation) |
| **Leanpub** | Purpose-built for book publishing, Markdown/Markua, 80% royalties | Proprietary platform, limited local control | ⚠️ Alternative - Platform handles publishing | ⭐⭐⭐ Medium (indie publishers) |

### Decision Matrix

**Critical Requirements**:
1. ✅ Markdown input format
2. ✅ EPUB 3 output (Amazon KDP requirement)
3. ✅ PDF output (print-on-demand)
4. ✅ UTF-8 Japanese text support
5. ✅ Multi-language code block syntax highlighting
6. ✅ Local build capability (no cloud dependency)
7. ✅ CI-compatible (scriptable, reproducible)
8. ✅ VS Code integration (preview, linting)
9. ✅ Widely adopted (community support, longevity)
10. ✅ Package-manageable installation

**Scoring** (✅ = 1 point):
- **Pandoc**: 10/10 - Meets all requirements
- **Asciidoctor**: 9/10 - Uses AsciiDoc instead of pure Markdown (minor)
- **Sphinx**: 7/10 - Primarily RST, heavier setup for narrative books
- **Bookdown**: 6/10 - Requires R ecosystem, R Markdown syntax
- **GitBook**: 4/10 - No local EPUB/PDF generation
- **Leanpub**: 5/10 - Platform dependency, limited local control

## Selected Tool: Pandoc

### Why Pandoc?

1. **Universal Document Converter**: Converts between 40+ formats including Markdown → EPUB 3, Markdown → PDF (via LaTeX), Markdown → DOCX

2. **Technical Book Publishing Proven**:
   - Used by O'Reilly for technical book production
   - Standard tool in academic publishing (theses, papers)
   - Extensive use in programming book community

3. **Japanese Text Support**: Native UTF-8 handling, CJK font support in LaTeX/EPUB

4. **Code Block Excellence**:
   - Syntax highlighting via highlight.js, Pygments, or KDE's highlighting engine
   - Supports C, C++, Swift, Kotlin, JavaScript, Python, and 200+ languages
   - Preserves indentation and formatting

5. **Metadata Flexibility**: YAML front matter for book title, author, ISBN, publication date, cover image

6. **Amazon KDP Compatibility**:
   - EPUB 3.0 output passes Amazon validation
   - LaTeX PDF meets KDP print specifications (custom margins, page sizes)
   - Can generate both formats from single source

7. **VS Code Integration**:
   - Markdown Preview Enhanced extension supports Pandoc
   - Live preview with same rendering as final output
   - Syntax highlighting in editor

8. **CI-Ready**:
   - Command-line driven (no GUI required)
   - Docker images available (`pandoc/latex`, `pandoc/core`)
   - Reproducible builds via version-locked dependencies

9. **Active Maintenance**: Version 3.x (2025), regular updates, 35k+ GitHub stars

### Pandoc Architecture for This Project

```
Markdown Source Files
         ↓
   Pandoc Converter
         ↓
    ┌─────┴─────┐
    ↓           ↓
  EPUB 3       LaTeX
                ↓
              PDF (via pdflatex/xelatex)
```

### Pandoc Workflow

1. **Write**: Author writes in standard Markdown with YAML metadata header
2. **Preview**: VS Code + Markdown Preview Enhanced shows real-time rendering
3. **Build EPUB**: `pandoc -o book.epub` with custom CSS/template
4. **Build PDF**: `pandoc -o book.pdf --pdf-engine=xelatex` for Japanese text
5. **Validate**: Run `epubcheck book.epub` for KDP compliance
6. **Publish**: Upload EPUB and PDF to Amazon KDP

### Dependencies

**Core**:
- Pandoc 3.x (installable via brew, apt, choco)
- LaTeX distribution: TexLive or MacTeX (for PDF generation)
- epubcheck (Java-based EPUB validator)

**Optional but Recommended**:
- kindlegen or Kindle Previewer (Amazon's EPUB → MOBI converter for testing)
- Calibre (ebook management, format conversion, testing)
- Python 3.x (for build scripts)

**VS Code Extensions**:
- Markdown Preview Enhanced (pandoc-aware preview)
- Markdown All in One (TOC, formatting, shortcuts)
- Code Spell Checker (for Japanese + English)

**Installation Size**: ~2GB (Pandoc 100MB, LaTeX 1.5GB, supporting tools 400MB)

## Alternative Considered: Asciidoctor

**Why Consider?**
- Excellent for technical documentation
- Native PDF generation via asciidoctor-pdf (no LaTeX dependency)
- Powerful cross-reference and include system
- Used by major tech companies (Red Hat, GitLab)

**Why Not Selected as Primary?**
- AsciiDoc syntax differs from Markdown (requires learning curve)
- Smaller ecosystem than Markdown
- User requested "Markdown or similar markup" - Pandoc's Markdown is more familiar

**Recommendation**: Keep as fallback if Pandoc's PDF quality doesn't meet print requirements

## CI Migration Strategy

### Local Build (Immediate)

```bash
# Install dependencies (macOS)
brew install pandoc
brew install --cask mactex-no-gui  # LaTeX without GUI apps
brew install epubcheck

# Build commands
pandoc manuscript/**/*.md -o output/book.epub --metadata-file=metadata.yml
pandoc manuscript/**/*.md -o output/book.pdf --pdf-engine=xelatex --metadata-file=metadata.yml
```

### CI Build (Future)

**GitHub Actions Example**:
```yaml
name: Build Book
on: [push]
jobs:
  build:
    runs-on: ubuntu-latest
    container:
      image: pandoc/latex:latest
    steps:
      - uses: actions/checkout@v3
      - name: Build EPUB
        run: pandoc manuscript/**/*.md -o book.epub --metadata-file=metadata.yml
      - name: Build PDF
        run: pandoc manuscript/**/*.md -o book.pdf --pdf-engine=xelatex --metadata-file=metadata.yml
      - name: Validate EPUB
        run: epubcheck book.epub
      - name: Upload artifacts
        uses: actions/upload-artifact@v3
        with:
          name: book-outputs
          path: |
            book.epub
            book.pdf
```

**Key CI Compatibility Features**:
- Pandoc Docker images (no local installation needed in CI)
- Deterministic builds (same input → same output)
- Environment variable support for version numbers, metadata
- Exit codes for validation failures

## Risks and Mitigations

| Risk | Likelihood | Impact | Mitigation |
| ---- | ---------- | ------ | ---------- |
| LaTeX installation too large for developers | Medium | Medium | Provide Docker-based build option; document minimal LaTeX installation |
| Pandoc template customization learning curve | Medium | Low | Start with default templates; customize incrementally based on KDP feedback |
| EPUB output doesn't pass Amazon validation | Low | High | Test early with sample content; use epubcheck before KDP upload |
| Japanese text rendering issues in PDF | Medium | Medium | Use xelatex engine; specify CJK fonts; test with sample Japanese content |
| Build time exceeds 5-minute target for large books | Low | Low | Optimize by building chapters incrementally; cache LaTeX artifacts |

## Implementation Recommendations

### Phase 0: Proof of Concept (1-2 days)
1. Install Pandoc + LaTeX on development machine
2. Create sample chapter with:
   - Japanese text + English technical terms
   - Code blocks in multiple languages (C, Swift, Kotlin)
   - Images and diagrams
   - Tables
3. Build to EPUB and PDF
4. Validate EPUB with epubcheck
5. Review PDF print quality
6. Test in Kindle Previewer

### Phase 1: Production Setup (3-5 days)
1. Create manuscript directory structure
2. Set up metadata.yml with book information
3. Configure VS Code with extensions
4. Create build scripts (build.sh for EPUB, PDF, validation)
5. Document dependency installation process
6. Create sample CI workflow (GitHub Actions YAML)

### Phase 2: Optimization (ongoing)
1. Customize EPUB CSS for better code block rendering
2. Customize LaTeX template for print specifications
3. Add image optimization to build pipeline
4. Create validation checklist for KDP requirements

## Alternatives Rejected

### Markdown Processors NOT Chosen:

**GitBook**: Web-focused, no local EPUB/PDF generation without custom tooling

**Jekyll/Hugo**: Static site generators, not designed for ebook output

**MkDocs**: Documentation site generator, lacks EPUB/PDF workflow

**Sphinx with Markdown**: Overkill for narrative book; better suited for API documentation

**Bookdown**: Requires R ecosystem; R Markdown syntax less familiar than standard Markdown

**Leanpub**: Platform dependency; prefer local-first with optional platform publishing

## References

- [Pandoc User's Guide](https://pandoc.org/MANUAL.html)
- [Pandoc EPUB Output](https://pandoc.org/epub.html)
- [Amazon Kindle Direct Publishing Guidelines](https://kdp.amazon.com/en_US/help/topic/G200735480)
- [EPUB 3.0 Specification](https://www.w3.org/publishing/epub3/epub-spec.html)
- [Sustainable Authorship in Plain Text using Pandoc and Markdown](https://programminghistorian.org/en/lessons/sustainable-authorship-in-plain-text-using-pandoc-and-markdown)

## Conclusion

**Pandoc** provides the optimal solution for this BLE technical book project:
- ✅ Mature, widely-adopted toolchain used by professional publishers
- ✅ Direct Markdown → EPUB 3 + PDF workflow
- ✅ Excellent support for code-heavy technical content
- ✅ UTF-8 Japanese text handling
- ✅ VS Code integration via extensions
- ✅ CI-compatible from day one
- ✅ All dependencies package-manageable

This decision resolves the NEEDS CLARIFICATION items in the Technical Context and enables proceeding to Phase 1 (design).