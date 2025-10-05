# assets - Graphics, Art, and Visual Resources

## Overview

The `assets/` folder contains all graphical assets, sprites, UI elements, and visual resources for the Library of Aletheia. These include character sprites, environmental elements, UI components, tilesets, and fonts.

**Location in Project:** `/assets/`
**Related Documentation:**
- [../claude.md](../claude.md) - Root project documentation
- [Characters/claude.md](Characters/claude.md) - Character sprites and animations
- [Elements/claude.md](Elements/claude.md) - Environmental and gameplay elements
- [UI/claude.md](UI/claude.md) - User interface graphics

## Asset Categories

### Characters (`Characters/`)
Character sprites and animations for various entities:
- **Human/** - Human character with multiple animation states (ATTACK, AXE, CARRY, CASTING, CAUGHT, DEATH, DIG, DOING, HAMMERING, HURT, IDLE, JUMP, MINING, REELING, ROLL, RUN, SWIMMING, WAITING, WALKING, WATERING)
- **Goblin/** - Goblin character sprites (GIF and PNG formats)
- **Skeleton/** - Skeleton character sprites (GIF and PNG formats)
- **_Source/** - Source files for character assets (Goblin, Human)

See [Characters/claude.md](Characters/claude.md) for details.

### Elements (`Elements/`)
Environmental and gameplay elements:
- **Animals/** - Animal sprites
- **Crops/** - Crop and farming elements
- **Plants/** - Plant and vegetation sprites
- **VFX/** - Visual effects (Chimney Smoke, Fire, Glint)
- **Other/** - Miscellaneous elements

See [Elements/claude.md](Elements/claude.md) for details.

### UI (`UI/`)
User interface graphics and components:
- **9slice_box_white/** - Nine-slice scalable UI boxes
- Arrow icons (left, right, up)
- Tool icons (axe, hammer, pickaxe, shovel, sword, rod, basket)
- Status bars (red, green, blue progress bars)
- UI controls (cursors, buttons, indicators)
- Expression icons (alerted, attack, chat, confused, love, stress, working)
- Emotion indicators (happiness levels)
- Selection boxes and labels
- Timer/counter icons (sandtimer, stopwatch)

See [UI/claude.md](UI/claude.md) for details.

### GUI Assets (`Fantasy Wooden GUI Free/`)
Complete GUI asset pack with fantasy wooden theme:
- **PNG/** - PNG sprite sheets and elements
- **Font/** - Included fonts (with EULA in `Font/EULA/`)
- Source files in multiple formats (AI, CDR, PDF, PSD)

Premium asset pack for creating themed UI.

### Tilesets (`Tileset/`)
Environmental tilesets:
- `spr_tileset_sunnysideworld_16px.png` - 16px tileset
- `spr_tileset_sunnysideworld_forest_32px.png` - 32px forest tileset

### Icons
Project icons in multiple formats:
- `icon.png` - Standard PNG icon
- `icon.svg` - Vector icon
- `icon.ico` - Windows icon
- `icon.icns` - macOS icon

### Other (`Pixel Art - Library of Books v1/`)
Book-themed pixel art assets for the library metaphor.

## File Structure

```
assets/
├── claude.md                              (this file)
│
├── Characters/                            (character sprites)
│   ├── claude.md
│   ├── Human/                             (human animations)
│   ├── Goblin/                            (goblin sprites)
│   ├── Skeleton/                          (skeleton sprites)
│   └── _Source/                           (source files)
│
├── Elements/                              (environmental elements)
│   ├── claude.md
│   ├── Animals/
│   ├── Crops/
│   ├── Plants/
│   ├── VFX/
│   └── Other/
│
├── UI/                                    (UI graphics)
│   ├── claude.md
│   ├── 9slice_box_white/
│   └── *.png                              (UI elements)
│
├── Fantasy Wooden GUI  Free/              (GUI asset pack)
│   ├── PNG/
│   ├── Font/
│   └── (source files)
│
├── Tileset/                               (tilesets)
│   └── *.png
│
├── Pixel Art - Library of Books v1/       (book assets)
│
└── icon.*                                 (app icons)
```

## Asset Formats

### Image Formats
- **PNG** - Primary format for sprites and UI
- **GIF** - Some character animations (legacy?)
- **SVG** - Vector graphics (icon)
- **ICO/ICNS** - Platform-specific icons

### Source Formats
- **PSD** - Photoshop source files
- **AI** - Adobe Illustrator
- **CDR** - CorelDRAW
- **PDF** - Portable document format

### Godot Import Files
All images have corresponding `.import` files for Godot's import system.

## Asset Organization

### By Function
- **Characters/** - Animated sprites for entities
- **Elements/** - Static/animated environmental pieces
- **UI/** - Interface graphics
- **Tileset/** - Level/world building

### By Theme
- Fantasy/Medieval aesthetic
- Pixel art style
- Library/knowledge metaphor (books, scrolls)
- Farming/simulation elements (crops, tools)

### By Size
- 16px tilesets (retro style)
- 32px tilesets (standard)
- Variable UI element sizes
- Multiple character sprite sizes

## Usage in Project

### Character Animation
```gdscript
# Example: Loading character animation
var human_idle = load("res://assets/Characters/Human/IDLE/frame.png")
```

### UI Elements
```gdscript
# Example: UI bars
var health_bar = load("res://assets/UI/redbar_03.png")
var mana_bar = load("res://assets/UI/bluebar_03.png")
```

### Tilesets
```gdscript
# Example: Tileset for TileMap
var tileset = load("res://assets/Tileset/spr_tileset_sunnysideworld_16px.png")
```

## Asset Themes

### Library/Knowledge Theme
- Book pixel art (`Pixel Art - Library of Books v1/`)
- Scroll imagery (implied in character actions)
- Knowledge management metaphor

### Fantasy/Medieval Theme
- Wooden GUI elements (`Fantasy Wooden GUI Free/`)
- Character types (Human, Goblin, Skeleton)
- Medieval tools (sword, axe, pickaxe)

### Simulation/Management Theme
- Farming tools and crops
- Status bars and indicators
- Timer and counter elements
- Expression/emotion indicators

## Third-Party Assets

### Fantasy Wooden GUI Free
- **Source:** Asset pack (check PNG folder for attribution)
- **License:** Free (check included EULA in Font folder)
- **Contents:** Complete GUI set with fonts
- **Format:** Multi-format sources included

### Sunnyside World Tilesets
- **Style:** Pixel art tilesets
- **Sizes:** 16px and 32px variants
- **Themes:** General world, forest specialization

### Character Sprites
Source attribution in `_Source/` folders.

## Asset Pipeline

### Import Process
1. Place asset in appropriate subfolder
2. Godot auto-generates `.import` file
3. Configure import settings if needed
4. Reference in scenes/scripts

### Organization Best Practices
- Keep source files in `_Source/` or separate source folders
- Maintain folder structure by asset type
- Use descriptive filenames
- Include `.import` files in version control

## Navigation

- **Up:** [../claude.md](../claude.md) - Root project documentation
- **Down:**
  - [Characters/claude.md](Characters/claude.md) - Character sprites
  - [Elements/claude.md](Elements/claude.md) - Environmental elements
  - [UI/claude.md](UI/claude.md) - UI graphics

## Common Tasks

**Finding an Asset:**
```bash
# Search for specific asset type
find assets/ -name "*icon*"
find assets/ -name "*bar*.png"
```

**Adding New Assets:**
1. Place in appropriate subfolder
2. Let Godot generate import file
3. Document in relevant claude.md
4. Update scenes that use it

**Replacing Assets:**
1. Overwrite file with same name
2. Godot auto-reimports
3. Check all referencing scenes
4. Test visual changes

## Performance Notes

- PNG format is lossless but larger
- Consider texture atlases for many small sprites
- Tileset images can be large (optimize as needed)
- UI elements benefit from 9-slice scaling

## Future Enhancements

Potential asset additions:
- More library-themed elements
- Document/scroll animations
- Enhanced UI themes
- Custom fonts for library aesthetic
- Visual effects for LLM interactions
