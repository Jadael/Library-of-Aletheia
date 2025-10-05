# docs - Plugin Documentation Files

## Overview

The `docs/` folder contains documentation files from the Todo_Manager plugin. These are reference materials for the plugin's functionality and usage.

**Location:** `/docs/`
**Related:**
- [../claude.md](../claude.md) - Root project documentation
- [../addons/Todo_Manager/claude.md](../addons/Todo_Manager/claude.md) - Todo Manager plugin

## Purpose

This folder serves as a collection point for plugin-generated or plugin-related documentation files. Currently it contains Todo_Manager markdown documentation.

## Documentation Files

### Todo_Manager Documentation

**Chronos.md** - Time/chronological features
**example.md** - Usage examples
**plugin.md** - Plugin overview and setup
**resizable.md** - Resizable UI features
**todo_class.md** - TODO class documentation

### Formatting References

Header format documentation for markdown:
- **h1_format.md** - H1 heading format
- **h2_format.md** - H2 heading format
- **h3_format.md** - H3 heading format
- **h4_format.md** - H4 heading format
- **h5_format.md** - H5 heading format
- **h6_format.md** - H6 heading format

## File Structure

```
docs/
├── claude.md                    (this file)
├── Chronos.md                   (Todo Manager - time features)
├── example.md                   (Todo Manager - examples)
├── plugin.md                    (Todo Manager - plugin docs)
├── resizable.md                 (Todo Manager - UI resizing)
├── todo_class.md               (Todo Manager - class reference)
├── h1_format.md                (Markdown H1 format)
├── h2_format.md                (Markdown H2 format)
├── h3_format.md                (Markdown H3 format)
├── h4_format.md                (Markdown H4 format)
├── h5_format.md                (Markdown H5 format)
└── h6_format.md                (Markdown H6 format)
```

## Relationship to Addons

These docs are associated with:
- **Todo_Manager plugin** (`addons/Todo_Manager/`)
- Provides user-facing documentation
- Reference material for plugin usage

The plugin itself has its own `doc/` folder at `addons/Todo_Manager/doc/` with additional documentation and images.

## Document Types

### Plugin Documentation
- Usage guides
- Feature explanations
- Class/API references
- Examples and tutorials

### Format References
- Markdown heading styles
- Documentation standards
- Formatting conventions

## Usage

### For Plugin Users
Read these files to understand:
- How to use Todo_Manager features
- TODO class structure and API
- Plugin configuration options
- Best practices and examples

### For Developers
Reference for:
- Plugin architecture understanding
- Extending plugin functionality
- Documentation format standards
- Markdown style guide

## Common Tasks

**Reading Plugin Docs:**
```bash
# View plugin documentation
cat docs/plugin.md

# Check examples
cat docs/example.md

# Understand TODO class
cat docs/todo_class.md
```

**Finding Specific Info:**
```bash
# Search for feature
grep -r "feature_name" docs/

# Find format reference
ls docs/h*_format.md
```

## Relation to Other Docs

### Project Documentation Hierarchy

1. **Root:** `../claude.md` - Project overview
2. **Folder-specific:** Various `claude.md` files - Context docs
3. **Implementation:** `../Daemons/docs/` - LLM-generated daemon docs
4. **Plugin docs:** `docs/` (this folder) - Plugin references
5. **User docs:** `../documents/` - User-facing knowledge base

### Documentation Sources

| Folder | Type | Purpose |
|--------|------|---------|
| `/docs/` | Plugin reference | Todo_Manager docs |
| `/documents/` | Knowledge base | User documentation, guides |
| `/Daemons/docs/` | Implementation | Daemon documentation |
| `/addons/Todo_Manager/doc/` | Plugin internal | Plugin's own doc folder |

## Markdown Format Standards

The `h*_format.md` files define:
- Heading level styles
- Markdown conventions
- Documentation formatting rules
- Consistency standards

These may be used by:
- Documentation generation systems
- Aletheia's self-documentation
- Markdown processors

## Future Use

This folder could expand to include:
- Other plugin documentation
- Generated API references
- Tool usage guides
- Integration documentation

## Navigation

- **Up:** [../claude.md](../claude.md) - Root project documentation
- **Related:**
  - [../addons/Todo_Manager/claude.md](../addons/Todo_Manager/claude.md) - Todo Manager plugin
  - [../documents/claude.md](../documents/claude.md) - User documentation
  - [../Daemons/docs/claude.md](../Daemons/docs/claude.md) - Daemon docs

## Notes

- This folder is distinct from `addons/Todo_Manager/doc/`
- Contains reference docs, not source plugin files
- Part of project documentation, not plugin code
- May be plugin-generated or manually written
