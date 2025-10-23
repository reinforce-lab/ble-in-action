# Feature Specification: Technical Writing Style Guide

**Feature Branch**: `002-technical-writing-style-guide`  
**Created**: 2025-10-21  
**Status**: Draft  
**Input**: User description: "技術本としての、文章の文体を決めます。有名な技術本の出版社のフォーマットや、論文あるいは技術報告書のフォーマットの情報を参考に、まとめます。てにおは、句読点の基本項目および図表の入れ方や数式及びコードの入れ方などを、300行程度にまとめます。それがどこからきているかは、URLなどのリンクで、引用元がわかるようにします。また、分量が多いが読むべき項目は、参照すべき内容を示した上で、リンクで情報先を示して短くまとめます。"

## User Scenarios & Testing

### User Story 1 - Apply Consistent Writing Style (Priority: P1)

Authors need to write technical content following consistent style guidelines to ensure professional quality and readability across all chapters.

**Why this priority**: This is the core value - without consistent style rules, each author may write differently, creating a disjointed reading experience. This directly impacts book quality and professional credibility.

**Independent Test**: Can be tested by having one author write a sample chapter following the style guide, then having a reviewer verify all style rules are correctly applied. Delivers immediate value by ensuring consistency.

**Acceptance Scenarios**:

1. **Given** an author is writing a new chapter, **When** they reference the style guide for sentence endings (てにおは), **Then** they can find clear rules with examples showing correct and incorrect usage
2. **Given** an author needs to format code blocks, **When** they consult the style guide, **Then** they find specific formatting rules with syntax highlighting preferences and caption placement
3. **Given** an author is unsure about punctuation, **When** they check the style guide, **Then** they find rules for commas, periods, and technical term formatting with industry-standard references

---

### User Story 2 - Format Technical Elements Correctly (Priority: P2)

Authors need to insert figures, tables, equations, and code snippets following standardized formatting conventions that match established technical publishing standards.

**Why this priority**: Technical content requires special formatting. This ensures figures are numbered correctly, equations are readable, and code examples are properly highlighted. Essential for technical credibility but depends on having basic writing style (P1) established first.

**Independent Test**: Can be tested by having an author create a chapter section with one figure, one table, one equation, and one code block, then verifying all elements follow the prescribed format. Each element type can be tested separately.

**Acceptance Scenarios**:

1. **Given** an author needs to insert a diagram, **When** they follow the figure insertion guidelines, **Then** the figure has a numbered caption, proper placement, and consistent sizing according to the style guide
2. **Given** an author includes mathematical notation, **When** they format it according to the equation guidelines, **Then** the equation is properly numbered, aligned, and uses consistent LaTeX/Pandoc syntax
3. **Given** an author adds a code example, **When** they apply the code formatting rules, **Then** the code block includes language specification, syntax highlighting settings, and appropriate line numbering if required

---

### User Story 3 - Cite Sources Properly (Priority: P3)

Authors need to cite reference sources (publisher style guides, academic papers, technical reports) with working URLs/links so readers can verify standards and explore detailed guidelines.

**Why this priority**: Citations provide credibility and allow readers to research deeper. Important for authority but not blocking for initial writing - can be added after content is written.

**Independent Test**: Can be tested by selecting 5 cited sources and verifying each has: (1) a clear URL or DOI, (2) a brief summary of what's referenced, and (3) proper citation format. Works independently of actual content.

**Acceptance Scenarios**:

1. **Given** the style guide references an external publisher's format, **When** a reader clicks the citation link, **Then** they are directed to the specific section or page of the referenced guideline
2. **Given** the style guide summarizes lengthy reference material, **When** an author wants more detail, **Then** they find a brief summary plus a link to the full source document
3. **Given** multiple sources are cited, **When** reviewing the bibliography, **Then** all citations follow a consistent format with URLs, titles, and brief descriptions of relevance

---

### Edge Cases

- What happens when style rules conflict between different publisher standards? (Resolution: Document which standard takes precedence, with explicit priority order)
- How does the guide handle style for emerging content types not covered by traditional publishers (e.g., interactive code examples, embedded videos)? (Document acceptable adaptations with rationale)
- What if an author needs to deviate from the style guide for specific technical reasons? (Provide exception process and documentation requirements)
- How are style guide updates communicated to authors mid-project? (Version control strategy and change notification process)

## Requirements

### Functional Requirements

