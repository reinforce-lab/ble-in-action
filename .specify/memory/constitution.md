<!--
Sync Impact Report:
================================================================================
Version: 0.0.0 → 1.0.0
Change Type: MAJOR (Initial constitution ratification)

Principles Established:
- I. Hands-On Learning Through Practice (NEW)
- II. Cross-Platform Code Verification (NEW)
- III. Progressive Complexity (NEW)
- IV. Problem-Solving Orientation (NEW)
- V. Self-Contained Examples (NEW)
- VI. Technical Accuracy & Standards Compliance (NEW)

Sections Added:
- Core Principles (6 principles)
- Content Requirements
- Quality Standards
- Governance

Templates Status:
✅ plan-template.md - Reviewed, no changes needed (generic structure)
✅ spec-template.md - Reviewed, no changes needed (generic structure)
✅ tasks-template.md - Reviewed, no changes needed (generic structure)

Follow-up Items:
- Create README.md describing the book project
- Consider adding chapter outline as project progresses
================================================================================
-->

# BLE In Action Constitution

## Core Principles

### I. Hands-On Learning Through Practice

Every chapter and section MUST include working, executable code examples that readers can build and test themselves. Code examples MUST span multiple platforms (embedded hardware, mobile applications, desktop software) to demonstrate real-world BLE communication scenarios.

**Rationale**: BLE technology requires understanding across hardware and software domains. Readers learn best by actually implementing communication between devices, not just reading theory. This principle ensures the book delivers practical development capability.

**Implementation Requirements**:
- Each technical concept accompanied by complete, runnable code
- Code samples provided for at least two platforms per major concept
- Hardware requirements clearly specified with accessible alternatives
- All code examples tested and verified before publication

### II. Cross-Platform Code Verification (NON-NEGOTIABLE)

All code examples MUST be tested and verified to work on their target platforms before inclusion. Examples involving device communication MUST demonstrate actual BLE data exchange between real hardware and software components.

**Rationale**: BLE development involves multiple platforms (microcontrollers, iOS, Android, desktop) with platform-specific quirks. Untested code erodes reader trust and wastes their time. Cross-platform verification ensures examples actually work in practice, not just in theory.

**Implementation Requirements**:
- Test harness established for each target platform (embedded, iOS, Android, desktop)
- BLE communication examples verified with actual device-to-device testing
- Platform-specific limitations and workarounds documented
- Version requirements explicitly stated (SDK versions, OS versions, hardware models)

### III. Progressive Complexity

Content MUST be structured from fundamental concepts to advanced topics, ensuring each chapter builds upon previously established knowledge. Complex topics MUST be broken down into digestible, sequential learning steps.

**Rationale**: BLE involves layered complexity (radio fundamentals → GATT architecture → application protocols). Readers from diverse backgrounds (hardware engineers, app developers, system integrators) need a clear learning path that doesn't assume specialized prior knowledge.

**Implementation Requirements**:
- Each chapter references prerequisite knowledge from earlier chapters
- New concepts introduced one at a time with clear definitions
- Glossary maintained for BLE-specific terminology
- Difficulty level indicated for each section (Beginner/Intermediate/Advanced)

### IV. Problem-Solving Orientation

Content MUST address common challenges, debugging techniques, and troubleshooting strategies that developers encounter in real BLE projects. Each major topic MUST include a "Common Issues and Solutions" section.

**Rationale**: BLE development involves debugging wireless communication, timing issues, power management, and platform differences. Readers need practical problem-solving skills, not just feature descriptions, to succeed in real projects.

**Implementation Requirements**:
- Dedicated troubleshooting sections in each chapter
- Common error scenarios documented with diagnostic approaches
- Debugging tools and techniques explained for each platform
- Real-world gotchas and workarounds highlighted throughout

### V. Self-Contained Examples

Code examples MUST be complete and self-contained, not fragments requiring readers to guess missing parts. Each example MUST include all necessary setup code, imports, and configuration.

**Rationale**: Incomplete code examples force readers to spend time debugging missing pieces rather than learning BLE concepts. Self-contained examples respect reader time and reduce frustration, enabling focus on the actual technology being taught.

