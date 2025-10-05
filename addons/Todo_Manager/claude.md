# Todo_Manager - Task Management Plugin

## Overview

The `Todo_Manager` addon is a third-party Godot editor plugin that provides a dock panel for tracking TODO, FIXME, HACK, and other task comments throughout the project codebase.

**Type:** Editor Plugin
**Author:** Peter de Vroom
**Version:** 2.3.1
**Location:** `/addons/Todo_Manager/`
**Related Documentation:**
- [../../claude.md](../../claude.md) - Root project documentation
- [../claude.md](../claude.md) - Parent addons documentation

## Purpose

This plugin helps developers:
- Track TODO/FIXME/HACK comments across the project
- Organize tasks by priority and type
- Navigate quickly to task locations
- Maintain development task visibility

## Components

### Plugin Configuration

**plugin.cfg** - Plugin metadata
```ini
[plugin]
name="Todo Manager"
description="Dock for housing TODO messages."
author="Peter de Vroom"
version="2.3.1"
script="plugin.gd"
```

**todo.cfg** - Plugin settings
- Pattern definitions
- Color configurations
- Custom task types

### Core Scripts

**plugin.gd** - Plugin entry point (~9247 bytes)
- Extends `EditorPlugin`
- Main plugin logic
- Dock registration

**Dock.gd** - Dock panel implementation (~10767 bytes)
- Main UI for todo list
- Task display and organization
- Search and filtering

**Pattern.gd** - Pattern definition (~445 bytes)
- Task pattern matching
- Comment recognition

**PatternEdit.gd** - Pattern editor (~445 bytes)
- UI for editing task patterns
- Custom pattern creation

### Data Classes

**todo_class.gd** - TODO item class (~135 bytes)
- Data structure for TODO items
- Task metadata

**todoItem_class.gd** - TODO item extended (~404 bytes)
- Enhanced task item structure
- Additional properties

### UI Components

**ColourPicker.gd** - Color selection (~318 bytes)
- Color picker for task categories
- Priority visual indicators

**Current.gd** - Current context (~1297 bytes)
- Active task/project state
- Context management

**Project.gd** - Project handling (~2147 bytes)
- Project-level task management
- Global task operations

**Test.gd** - Testing utilities (~62 bytes)
- Plugin testing helpers

### UI Folder

