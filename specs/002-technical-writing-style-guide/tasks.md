# Implementation Tasks: Technical Writing Style Guide

**Feature**: 002-technical-writing-style-guide  
**Branch**: `002-technical-writing-style-guide`  
**Generated**: 2025-10-23

## Overview

This document provides a detailed task breakdown for implementing the technical writing style guide. The guide will be ~300 lines of Markdown documentation defining Japanese grammar conventions, punctuation rules, technical element formatting, and citation standards.

**Deliverable**: `docs/writing-style-guide.md` (250-350 lines)

**Implementation Strategy**: This is a documentation-only feature with no code. Tasks are organized by user story priority to enable independent, incremental delivery. Each user story delivers a testable increment.

---

## User Story Dependencies

```
Phase 1 (Setup)
    ↓
Phase 2 (Foundational - US1: Basic Writing Style)
    ↓
Phase 3 (US2: Technical Elements) ← Can start in parallel after US1 structure exists
    ↓
Phase 4 (US3: Citations) ← Can start in parallel after US1 structure exists
    ↓
Phase 5 (Polish)
```

**MVP Scope**: User Story 1 only - provides essential writing style rules  
**Parallel Opportunities**: US2 and US3 can be worked on independently after US1 completes

---

## Phase 1: Setup

**Goal**: Initialize file structure and basic document framework

**Duration**: 5-10 minutes

### Tasks

- [x] T001 Create docs directory in repository root at `/Users/u_akihiro/Desktop/BLEInAction/docs/`
- [x] T002 Create empty style guide file at `/Users/u_akihiro/Desktop/BLEInAction/docs/writing-style-guide.md`
- [x] T003 Add document header with title, version, date, and audience in `/Users/u_akihiro/Desktop/BLEInAction/docs/writing-style-guide.md`

**Completion Criteria**: 
- docs/ directory exists
- writing-style-guide.md file created with header
- File is valid Markdown

---

## Phase 2: User Story 1 - Apply Consistent Writing Style (Priority: P1)

**Story Goal**: Authors can write technical content following consistent Japanese grammar and punctuation rules

**Why P1**: Core value - establishes foundation for all writing. Without this, authors have no baseline for consistency.

**Independent Test**: Author writes sample chapter section, reviewer verifies てにおは usage, punctuation, and tone match style guide rules. Delivers immediate value by preventing style drift.

**Estimated Duration**: 60-75 minutes

### Tasks

- [ ] T004 [US1] Add Section 1 "はじめに" (Introduction) with purpose, audience, and referenced publisher guidelines in `/Users/u_akihiro/Desktop/BLEInAction/docs/writing-style-guide.md`
- [ ] T005 [US1] Add Section 2.1 "文体と敬体" defining です・ます form with correct/incorrect examples in `/Users/u_akihiro/Desktop/BLEInAction/docs/writing-style-guide.md`
- [ ] T006 [P] [US1] Add Section 2.2 "助詞の使い方" covering は/が/を/に/で/と particles with examples in `/Users/u_akihiro/Desktop/BLEInAction/docs/writing-style-guide.md`
- [ ] T007 [P] [US1] Add Section 2.3 "句読点の規則" defining comma (、) and period (。) usage with examples in `/Users/u_akihiro/Desktop/BLEInAction/docs/writing-style-guide.md`
- [ ] T008 [P] [US1] Add Section 2.4 "引用符とカッコの使い分け" with table showing 「」/""/()/ [] usage in `/Users/u_akihiro/Desktop/BLEInAction/docs/writing-style-guide.md`
- [ ] T009 [P] [US1] Add Section 3.1 "英語技術用語の表記" defining first-use format and subsequent usage in `/Users/u_akihiro/Desktop/BLEInAction/docs/writing-style-guide.md`
- [ ] T010 [P] [US1] Add Section 3.2 "略語の定義" with table of BLE/GATT/UUID abbreviations in `/Users/u_akihiro/Desktop/BLEInAction/docs/writing-style-guide.md`
- [ ] T011 [P] [US1] Add Section 3.3 "カタカナ表記" with romanization and API term handling rules in `/Users/u_akihiro/Desktop/BLEInAction/docs/writing-style-guide.md`
- [ ] T012 [US1] Validate US1 sections: check examples present, rules clear, length ~120 lines of `/Users/u_akihiro/Desktop/BLEInAction/docs/writing-style-guide.md`

**Acceptance Criteria** (from spec.md):
- ✅ Author can find てにおは rules with correct/incorrect examples
- ✅ Punctuation rules (、。,.) defined with usage contexts
- ✅ Technical term handling with first-use format specified

