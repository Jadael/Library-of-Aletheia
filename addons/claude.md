# addons - Godot Plugins and Extensions

## Overview

The `addons/` folder contains Godot plugins that extend the engine's functionality. These are standard Godot addons that integrate with the editor and runtime environment.

**Location in Project:** `/addons/`
**Related Documentation:**
- [../claude.md](../claude.md) - Root project documentation
- [godot_llm/claude.md](godot_llm/claude.md) - LLM integration plugin
- [oracle_console/claude.md](oracle_console/claude.md) - Console interface plugin
- [Todo_Manager/claude.md](Todo_Manager/claude.md) - Task management plugin

## Installed Plugins

### godot_llm - LLM Integration Plugin

**Type:** GDExtension (native library)
**Purpose:** Integrates local Large Language Model capabilities into Godot

The GDLlama plugin provides native bindings for running LLM models (GGUF format) directly in Godot. It's the foundation for the Library of Aletheia's AI-powered features.

**Key Components:**
- `godot_llm.gdextension` - Extension configuration
- `bin/` - Native libraries for multiple platforms (Windows, Linux, macOS, Android)
- Cross-platform support with release builds

**Usage:**
- Used by `Daemons/Shoggoth.gd` as LLM backend (one of several options)
- Shoggoth abstracts this away - provides transparent LLM API
- Provides text generation and embedding capabilities
- Requires GGUF format models to be downloaded separately

**Status:** Current backend, but may be replaced (not updated in 2+ years)
**Alternatives:** Ollama, custom scaffolding, bundled open-source model

**Documentation:** See [godot_llm/claude.md](godot_llm/claude.md)

### oracle_console - Console Interface Plugin

**Type:** Editor Plugin
**Purpose:** LLM-powered chatbot console for the Godot editor

Provides a console interface within the Godot editor for interacting with LLM models during development.

**Key Components:**
- `plugin.cfg` - Plugin configuration
- `OracleConsolePlugin.gd` - Plugin entry point
- `OracleConsole.gd` - Console implementation
- `OracleConsole.tscn` - Console UI scene

**Related Runtime Component:**
- `Daemons/oracle_console.gd` - Runtime console daemon
- `Daemons/Scenes/oracle_console.tscn` - Runtime console scene

**Documentation:** See [oracle_console/claude.md](oracle_console/claude.md)

### Todo_Manager - Task Management Plugin

**Type:** Editor Plugin
**Purpose:** TODO/FIXME/HACK comment tracking in the editor

Provides a dock panel in the Godot editor for managing TODO comments in code. This is a third-party plugin by Peter de Vroom.

**Key Components:**
- `plugin.cfg` - Plugin configuration (v2.3.1)
- `plugin.gd` - Plugin entry point
- `Dock.gd` - Dock panel implementation
- `UI/` - User interface components
- `doc/` - Plugin documentation

**Features:**
- Scans project for TODO/FIXME/HACK comments
- Displays them in organized dock panel
- Pattern-based comment detection
- Color-coded priority system

**Configuration:**
- `todo.cfg` - Plugin settings
- Pattern definitions in `Pattern.gd`, `PatternEdit.gd`
- Color picker for categorization

**Documentation:** See [Todo_Manager/claude.md](Todo_Manager/claude.md)

## File Structure

```
addons/
├── claude.md                    (this file)
│
├── godot_llm/                   (LLM integration - GDExtension)
│   ├── claude.md
│   ├── godot_llm.gdextension    (extension config)
│   └── bin/                     (native libraries)
│       └── lib*.dll/so/dylib    (platform binaries)
│
├── oracle_console/              (Console plugin)
│   ├── claude.md
│   ├── plugin.cfg
│   ├── OracleConsolePlugin.gd
│   ├── OracleConsole.gd
│   └── OracleConsole.tscn
│
└── Todo_Manager/                (TODO tracking plugin)
    ├── claude.md
    ├── plugin.cfg
    ├── plugin.gd
    ├── Dock.gd
    ├── UI/
    ├── doc/
    └── *.gd                     (supporting scripts)
```

## Plugin Architecture

### GDExtension vs Editor Plugin

**GDExtension (godot_llm):**
- Native C/C++ code compiled to platform-specific libraries
- Provides new node types and functionality at runtime
- Loaded via `.gdextension` file
- Requires platform-specific binaries in `bin/`

**Editor Plugin (oracle_console, Todo_Manager):**
- GDScript-based extensions to the editor
- Defined via `plugin.cfg`
- Main script extends `EditorPlugin`
- Can add docks, tools, and editor functionality

### Enabling Plugins

Plugins are enabled in `project.godot`:

```ini
[editor_plugins]
enabled=PackedStringArray("res://addons/Todo_Manager/plugin.cfg")
```

Only Todo_Manager is currently enabled as an editor plugin. The oracle_console and godot_llm are integrated differently into the runtime.

## Integration with Daemons

Several addons have corresponding daemon systems:

| Addon | Runtime Daemon | Purpose |
|-------|----------------|---------|
| godot_llm | Daemons/Shoggoth.gd | LLM backend abstraction (transparent API) |
| oracle_console | Daemons/oracle_console.gd | Runtime console interface |
| Todo_Manager | (N/A) | Editor-only tool |

**Important:** Shoggoth is NOT an agent - it's a transparent backend abstraction. It wraps godot_llm (or future alternatives) to provide clean "raw LLM compute" access without exposing implementation complexity.

## Common Tasks

**Adding a New Plugin:**
1. Create folder in `addons/`
2. Add `plugin.cfg` with plugin metadata
3. Create main plugin script (extends `EditorPlugin`)
4. Enable in Project Settings → Plugins
5. Document in this `claude.md`
6. Create subfolder `claude.md`

**Using GDExtension:**
```gdscript
# GDExtension nodes are available automatically
var llm = LLMNode.new()  # Example
add_child(llm)
```

**Accessing Editor Plugins:**
```gdscript
# In EditorPlugin script
func _enter_tree():
    add_control_to_dock(DOCK_SLOT_RIGHT_UL, my_control)
```

## Platform Support

### godot_llm Platform Coverage:
- ✅ Windows (x86_64)
- ✅ Linux (x86_64)
- ✅ macOS (Universal)
- ✅ Android (ARM64)

Note: Debug builds are configured to use release libraries for performance (see `godot_llm.gdextension:7-8`).

## Dependencies

**godot_llm Requirements:**
- GGUF format LLM models (not included)
- Sufficient RAM for model loading
- Compatible CPU for inference

**oracle_console Requirements:**
- godot_llm extension (for LLM functionality)
- Shoggoth daemon (for model management)

**Todo_Manager Requirements:**
- None (standalone editor tool)

## Navigation

- **Up:** [../claude.md](../claude.md) - Root project documentation
- **Down:**
  - [godot_llm/claude.md](godot_llm/claude.md) - LLM integration details
  - [oracle_console/claude.md](oracle_console/claude.md) - Console plugin details
  - [Todo_Manager/claude.md](Todo_Manager/claude.md) - TODO manager details

## External Resources

- **GDLlama Project:** [GitHub repository for godot_llm](https://github.com/your-repo-here) (check addon for URL)
- **Todo_Manager:** Third-party plugin by Peter de Vroom
- **Godot Plugins Docs:** https://docs.godotengine.org/en/stable/tutorials/plugins/
