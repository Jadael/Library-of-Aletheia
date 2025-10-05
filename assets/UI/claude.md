# assets/UI - User Interface Graphics

## Overview

The `assets/UI/` folder contains user interface graphics including icons, buttons, bars, cursors, and UI components for the Library of Aletheia interface.

**Location:** `/assets/UI/`
**Related:**
- [../../claude.md](../../claude.md) - Root documentation
- [../claude.md](../claude.md) - Parent assets documentation

## UI Categories

### Nine-Slice Boxes
**Folder:** `9slice_box_white/`
- Scalable UI containers
- Corner and edge sprites for dynamic sizing
- White/neutral theme

### Navigation Icons
**Arrow icons** for directional navigation:
- `arrow_left.png` - Left navigation
- `arrow_right.png` - Right navigation
- `arrow_up.png` - Up navigation
- `arrow_up-1.png` - Up variant

### Tool Icons
**Gameplay/action icons:**
- `axe.png` - Axe tool
- `hammer.png` - Hammer tool
- `pickaxe.png` - Pickaxe tool
- `shovel.png` - Shovel tool
- `sword.png` - Sword/combat
- `rod.png`, `rod alt.png` - Fishing rod variants
- `basket.png` - Basket/container
- `plant.png` - Planting action
- `water.png` - Watering action

### Status Bars
**Progress/health bars** in multiple colors:

**Red bars** (health/danger):
- `redbar_00.png` through `redbar_06.png` (7 variants)

**Green bars** (health/success):
- `greenbar_00.png` through `greenbar_06.png` (8 variants including duplicate)

**Blue bars** (mana/energy):
- `bluebar_00.png` through `bluebar_05.png` (6 variants)

### Cursors
**Custom mouse cursors:**
- `cursor_01.png` through `cursor_05.png` (5 variants)

### Expression Icons
**Emotion/status indicators:**
- `expression_alerted.png` - Alert state
- `expression_attack.png` - Attack/aggressive
- `expression_chat.png` - Talking/communication
- `expression_confused.png`, `expression_confused-1.png` - Confusion
- `expression_love.png` - Affection/like
- `expression_stress.png` - Stress/worry
- `expression_working.png` - Busy/working

### Emotion Indicators
**Happiness/mood levels:**
- `happiness_01.png` through `happiness_04.png` (4 levels)

### UI Controls
**Interactive elements:**
- `confirm.png` - Confirmation button
- `cancel.png` - Cancel button
- `search.png` - Search function
- `indicator.png` - General indicator
- `plan alt.png` - Planning/map icon

### Hands/Interaction
**Hand cursor states:**
- `hand_open_01.png`, `hand_open_02.png` - Open hand
- `hand_closed_01.png`, `hand_closed_02.png` - Closed/grabbing hand

### Selection UI
**Selection indicators:**
- `select_dots.png` - Selection dots (small)
- `select_dots_large.png` - Selection dots (large)
- `selectbox_tl.png` - Top-left corner
- `selectbox_tr.png` - Top-right corner
- `selectbox_bl.png` - Bottom-left corner
- `selectbox_br.png` - Bottom-right corner

### Labels/Text Containers
**Text background elements:**
- `label_left.png` - Label left cap
- `label_middle.png` - Label middle (tileable)
- `label_right.png` - Label right cap

### Item Display
**Item disc backgrounds:**
- `itemdisc_01.png`, `itemdisc_02.png` - Circular item backgrounds

### Timers/Counters
**Time indicators:**
- `sandtimer.png` - Hourglass/timer
- `stopwatch.png` - Stopwatch/precise timing
- `playercount.png` - Player counter

## File Structure

```
UI/
├── claude.md                    (this file)
├── 9slice_box_white/           (scalable containers)
│   └── (nine-slice sprites)
│
└── *.png                       (all UI elements)
    ├── arrow_*.png            (navigation)
    ├── *bar_*.png             (progress bars)
    ├── cursor_*.png           (cursors)
    ├── expression_*.png       (expressions)
    ├── happiness_*.png        (emotion levels)
    ├── hand_*.png             (interaction cursors)
    ├── selectbox_*.png        (selection)
    ├── label_*.png            (text containers)
    └── (tools, controls, etc.)
```

## Usage Patterns

### Progress Bars

