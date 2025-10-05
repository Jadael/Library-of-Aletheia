# fonts - Typography Resources

## Overview

The `fonts/` folder contains TrueType font files used for text rendering throughout the Library of Aletheia. The selection includes both serif and monospace fonts appropriate for a library/document management aesthetic.

**Location:** `/fonts/`
**Related:**
- [../claude.md](../claude.md) - Root project documentation
- [../textures/claude.md](../textures/claude.md) - Texture resources

## Font Collection

### Libre Baskerville (Serif)
**Purpose:** Display text, document content, literary aesthetic

**LibreBaskerville-Regular.ttf**
- Standard serif font
- Primary reading font
- Classic book typography
- Professional document appearance

**LibreBaskerville-Bold.ttf**
- Bold weight variant
- Headers and emphasis
- Titles and headings
- Important text highlighting

**LibreBaskerville-Italic.ttf**
- Italic variant
- Emphasis and quotes
- Foreign terms
- Stylistic variation

**Characteristics:**
- Traditional serif typeface
- Optimized for body text
- Web/print font origin
- Excellent readability
- Library/book aesthetic

### Fira Sans (Sans-Serif)
**Purpose:** UI elements, labels, modern contrast

**FiraSans-Regular.ttf**
- Clean sans-serif font
- UI text and labels
- Modern, readable
- Good screen rendering

**Characteristics:**
- Mozilla's open-source font
- Designed for readability
- Wide language support
- Good at small sizes

### Hack (Monospace)
**Purpose:** Code display, technical text

**Hack-Regular.ttf**
- Monospace programming font
- Code snippets
- Technical documentation
- Fixed-width text needs

**Characteristics:**
- Designed for source code
- Clear character distinction
- Programming ligatures (possibly)
- Developer-friendly

## File Structure

```
fonts/
├── claude.md                          (this file)
│
├── LibreBaskerville-Regular.ttf      (serif - regular)
├── LibreBaskerville-Regular.ttf.import
├── LibreBaskerville-Bold.ttf         (serif - bold)
├── LibreBaskerville-Bold.ttf.import
├── LibreBaskerville-Italic.ttf       (serif - italic)
├── LibreBaskerville-Italic.ttf.import
│
├── FiraSans-Regular.ttf              (sans-serif)
├── FiraSans-Regular.ttf.import
│
├── Hack-Regular.ttf                  (monospace)
├── Hack-Regular.ttf.import
│
├── paper_texture.png                 (background texture)
└── paper_texture.png.import
```

## Additional Asset

### paper_texture.png
**Note:** This is a texture, not a font, but stored in fonts folder

- Paper background texture
- Document/parchment aesthetic
- Used for UI backgrounds
- Enhances library theme

(Should possibly be moved to `textures/` folder for better organization)

## Typography Usage

### Document Display (Scroll UI)

```gdscript
# Example: Setting up document text
var document_label = Label.new()
document_label.add_theme_font_override("font", load("res://fonts/LibreBaskerville-Regular.ttf"))
document_label.add_theme_font_size_override("font_size", 16)
```

### Code Display (Codex UI)

```gdscript
# Example: Code editor font
var code_editor = CodeEdit.new()
code_editor.add_theme_font_override("font", load("res://fonts/Hack-Regular.ttf"))
code_editor.add_theme_font_size_override("font_size", 14)
```

### UI Elements

```gdscript
# Example: Clean UI text
var ui_label = Label.new()
ui_label.add_theme_font_override("font", load("res://fonts/FiraSans-Regular.ttf"))
```

### Text Styles

```gdscript
# Example: Emphasized text
var emphasized = RichTextLabel.new()
emphasized.add_theme_font_override("italics_font", load("res://fonts/LibreBaskerville-Italic.ttf"))
emphasized.add_theme_font_override("bold_font", load("res://fonts/LibreBaskerville-Bold.ttf"))
```

## Font Pairing Strategy

### Library Aesthetic
- **Primary:** Libre Baskerville (document text)
- **Secondary:** Fira Sans (UI labels)
- **Technical:** Hack (code blocks)

