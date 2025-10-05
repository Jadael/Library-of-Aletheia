# documents - User Documentation and Knowledge Base

## Overview

The `documents/` folder contains the project's knowledge base, user-facing documentation, design documents, and reference materials. These are primarily Markdown files with YAML frontmatter that serve as both documentation and test content for the Library of Aletheia system.

**Location:** `/documents/`
**Related:**
- [../claude.md](../claude.md) - Root project documentation
- [../docs/claude.md](../docs/claude.md) - Plugin documentation

## Purpose

This folder serves multiple roles:
1. **User Documentation** - Guides, principles, and how-tos
2. **Design Documents** - Project planning and architecture
3. **Reference Materials** - Technical references and standards
4. **Test Content** - Sample documents for testing the library system
5. **Knowledge Base** - Project knowledge and context

## Documentation Categories

### Core Principles & Philosophy

**Aletheia's Documentation Principles.md**
- Documentation philosophy for the project
- Standards for self-documenting code
- Aletheia daemon's guiding principles

**Meeting to Address Clarity in Voice and Tone.md**
- Voice and tone guidelines
- Communication standards
- Writing style decisions

### Technical References

**GDScript Documentation Syntax.md**
- GDScript documentation standards
- Code documentation format
- Godot doc comment conventions

**chronicler-logging-guide.md**
- Chronicler logging system guide
- Event logging best practices
- Wide logging methodology

**GDLlama Nodes Reference.md**
- GDLlama plugin node documentation (current LLM backend)
- ⚠️ Backend-specific - abstracted by Shoggoth daemon
- Node API and usage (may be replaced with Ollama/custom)

**gdllama-node-documentation.md**
- Additional GDLlama documentation
- Extended node reference
- ⚠️ Backend may be replaced - Shoggoth abstracts this

**Window — Godot Engine (stable) documentation in English.md**
- Godot Window class reference
- External documentation snapshot

### Design & Planning

**project-knowledge-archon-introduction.md**
- Knowledge management archon introduction
- Project architecture concepts
- System design philosophy

**Introduction of Mnemosynus.md**
- Mnemosynus system introduction (13KB - detailed)
- Memory/knowledge management concepts
- Archive system design

**Daemon Agenda Cards.md**
- Daemon planning and organization
- Task management for daemons
- Development roadmap

**plan.md**
- Project plan and roadmap
- Implementation strategy
- Development milestones

### Format & Standards

**Markdown with YAML Frontmatter.md**
- Document format specification (11KB - comprehensive)
- YAML frontmatter structure
- Markdown conventions used in the project

### Issues & Discussion

**Metadata Editing UX Issue.md**
- UX problem discussion
- Metadata editing challenges
- Proposed solutions

### Other Content

**one room metroidvania.md**
- Game design document (10KB)
- Design exploration or test content
- Possibly unrelated to main project

## File Structure

```
documents/
├── claude.md                                              (this file)
│
├── Aletheia's Documentation Principles.md                (documentation philosophy)
├── GDScript Documentation Syntax.md                       (code doc standards)
├── chronicler-logging-guide.md                            (logging guide)
│
├── GDLlama Nodes Reference.md                            (LLM plugin reference)
├── gdllama-node-documentation.md                         (LLM extended docs)
│
├── Markdown with YAML Frontmatter.md                     (document format spec)
├── Meeting to Address Clarity in Voice and Tone.md       (writing guidelines)
│
├── project-knowledge-archon-introduction.md              (system design)
├── Introduction of Mnemosynus.md                         (memory system)
├── Daemon Agenda Cards.md                                (daemon planning)
├── plan.md                                               (project roadmap)
│
├── Metadata Editing UX Issue.md                          (UX discussion)
├── Window — Godot Engine (stable) documentation...md     (external reference)
│
└── one room metroidvania.md                              (game design)
```

## Document Format

Most documents follow the Markdown with YAML frontmatter format as specified in `Markdown with YAML Frontmatter.md`:

```markdown
---
title: Document Title
last_updated: 2024-XX-XX
author: Name
tags: [tag1, tag2]
---

# Content Here
```

This format is central to the Library of Aletheia's document management system.

## Key Documents

### Essential Reading for Development

1. **Aletheia's Documentation Principles.md** - Understand documentation philosophy
2. **GDScript Documentation Syntax.md** - Code documentation standards
3. **chronicler-logging-guide.md** - Logging best practices
4. **Markdown with YAML Frontmatter.md** - Document format specification

