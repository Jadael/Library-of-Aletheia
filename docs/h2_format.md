---
title: h2_format
last_updated: 2024-09-12T16:14:43
---

# h2_format

## Properties

- @export var font_size: float = 1.714 : set = _set_font_size
- @export var is_bold := false : set = _set_is_bold
- @export var is_italic := false : set = _set_is_italic
- @export var is_underlined := false : set = _set_is_underlined
- @export var override_font_color: bool = false : set = _set_override_font_color
- @export var font_color: Color = Color.WHITE : set = _set_font_color

## Functions

### func _init() -> void:

**Function Name:** `_init`
**Purpose:** The `_init` function is a special function in Godot, which is called when the script is initialized. It is used to initialize the script's properties and set up the script for its intended use.

### func _set_font_size(new_font_size: float) -> void:

The function `_set_font_size` is responsible for setting the font size of a specific object. It takes a single parameter `new_font_size` of type `float`, which represents the new desired font size. The function updates the internal font size variable `font_size` to the new value and then emits the `_updated` signal to notify any connected listeners of the change.

### func _set_override_font_color(enabled: bool) -> void:

Here is the description for the provided function:

### func _set_font_color(new_font_color: Color) -> void:

**Function:** `_set_font_color`

### func _set_is_bold(new_is_bold: bool) -> void:

**Function Description:**

### func _set_is_italic(new_is_italic: bool) -> void:

**Function:** `_set_is_italic`

### func _set_is_underlined(new_is_underlined: bool) -> void:

**Function Name:** `_set_is_underlined`

## Signals

- signal _updated

## Usage Examples

[To be filled with relevant code examples]

## Related Entities

[To be filled with links to related Archons/Daemons]

## Version History

- Initial documentation generated on 2024-09-12T16:17:15
