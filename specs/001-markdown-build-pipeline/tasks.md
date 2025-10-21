---
description: "Implementation tasks for Markdown Build Pipeline for Kindle Publishing"
---

# Tasks: Markdown Build Pipeline for Kindle Publishing

**Input**: Design documents from `/specs/001-markdown-build-pipeline/`
**Prerequisites**: plan.md, spec.md, research.md, data-model.md, quickstart.md

**Tests**: Tests are NOT explicitly requested in the spec. Manual validation via Amazon KDP validator and test builds will be used.

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`
- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Path Conventions
- **Project type**: Single project (book manuscript with build tooling)
- **Structure**: `manuscript/` for content, `build/` for tooling, `output/` for artifacts
- Paths are relative to repository root `/Users/u_akihiro/Desktop/BLEInAction`

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic directory structure

- [X] T001 Create directory structure: `manuscript/chapters/`, `manuscript/images/{diagrams,screenshots}`, `manuscript/code-examples/{embedded,ios,android}`
- [X] T002 Create directory structure: `build/{scripts,templates,config}`, `output/{epub,pdf,validation-reports,build-logs}`
- [X] T003 [P] Create `.vscode/settings.json` with UTF-8 encoding, markdown preview, and Japanese support settings
- [X] T004 [P] Create `.vscode/tasks.json` with build tasks for EPUB, PDF, and validation
- [X] T005 [P] Create `.vscode/extensions.json` recommending Markdown All in One, Markdown Preview Enhanced, Code Spell Checker
- [X] T006 [P] Update `.gitignore` to exclude `output/` directory and temporary build files

**Checkpoint**: Project structure ready for content and build system

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core build infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until build system foundation is established

- [X] T007 [P] Research Docker pandoc/latex with Japanese CJK font support (xelatex, luatex, collection-langjapanese)
- [X] T008 [P] Create `build/scripts/setup.sh` with installation instructions or Docker setup
- [X] T009 [P] Create `manuscript/metadata.yml` with book title, author, language (ja), ISBN placeholder
- [X] T010 [P] Create `manuscript/chapters.txt` listing chapter markdown files in order
- [X] T011 [P] Create `build/config/build.yml` with Pandoc configuration (formats, engines, options)
- [X] T012 [P] Create `build/templates/epub-styles.css` with basic EPUB styling (fonts, spacing, code blocks)
- [X] T013 [P] Create `build/templates/latex-preamble.tex` with Japanese font configuration and page setup

**Checkpoint**: Foundation ready - user stories can now be implemented

---

## Phase 3: User Story 1 - Write Content in VS Code (Priority: P1) 🎯 MVP

**Goal**: Authors can write technical book content using Markdown in VS Code with real-time preview, syntax highlighting, and Japanese text support

**Independent Test**: Create sample chapter with Japanese text and code blocks, verify preview renders correctly, save file and confirm UTF-8 encoding preserved

### Implementation for User Story 1

- [X] T014 [P] [US1] Create sample chapter `manuscript/chapters/01-introduction.md` with Japanese text, English technical terms, code blocks (C, Swift, Kotlin), table, and image reference
- [X] T015 [P] [US1] Add sample images: `manuscript/images/cover.png` (1600x2400px placeholder) and `manuscript/images/diagrams/sample-architecture.png`
- [X] T016 [US1] Create build scripts: `build/scripts/build-epub.sh` and `build/scripts/build-pdf.sh` for automated conversion
- [X] T017 [US1] Create `Makefile` with targets: `build-epub`, `build-pdf`, `build-all`, `validate`, `clean`
- [X] T018 [US1] Update `manuscript/chapters.txt` to include `chapters/01-introduction.md` (already done in T010)
- [X] T019 [US1] Create `quickstart.md` with setup instructions, build commands, troubleshooting, and writing guidelines

**Checkpoint**: VS Code writing environment fully functional with Japanese text support

**Bug Fix (2025-10-21)**: ARM64 (Apple Silicon) compatibility
- [X] Fixed Dockerfile to use AMD64 emulation (pandoc/latex doesn't have native ARM64 image)
- [X] Split build.yml into separate epub.yml and pdf.yml (Pandoc defaults file format requirement)
- [X] Updated build scripts with `--platform linux/amd64` flag to suppress warnings
- [X] Added platform detection to setup.sh with informative message

---

## Phase 4: User Story 2 - Build to Kindle Formats Locally (Priority: P2)

**Goal**: Authors execute local build command that converts Markdown to EPUB and PDF with proper formatting and Japanese text support

**Independent Test**: Run build scripts on sample content and verify both EPUB and PDF outputs are generated, open them to confirm formatting and Japanese text rendering

### Implementation for User Story 2

- [ ] T020 [US2] Create `build/scripts/build-epub.sh` - reads `chapters.txt`, runs Pandoc with EPUB3 output, applies metadata and CSS template
- [ ] T021 [US2] Create `build/scripts/build-pdf.sh` - reads `chapters.txt`, runs Pandoc with PDF output via xelatex engine for Japanese text, applies LaTeX template
- [ ] T022 [US2] Create `build/scripts/build.sh` - orchestrates both EPUB and PDF builds, provides status output and final artifact locations
- [ ] T023 [US2] Create `build/scripts/validate.sh` - runs epubcheck on generated EPUB, saves validation report to `output/validation-reports/`
- [ ] T024 [US2] Make all build scripts executable with `chmod +x`
- [ ] T025 [US2] Update `build/scripts/build-epub.sh` to use Docker fallback if local Pandoc not installed: `docker run --rm -v "$(pwd):/data" -u $(id -u):$(id -g) pandoc/latex`
- [ ] T026 [US2] Update `build/scripts/build-pdf.sh` to use Docker with Japanese fonts: research `pandoc/latex` image CJK font installation or mount custom fonts
- [ ] T027 [US2] Test local build by running `./build/scripts/build.sh` - verify EPUB generated at `output/epub/BLEInAction.epub`
- [ ] T028 [US2] Test local build by running `./build/scripts/build.sh` - verify PDF generated at `output/pdf/BLEInAction.pdf` with Japanese text rendered correctly
- [ ] T029 [US2] Run `./build/scripts/validate.sh` - verify EPUB passes epubcheck validation (EPUB 3.0 compliance)
- [ ] T030 [US2] Open generated EPUB in Apple Books or Calibre - verify Japanese text, code blocks, table of contents, and images display correctly
- [ ] T031 [US2] Open generated PDF in Preview - verify Japanese text renders with correct font, page layout matches print specs, code blocks are readable

**Checkpoint**: Local build pipeline fully functional with Japanese text support and EPUB/PDF validation

---

## Phase 5: User Story 3 - CI-Ready Build Configuration (Priority: P3)

**Goal**: Build system uses standard tooling, relative paths, and environment variables to enable smooth CI migration in the future

**Independent Test**: Review build scripts for hard-coded paths, verify all dependencies are documented with versions, confirm Docker-based build works in isolated environment

### Implementation for User Story 3

- [ ] T032 [P] [US3] Create `build/scripts/docker-build.sh` - wrapper script that runs build entirely in Docker container (pandoc/latex:latest)
- [ ] T033 [P] [US3] Create `.github/workflows/build-book.yml.sample` - example GitHub Actions workflow showing Docker-based build, artifact upload, and validation
- [ ] T034 [US3] Audit `build/scripts/build-epub.sh` - replace any hard-coded paths with `$PROJECT_ROOT` environment variable and relative paths
- [ ] T035 [US3] Audit `build/scripts/build-pdf.sh` - replace any hard-coded paths with `$PROJECT_ROOT` environment variable and relative paths
- [ ] T036 [US3] Create `build/scripts/install-dependencies.sh` - documents all tool versions (Pandoc 3.x, TeXLive 2024+, epubcheck) and provides automated installation
- [ ] T037 [US3] Update `manuscript/metadata.yml` to support version number from environment variable `${VERSION:-1.0.0}` for CI builds
- [ ] T038 [US3] Test Docker-based build by running `./build/scripts/docker-build.sh` in clean environment - verify EPUB and PDF generated successfully
- [ ] T039 [US3] Document CI migration path in `specs/001-markdown-build-pipeline/quickstart.md` CI section with GitHub Actions and GitLab CI examples
- [ ] T040 [US3] Verify no absolute paths remain in build scripts by running `grep -r "/Users/" build/scripts/` (should return empty)

**Checkpoint**: Build system is CI-ready with Docker support and portable configuration

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Documentation, validation, and quality improvements across all user stories

- [ ] T041 [P] Create `README.md` at repository root with project overview, quickstart link, and build command examples
- [ ] T042 [P] Create `manuscript/README.md` explaining directory structure and authoring guidelines (chapter naming, image placement, code examples)
- [ ] T043 [P] Create `build/README.md` documenting build system architecture, script purposes, and customization options
- [ ] T044 [P] Add Japanese code example: create `manuscript/code-examples/embedded/nrf52-beacon/main.c` with BLE beacon implementation and Japanese comments
- [ ] T045 Validate all success criteria from `specs/001-markdown-build-pipeline/spec.md` against actual implementation
- [ ] T046 Update `specs/001-markdown-build-pipeline/quickstart.md` to prioritize Docker-based setup instead of local tool installation - rewrite installation steps for Docker approach
- [ ] T047 Add Docker-specific troubleshooting section to quickstart.md (Docker not installed, volume mount issues, CJK font problems in container)
- [ ] T048 Run full build and validation workflow per updated `specs/001-markdown-build-pipeline/quickstart.md` - document any deviations or improvements
- [ ] T049 Create troubleshooting section in quickstart.md based on actual build issues encountered during Docker testing
- [ ] T050 Update `.github/copilot-instructions.md` if new patterns or conventions emerge during implementation

**Checkpoint**: Project is fully documented and validated against specification

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3-5)**: All depend on Foundational phase completion
  - User stories can proceed in parallel (if staffed)
  - Or sequentially in priority order (P1 → P2 → P3)
- **Polish (Phase 6)**: Depends on all user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2) - No dependencies on other stories - **THIS IS THE MVP**
- **User Story 2 (P2)**: Can start after Foundational (Phase 2) - Technically independent but naturally builds on US1 content
- **User Story 3 (P3)**: Can start after Foundational (Phase 2) - Refines US2 build scripts for CI compatibility

### Within Each User Story

- **US1**: All tasks are parallel except T018-T019 which require T014-T017 to complete
- **US2**: T020-T024 can run in parallel, T025-T026 refine them, T027-T031 are sequential validation steps
- **US3**: T032-T036 can run in parallel, T037 is independent, T038-T040 are sequential validation steps

### Parallel Opportunities

- Phase 1: T003, T004, T005, T006 can all run in parallel (different files)
- Phase 2: T012 and T013 can run in parallel (different template files)
- Phase 3: T014, T015 can run in parallel (different files)
- Phase 4: T020, T021, T022, T023 can run in parallel (different scripts)
- Phase 5: T032, T033, T034, T035, T036 can all start in parallel
- Phase 6: T041, T042, T043, T044 can all run in parallel (different documentation files)

---

## Parallel Example: User Story 2 (Build Scripts)

```bash
# Launch all build script creation tasks together:
Terminal 1: "Create build-epub.sh script with Pandoc EPUB3 conversion"
Terminal 2: "Create build-pdf.sh script with xelatex PDF generation"
Terminal 3: "Create build.sh orchestration script"
Terminal 4: "Create validate.sh script with epubcheck"