### System Architecture

1. **project-knowledge-archon-introduction.md** - Archon system overview
2. **Introduction of Mnemosynus.md** - Memory/archive system
3. **Daemon Agenda Cards.md** - Daemon organization

### LLM Backend (Current - May Change)

1. **GDLlama Nodes Reference.md** - Current backend documentation (GDLlama)
2. **gdllama-node-documentation.md** - Extended backend docs

**Note:** These docs are backend-specific. Shoggoth daemon abstracts LLM access - backend could switch to Ollama or custom implementation without affecting other code.

## Relationship to System

### Document Sources
- Created manually by developers
- Generated by Aletheia (possibly)
- Captured from external sources (Godot docs)
- Test/example content

### Document Usage
- **Read by Librarian** - Document management daemon
- **Indexed by Curator** - Content organization
- **Logged by Chronicler** - Document access tracking
- **Processed via Shoggoth** - LLM analysis (Shoggoth = transparent LLM API)
- **Displayed by Scroll** - Document viewer

### Card Catalog Integration
These documents appear in the card catalog system as the library's collection. They serve as both documentation and test data for the document management features.

## Document Types by Size

### Large Documents (10KB+)
- Introduction of Mnemosynus.md (13KB)
- Markdown with YAML Frontmatter.md (11KB)
- Meeting to Address Clarity in Voice and Tone.md (11KB)
- one room metroidvania.md (10KB)

### Medium Documents (5-9KB)
- GDLlama Nodes Reference.md (8.7KB)
- project-knowledge-archon-introduction.md (7KB)
- Window — Godot Engine documentation.md (7KB)
- chronicler-logging-guide.md (6.5KB)
- plan.md (6KB)
- gdllama-node-documentation.md (5.6KB)
- GDScript Documentation Syntax.md (5.5KB)

### Small Documents (< 5KB)
- Aletheia's Documentation Principles.md (4.7KB)
- Metadata Editing UX Issue.md (3.7KB)
- Daemon Agenda Cards.md (2.7KB)

## Common Tasks

### Reading Documents
```bash
# View documentation
cat documents/"Aletheia's Documentation Principles.md"

# Search for topic
grep -r "LLM" documents/

# List by size
ls -lhS documents/*.md
```

### Adding New Documents
1. Create Markdown file with YAML frontmatter
2. Follow format in "Markdown with YAML Frontmatter.md"
3. Place in `documents/` folder
4. Use card catalog to index
5. Document in this claude.md if significant

### Organizing Documents
- Group related docs by prefix/naming
- Use YAML frontmatter tags for categorization
- Reference in card catalog system
- Link between related documents

## Integration Points

### With Daemons
- **Librarian** - Tracks these documents
- **Scribe** - May edit these documents
- **Curator** - Organizes and categorizes
- **Archivist** - Persists changes
- **Aletheia** - May generate documentation here

### With UI
- **Scroll** (`Daemons/Scenes/Scroll.tscn`) - Displays these documents
- **CardCatalog** - Indexes and browses these documents
- **Codex** - May display code-related docs

## Metadata Standards

From "Markdown with YAML Frontmatter.md", typical frontmatter:

```yaml
---
title: String           # Document title
author: String          # Creator
created: Date           # Creation date
last_updated: Date      # Last modification
tags: Array            # Categorization
status: String         # draft/review/final
---
```

## Version History

Documents likely tracked via:
- Git commits (primary)
- YAML frontmatter `last_updated` field
- Chronicler event logs
- Card catalog metadata

## Future Expansion

This folder could grow to include:
- User guides and tutorials
- API documentation (auto-generated)
- Architecture decision records
- Meeting notes and discussions
- Research and exploration docs
- Feature specifications

## Navigation

- **Up:** [../claude.md](../claude.md) - Root project documentation
- **Related:**
  - [../docs/claude.md](../docs/claude.md) - Plugin documentation
  - [../Daemons/docs/claude.md](../Daemons/docs/claude.md) - Daemon implementation docs
  - [../README.md](../README.md) - Public project readme

## Notes

- These are "living documents" - subject to change
- Some may be works in progress
- Mix of project documentation and test content
- Central to the Library of Aletheia's purpose as a document management system
