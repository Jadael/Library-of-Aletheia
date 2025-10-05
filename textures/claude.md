# textures - Texture Resources

## Overview

The `textures/` folder is designated for texture assets used in rendering, backgrounds, and visual effects throughout the Library of Aletheia. Currently empty, but intended for texture-related resources.

**Location:** `/textures/`
**Related:**
- [../claude.md](../claude.md) - Root project documentation
- [../fonts/claude.md](../fonts/claude.md) - Font resources
- [../assets/claude.md](../assets/claude.md) - Main assets folder

## Purpose

This folder should contain:
- Background textures
- Surface materials
- UI texture elements
- Particle textures
- Shader textures
- Pattern overlays

## Current State

**Status:** Empty folder

**Note:** There is currently a `paper_texture.png` in the `fonts/` folder that should logically be here:
- `fonts/paper_texture.png` - Paper/parchment background texture
- Should be moved to `textures/paper_texture.png` for better organization

## File Structure

```
textures/
└── claude.md                    (this file)
```

Expected structure:
```
textures/
├── claude.md
├── backgrounds/
│   └── paper_texture.png       (should be moved here)
├── materials/
├── particles/
└── ui/
```

## Texture Types

### Backgrounds
- Paper/parchment textures
- Wood grain
- Stone/marble
- Fabric patterns
- Aged document effects

### UI Textures
- Button textures
- Panel backgrounds
- Border patterns
- Decorative elements

### Material Textures
- Surface materials for 3D (if used)
- Normal maps
- Roughness maps
- Metallic maps

### Particle Textures
- Smoke textures
- Fire textures
- Magic effect textures
- Dust particles

## Library Theme Textures

Potential texture assets for library aesthetic:

### Document Textures
- Aged paper varieties
- Parchment backgrounds
- Book cover materials
- Leather textures
- Cloth bindings

### Environmental
- Wood (shelves, desks, floors)
- Stone (walls, columns)
- Metal (fixtures, decorations)
- Glass (windows, displays)

### Mystical/Magical
- Glow effects
- Particle systems
- Energy patterns
- Ethereal backgrounds

## Usage Patterns

### Background Textures

```gdscript
# Example: Paper background for document
var bg = TextureRect.new()
bg.texture = load("res://textures/backgrounds/paper_texture.png")
bg.stretch_mode = TextureRect.STRETCH_TILE
```

### Shader Textures

```gdscript
# Example: Using texture in shader
shader_material.set_shader_parameter("paper_texture", load("res://textures/paper.png"))
```

### Particle Textures

```gdscript
# Example: Particle system
var particles = GPUParticles2D.new()
particles.texture = load("res://textures/particles/dust.png")
particles.process_material = particle_material
```

## Integration Points

### Glyph Daemon
May use textures for:
- Text rendering backgrounds
- Document display surfaces
- Typography effects

### UI Systems
- Panel backgrounds
- Button textures
- Decorative borders
- Themed elements

### Visual Effects
- Particle systems (VFX)
- Shader effects
- Post-processing

## Organization Strategy

### By Purpose
```
textures/
├── backgrounds/     (full-screen backgrounds)
├── ui/             (interface textures)
├── materials/      (surface materials)
├── particles/      (particle system textures)
└── effects/        (special effects)
```

### By Theme
```
textures/
├── library/        (book, paper, wood)
├── mystical/       (magic, energy, ethereal)
├── interface/      (UI specific)
└── environment/    (world building)
```

## Texture Formats

### Recommended Formats
- **PNG** - Lossless, transparency support
- **WebP** - Smaller size, good quality
- **JPG** - Photos, no transparency
- **SVG** - Vector textures (if supported)

### Godot Import
- `.import` files auto-generated
- Configure compression
- Set filtering (nearest/linear)
- Mipmaps if needed

## Performance Considerations

### Texture Size
- Use power-of-two dimensions when possible (256, 512, 1024)
- Compress for performance
- Use texture atlases for many small textures

### Memory Usage
- Large textures consume VRAM
- Use appropriate resolution
- Consider streaming for very large textures

### Loading
- Pre-load common textures
- Stream load for large backgrounds
- Use resource groups

## Common Tasks

### Adding Textures
1. Create appropriate subfolder
2. Place texture file
3. Configure import settings
4. Reference in materials/shaders
5. Document significant additions

### Creating Seamless Textures
1. Use tileable images
2. Set wrap mode to repeat
3. Test seams
4. Adjust in image editor if needed

### Optimizing Textures
1. Resize to appropriate dimensions
2. Compress (lossy/lossless as appropriate)
3. Use VRAM compression if supported
4. Remove unused textures

## Migration Note

### paper_texture.png
**Current location:** `fonts/paper_texture.png`
**Should be:** `textures/backgrounds/paper_texture.png`

**Migration steps:**
1. Create `textures/backgrounds/` folder
2. Move `fonts/paper_texture.png` here
3. Update all references in code
4. Test all scenes using the texture

**Current references to update:**
```bash
# Find references
grep -r "fonts/paper_texture" --include="*.gd" --include="*.tscn"
```

## Future Additions

Expected texture additions:
- Paper/parchment varieties (aged, clean, torn)
- Wood grain for UI panels
- Leather book covers
- Mystical glow effects
- Particle textures for VFX
- UI border patterns
- Background ambiance textures

## Asset Sources

### Creating Textures
- Photo-based (scanned/photographed)
- Procedural generation
- Hand-painted
- AI-generated
- Asset packs

### Licensing
- Ensure proper licensing for all textures
- Document attribution
- Use open-source/CC when possible

## Relationship to Assets Folder

**Distinction:**
- **`assets/`** - Complete sprites, characters, UI elements
- **`textures/`** - Base textures for materials, backgrounds, effects

**Overlap:**
- Some items could belong in either
- Current organization: sprites in assets, materials here
- Consider use case for placement

## Navigation

- **Up:** [../claude.md](../claude.md) - Root project documentation
- **Sibling:** [../fonts/claude.md](../fonts/claude.md) - Font resources
- **Related:** [../assets/claude.md](../assets/claude.md) - Main assets folder

## Notes

- Currently empty - opportunity for organization
- `paper_texture.png` needs migration from `fonts/`
- Structure should align with project visual needs
- Library theme suggests rich texture opportunities
