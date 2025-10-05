# Library of Aletheia - Project Documentation

## Project Overview

The Library of Aletheia is an experimental document management system built with Godot 4 that explores the intersection of large language models, user interfaces, and knowledge management. It creates an immersive, metaphor-rich environment for interacting with documents and information.

**Technology:** Godot 4.4 (GDScript)
**Main Scene:** `main.tscn`
**Configuration:** `project.godot`

## Navigation Guide

This folder contains `claude.md` documentation files distributed throughout the project to help understand the codebase structure. Each subfolder contains its own `claude.md` that provides context-specific information.

### Documentation Map

- **[Daemons/claude.md](Daemons/claude.md)** - Core autoloaded singletons (the "backend" systems)
  - [Daemons/Scenes/claude.md](Daemons/Scenes/claude.md) - UI scenes and components
  - [Daemons/docs/claude.md](Daemons/docs/claude.md) - Implementation documentation
- **[addons/claude.md](addons/claude.md)** - Godot plugins and extensions
- **[assets/claude.md](assets/claude.md)** - Graphics, sprites, UI elements, and art assets
- **[docs/claude.md](docs/claude.md)** - Plugin-related documentation files
- **[documents/claude.md](documents/claude.md)** - User-facing documentation and knowledge base
- **[fonts/claude.md](fonts/claude.md)** - Font assets
- **[textures/claude.md](textures/claude.md)** - Texture assets

## Recursive Documentation Pattern

To recursively include all documentation when working with Claude:

1. Start by reading this file: `claude.md`
2. Then read each subfolder's `claude.md` as listed above
3. Each subfolder's `claude.md` will reference its own nested documentation
4. Continue recursively until you've mapped the area you need

**Example recursive read command:**
```bash
# Read root documentation
cat claude.md

# Read all top-level documentation
cat Daemons/claude.md addons/claude.md assets/claude.md docs/claude.md documents/claude.md fonts/claude.md textures/claude.md

# Read nested documentation (example for Daemons)
cat Daemons/Scenes/claude.md Daemons/docs/claude.md
```

## Project Structure Overview

```
Library-of-Aletheia/
├── claude.md                    (this file)
├── main.tscn                    (main scene entry point)
├── project.godot                (Godot project configuration)
├── README.md                    (user-facing project description)
│
├── Daemons/                     (Core autoloaded singleton systems)
│   ├── claude.md
│   ├── *.gd                     (Autoloaded "daemon" scripts)
│   ├── Scenes/                  (UI scenes and components)
│   ├── docs/                    (Implementation documentation)
│   └── Archived/                (Deprecated/unused code)
│
├── addons/                      (Godot plugins)
│   ├── claude.md
│   ├── godot_llm/              (LLM integration plugin)
│   ├── oracle_console/         (Console interface)
│   └── Todo_Manager/           (Task management plugin)
│
├── assets/                      (Art and visual resources)
│   ├── claude.md
│   ├── Characters/             (Character sprites)
│   ├── Elements/               (Environmental assets)
│   ├── UI/                     (UI graphics)
│   └── Tileset/                (Tile graphics)
│
├── docs/                        (Plugin documentation)
│   └── claude.md
│
├── documents/                   (User documentation and knowledge base)
│   └── claude.md
│
├── fonts/                       (Font assets)
│   └── claude.md
│
└── textures/                    (Texture resources)
    └── claude.md
```

## Key Architectural Concepts

### Autoloaded Daemons (Singletons)

The project uses Godot's autoload feature extensively. All "daemon" scripts in the `Daemons/` folder are globally accessible singletons that handle specific concerns:

- **Aletheia** - Main coordination daemon
- **Shoggoth** - LLM backend API abstraction (transparent interface to LLM compute)
- **Chronicler** - Wide logging system for tracking events
- **Librarian** - Document management
- **Scribe** - Text/document editing
- **Curator** - Content organization
- **Archivist** - Data persistence
- And many more (see `project.godot` autoload section or `Daemons/claude.md`)

### Document Management Philosophy

The project uses a "card catalog" metaphor - tracking "documents the library knows about" rather than "controlling a vault/repository". Documents are Markdown files with optional YAML frontmatter.

### LLM Integration

The Shoggoth daemon provides a clean, transparent API abstraction for LLM compute. It handles all backend complexity (HTTP communication, queuing, API differences) so that users, daemons, and code can access "raw LLM compute" without worrying about implementation details.

**Current Backend:** Ollama API (http://localhost:11434)
**Default Model:** mistral-small:24b
**Design Goal:** Backend-agnostic - Shoggoth abstracts away the specifics

The system uses `ollama_client.gd` as an HTTP wrapper for communicating with Ollama's localhost API.

## Current State

- ⚠️ **Work in Progress** - Early development, not production-ready
- ✅ Open and edit Markdown files with YAML frontmatter
- ✅ LLM integration for text generation
- ✅ Card catalog interface for document management
- ✅ Wide logging system (Chronicler)
- ⚠️ Build currently does not work (debugging in progress)

## Getting Started

1. Clone the repository
2. Install and run Ollama (https://ollama.ai)
3. Pull the mistral-small model:
   ```bash
   ollama pull mistral-small:24b
   ```
4. Open project in Godot 4.3+
5. Run main scene - Shoggoth will automatically connect to Ollama

## For Claude Code Users

When working on this project:

1. **Always read the relevant `claude.md` files first** to understand context
2. **Check the Daemons folder** - most core logic is in autoloaded singletons
3. **Shoggoth is NOT an agent** - it's a transparent API for raw LLM compute via Ollama
4. **Use the Chronicler logging system** when adding new features
5. **Follow GDScript conventions** - see `documents/GDScript Documentation Syntax.md`
6. **Ollama must be running** on localhost:11434 for LLM features to work

## Related Files

- `README.md` - User-facing project overview
- `CONTRIBUTING.md` - Contribution guidelines
- `LICENSE` - License information
- `project.godot` - Full Godot configuration including autoload setup