# Then sequentially validate outputs:
Step 1: Make scripts executable
Step 2: Test EPUB build
Step 3: Test PDF build
Step 4: Validate EPUB
Step 5: Manually verify outputs
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

This is the recommended starting approach:

1. Complete Phase 1: Setup (T001-T006) - 30 minutes
2. Complete Phase 2: Foundational (T007-T013) - 2-3 hours (including Docker research)
3. Complete Phase 3: User Story 1 (T014-T019) - 1 hour
4. **STOP and VALIDATE**: Test writing environment
   - Open VS Code in project
   - Create/edit sample chapter
   - Verify Japanese text displays correctly
   - Confirm syntax highlighting works for code blocks
   - Check markdown preview rendering
5. **MVP COMPLETE** - Writing environment is functional

At this point, authors can begin writing book content even without build system!

### Full Feature Delivery

After MVP validation:

6. Complete Phase 4: User Story 2 (T020-T031) - 3-4 hours (including Docker PDF setup)
7. **VALIDATE US2**: Test build pipeline
   - Run build scripts
   - Verify EPUB and PDF generation
   - Check Japanese text rendering in outputs
   - Validate EPUB compliance
8. Complete Phase 5: User Story 3 (T032-T040) - 2-3 hours
9. **VALIDATE US3**: Test CI compatibility
   - Run Docker-based build in isolated environment
   - Verify no hard-coded paths
   - Check GitHub Actions example