```gdscript
# Health bar example
var health_bar = TextureProgressBar.new()
health_bar.texture_under = load("res://assets/UI/redbar_00.png")
health_bar.texture_progress = load("res://assets/UI/redbar_06.png")
health_bar.value = 75  # 75%
```

### Custom Cursors

```gdscript
# Change cursor
Input.set_custom_mouse_cursor(
    load("res://assets/UI/cursor_01.png"),
    Input.CURSOR_ARROW
)
```

### Nine-Slice Containers

```gdscript
# Scalable panel
var panel = NinePatchRect.new()
panel.texture = load("res://assets/UI/9slice_box_white/box.png")
panel.patch_margin_left = 8
panel.patch_margin_right = 8
# ... (set other margins)
```

### Expression Indicators

```gdscript
# Show character state
var expression = Sprite2D.new()
match character_mood:
    "happy": expression.texture = load("res://assets/UI/happiness_04.png")
    "confused": expression.texture = load("res://assets/UI/expression_confused.png")
    "working": expression.texture = load("res://assets/UI/expression_working.png")
```

## Library Context Usage

### Document Management UI

**Tool Icons as Actions:**
- `search.png` - Search documents
- `axe.png` - Cut/remove content
- `hammer.png` - Build/construct documents
- `basket.png` - Collection/basket of documents

**Status Bars:**
- **Red** - Document health/issues
- **Green** - Document completion
- **Blue** - LLM processing/energy

**Expression Icons:**
- `expression_working.png` - LLM processing
- `expression_alerted.png` - Attention needed
- `expression_confused.png` - Parsing error
- `expression_chat.png` - Interactive mode

### Navigation
- Arrows for browsing documents
- Selection boxes for multi-select
- Cursors for different interaction modes

### Indicators
- Timer icons for LLM generation time
- Happiness levels for document quality
- Item discs for document icons

## Design Patterns

### Color-Coded Systems
- **Red** - Danger, health, errors
- **Green** - Success, completion, health
- **Blue** - Energy, resources, processing

### Progressive Elements
Many elements come in sequences:
- Bars: 00-06 (empty to full)
- Happiness: 01-04 (levels)
- Cursors: 01-05 (states)

### Dual Formats
Some elements have variants:
- `rod.png` / `rod alt.png`
- `expression_confused.png` / `expression_confused-1.png`
- `plan alt.png` (variant)

## Common Tasks

**Creating Progress Bar:**
1. Choose bar color (red/green/blue)
2. Use `*bar_00` for background
3. Use `*bar_06` for fill
4. Apply to TextureProgressBar node

**Implementing Custom Cursor:**
1. Select cursor variant (01-05)
2. Set via `Input.set_custom_mouse_cursor()`
3. Map to appropriate mouse state

**Building Scalable Panel:**
1. Use nine-slice box sprites
2. Configure NinePatchRect margins
3. Set size dynamically

**Adding Expression Indicator:**
1. Create Sprite2D node
2. Switch texture based on state
3. Position near character/UI element

## Performance Notes

- Small PNG icons load quickly
- Pre-load frequently used UI elements
- Use texture atlases for many small icons
- Nine-slice scaling is efficient

## Asset Style

**Aesthetic:**
- Pixel art style
- Farming/simulation theme
- Clear, readable icons
- Consistent color palette

**Size:**
- Small icon size (likely 16x16 or 32x32)
- Optimized for pixel-perfect display
- Appropriate for retro/indie aesthetic

## Integration with GUI Pack

These UI elements complement the Fantasy Wooden GUI pack:
- Neutral/white theme works with wooden aesthetic
- Icons provide functional clarity
- Can be layered on wooden panels

## Future Enhancements

Potential library-themed additions:
- **Book icons** - Open, closed, reading
- **Scroll indicators** - Unfurled, rolled
- **Quill/pen** - Writing/editing mode
- **Magnifying glass** - Detailed search variant
- **Candle/lamp** - Reading light indicator
- **Bookmark** - Save/mark position
- **Category symbols** - Different document types

## Navigation

- **Up:** [../claude.md](../claude.md) - Parent assets documentation
- **Root:** [../../claude.md](../../claude.md) - Project root documentation
- **Related:** [../Fantasy Wooden GUI  Free/claude.md](../Fantasy%20Wooden%20GUI%20%20Free/claude.md) - GUI asset pack
