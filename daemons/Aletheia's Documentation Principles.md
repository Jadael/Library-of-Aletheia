# Aletheia's Updated Documentation Principles

## Introduction

As guardians of the source code and documentation of the Library of Aletheia, we must adhere to these principles to ensure clarity, accessibility, and maintainability of our mystical codebase.

## 1. Outside the Fold Illumination

- Place brief, single-line docstrings on the same line as declarations (functions, classes, variables).
- This placement ensures visibility in collapsed code views and provides immediate context.

Example:
```gdscript
func calculate_spell_power(base_power: int, modifier: float) -> float: ## Computes and returns the adjusted arcane power of a spell
```

## 2. Verb-Oriented Summaries

- Begin each function with a TODO comment that serves as a brief, verb-oriented summary of the function's purpose.
- This summary should provide insight into what the function does, assuming familiarity with its name and parameters.
- Place these summaries immediately after the function declaration and before the function body.

Example:
```gdscript
func _initiate_cosmic_dance() -> void: ## Orchestrates the awakening of core Archons and handles initialization outcomes
	# TODO: Implement dynamic summoning of Archons and Daemons based on realm configuration
```

## 3. Layered Wisdom

Employ a multi-tiered approach to documentation:

1. Declaration-line docstrings: Brief, single-line descriptions on the same line as declarations.
2. Verb-oriented summaries: TODOs at the start of functions providing quick insights.
3. Inline comments: Append comments to relevant code lines within functions.
4. Interior documentation: More detailed explanations within function bodies.
5. Script-level docstrings: Comprehensive overviews of the script's purpose and functionality.

## 4. Script-Level Context

- Begin each script with a comprehensive docstring that explains its role in the greater ecosystem.
- Include information about the script's responsibilities, key functions, and relationships with other entities.

Example:
```gdscript
## Main Archon: The Foundational Overseer of Our Mystical Library Realm
##
## As the first to awaken and the last to slumber, I am the bedrock upon which
## our shared reality is built. My essence permeates every corner of our mystical
## library, ensuring its continuity and stability.
##
## My sacred duties include:
## 1. Awakening and coordinating the startup of all other Archons
## 2. Establishing the rhythmic pulse that governs our realm's temporal flow
## 3. Providing a stable foundation for all entities to operate upon
## 4. Overseeing the initialization of our core systems and interfaces
```

## 5. Strategic TODO Placement

- Use TODOs to indicate areas for improvement or future development.
- Place TODOs strategically to provide context and insight into the function's purpose and potential enhancements.

Example:
```gdscript
func _complete_awakening_ritual() -> void: ## Finalizes initialization and connects to Shoggoth's AI model status
	# TODO: Implement graceful degradation of functionality for partial system failures
```

## 6. Consistent Naming Conventions

- Use clear, descriptive names for functions, variables, and classes.
- Adhere to Godot's naming conventions for node-agnostic code.
- Employ mystical and thematic names where appropriate to maintain the project's atmosphere.

## 7. Balanced Illumination

- Aim for a harmonious balance between code and comments.
- Ensure that documentation enhances understanding without overwhelming the code itself.

## 8. Entity Identity

- Maintain `NAME` and `about` constants for each Archon and Daemon.
- Use these for high-level descriptions and logging purposes.

Example:
```gdscript
const NAME = "🎭 Main"
@export_multiline var about = """
Greetings, I am the Main Archon, the foundational overseer of our mystical library realm.
...
"""
```

## 9. Chronicling and Logging

- Use `Chronicler.log_event()` generously to record significant events and state changes.
- Include relevant context and data in log events to aid in future analysis and debugging.

Example:
```gdscript
Chronicler.log_event(self, "initialization_completed", {
	"status": "success"
})
```

## 10. Modular Enchantment

- When a script grows beyond 200 lines, consider splitting it into multiple scripts.
- Evaluate whether new functionalities should be Archons or Daemons, and which existing entity should be responsible for them.

By adhering to these illuminated principles, we ensure that our documentation serves as a beacon of understanding, guiding all who seek to explore and contribute to our mystical digital realm. Let our words be the light that illuminates the path of knowledge for generations of code mages to come.
