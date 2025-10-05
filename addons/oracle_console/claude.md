# oracle_console - Console Interface Plugin

## Overview

The `oracle_console` addon is a Godot editor plugin that provides an LLM-powered chatbot console interface within the Godot editor. It enables developers to interact with AI models (via Ollama) during development.

**Type:** Editor Plugin
**Location:** `/addons/oracle_console/`
**Backend:** Ollama API via Shoggoth daemon
**Default Model:** mistral-small:24b
**Related Documentation:**
- [../../claude.md](../../claude.md) - Root project documentation
- [../claude.md](../claude.md) - Parent addons documentation
- [../../Daemons/claude.md](../../Daemons/claude.md) - Related runtime daemon

## Purpose

This plugin adds a console interface to the Godot editor for:
- Interactive LLM conversations during development (via Ollama)
- Quick AI assistance while coding
- Testing LLM functionality
- Development-time AI experimentation
- Text generation and continuation

## Components

### Plugin Configuration

**plugin.cfg** - Plugin metadata
```ini
[plugin]
name="Oracle Console"
description="A simple LLM-powered chatbot console for the Godot editor."
author="Your Name"
version="1.0"
script="OracleConsolePlugin.gd"
```

### Scripts

**OracleConsolePlugin.gd** - Plugin entry point
- Extends `EditorPlugin`
- Registers console with editor
- Manages plugin lifecycle
- ~301 bytes (lightweight plugin)

**OracleConsole.gd** - Console implementation
- Main console logic and UI handling
- Uses Shoggoth daemon for LLM interaction (Ollama backend)
- Includes full text box content in prompts for context-aware generation
- Message processing and display
- ~4839 bytes (core implementation)

### Scene

**OracleConsole.tscn** - Console UI
- Visual layout and interface
- Input/output components
- Editor dock integration

## Dual Implementation

### Editor Plugin (this addon)
- **Location:** `addons/oracle_console/`
- **Purpose:** Development-time console in editor
- **Context:** Godot Editor
- **Access:** Via editor dock/panel

### Runtime Daemon
- **Location:** `Daemons/oracle_console.gd` (autoloaded)
- **Purpose:** Runtime console in game/application
- **Context:** Running application
- **Access:** Via in-game interface (`Daemons/Scenes/oracle_console.tscn`)

Both share similar functionality but operate in different contexts.

## File Structure

```
addons/oracle_console/
├── claude.md                    (this file)
├── plugin.cfg                   (plugin metadata)
├── OracleConsolePlugin.gd      (plugin entry point, extends EditorPlugin)
├── OracleConsolePlugin.gd.uid
├── OracleConsole.gd            (console implementation)
├── OracleConsole.gd.uid
└── OracleConsole.tscn          (console UI scene)
```

## Integration

### Dependencies

**Requires:**
- `Daemons/Shoggoth.gd` - For LLM task management (Ollama backend)
- `Daemons/ollama_client.gd` - HTTP client for Ollama API (used by Shoggoth)
- Ollama running on localhost:11434

**Note:** The editor plugin version may have limited access to runtime autoloads depending on when it's initialized.

### Editor Integration

```gdscript
# OracleConsolePlugin.gd (typical pattern)
func _enter_tree():
    # Add console to editor
    var console = preload("OracleConsole.tscn").instantiate()
    add_control_to_bottom_panel(console, "Oracle Console")

func _exit_tree():
    # Clean up when plugin disabled
    remove_control_from_bottom_panel(console)
    console.queue_free()
```

## Usage

### In Editor

1. Enable plugin in Project Settings → Plugins
2. Open console from bottom panel tabs
3. Type messages/queries
4. Receive LLM responses
5. Use for development assistance

### Typical Workflow

```
Developer → Types query in console
         ↓
Console → Includes full text box content as context
         ↓
Shoggoth → Sends to Ollama via HTTP (ollama_client.gd)
         ↓
Ollama (mistral-small:24b) → Generates response
         ↓
Console → Displays response
```

## Features

Based on file sizes and purpose, likely includes:
- Text input field for queries
- Output/history display
- LLM model interaction
- Message formatting
- Command parsing (possibly)
- Session persistence (possibly)

## Relationship to Runtime Console

| Aspect | Editor Plugin | Runtime Daemon |
|--------|---------------|----------------|
| Location | `addons/oracle_console/` | `Daemons/oracle_console.gd` |
| Scene | `OracleConsole.tscn` | `Daemons/Scenes/oracle_console.tscn` |
| Context | Godot Editor | Running Application |
| Purpose | Dev assistance | User/runtime interface |
| Autoload | No | Yes |

The implementations are separate but likely share similar code patterns.

## Common Tasks

**Enabling the Plugin:**
1. Project → Project Settings → Plugins
2. Find "Oracle Console"
3. Check "Enable"
4. Console appears in bottom panel

**Modifying Console Behavior:**
1. Edit `OracleConsole.gd`
2. Update UI in `OracleConsole.tscn`
3. Reload plugin or restart editor

**Debugging Plugin:**
```bash
# Check if plugin is loaded
# Editor: Project → Project Settings → Plugins

# View plugin output
# Check Godot editor Output/Debugger tabs
```

## Known Limitations

As an editor plugin:
- May not have full access to runtime autoloads
- Runs in editor context, not game context
- Different lifecycle than runtime systems
- May need special handling for project resources

## Configuration

The plugin is configured through:
- `plugin.cfg` - Plugin metadata
- Shoggoth daemon - Model configuration (Ollama host, model name, temperature)
- AI Settings window - User-configurable Ollama settings
- Default: mistral-small:24b on localhost:11434

No separate config file in this folder - configuration is managed by Shoggoth.

## Development Notes

### Plugin Structure
```gdscript
# Typical EditorPlugin pattern
class_name OracleConsolePlugin
extends EditorPlugin

var console_instance

func _enter_tree():
    # Plugin initialization
    console_instance = preload("OracleConsole.tscn").instantiate()
    add_control_to_bottom_panel(console_instance, "Oracle Console")

func _exit_tree():
    # Cleanup
    remove_control_from_bottom_panel(console_instance)
    console_instance.queue_free()
```

### Console Implementation
The `OracleConsole.gd` likely contains:
- UI event handlers
- LLM communication logic
- Message history management
- Response formatting

## Navigation

- **Up:** [../claude.md](../claude.md) - Parent addons documentation
- **Root:** [../../claude.md](../../claude.md) - Project root documentation
- **Related:**
  - [../../Daemons/oracle_console.gd](../../Daemons/oracle_console.gd) - Runtime daemon
  - [../../Daemons/Scenes/oracle_console.tscn](../../Daemons/Scenes/oracle_console.tscn) - Runtime scene
  - [../godot_llm/claude.md](../godot_llm/claude.md) - LLM integration

## Future Enhancements

Potential improvements:
- Command system for special operations
- Conversation history persistence
- Multi-model support
- Code generation helpers
- Integration with Godot's help system
- Shared implementation with runtime console
