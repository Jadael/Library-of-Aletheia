---
title: h4_format
last_updated: 2024-09-12T16:19:47
---

# h4_format

## Properties

- @export var font_size: float = 1.142 : set = _set_font_size
- @export var is_bold := false : set = _set_is_bold
- @export var is_italic := false : set = _set_is_italic
- @export var is_underlined := false : set = _set_is_underlined
- @export var override_font_color: bool = false : set = _set_override_font_color
- @export var font_color: Color = Color.WHITE : set = _set_font_color

## Functions

### func _init() -> void:

**Function:** `_init`
**Purpose:** Initializes the function.
**Parameters:** None.
**Returns:** `void` (nothing).
**Important details:**
The `_init` function is a special function in Godot, which is automatically called when a script is initialized. It is used to set the `resource_local_to_scene` variable to `true`. This variable is a boolean that determines whether resources are loaded locally or in the scene. Setting it to `true` means that resources will be loaded locally, which can improve performance. The function does not take any parameters and does not return any value. It is an initialization function that sets the `resource_local_to_scene` variable to a specific value.<|eot_id|>

### func _set_font_size(new_font_size: float) -> void:

The function `_set_font_size` is designed to set the font size of a given object. It takes a single parameter `new_font_size` of type `float`, which specifies the desired font size. The function updates the `font_size` property with the new value and emits a `_updated` signal, indicating that the font size has been changed.

### func _set_override_font_color(enabled: bool) -> void:

**Function:** `_set_override_font_color`

### func _set_font_color(new_font_color: Color) -> void:

Here is the description of the function:

### func _set_is_bold(new_is_bold: bool) -> void:

Here is the description of the function `_set_is_bold`:

### func _set_is_italic(new_is_italic: bool) -> void:

Function: _set_is_italic

### func _set_is_underlined(new_is_underlined: bool) -> void:

**Function Description:**

## Signals

- signal _updated

## Usage Examples

[To be filled with relevant code examples]

## Related Entities

[To be filled with links to related Archons/Daemons]

## Version History

- Initial documentation generated on 2024-09-12T16:22:14