**Parallel Execution Example**:
```bash
# Tasks T006-T011 can be written independently after T005 completes
# Each task works on different subsections of the document
```

**Deliverable After US1**: 
- Sections 1-3 complete (~120 lines)
- Basic writing style established
- Authors can start writing with consistent grammar/punctuation

---

## Phase 3: User Story 2 - Format Technical Elements Correctly (Priority: P2)

**Story Goal**: Authors can insert figures, tables, equations, and code blocks following standardized formatting

**Why P2**: Technical content requires special formatting. Essential for credibility but depends on basic writing style (US1) being established first.

**Independent Test**: Author creates section with 1 figure, 1 table, 1 equation, 1 code block - reviewer verifies all follow prescribed formats. Each element type testable separately.

**Estimated Duration**: 80-90 minutes

### Tasks

- [ ] T013 [US2] Add Section 4.1 "図の書式" with Markdown syntax, caption format, and file naming rules in `/Users/u_akihiro/Desktop/BLEInAction/docs/writing-style-guide.md`
- [ ] T014 [P] [US2] Add Section 4.2 "表の書式" with Pandoc table syntax and caption placement in `/Users/u_akihiro/Desktop/BLEInAction/docs/writing-style-guide.md`
- [ ] T015 [P] [US2] Add Section 4.3 "クロスリファレンス" with figure/table reference syntax in `/Users/u_akihiro/Desktop/BLEInAction/docs/writing-style-guide.md`
- [ ] T016 [P] [US2] Add Section 5.1 "インラインコード" with backtick usage for functions/variables in `/Users/u_akihiro/Desktop/BLEInAction/docs/writing-style-guide.md`
- [ ] T017 [P] [US2] Add Section 5.2 "コードブロック" with language-tagged fenced code blocks and caption format in `/Users/u_akihiro/Desktop/BLEInAction/docs/writing-style-guide.md`
- [ ] T018 [P] [US2] Add Section 5.3 "言語タグ" listing supported languages (c, swift, kotlin, python, json, bash) in `/Users/u_akihiro/Desktop/BLEInAction/docs/writing-style-guide.md`
- [ ] T019 [P] [US2] Add Section 5.4 "コメントの言語" with Japanese comment preference and examples in `/Users/u_akihiro/Desktop/BLEInAction/docs/writing-style-guide.md`
- [ ] T020 [P] [US2] Add Section 6.1 "インライン数式" with $...$ syntax for variables in `/Users/u_akihiro/Desktop/BLEInAction/docs/writing-style-guide.md`
- [ ] T021 [P] [US2] Add Section 6.2 "ディスプレイ数式" with $$...$$ syntax and equation labeling in `/Users/u_akihiro/Desktop/BLEInAction/docs/writing-style-guide.md`
- [ ] T022 [P] [US2] Add Section 6.3 "変数と記号の命名" with LaTeX formatting conventions in `/Users/u_akihiro/Desktop/BLEInAction/docs/writing-style-guide.md`
- [ ] T023 [US2] Validate US2 sections: check all element types covered, examples present, length ~110 lines of `/Users/u_akihiro/Desktop/BLEInAction/docs/writing-style-guide.md`

**Acceptance Criteria** (from spec.md):
- ✅ Figure format: numbered caption, proper placement, sizing standards
- ✅ Equation format: numbered, aligned, LaTeX/Pandoc syntax
- ✅ Code format: language specification, syntax highlighting, line numbering rules

**Parallel Execution Example**:
```bash
# Tasks T014-T022 can be written independently after T013 completes
# Figures, tables, code, and equations are separate subsections
```

**Deliverable After US2**: 
- Sections 4-6 complete (~110 additional lines, total ~230)
- All technical element formatting defined
- Authors can include properly formatted figures, tables, equations, code

---

## Phase 4: User Story 3 - Cite Sources Properly (Priority: P3)

**Story Goal**: Authors can cite reference sources with working URLs so readers can verify standards

**Why P3**: Citations provide credibility and research depth. Important but not blocking for initial writing - can be added after content exists.

**Independent Test**: Select 5 citations, verify each has: (1) URL/DOI, (2) brief summary, (3) consistent format. Works independently of other content.

**Estimated Duration**: 30-40 minutes

### Tasks