10. Complete Phase 6: Polish (T041-T048) - 2-3 hours
11. **FINAL VALIDATION**: Run complete quickstart guide end-to-end

**Total Estimated Time**: 12-16 hours for complete feature

### Incremental Delivery Milestones

1. **Milestone 1 (MVP)**: Writing environment ready (Phase 1-3) → Authors can write content
2. **Milestone 2**: Local builds working (Phase 4) → Authors can generate EPUB/PDF locally
3. **Milestone 3**: CI-ready (Phase 5) → Future automated builds enabled
4. **Milestone 4**: Production-ready (Phase 6) → Fully documented and validated

### Docker-First Alternative Strategy

For users who prefer Docker from the start (no local LaTeX installation):

1. Complete Phase 1: Setup
2. Complete Phase 2: Foundational BUT prioritize Docker research (T007)
3. Create Docker-based build scripts FIRST (combine T020-T022 with T032)
4. Then complete User Story 1 (writing environment)
5. Validate both writing and building together

**Advantage**: Avoids ~2GB local LaTeX installation
**Trade-off**: Slightly longer build times (Docker container startup)

---

## Special Considerations for Japanese Text

### Critical Tasks for Japanese Support

These tasks are NON-NEGOTIABLE for proper Japanese text rendering:

- **T007**: Research Docker Japanese font setup - MUST include CJK font installation
- **T013**: LaTeX preamble MUST configure Japanese font (Hiragino Mincho ProN or equivalent)
- **T016**: Metadata MUST specify `language: ja-JP`
- **T021**: PDF build MUST use xelatex engine (not pdflatex) for UTF-8 support
- **T026**: Docker PDF build MUST include Japanese font packages (`collection-langjapanese`)