**Implementation Requirements**:
- No implicit "... rest of code here ..." placeholders
- All imports, dependencies, and configuration explicitly shown
- Setup and teardown code included where relevant
- File structure shown for multi-file examples

### VI. Technical Accuracy & Standards Compliance

All technical content MUST accurately reflect the Bluetooth Core Specification and platform-specific BLE implementations. When platform behavior diverges from specification, differences MUST be explicitly documented.

**Rationale**: BLE is a standards-based technology. Inaccurate information leads to failed implementations and reader frustration. Understanding both the standard and platform-specific variations is critical for successful development.

**Implementation Requirements**:
- All protocol details verified against current Bluetooth Core Specification
- Platform-specific implementation differences documented
- Standards version referenced explicitly (e.g., "Bluetooth 5.3 specification")
- Deprecated features marked clearly with migration guidance

## Content Requirements

### Code Examples

- **Platform Coverage**: Code examples MUST include at least:
  - One embedded/firmware example (Nordic nRF52, ESP32, or similar)
  - One mobile example (iOS or Android)
  - One supporting platform (desktop or web-based BLE central)
- **Language Diversity**: Examples MUST use languages appropriate to each platform (C/C++ for embedded, Swift/Kotlin for mobile, etc.)
- **Licensing**: All code examples released under MIT license to enable unrestricted reuse
- **Repository**: Complete working examples maintained in accompanying GitHub repository

### Chapter Structure

Each chapter MUST include:

1. **Learning Objectives**: Clear statement of what readers will learn
2. **Prerequisites**: Explicit knowledge requirements from prior chapters
3. **Theory Section**: Conceptual explanation with diagrams where helpful
4. **Practical Implementation**: Step-by-step code examples
5. **Common Issues**: Troubleshooting and debugging guidance
6. **Summary**: Key takeaways and next steps

### Hardware Requirements

- **Accessibility**: Recommended hardware MUST be readily available for purchase
- **Budget Conscious**: Provide both entry-level and professional-grade hardware options
- **Alternatives**: List at least two alternative hardware platforms where possible
- **Tool Requirements**: Specify all required development tools with version numbers

## Quality Standards

### Technical Review

- Each chapter reviewed by at least one domain expert (BLE protocol, embedded systems, or mobile development)
- All code examples verified by independent testing before publication
- Technical accuracy validated against official specification documents

### Editorial Standards

- **Language**: Primary language is Japanese; technical terms use English where industry-standard
- **Clarity**: Avoid jargon without definition; prefer clear explanation over brevity
- **Consistency**: Terminology used consistently throughout the book
- **Formatting**: Code formatted according to language-specific conventions (e.g., Swift style guide for iOS examples)

### Publishing Requirements

- **Format**: Both print (paperback) and digital (Kindle) formats via Amazon KDP
- **Updates**: Plan for revised editions as BLE specifications evolve
- **Errata**: Maintain public errata document for post-publication corrections
- **Reader Support**: Provide mechanism for reader questions (GitHub issues, email, etc.)

## Governance

This constitution establishes the foundational principles for "BLE In Action" content development. These principles ensure the book delivers practical, hands-on learning that empowers readers to successfully develop BLE applications across diverse platforms.

**Amendment Process**:
- Constitution amendments MUST be documented with version increment and rationale
- MAJOR version: Change to core principles or removal of requirements
- MINOR version: Addition of new principles or expansion of requirements
- PATCH version: Clarifications, typo corrections, or editorial refinements

**Compliance**:
- All chapter outlines MUST verify alignment with core principles before drafting
- All code examples MUST pass cross-platform verification before inclusion
- Technical reviewers MUST check compliance with technical accuracy requirements
- Editorial review MUST verify adherence to content structure requirements

**Versioning**:
- Book content follows semantic versioning: MAJOR.MINOR.PATCH
- MAJOR: Significant content additions, coverage of new BLE spec versions
- MINOR: New chapters, expanded examples, additional platform coverage
- PATCH: Corrections, clarifications, minor example updates

**Version**: 1.0.0 | **Ratified**: 2025-10-21 | **Last Amended**: 2025-10-21