- [ ] T024 [US3] Add Section 7.1 "本文中の引用" with numbered citation format [N] and examples in `/Users/u_akihiro/Desktop/BLEInAction/docs/writing-style-guide.md`
- [ ] T025 [P] [US3] Add Section 7.2 "参考文献リストの書式" with author/title/URL/summary format and 3 example citations in `/Users/u_akihiro/Desktop/BLEInAction/docs/writing-style-guide.md`
- [ ] T026 [P] [US3] Add Section 7.3 "長文資料の要約" with link + summary pattern and example in `/Users/u_akihiro/Desktop/BLEInAction/docs/writing-style-guide.md`
- [ ] T027 [P] [US3] Add Section 8 "参考資料" with working URLs to O'Reilly, Manning, IEEE, ACM, 文化庁, Pandoc, LaTeX resources in `/Users/u_akihiro/Desktop/BLEInAction/docs/writing-style-guide.md`
- [ ] T028 [US3] Validate US3 sections: verify all URLs accessible, summaries present, length ~50 lines of `/Users/u_akihiro/Desktop/BLEInAction/docs/writing-style-guide.md`

**Acceptance Criteria** (from spec.md):
- ✅ Citation links direct to specific section/page of referenced guideline
- ✅ Lengthy sources have brief summary plus link
- ✅ Citations follow consistent format with URLs, titles, descriptions

**Parallel Execution Example**:
```bash
# Tasks T025-T027 can be written independently after T024 completes
# Bibliography, summaries, and resources are separate subsections
```

**Deliverable After US3**: 
- Sections 7-8 complete (~50 additional lines, total ~280)
- All citation formats defined with publisher references
- Authors can properly cite sources with working links

---

## Phase 5: Polish & Cross-Cutting Concerns

**Goal**: Finalize document with revision history, validate all requirements met, ensure quality standards

**Duration**: 30-45 minutes

### Tasks

- [ ] T029 Add revision history section at end of `/Users/u_akihiro/Desktop/BLEInAction/docs/writing-style-guide.md` with v1.0.0 initial creation
- [ ] T030 Verify total line count is 250-350 lines in `/Users/u_akihiro/Desktop/BLEInAction/docs/writing-style-guide.md` (SC-004)
- [ ] T031 Count examples and verify ≥95% of major rules have 正例/誤例 in `/Users/u_akihiro/Desktop/BLEInAction/docs/writing-style-guide.md` (SC-002)
- [ ] T032 Manual validation: click all external URLs to verify accessibility in `/Users/u_akihiro/Desktop/BLEInAction/docs/writing-style-guide.md` (SC-003)
- [ ] T033 Verify O'Reilly, Manning, IEEE, ACM each cited with at least one URL in `/Users/u_akihiro/Desktop/BLEInAction/docs/writing-style-guide.md` (SC-005)
- [ ] T034 Check multi-page sources have 1-3 sentence summaries in `/Users/u_akihiro/Desktop/BLEInAction/docs/writing-style-guide.md` (SC-006)
- [ ] T035 Verify all 15 functional requirements (FR-001 to FR-015) addressed in `/Users/u_akihiro/Desktop/BLEInAction/docs/writing-style-guide.md`
- [ ] T036 Proofread document for clarity, consistency, Japanese grammar in `/Users/u_akihiro/Desktop/BLEInAction/docs/writing-style-guide.md`
- [ ] T037 Format check: ensure proper Markdown syntax, headings, tables, code blocks render correctly in `/Users/u_akihiro/Desktop/BLEInAction/docs/writing-style-guide.md`
- [ ] T038 Commit style guide with message "feat: add technical writing style guide for Japanese BLE book"

**Quality Checklist**:
- [ ] Length: 250-350 lines (SC-004)
- [ ] Examples: ≥95% of rules (SC-002)
- [ ] URLs: All working (SC-003)
- [ ] Publishers: O'Reilly, Manning, IEEE, ACM cited (SC-005)
- [ ] Summaries: Multi-page sources summarized (SC-006)
- [ ] Language: Written in Japanese (FR-012)
- [ ] Coverage: All 15 FRs addressed (FR-001 to FR-015)

---

## Summary

### Task Statistics

- **Total Tasks**: 38
- **Setup Phase**: 3 tasks (5-10 min)
- **User Story 1** (P1): 9 tasks (60-75 min)
- **User Story 2** (P2): 11 tasks (80-90 min)
- **User Story 3** (P3): 5 tasks (30-40 min)
- **Polish Phase**: 10 tasks (30-45 min)

**Total Estimated Time**: 3.5-4.5 hours

### Parallel Opportunities

**Within User Story 1** (after T005):
- T006 (particles) || T007 (punctuation) || T008 (quotation marks)
- T009 (technical terms) || T010 (abbreviations) || T011 (katakana)

