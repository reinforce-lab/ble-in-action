# Feature Specification: Markdown Build Pipeline for Kindle Publishing

**Feature Branch**: `001-markdown-build-pipeline`  
**Created**: 2025-10-21  
**Status**: Draft  
**Input**: User description: "執筆環境を構築する。vscodeと親和性の高いmarkdown記法あるいは類似の記法などの、テキスト記法を用いる。これをビルドして配布可能なフォーマットを生成する。配布先はamazon kindleの電子書籍およびプリントオンデマンド書籍である。ビルド環境を構築する。現在はローカルでビルドできれば良い。しかし、将来的にCIにスムースに移行できる方法が望ましい。"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Write Content in VS Code (Priority: P1)

Authors write technical book content using Markdown syntax in VS Code with real-time preview, syntax highlighting, and editing features optimized for technical documentation including code blocks, tables, and BLE-specific terminology.

**Why this priority**: This is the foundation—without a smooth writing environment, no content can be created. Authors spend most time writing, so this must work flawlessly first.

**Independent Test**: Can be fully tested by creating a sample chapter with code examples, verifying syntax highlighting works, preview renders correctly, and files save properly in the project structure.

**Acceptance Scenarios**:

1. **Given** VS Code is open with the project, **When** author creates a new chapter file in Markdown, **Then** syntax highlighting and preview are immediately available
2. **Given** author is writing content with code blocks, **When** they format code with language-specific syntax (C, Swift, Kotlin), **Then** code blocks render with appropriate highlighting in preview
3. **Given** author includes tables and images, **When** they preview the document, **Then** formatting displays correctly with proper alignment and image references
4. **Given** author writes Japanese text with embedded English technical terms, **When** they save the file, **Then** encoding is preserved correctly (UTF-8)

---

### User Story 2 - Build to Kindle Formats Locally (Priority: P2)

Authors execute a local build command that converts Markdown source files into distributable formats required by Amazon Kindle Direct Publishing: EPUB for ebook and PDF for print-on-demand, with proper formatting, chapter structure, and metadata.

**Why this priority**: After writing content, authors need to verify the output looks correct before publishing. Local building enables rapid iteration on formatting issues.

**Independent Test**: Can be tested independently by running the build command on sample content and verifying both EPUB and PDF outputs are generated with correct formatting, metadata, and chapter structure.

**Acceptance Scenarios**:

1. **Given** Markdown source files exist in the project, **When** author runs the build command, **Then** both EPUB and PDF files are generated in an output directory
2. **Given** content includes code blocks and technical diagrams, **When** build completes, **Then** EPUB maintains code formatting and PDF preserves image quality for print
3. **Given** book has multiple chapters, **When** building to EPUB, **Then** table of contents is automatically generated with proper chapter hierarchy
4. **Given** build encounters formatting issues, **When** build runs, **Then** clear error messages indicate the specific file and line number of problems
5. **Given** author needs to verify output, **When** build completes, **Then** file paths for generated EPUB and PDF are displayed

---

### User Story 3 - CI-Ready Build Configuration (Priority: P3)

Build system is configured with clear separation between local and CI environments, using standard tooling and configuration files that can be easily adapted to GitHub Actions, GitLab CI, or other CI platforms without rewriting build logic.

**Why this priority**: While immediate need is local builds, planning for CI from the start avoids costly refactoring later. This enables automated builds on every commit once CI is added.

**Independent Test**: Can be tested by reviewing build scripts and configuration files to verify they use standard tools, avoid hard-coded local paths, and include environment variable support for CI customization.

**Acceptance Scenarios**:

1. **Given** build configuration files exist, **When** reviewing for CI compatibility, **Then** no hard-coded absolute paths are present, only relative paths from project root
2. **Given** build requires external tools, **When** examining dependencies, **Then** all tools are installable via standard package managers (pip, npm, apt, brew)
3. **Given** future CI migration is planned, **When** examining build scripts, **Then** environment variables are supported for output paths, version numbers, and build options
4. **Given** build needs to run in clean environments, **When** documenting requirements, **Then** all dependencies are listed with specific version numbers