**UI/** - Interface components
- Visual elements for dock panel
- Custom controls
- Task list views

### Documentation

**doc/** - Plugin documentation
- Usage guides
- Screenshots in `doc/images/`
- Feature documentation

**CONTRIBUTING.md** - Contribution guidelines
**README.md** - English documentation
**READMECN.md** - Chinese documentation

## File Structure

```
addons/Todo_Manager/
├── claude.md                    (this file)
├── plugin.cfg                   (plugin metadata)
├── plugin.gd                    (main plugin script)
├── todo.cfg                     (plugin settings)
│
├── Dock.gd                      (dock panel)
├── Pattern.gd                   (pattern matching)
├── PatternEdit.gd               (pattern editor)
├── ColourPicker.gd             (color picker)
├── Current.gd                   (current context)
├── Project.gd                   (project handling)
├── Test.gd                      (testing)
│
├── todo_class.gd               (TODO data class)
├── todoItem_class.gd           (TODO item data)
│
├── UI/                         (UI components)
│   └── (various UI scripts and scenes)
│
├── doc/                        (documentation)
│   ├── images/                 (screenshots)
│   └── (documentation files)
│
├── CONTRIBUTING.md
├── README.md
└── READMECN.md
```

## Features

### Task Pattern Recognition

The plugin scans for comment patterns like:
```gdscript
# TODO: Implement feature
# FIXME: Bug in this function
# HACK: Temporary workaround
# NOTE: Important information
```

Patterns are customizable via `Pattern.gd` and `PatternEdit.gd`.

### Organization

**By Type:**
- TODO - Tasks to be done
- FIXME - Bugs to fix
- HACK - Code that needs improvement
- Custom patterns

**By Priority:**
- Color-coded categories
- Configurable via ColourPicker
- Visual distinction

**By Location:**
- File path grouping
- Quick navigation to source

### Dock Panel

The dock panel displays:
- List of all found tasks
- File locations and line numbers
- Pattern type indicators
- Search/filter capabilities
- Navigation buttons

## Configuration

### Pattern Customization

Edit task patterns:
1. Open Todo Manager settings
2. Add/edit patterns in PatternEdit
3. Define regex or text matches
4. Set colors and priorities

### Color Coding

Use ColourPicker to:
- Assign colors to task types
- Create visual priority system
- Customize appearance

### Project Settings

`todo.cfg` contains:
- Enabled patterns
- Color assignments
- Scan directories
- Exclusion rules

## Integration

### Editor Integration

```gdscript
# plugin.gd typical pattern
func _enter_tree():
    var dock = preload("UI/Dock.tscn").instantiate()
    add_control_to_dock(DOCK_SLOT_RIGHT_UL, dock)

func _exit_tree():
    remove_control_from_docks(dock)
    dock.queue_free()
```

### Scanning Process

1. Plugin scans project files
2. Matches patterns against comments
3. Extracts task information
4. Populates dock panel
5. Updates on file changes

## Usage

### Basic Workflow

1. **Enable Plugin:**
   - Project → Project Settings → Plugins
   - Enable "Todo Manager"

2. **Add Tasks in Code:**
   ```gdscript
   # TODO: Add error handling
   # FIXME: Memory leak here
   ```

3. **View in Dock:**
   - Tasks appear automatically in dock
   - Click to navigate to location

4. **Organize:**
   - Filter by type
   - Sort by priority
   - Search by text

### Custom Patterns

Create project-specific patterns:
- `@urgent` - High priority tasks
- `@review` - Code review needed
- `@performance` - Optimization needed

## Common Tasks

**Refreshing Task List:**
- Automatic on file save
- Manual refresh button in dock

**Navigating to Task:**
- Click task in dock panel
- Editor jumps to file:line

**Adding Custom Pattern:**
1. Open pattern editor
2. Define pattern regex
3. Set display color
4. Save configuration

**Filtering Tasks:**
- Use search field in dock
- Filter by type checkboxes
- Show/hide completed

## Plugin Status

### Currently Enabled

From `project.godot`:
```ini
[editor_plugins]
enabled=PackedStringArray("res://addons/Todo_Manager/plugin.cfg")
```

This is the only editor plugin currently enabled in the project.

### Version Information

- **Version:** 2.3.1
- **Maintained by:** Peter de Vroom
- **Type:** Third-party plugin
- **License:** See plugin documentation

## Known Features

Based on file structure:
- ✅ Pattern-based task detection
- ✅ Color-coded priorities
- ✅ Dock panel interface
- ✅ File navigation
- ✅ Custom patterns
- ✅ Project-wide scanning
- ✅ Search and filter
- ✅ Multi-language support (EN/CN docs)

## Documentation Resources

**In Plugin:**
- `doc/` folder - Usage documentation
- `doc/images/` - Screenshots and visual guides
- `README.md` - English documentation
- `READMECN.md` - Chinese documentation

**External:**
- Check README.md for links to project repository
- CONTRIBUTING.md for development info

## Development

### Extending the Plugin

To customize:
1. Edit pattern definitions in `Pattern.gd`
2. Modify dock UI in `UI/` components
3. Update `Dock.gd` for behavior changes
4. Adjust `todo.cfg` for defaults

### Testing

Use `Test.gd` for:
- Plugin functionality testing
- Pattern matching validation
- Performance testing

## Integration with Library of Aletheia

The Todo Manager helps track:
- Development tasks in daemon code
- Documentation TODOs
- Known issues and technical debt
- Feature implementation plans

It's particularly useful for:
- Managing the WIP state of the project
- Tracking build issues
- Organizing debugging tasks

## Navigation

- **Up:** [../claude.md](../claude.md) - Parent addons documentation
- **Root:** [../../claude.md](../../claude.md) - Project root documentation
- **Docs:** Check `doc/` folder for detailed usage documentation
