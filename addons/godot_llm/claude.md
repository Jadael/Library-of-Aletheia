# godot_llm - LLM Integration GDExtension

## Overview

The `godot_llm` addon is a GDExtension that provides Large Language Model (LLM) capabilities to Godot. It enables running local GGUF format models for text generation and embeddings directly within the Godot engine.

**Type:** GDExtension (Native Library)
**Location:** `/addons/godot_llm/`
**Status:** ⚠️ Current backend, but may be replaced (not updated in 2+ years)

**Related Documentation:**
- [../../claude.md](../../claude.md) - Root project documentation
- [../claude.md](../claude.md) - Parent addons documentation

## Purpose

This extension is **ONE POSSIBLE BACKEND** for LLM capabilities. The Shoggoth daemon abstracts this completely - it could be replaced with Ollama, custom scaffolding, or a bundled open-source model without affecting other code.

**Current Uses:**
- Text generation for document analysis
- Embeddings for semantic search
- LLM-assisted documentation generation
- Interactive AI features

**Future Alternatives:**
- Ollama API integration (more actively maintained)
- Custom LLM scaffolding (lighter weight)
- Bundled small open-source model (distribution-friendly)

## Components

### Configuration

**godot_llm.gdextension** - Extension manifest
- Entry point: `llm_library_init`
- Minimum Godot version: 4.2
- Platform-specific library mappings
- **Note:** Debug builds use release libraries for performance

### Native Libraries (`bin/`)

Platform binaries for the extension:

```
bin/
├── libgodot_llm.windows.debug.amd64.dll     (Windows debug - unused)
├── libgodot_llm.windows.release.amd64.dll   (Windows release) ✓
├── libgodot_llm.linux.debug.x86_64.so       (Linux debug - unused)
├── libgodot_llm.linux.release.x86_64.so     (Linux release) ✓
├── libgodot_llm.android.debug.aarch64.so    (Android debug - unused)
├── libgodot_llm.android.release.aarch64.so  (Android release) ✓
├── libgodot_llm.darwin.debug.universal.dylib (macOS debug - unused)
└── libgodot_llm.darwin.release.universal.dylib (macOS release) ✓
```

**Performance Optimization:**
Debug builds are configured to use release libraries because debug builds are "really slow" (see `godot_llm.gdextension:7`). This is an intentional configuration choice for development.

## Platform Support

| Platform | Architecture | Status |
|----------|--------------|--------|
| Windows  | x86_64       | ✅ Supported |
| Linux    | x86_64       | ✅ Supported |
| macOS    | Universal    | ✅ Supported |
| Android  | ARM64        | ✅ Supported |

All platforms use release builds even in debug mode for performance.

## Integration

### Used By

**Shoggoth Daemon** (`Daemons/Shoggoth.gd`) - LLM Backend Abstraction
- **Shoggoth is NOT an agent** - it's a transparent backend API
- Wraps this extension to provide clean "raw LLM compute" access
- Abstracts all implementation details (loading, queuing, API)
- Makes switching backends painless - just change Shoggoth internals
- Other code never knows if it's using GDLlama, Ollama, or custom backend

### Model Requirements

