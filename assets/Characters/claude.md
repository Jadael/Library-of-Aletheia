# assets/Characters - Character Sprites and Animations

## Overview

The `assets/Characters/` folder contains character sprites and animations for various entity types in the Library of Aletheia. Each character has multiple animation states and is available in different formats.

**Location:** `/assets/Characters/`
**Related:**
- [../../claude.md](../../claude.md) - Root documentation
- [../claude.md](../claude.md) - Parent assets documentation

## Character Types

### Human
**Location:** `Human/`
**Format:** PNG sprite sheets organized by animation state

**Animation States:**
- **ATTACK** - Attack animation
- **AXE** - Axe wielding animation
- **CARRY** - Carrying objects
- **CASTING** - Magic/spellcasting animation
- **CAUGHT** - Being caught/grabbed
- **DEATH** - Death animation
- **DIG** - Digging animation
- **DOING** - Generic action
- **HAMMERING** - Using hammer
- **HURT** - Taking damage
- **IDLE** - Standing still
- **JUMP** - Jumping
- **MINING** - Mining action
- **REELING** - Fishing reel animation
- **ROLL** - Rolling/dodging
- **RUN** - Running
- **SWIMMING** - Swimming
- **WAITING** - Waiting/idle variant
- **WALKING** - Walking
- **WATERING** - Watering plants

### Goblin
**Location:** `Goblin/`
**Formats:** GIF and PNG
**Subfolders:**
- `GIF/` - Animated GIF sprites
- `PNG/` - PNG sprite sheets

### Skeleton
**Location:** `Skeleton/`
**Formats:** GIF and PNG
**Subfolders:**
- `GIF/` - Animated GIF sprites
- `PNG/` - PNG sprite sheets

### Source Files
**Location:** `_Source/`
**Contents:** Original/editable character assets
**Subfolders:**
- `_Source/Goblin/` - Goblin source files
- `_Source/Human/` - Human source files

## File Structure

```
Characters/
├── claude.md                    (this file)
│
├── Human/                       (human character)
│   ├── ATTACK/
│   ├── AXE/
│   ├── CARRY/
│   ├── CASTING/
│   ├── CAUGHT/
│   ├── DEATH/
│   ├── DIG/
│   ├── DOING/
│   ├── HAMMERING/
│   ├── HURT/
│   ├── IDLE/
│   ├── JUMP/
│   ├── MINING/
│   ├── REELING/
│   ├── ROLL/
│   ├── RUN/
│   ├── SWIMMING/
│   ├── WAITING/
│   ├── WALKING/
│   └── WATERING/
│
├── Goblin/                      (goblin character)
│   ├── GIF/
│   └── PNG/
│
├── Skeleton/                    (skeleton character)
│   ├── GIF/
│   └── PNG/
│
└── _Source/                     (source files)
    ├── Goblin/
    └── Human/
```

## Animation Organization

### Human Character Detail

The human character has the most comprehensive animation set with 20+ states covering:

**Combat:**
- ATTACK, HURT, DEATH

**Tools:**
- AXE, HAMMERING, DIG, MINING, WATERING

**Movement:**
- IDLE, WALKING, RUN, JUMP, ROLL, SWIMMING

**Actions:**
- CARRY, DOING, CASTING, CAUGHT, REELING, WAITING

Each folder contains frame-by-frame sprite sequences for smooth animation.

## Usage Patterns

### Loading Character Animations

```gdscript
# Load specific animation frame
var idle_frame_1 = load("res://assets/Characters/Human/IDLE/frame_001.png")

# Load animation sequence (example)
var walk_frames = []
for i in range(frame_count):
    walk_frames.append(load("res://assets/Characters/Human/WALKING/frame_%03d.png" % i))
```

### Animation State Machine

```gdscript
# Typical state-based animation
match character_state:
    "idle":
        play_animation("res://assets/Characters/Human/IDLE/")
    "walking":
        play_animation("res://assets/Characters/Human/WALKING/")
    "attacking":
        play_animation("res://assets/Characters/Human/ATTACK/")
```

### Using AnimatedSprite2D

```gdscript
# Setup in scene
var sprite = AnimatedSprite2D.new()
sprite.sprite_frames = preload("res://path_to_sprite_frames_resource")
sprite.play("idle")
```

## Format Notes

### PNG Format
- Frame-by-frame sprites
- Individual files per frame
- Organized in state folders
- Used for Human character primarily

### GIF Format
- Animated format
- Self-contained animation
- Used for Goblin and Skeleton
- Legacy format (PNG preferred for Godot)

### Godot Import
All sprite files have `.import` companions for Godot's import system.

## Character Themes

### Library Context

While these appear to be farming/simulation character sprites, they can be repurposed for the Library of Aletheia's metaphorical interface:

- **Human** - The librarian/user avatar
- **Goblin** - Archive assistant or cataloging entity
- **Skeleton** - Archived/deprecated content representation

### Animation Mapping

Library context mapping:
- **IDLE** → Waiting for commands
- **WALKING** → Navigating documents
- **CASTING** → Invoking LLM operations
- **CARRYING** → Moving documents
- **DIG/MINING** → Searching/researching
- **WATERING** → Nurturing knowledge

## Asset Attribution

Source files in `_Source/` folders suggest these are:
- Custom created or licensed assets
- Editable source versions available
- Check source folders for attribution details

## Performance Considerations

### Sprite Sheet Optimization
- Many individual PNGs can impact performance
- Consider creating sprite atlases
- Use Godot's AnimatedSprite2D with SpriteFrames resources

### Animation Efficiency
- Not all 20+ animations may be needed
- Load only required animation states
- Use texture filtering appropriate to pixel art style

## Common Tasks

**Adding New Character:**
1. Create character folder (e.g., `Wizard/`)
2. Organize animations by state
3. Place source files in `_Source/NewCharacter/`
4. Create SpriteFrames resource if needed
5. Document in this claude.md

**Adding Animation State:**
1. Create state folder (e.g., `Human/READING/`)
2. Add frame sprites
3. Update AnimatedSprite2D configuration
4. Test animation timing

**Replacing Character Sprites:**
1. Replace files in animation folder
2. Maintain naming convention
3. Godot auto-reimports
4. Test all affected scenes

## Future Enhancements

Potential additions:
- **Reading/Writing animations** - Library-specific actions
- **Scroll handling** - Document interaction
- **Book carrying variants** - Knowledge management theme
- **Cataloging animations** - Library work activities
- **Spectral/mystical effects** - LLM interaction visuals

## Navigation

- **Up:** [../claude.md](../claude.md) - Parent assets documentation
- **Root:** [../../claude.md](../../claude.md) - Project root documentation
- **Sibling:** [../Elements/claude.md](../Elements/claude.md) - Environmental elements
