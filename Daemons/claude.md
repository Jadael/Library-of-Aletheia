# Daemons - Core Autoloaded Singleton Systems

## Overview

The `Daemons/` folder contains the core backend systems of the Library of Aletheia. These are autoloaded singleton scripts (configured in `project.godot`) that are globally accessible throughout the application. They are referred to as "Archons" and "Daemons" following the project's metaphorical naming convention.

**Location in Project:** `/Daemons/`
**Related Documentation:**
- [../claude.md](../claude.md) - Root project documentation
- [Scenes/claude.md](Scenes/claude.md) - UI scenes and components for daemon interfaces
- [docs/claude.md](docs/claude.md) - Implementation documentation and guides

## Daemon Philosophy

Each daemon is designed as a specialized singleton responsible for a specific domain of functionality. They follow these principles:

1. **Single Responsibility** - Each daemon handles one cohesive concern
2. **Always Available** - As autoloaded singletons, they're accessible from anywhere via their name (e.g., `Chronicler.log_event()`)
3. **Signal-Based Communication** - Daemons communicate via Godot signals for loose coupling
4. **Metaphorical Naming** - Names reflect their conceptual role (e.g., Scribe for writing, Librarian for document management)

## Core Daemons (Archons)

### Primary System Daemons

**Aletheia** (`Aletheia.gd`) - *Archon of Project Knowledge and Documentation*
- Orchestrates documentation generation and management
- Coordinates other documentation-related daemons (CodeSeer, SyntaxSage, DocuKeeper)
- Main entry point for documentation operations
- Location: `Daemons/Aletheia.gd:1`

**Chronicler** (`Chronicler.gd`) - *Impartial Scribe of the Realm's Grand Narrative*
- Wide logging system for all significant events
- High cardinality structured logging with rich context
- Persistent log storage at `user://debug_log.json`
- Provides event logging interface for all systems
- Location: `Daemons/Chronicler.gd:1`