**Within User Story 2** (after T013):
- T014 (tables) || T015 (cross-refs) || T016 (inline code)
- T017 (code blocks) || T018 (language tags) || T019 (comments)
- T020 (inline equations) || T021 (display equations) || T022 (symbols)

**Within User Story 3** (after T024):
- T025 (bibliography) || T026 (summaries) || T027 (resources)

**Between User Stories**:
- US2 can start immediately after US1 completes (no dependency)
- US3 can start immediately after US1 completes (no dependency)
- US2 and US3 can be worked on in parallel

### Independent Test Criteria by Story

**US1 Test**: Have author write 2-page chapter section following Sections 1-3
- Verify: です・ます form used consistently
- Verify: Particles (は/が/を) used correctly per rules
- Verify: Punctuation (、。) matches guidelines
- Verify: Technical terms formatted per first-use rule
- Result: Author confirms rules are clear and applicable

**US2 Test**: Have author create sample content with all technical elements
- Insert 1 figure: verify numbered caption below, proper sizing
- Insert 1 table: verify numbered caption above, proper formatting
- Insert 1 equation: verify LaTeX syntax, numbered correctly
- Insert 1 code block: verify language tag, syntax highlighting settings
- Result: All 4 elements render correctly in build pipeline

**US3 Test**: Review Section 7-8 citations
- Select 5 random URLs: verify all accessible (not 404)
- Check 3 multi-page sources: verify 1-3 sentence summaries present
- Verify O'Reilly, Manning, IEEE, ACM each have ≥1 citation with URL
- Result: All citations functional and properly formatted

### MVP Definition

**Minimum Viable Product** = User Story 1 only (Tasks T001-T012)

**Deliverable**: 
- Sections 1-3 of style guide (~120 lines)
- Basic writing style, punctuation, technical term handling
- Enough for authors to start writing with consistency

**Why this is viable**:
- Addresses core pain point (inconsistent writing style)
- Delivers immediate value (prevents style drift from day 1)
- Independently testable (author can write sample following rules)
- Can iterate on technical formatting (US2) and citations (US3) later

### Incremental Delivery Strategy

1. **Sprint 1** (MVP): Complete US1 → Authors can start writing chapters
2. **Sprint 2**: Complete US2 → Authors can add figures, tables, code
3. **Sprint 3**: Complete US3 → Authors can cite sources properly
4. **Sprint 4**: Polish → Quality assurance, final validation

Each sprint delivers usable increment. No sprint blocks book writing progress.

---

## Validation Against Success Criteria

After completion, verify all 9 success criteria from spec.md:

- [ ] **SC-001**: Authors find guidance in <30 seconds (test with 3 common questions)
- [ ] **SC-002**: 95%+ of rules have examples (count 正例/誤例 pairs)
- [ ] **SC-003**: All URLs work (click-test each citation)
- [ ] **SC-004**: Length 250-350 lines (run `wc -l docs/writing-style-guide.md`)
- [ ] **SC-005**: Major publishers cited with URLs (search for O'Reilly, Manning, IEEE, ACM)
- [ ] **SC-006**: Multi-page sources have summaries (check Section 7.3 and 8)
- [ ] **SC-007**: Two reviewers confirm completeness (schedule review)
- [ ] **SC-008**: Authors report reduced uncertainty (survey after 1 month)
- [ ] **SC-009**: Fewer style revisions in editing (measure in next cycle)

**Immediate validation** (SC-001 to SC-006) can be done upon task completion.  
**Delayed validation** (SC-007 to SC-009) requires usage over time.

---

## Notes for Implementation

### Research Reference

All decisions documented in `research.md`:
- Japanese conventions: Section 1 (particles, punctuation, tone)
- Publisher guidelines: Section 2 (O'Reilly, Manning, IEEE, ACM)
- Technical elements: Section 3 (figures, tables, equations, code)
- Citations: Section 4 (numbered references with URLs)
- Technical terms: Section 5 (English acronyms + Japanese)

### Quickstart Reference

Step-by-step guide in `quickstart.md` provides:
- Detailed examples for each section
- Code snippets to copy/adapt
- Validation checklist
- Common issues and solutions

### Constitution Alignment

This feature directly implements Constitution requirements:
- **Editorial Standards**: Primary language Japanese, clarity, consistency, code formatting
- **Self-Contained Examples**: 正例/誤例 format for all rules
- **Problem-Solving Orientation**: Edge cases and troubleshooting guidance
- **Technical Accuracy**: Citations to authoritative sources with versions

No constitution violations - feature fully compliant.

---

**Ready to implement**: All tasks defined with clear acceptance criteria, file paths, and validation steps.