The extension requires:
- **Format:** GGUF (Georgi Gerganov's Universal Format)
- **Location:** User-specified paths in Shoggoth daemon
- **Types:** Both text generation and embedding models supported
- **Size:** Depends on model (typically 3GB-20GB+)

**Model Configuration:**
```gdscript
# In Daemons/Shoggoth.gd
var model_path = "path/to/model.gguf"
# Configure and use via this daemon
```

## Architecture

### GDExtension Structure

1. **Native Layer (C/C++):**
   - Compiled libraries in `bin/`
   - Interface with llama.cpp or similar LLM backend
   - Optimized for performance

2. **Godot Integration:**
   - Registered via `llm_library_init` entry point
   - Exposes classes/nodes to GDScript
   - Cross-platform abstraction

3. **Application Layer (Shoggoth):**
   - Shoggoth daemon = transparent backend abstraction
   - Provides clean "raw LLM compute" API
   - Hides all implementation complexity
   - Backend-agnostic design

### Usage Pattern (Through Shoggoth ONLY)

```gdscript
# ALWAYS use Shoggoth - it abstracts the backend
var response = await Shoggoth.generate_text(prompt)
var embedding = await Shoggoth.get_embedding(text)

# NEVER use godot_llm directly - breaks abstraction
# var llm = LLMNode.new()  # DON'T DO THIS
# llm.load_model(path)     # Shoggoth handles this
```

**Key Principle:** All LLM access goes through Shoggoth. This allows replacing GDLlama with Ollama/custom backend without touching any other code.

## File Structure

```
addons/godot_llm/
├── claude.md                           (this file)
├── godot_llm.gdextension              (extension config)
├── godot_llm.gdextension.uid          (Godot UID)
└── bin/                               (native libraries)
    ├── libgodot_llm.windows.*.dll
    ├── libgodot_llm.linux.*.so
    ├── libgodot_llm.darwin.*.dylib
    └── libgodot_llm.android.*.so
```

## Configuration Details

From `godot_llm.gdextension`:

```ini
[configuration]
entry_symbol = "llm_library_init"
compatibility_minimum = "4.2"

[libraries]
# All platforms use release builds for performance
windows.debug.x86_64 = "bin/libgodot_llm.windows.release.amd64.dll"
windows.release.x86_64 = "bin/libgodot_llm.windows.release.amd64.dll"
# ... (similar for other platforms)
```

## Performance Considerations

### Why Release Builds in Debug Mode

The extension uses release libraries even during debug because:
- Debug LLM builds are "really slow" (per comment in `.gdextension`)
- LLM inference is CPU-intensive
- Development experience is better with optimized builds
- Godot can still debug GDScript while native code is optimized

### Resource Usage

LLM operations are resource-intensive:
- **CPU:** Inference requires significant processing
- **RAM:** Models load entirely into memory (3GB-20GB+)
- **Disk:** Model files are large
- **Time:** Generation can take seconds per response

## Common Tasks

**Adding New Platform Support:**
1. Compile native library for platform
2. Add binary to `bin/` folder
3. Update `godot_llm.gdextension` with new platform entry
4. Test on target platform

**Updating Extension:**
1. Replace binaries in `bin/`
2. Update `.gdextension` if API changes
3. Update Shoggoth daemon if interface changes
4. Test all LLM-dependent features

**Troubleshooting:**
```bash
# Check if extension loaded
# In Godot: Project → Project Settings → Addons
# Look for godot_llm in loaded extensions

# Verify binary paths
cat addons/godot_llm/godot_llm.gdextension

# Test via Shoggoth
# In console: Shoggoth.test_connection()
```

## Known Issues / Notes

- Debug builds intentionally use release libraries
- Large model files not included in repository
- Requires manual model download and configuration
- Performance depends heavily on CPU capabilities
- No GPU acceleration (CPU inference only)

## Related Files

- **`Daemons/Shoggoth.gd`** - Primary usage interface
- **`Daemons/ai_settings.gd`** - AI/LLM configuration
- **`documents/GDLlama Nodes Reference.md`** - Node documentation
- **`documents/gdllama-node-documentation.md`** - Additional docs

## External Dependencies

This extension likely depends on:
- **llama.cpp** - C/C++ LLM inference library
- **GGUF model files** - Quantized model format
- **Platform C++ runtimes** - Visual C++, GCC, Clang, etc.

## Navigation

- **Up:** [../claude.md](../claude.md) - Parent addons documentation
- **Root:** [../../claude.md](../../claude.md) - Project root documentation
- **Related:** `../../Daemons/Shoggoth.gd` - Primary integration point

## API Reference

For specific GDExtension API (classes, methods, signals), see:
- `documents/GDLlama Nodes Reference.md`
- `documents/gdllama-node-documentation.md`
- Shoggoth daemon implementation for high-level usage patterns