- **FR-001**: Style guide MUST define rules for Japanese particle usage (てにおは) with correct and incorrect examples
- **FR-002**: Style guide MUST specify punctuation rules including comma (、), period (。), and western punctuation marks (,.) with usage contexts
- **FR-003**: Style guide MUST provide figure insertion guidelines including numbering scheme, caption format, placement rules, and sizing standards
- **FR-004**: Style guide MUST provide table formatting guidelines including header styles, alignment rules, and caption placement
- **FR-005**: Style guide MUST provide equation formatting guidelines including numbering, alignment, and LaTeX/Pandoc syntax conventions
- **FR-006**: Style guide MUST provide code block formatting guidelines including language specification, syntax highlighting preferences, line numbering rules, and caption placement
- **FR-007**: Style guide MUST be approximately 300 lines in length, balancing comprehensiveness with readability
- **FR-008**: Style guide MUST cite source materials (publisher guides, academic standards, technical report formats) with working URLs or DOIs
- **FR-009**: Style guide MUST summarize lengthy reference materials with brief descriptions and links rather than reproducing full content
- **FR-010**: Style guide MUST reference established technical publishers (O'Reilly, Manning, Packt, IEEE, ACM, etc.) and their style conventions
- **FR-011**: Style guide MUST include examples demonstrating correct application of each major style rule
- **FR-012**: Style guide MUST be written in Japanese to match the book's primary language
- **FR-013**: Style guide MUST organize rules into clear sections (basic writing style, technical elements, formatting, citations)
- **FR-014**: Style guide MUST specify tone and voice guidelines (formal vs. informal, person usage, active vs. passive voice)
- **FR-015**: Style guide MUST address technical term handling (romanization, abbreviations, first-use explanations)

### Key Entities

- **Style Rule**: Represents a single guideline covering a specific writing or formatting aspect, includes description, examples, rationale, and source citation
- **Citation**: Represents a reference to external standard or guideline, includes URL/DOI, source title, relevant section, and brief relevance description
- **Example**: Demonstrates correct or incorrect application of a style rule, shows before/after or good/bad comparison
- **Section**: Groups related style rules (e.g., "Punctuation", "Code Formatting"), provides navigation structure

## Success Criteria

### Measurable Outcomes

- **SC-001**: Authors can find relevant style guidance within 30 seconds of searching the guide for common questions (punctuation, code formatting, figure insertion)
- **SC-002**: 95% of style rules include at least one example demonstrating correct usage
- **SC-003**: Every external citation includes a working URL or DOI that can be accessed by readers
- **SC-004**: Style guide length is between 250-350 lines, ensuring comprehensive coverage without overwhelming detail
- **SC-005**: All major technical publishers referenced (O'Reilly, Manning, IEEE, ACM) have at least one cited guideline with URL
- **SC-006**: 100% of multi-page reference sources include a summary (1-3 sentences) plus link rather than full reproduction
- **SC-007**: Two independent reviewers confirm the guide covers all essential technical writing aspects for a BLE technical book
- **SC-008**: Authors report reduced uncertainty about formatting decisions when following the guide (measured through survey or feedback)
- **SC-009**: Manuscript consistency improves as measured by reduction in style-related revision comments during editing phase

## Assumptions

- The book will be written primarily in Japanese with some English technical terms
- The build pipeline (Pandoc + LaTeX) is the target format, so style rules should be compatible with Markdown/LaTeX syntax
- Authors have basic familiarity with Markdown formatting
- The target audience is technical professionals, so formal tone is appropriate
- Standard technical publisher conventions (O'Reilly, Manning, IEEE) are applicable to this book's subject matter
- The style guide will be version-controlled alongside the manuscript
- The 300-line guideline is approximate - clarity and completeness take precedence over exact length

## Dependencies

- Access to major technical publisher style guides (O'Reilly, Manning, IEEE, ACM)
- Access to Japanese academic writing standards (if applicable)
- Familiarity with Pandoc Markdown and LaTeX formatting capabilities
- Existing build pipeline (001-markdown-build-pipeline) defines technical constraints for formatting options

## Scope

### In Scope

- Japanese grammar and particle usage rules
- Punctuation conventions for Japanese technical writing
- Figure, table, equation, and code formatting standards
- Citation format and linking conventions
- Tone, voice, and terminology guidelines
- Examples demonstrating each major rule
- Summary of external reference materials with links

### Out of Scope

- Detailed content guidelines for specific chapters (that's editorial, not style)
- Translation guidelines between Japanese and English (unless needed for technical terms)
- Tool-specific tutorials (how to use Pandoc, LaTeX editors, etc.)
- Copy editing services or manuscript review (this is a self-service guide)
- Graphic design or layout decisions beyond basic formatting (cover design, page layout, etc.)
- Marketing copy or book description writing guidelines