### Validation Points for Japanese Text

- **After T018**: Preview MUST show Japanese characters correctly in VS Code
- **After T028**: PDF MUST render Japanese text with correct font (no missing glyphs)
- **After T030**: EPUB MUST display Japanese text in Apple Books/Calibre

### Web Research Required (T007, T026)

Search for:
- "pandoc/latex Docker Japanese CJK fonts"
- "Docker texlive Japanese fonts collection-langjapanese"
- "pandoc xelatex Japanese UTF-8"
- Latest 2025 best practices for Pandoc Japanese PDF generation

Update build scripts based on findings to ensure robust Japanese support.

---

## Notes

- [P] tasks = different files, no dependencies
- [Story] label maps task to specific user story for traceability
- Each user story should be independently completable and testable
- No automated tests - validation is manual via build outputs and KDP validation tools
- **Docker approach minimizes local dependencies (~100MB vs ~2GB)** - Primary setup method
- **T046-T047**: Update quickstart.md to reflect Docker-first approach instead of local installation
- Japanese text support is critical - validate at every checkpoint
- Commit after each task or logical group
- Stop at any checkpoint to validate story independently
- Expected build time: <2 minutes for 50-page manuscript, <5 minutes for 300-page book

---

## Task Summary

**Total Tasks**: 50 (T001-T050)

**By Phase**:
- Phase 1 (Setup): 6 tasks
- Phase 2 (Foundational): 7 tasks - **BLOCKS all user stories**
- Phase 3 (User Story 1 - Write Content): 6 tasks - **🎯 MVP**
- Phase 4 (User Story 2 - Build Locally): 12 tasks
- Phase 5 (User Story 3 - CI-Ready): 9 tasks
- Phase 6 (Polish & Documentation): 10 tasks

**By User Story**:
- User Story 1 (P1 - Writing Environment): 6 tasks
- User Story 2 (P2 - Local Build): 12 tasks
- User Story 3 (P3 - CI-Ready): 9 tasks
- Infrastructure (Setup + Foundational + Polish): 23 tasks

**Key Docker Tasks**:
- T007: Research Docker pandoc/latex with Japanese fonts
- T025-T026: Add Docker fallback to build scripts
- T032: Create docker-build.sh wrapper
- T038: Validate Docker build in clean environment
- **T046-T047: Update quickstart.md for Docker-first setup** (NEW)

**Parallelizable Tasks**: 22 tasks marked with [P]

**Estimated Time**: 12-16 hours total (MVP: 3-4 hours for T001-T019)