---

### Edge Cases

- What happens when a Markdown file contains invalid syntax or malformed code blocks? (Build should fail with clear error message indicating file and line)
- What happens when image references point to missing files? (Build should fail or warn with specific missing file names)
- What happens when very large images are included for print PDF? (Build should warn if image resolution exceeds print requirements or file size is excessive)
- What happens when chapter ordering is ambiguous? (Build should use explicit ordering configuration, not rely on alphabetical file names)
- What happens when building on Windows vs macOS vs Linux? (Build should work consistently across platforms with same output)
- What happens when Kindle format requirements change? (Build configuration should be versioned and updatable)

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST support Markdown syntax including code blocks with syntax highlighting for C, C++, Swift, Kotlin, JavaScript, and Python
- **FR-002**: System MUST integrate with VS Code providing real-time preview and editing features
- **FR-003**: System MUST generate EPUB format compatible with Amazon Kindle Direct Publishing ebook requirements
- **FR-004**: System MUST generate PDF format suitable for Amazon Kindle print-on-demand with proper margins, page sizes, and image resolution
- **FR-005**: System MUST preserve UTF-8 encoding for Japanese text throughout the build process
- **FR-006**: System MUST automatically generate table of contents from chapter headings
- **FR-007**: System MUST allow authors to include and reference images that are properly embedded in both EPUB and PDF outputs
- **FR-008**: System MUST support custom metadata (title, author, ISBN, publication date, description) for Kindle publishing
- **FR-009**: System MUST execute build process via command-line interface for local execution
- **FR-010**: Build process MUST complete within reasonable time (under 5 minutes for typical 300-page book on modern hardware)
- **FR-011**: System MUST provide clear error messages with file names and line numbers when build fails
- **FR-012**: System MUST use standard, widely-adopted tools rather than obscure or unmaintained dependencies
- **FR-013**: Build configuration MUST avoid hard-coded absolute paths, using relative paths or environment variables
- **FR-014**: System MUST document all dependencies with specific version requirements

### Assumptions

- Authors have basic familiarity with Markdown syntax
- Authors have VS Code installed or can install it
- Local build environment is macOS (as indicated by user's workspace path), though cross-platform compatibility is desired
- Standard Amazon KDP format requirements apply (EPUB 3.0, PDF with specific dimensions)
- Images for book are provided in common formats (PNG, JPEG) with reasonable file sizes
- Build tools can be installed via standard package managers (Homebrew on macOS)
- Git is available for version control (indicated by .git directory presence)
- Internet connection is available for initial dependency installation

### Key Entities

- **Manuscript Source**: Collection of Markdown files representing book chapters, organized in directory structure
- **Build Configuration**: Settings file specifying book metadata, chapter ordering, output formats, and build options
- **Output Artifacts**: Generated EPUB and PDF files ready for upload to Amazon KDP
- **Build Environment**: Local development setup with required tools and dependencies installed
- **Asset Resources**: Images, diagrams, and supplementary files referenced from Markdown content

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Authors can write a complete chapter with code examples, preview it in VS Code, and see proper formatting within 30 seconds of file creation
- **SC-002**: Local build command generates both EPUB and PDF outputs from a 50-page manuscript in under 2 minutes
- **SC-003**: Generated EPUB files pass Amazon KDP's automated validation without errors
- **SC-004**: Generated PDF files meet Amazon KDP's print-on-demand specifications (margins, resolution, color space) on first upload
- **SC-005**: Authors can modify content and rebuild to see changes without manual file manipulation or cleanup steps
- **SC-006**: Build process works consistently on repeated runs (same input produces identical output)
- **SC-007**: Error messages are clear enough that authors can identify and fix formatting issues without consulting build system documentation in 90% of common cases
- **SC-008**: All build dependencies can be installed from scratch on a clean system in under 15 minutes following documentation

