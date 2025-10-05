# assets/Elements - Environmental and Gameplay Elements

## Overview

The `assets/Elements/` folder contains environmental sprites, gameplay objects, and visual effects that populate the game world and support gameplay mechanics.

**Location:** `/assets/Elements/`
**Related:**
- [../../claude.md](../../claude.md) - Root documentation
- [../claude.md](../claude.md) - Parent assets documentation

## Element Categories

### Animals (`Animals/`)
Animal sprites for world population:
- Wildlife sprites
- Potential pets or farm animals
- Ambient life elements

### Crops (`Crops/`)
Agricultural/farming elements:
- Crop sprites at various growth stages
- Harvestable plants
- Farming simulation assets

### Plants (`Plants/`)
Vegetation and flora:
- Decorative plants
- Trees and bushes
- Environmental greenery

### VFX (`VFX/`)
Visual effects and particle elements:
- **Chimney Smoke/** - Smoke particle animations
- **Fire/** - Fire and flame effects
- **Glint/** - Sparkle/shine effects

### Other (`Other/`)
Miscellaneous elements:
- Objects that don't fit other categories
- Special items
- Environmental decorations

## File Structure

```
Elements/
├── claude.md                    (this file)
│
├── Animals/                     (animal sprites)
│   └── *.png
│
├── Crops/                       (crop sprites)
│   └── *.png
│
├── Plants/                      (vegetation)
│   └── *.png
│
├── VFX/                        (visual effects)
│   ├── Chimney Smoke/
│   ├── Fire/
│   └── Glint/
│
└── Other/                      (miscellaneous)
    └── *.png
```

## Element Themes

### Environmental Building
These elements create the world environment:
- **Plants** - Background vegetation
- **Animals** - Living world details
- **VFX** - Atmospheric effects

### Gameplay Support
Elements supporting game mechanics:
- **Crops** - Growth/farming systems
- **Animals** - Interaction targets
- **Other** - Functional objects

### Visual Polish
Effects for visual enhancement:
- **Smoke** - Ambient atmosphere
- **Fire** - Dynamic lighting/warmth
- **Glint** - Attention indicators

## Usage in Library Context

### Metaphorical Mapping

Elements can represent library concepts:

**Plants:**
- Growing knowledge
- Nurturing ideas
- Flourishing wisdom

**Crops:**
- Cultivated documents
- Harvesting insights
- Information maturity stages

**Animals:**
- Wandering thoughts
- Research assistants (symbolic)
- Archive inhabitants

**VFX:**
- **Fire** - Active processing/LLM thinking
- **Smoke** - Background operations
- **Glint** - Discoveries/insights

## VFX Details

### Chimney Smoke
- Particle animation frames
- Rising smoke effect
- Ambient atmosphere
- Could represent: Background LLM processing

### Fire
- Flame animation frames
- Dynamic fire effect
- Warmth/activity indicator
- Could represent: Active AI operations

### Glint
- Sparkle/shine frames
- Attention-grabbing effect
- Discovery indicator
- Could represent: New insights, important documents

## Usage Patterns

### Static Elements

```gdscript
# Place static element in scene
var plant = Sprite2D.new()
plant.texture = load("res://assets/Elements/Plants/tree_01.png")
add_child(plant)
```

### Animated Elements

```gdscript
# Animate VFX
var fire_anim = AnimatedSprite2D.new()
fire_anim.sprite_frames = preload("res://path_to_fire_frames")
fire_anim.play("burn")
add_child(fire_anim)
```

### Particle Systems

```gdscript
# Use as particle texture
var particles = GPUParticles2D.new()
particles.texture = load("res://assets/Elements/VFX/Chimney Smoke/smoke_01.png")
particles.emitting = true
```

## Asset Organization Strategy

### By Function
- **Decoration** - Plants, animals (visual only)
- **Interactive** - Crops, special objects
- **Effects** - VFX folder

### By Animation Complexity
- **Static** - Single frame sprites
- **Animated** - Multiple frame sequences
- **Particle** - VFX elements designed for particles

## Common Tasks

**Adding New Plant:**
1. Place PNG in `Plants/` folder
2. Name descriptively (e.g., `oak_tree.png`)
3. Let Godot import
4. Use in scenes

**Creating New VFX:**
1. Create subfolder in `VFX/` (e.g., `Sparkles/`)
2. Add animation frames
3. Create AnimatedSprite2D or particle setup
4. Document effect purpose

**Organizing Crops:**
1. Use naming convention for growth stages
2. Example: `wheat_stage_01.png` through `wheat_stage_04.png`
3. Create animation or state machine
4. Link to gameplay systems

## Performance Notes

### VFX Optimization
- Particle count impacts performance
- Limit simultaneous effects
- Use appropriate texture sizes
- Consider sprite sheets for animations

### Element Density
- Too many elements can reduce FPS
- Use culling for off-screen elements
- Batch similar elements
- Optimize texture sizes

## Library-Specific Usage

### Document Visualization
Elements could visualize document states:
- **Growing plants** - Documents being developed
- **Mature crops** - Completed documents
- **Fire** - Active editing/LLM generation
- **Glint** - Important annotations

### Ambient Effects
Create library atmosphere:
- **Smoke** - Mystical archive ambiance
- **Fire** - Candles/reading lights
- **Animals** - Archive familiars

### Progress Indicators
Use growth/change to show progress:
- Crop growth = document completion
- Fire intensity = processing activity
- Plant health = document quality

## Future Enhancements

Potential additions:
- **Book-specific VFX** - Page turning, dust motes
- **Knowledge symbols** - Runes, glyphs, letters
- **Library creatures** - Owls, cats, mystical beings
- **Magical effects** - Portal, transformation, enlightenment
- **Document states** - Scrolls, books, tablets at various states

## Asset Attribution

Check individual subfolders for:
- Source attribution
- License information
- Original asset packs
- Custom creation notes

## Navigation

- **Up:** [../claude.md](../claude.md) - Parent assets documentation
- **Root:** [../../claude.md](../../claude.md) - Project root documentation
- **Sibling:** [../Characters/claude.md](../Characters/claude.md) - Character sprites