### Use Cases

| Context | Font | Reason |
|---------|------|--------|
| Document content | Libre Baskerville Regular | Readability, classic book feel |
| Headers/Titles | Libre Baskerville Bold | Hierarchy, emphasis |
| Quotes/Emphasis | Libre Baskerville Italic | Stylistic variation |
| UI buttons/labels | Fira Sans Regular | Modern, clean |
| Code display | Hack Regular | Monospace clarity |

## Licensing

### Open Source Fonts
All fonts appear to be open-source:

- **Libre Baskerville** - SIL Open Font License (likely)
- **Fira Sans** - SIL Open Font License (Mozilla)
- **Hack** - MIT License (likely)

Verify specific licenses in font metadata or documentation.

## Godot Integration

### Import Configuration
Each `.ttf` file has an `.import` companion:
- Godot auto-generates on import
- Configures font rendering
- Hinting and antialiasing settings
- MSDF or bitmap configuration

### Dynamic Font Resources
```gdscript
# Preload for efficiency
const BASKERVILLE = preload("res://fonts/LibreBaskerville-Regular.ttf")
const BASKERVILLE_BOLD = preload("res://fonts/LibreBaskerville-Bold.ttf")
const BASKERVILLE_ITALIC = preload("res://fonts/LibreBaskerville-Italic.ttf")
const FIRA = preload("res://fonts/FiraSans-Regular.ttf")
const HACK = preload("res://fonts/Hack-Regular.ttf")
```

### Theme Integration
```gdscript
# Create theme with fonts
var theme = Theme.new()
theme.default_font = load("res://fonts/LibreBaskerville-Regular.ttf")
theme.default_font_size = 16
```

## Typography in Glyph Daemon

The Glyph daemon (`Daemons/glyph.gd`) likely manages:
- Font loading and caching
- Text rendering settings
- Typography presets
- Font size management

Reference Glyph daemon for text rendering utilities.

## Performance Considerations

### Font Loading
- Pre-load fonts at startup
- Cache font resources
- Avoid runtime font loading

### Rendering
- Use MSDF fonts for scaling (if needed)
- Optimize font size range
- Consider bitmap fonts for pixel art UI

### File Sizes
TTF files are typically small:
- Regular: ~100-200KB each
- Minimal performance impact
- Quick loading times

## Common Tasks

### Adding New Font
1. Place `.ttf` file in `fonts/` folder
2. Let Godot generate `.import` file
3. Configure import settings if needed
4. Reference in scripts/themes
5. Document in this claude.md

### Changing Font Size
```gdscript
# Dynamic font size (Scroll UI example)
Scroll.set_font_size(18)  # If such method exists
# Or direct theme override
label.add_theme_font_size_override("font_size", 18)
```

### Creating Font Variant
```gdscript
# Load and configure
var font = load("res://fonts/LibreBaskerville-Regular.ttf")
var font_variation = FontVariation.new()
font_variation.base_font = font
font_variation.variation_embolden = 0.5  # Example
```

## Design Rationale

### Why These Fonts?

**Libre Baskerville:**
- Library/book aesthetic perfect for project theme
- Excellent for long-form reading
- Professional, scholarly appearance

**Fira Sans:**
- Modern contrast to classical serif
- Clean UI text
- Good accessibility

**Hack:**
- Developer-friendly for code
- Clear in Codex interface
- GDScript documentation display

## Future Enhancements

Potential additions:
- Additional weights (Light, Medium)
- Display fonts for titles
- Decorative fonts for special UI
- Icon fonts for symbols
- Language-specific fonts

## Navigation

- **Up:** [../claude.md](../claude.md) - Root project documentation
- **Sibling:** [../textures/claude.md](../textures/claude.md) - Texture resources
- **Related:** `../Daemons/glyph.gd` - Typography daemon

## Notes

- `paper_texture.png` should possibly move to `textures/`
- Font selection aligns with library/knowledge theme
- All fonts appear to be open-source licensed
