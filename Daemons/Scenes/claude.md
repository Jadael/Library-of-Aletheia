# Daemons/Scenes - UI Scenes and Components

## Overview

The `Daemons/Scenes/` folder contains Godot scene files (`.tscn`) and their associated scripts that provide user interface components for the daemon systems. These scenes are the visual/interactive counterparts to the backend daemon logic.

**Location in Project:** `/Daemons/Scenes/`
**Related Documentation:**
- [../../claude.md](../../claude.md) - Root project documentation
- [../claude.md](../claude.md) - Parent Daemons folder documentation
- [../docs/claude.md](../docs/claude.md) - Implementation documentation

## Scene Files

### Document and Content Management

**Scroll.tscn** - *Primary Document Viewer/Editor*
- Main document viewing and editing interface
- Displays Markdown content with YAML frontmatter
- Text size controls (up/down buttons)
- Associated scripts:
  - `scroll_textsize_up.gd` - Increase text size button
  - `text_size_up_button.gd` - Text size increase logic
  - `text_size_down_button.gd` - Text size decrease logic
- Parent daemon: `../scroll.gd`

**Codex.tscn** - *Code Viewer/Editor*
- Code viewing and editing interface
- Syntax highlighting and code manipulation
- Parent daemon: `../codex.gd`

**card_catalog.tscn** - *Document Catalog Interface*
- Visual card catalog for browsing documents
- Implements the "library card catalog" metaphor
- Related: `instance_card.tscn` for individual card instances
- Associated scripts:
  - `instance_card.gd` - Individual card component logic
- Parent daemon: `../card_catalog.gd`

### Analysis and Documentation Tools

**code_seer.tscn** - *Code Analysis Interface*
- UI for code structure analysis
- Visualization of code metrics and structure
- Used by Aletheia daemon for documentation generation
- Parent daemon: `../code_seer.gd`

**syntax_sage.tscn** - *Syntax Analysis Interface*
- GDScript syntax validation UI
- Code quality visualization
- Parent daemon: `../syntax_sage.gd`

**docu_keeper.tscn** - *Documentation Management Interface*
- Document record management
- Documentation validation and formatting UI
- Parent daemon: `../docu_keeper.gd`

### System Interfaces

**chronicle_viewer.tscn** - *Log Viewer*
- Interface for viewing Chronicler logs
- Event browsing, filtering, and search
- Displays high-cardinality structured logs
- Parent daemon: `../chronicle_viewer.gd`

**oracle_console.tscn** - *Console Interface*
- Command-line style interface
- Terminal-like interaction with the system
- Parent daemon: `../oracle_console.gd`

**ai_settings.tscn** - *AI Configuration Interface*
- Ollama configuration UI (host, model selection)
- AI parameter configuration (temperature, stop tokens)
- Model: mistral-small:24b (default)
- Host: http://localhost:11434 (default)
- Parent daemon: `../ai_settings.gd`

## Scene Scripts

Individual scene scripts (separate from parent daemons):

**instance_card.gd** - *Card Instance Logic*
- Individual card component for card catalog
- Represents a single document in the catalog
- Used within `card_catalog.tscn`
- Location: `Daemons/Scenes/instance_card.gd:1`

**Text Size Control Scripts:**
- `scroll_textsize_up.gd` - Text size increase for Scroll
- `text_size_up_button.gd` - Generic text size up button
- `text_size_down_button.gd` - Generic text size down button

## File Structure

```
Daemons/Scenes/
├── claude.md                    (this file)
├── *.tscn                       (Godot scene files)
├── *.gd                         (scene-specific scripts)
└── *.gd.uid                     (Godot UID files)
```

### Complete File List
```
ai_settings.tscn
card_catalog.tscn
chronicle_viewer.tscn
code_seer.tscn
Codex.tscn
docu_keeper.tscn
instance_card.gd
instance_card.gd.uid
instance_card.tscn
oracle_console.tscn
Scroll.tscn
scroll_textsize_up.gd
scroll_textsize_up.gd.uid
syntax_sage.tscn
text_size_down_button.gd
text_size_down_button.gd.uid
text_size_up_button.gd
text_size_up_button.gd.uid
```

## Architecture Pattern

### Scene-Daemon Relationship

Each scene typically follows this pattern:

1. **Scene File (`.tscn`)** - Visual layout and node hierarchy
2. **Parent Daemon Script (`.gd` in `../`)** - Business logic (autoloaded singleton)
3. **Scene-Specific Scripts (`.gd` here)** - UI-specific behavior and interactions

Example:
```
card_catalog.tscn           (scene)
    ↑ uses
instance_card.gd           (scene script)
    ↑ managed by
../card_catalog.gd         (parent daemon - autoloaded)
```

### Accessing Scenes from Code

Since parent daemons are autoloaded, scenes can be instantiated:

```gdscript
# Load and instance a scene
var scene = preload("res://Daemons/Scenes/card_catalog.tscn")
var instance = scene.instantiate()
add_child(instance)

# Or access via parent daemon (if it manages the scene)
CardCatalog.show_catalog()  # If the daemon has such a method
```

## UI Design Patterns

### Text Size Controls
Multiple scenes use text size adjustment:
- Scroll scene has dedicated text size buttons
- Common pattern: up/down buttons modify label font size
- Scripts handle user preferences and persistence

### Card/Instance Pattern
The card catalog uses an instance-based pattern:
- `instance_card.tscn` defines individual card template
- `card_catalog.tscn` manages collection of cards
- Dynamic instantiation based on document library contents

### Console/Terminal Pattern
Oracle Console implements terminal-like interaction:
- Command input field
- Output history display
- Command parsing and execution

## Common Tasks

**Modifying a Scene:**
1. Open `.tscn` file in Godot editor
2. Edit scene tree and properties
3. Update associated scripts in this folder
4. Test with parent daemon functionality

**Creating a New Scene:**
1. Create `.tscn` in `Daemons/Scenes/`
2. Create associated script if needed
3. Link to parent daemon in `../`
4. Document in this `claude.md`
5. Update parent daemon documentation in `../claude.md`

**Finding Scene Usage:**
```bash
# Find where a scene is instantiated
grep -r "Scenes/scene_name.tscn" --include="*.gd"

# Find scene signals
grep -r "signal.*" Daemons/Scenes/*.gd
```

## Related Documentation

See `../docs/claude.md` for implementation guides that may reference these scenes.

## Navigation

- **Up:** [../claude.md](../claude.md) - Parent Daemons folder documentation
- **Sibling:** [../docs/claude.md](../docs/claude.md) - Implementation documentation
- **Root:** [../../claude.md](../../claude.md) - Project root documentation