**Shoggoth** (`Shoggoth.gd`) - *LLM Backend API Abstraction*
- **NOT an agent** - provides transparent "raw LLM compute" access
- Abstracts backend complexity (loading, queuing, API differences)
- Clean interface for users, daemons, and code to access LLM capabilities
- **Current Backend:** Ollama API (http://localhost:11434)
- **Default Model:** mistral-small:24b
- Uses `ollama_client.gd` for HTTP communication
- Handles all implementation details invisibly
- Location: `Daemons/Shoggoth.gd:1`

### Document Management Daemons

**Librarian** (`Librarian.gd`) - *Document Management*
- Manages document organization and retrieval
- Handles the "card catalog" system
- Tracks documents the library "knows about"
- Location: `Daemons/Librarian.gd:1`

**Scribe** (`Scribe.gd`) - *Text and Document Editing*
- Handles document editing operations
- Text manipulation and formatting
- Integration with editor interfaces
- Location: `Daemons/Scribe.gd:1`

**Curator** (`Curator.gd`) - *Content Organization*
- Manages content categorization and organization
- Metadata handling
- Content curation workflows
- Location: `Daemons/Curator.gd:1`

**Archivist** (`Archivist.gd`) - *Data Persistence*
- Handles saving and loading operations
- Data serialization and deserialization
- File system operations
- Location: `Daemons/Archivist.gd:1`

### UI and Interface Daemons

**CardCatalog** (`card_catalog.gd`) - *Document Catalog Interface*
- Visual card catalog system for document browsing
- Scene: `Scenes/card_catalog.tscn`
- Location: `Daemons/card_catalog.gd:1`

**ChronicleViewer** (`chronicle_viewer.gd`) - *Log Viewing Interface*
- UI for viewing Chronicler logs
- Event browsing and filtering
- Scene: `Scenes/chronicle_viewer.tscn`
- Location: `Daemons/chronicle_viewer.gd:1`

**Codex** (`codex.gd`) - *Code Viewing and Editing Interface*
- Code editor interface
- Scene: `Scenes/Codex.tscn`
- Location: `Daemons/codex.gd:1`

**Scroll** (`scroll.gd`) - *Document Viewing/Editing Interface*
- Primary document viewing and editing UI
- Scene: `Scenes/Scroll.tscn`
- Location: `Daemons/scroll.gd:1`

**Glyph** (`glyph.gd`) - *Typography and Text Rendering*
- Manages text rendering and formatting
- Font and glyph handling
- Location: `Daemons/glyph.gd:1`

### Specialized Analysis Daemons

**CodeSeer** (`code_seer.gd`) - *Code Analysis*
- Scans project directories to discover GDScript files
- Parses script structure (properties, functions, signals, constants)
- Extracts 'about' sections and entity metadata
- Used by Aletheia as "the discerning eye" in documentation generation
- Scene: `Scenes/code_seer.tscn`
- Location: `Daemons/code_seer.gd:1`

**SyntaxSage** (`syntax_sage.gd`) - *Documentation Generation*
- Generates comprehensive documentation from parsed code
- Uses Shoggoth (LLM) to create insightful function descriptions
- Creates Markdown documentation with YAML frontmatter
- Channels "the wisdom of Shoggoth" while maintaining documentation standards
- Used by Aletheia as the documentation wordsmith
- Scene: `Scenes/syntax_sage.tscn`
- Location: `Daemons/syntax_sage.gd:1`

**DocuKeeper** (`docu_keeper.gd`) - *Documentation Persistence*
- Manages storage and retrieval of generated documentation
- Maintains documentation output directory structure
- Saves documentation as Markdown files
- Guardian of persistent documentation files
- Used by Aletheia to preserve generated wisdom
- Scene: `Scenes/docu_keeper.tscn`
- Location: `Daemons/docu_keeper.gd:1`

### Security Daemons

**Aegis** (`aegis.gd`) - *Security Management*
- Security protocols and access control
- Location: `Daemons/aegis.gd:1`

**SecurityAnalysisDaemon** (`security_analysis_daemon.gd`)
- Security threat analysis
- Location: `Daemons/security_analysis_daemon.gd:1`

**SecurityBriefingDaemon** (`security_briefing_daemon.gd`)
- Security reporting and briefings
- Location: `Daemons/security_briefing_daemon.gd:1`

**SecurityProtocolDaemon** (`security_protocol_daemon.gd`)
- Security protocol enforcement
- Location: `Daemons/security_protocol_daemon.gd:1`

**ThreatAnalysisDaemon** (`threat_analysis_daemon.gd`)
- Threat detection and analysis
- Location: `Daemons/threat_analysis_daemon.gd:1`

**AlertResponseDaemon** (`alert_response_daemon.gd`)
- Alert handling and response
- Location: `Daemons/alert_response_daemon.gd:1`

**AuditDaemon** (`audit_daemon.gd`)
- System auditing and compliance
- Location: `Daemons/audit_daemon.gd:1`

### Other Daemons

**OracleConsole** (`oracle_console.gd`) - *Console Interface*
- Command-line style interface
- Scene: `Scenes/oracle_console.tscn`
- Location: `Daemons/oracle_console.gd:1`

**AISettings** (`ai_settings.gd`) - *AI Configuration*
- LLM and AI parameter configuration
- Scene: `Scenes/ai_settings.tscn`
- Location: `Daemons/ai_settings.gd:1`

**Main** (`Main.gd`) - *Main Scene Controller*
- Root scene controller (not autoloaded)
- Coordinates top-level application flow
- Location: `Daemons/Main.gd:1`

## File Structure

```
Daemons/
├── claude.md                    (this file)
├── *.gd                         (daemon scripts)
├── *.gd.uid                     (Godot UID files)
│
├── Scenes/                      (UI scenes for daemons)
│   ├── claude.md
│   ├── *.tscn                   (scene files)
│   ├── *.gd                     (scene-specific scripts)
│   └── *.gd.uid
│
├── docs/                        (implementation documentation)
│   ├── claude.md
│   └── *.md                     (various docs)
│
└── Archived/                    (deprecated code)
    └── *.gd                     (old/unused scripts)
```

## Autoload Configuration

All primary daemons are configured as autoloads in `project.godot`. To access them from any script:

```gdscript
# Examples
Chronicler.log_event("event_name", {"key": "value"})
var text = await Shoggoth.generate_text(prompt)  # Shoggoth = transparent LLM API
Librarian.open_document(path)
```

**Important:** Shoggoth provides raw LLM compute access. It's not an agent making decisions - it's a transparent backend abstraction that handles model APIs, queuing, and complexity invisibly.

## Key Patterns

### The Archon Header
Each daemon begins with:
```gdscript
# A COMPUTER CAN NEVER BE HELD ACCOUNTABLE
# THEREFORE A COMPUTER MUST NEVER MAKE A MANAGEMENT DECISION
# [filename].gd
extends Node
# Owner: Main / Autoload Singleton Daemon a.k.a. "Archon"
```

### Documentation Structure
Daemons include:
- Name constant (with emoji)
- `@export_multiline var about` describing their purpose
- Detailed doc comments following Godot standards
- Signal definitions for inter-daemon communication

### Chronicler Integration
Most daemons use the Chronicler for logging:
```gdscript
Chronicler.log_event("daemon_name.action", {
    "context": "relevant data",
    "details": "more info"
})
```

## Related Folders

- **[Scenes/claude.md](Scenes/claude.md)** - UI scenes and components for daemon interfaces
- **[docs/claude.md](docs/claude.md)** - Implementation guides and documentation
- **Archived/** - Deprecated daemon code (no claude.md, inactive)

## Common Tasks

**Adding a New Daemon:**
1. Create `new_daemon.gd` in `Daemons/`
2. Follow the Archon header pattern
3. Add to autoloads in `project.godot`
4. Document in this `claude.md`
5. Integrate Chronicler logging
6. Create UI scene in `Scenes/` if needed

**Finding Daemon Usage:**
```bash
# Find where a daemon is used
grep -r "DaemonName\." --include="*.gd"

# Find daemon signals
grep -r "signal.*" Daemons/*.gd
```

## Navigation

- **Up:** [../claude.md](../claude.md) - Root project documentation
- **Down:**
  - [Scenes/claude.md](Scenes/claude.md) - UI scenes and components
  - [docs/claude.md](docs/claude.md) - Implementation documentation
