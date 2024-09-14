---
title: h3_format
last_updated: 2024-09-12T16:17:15
---

# h3_format

## Properties

- @export var font_size: float = 1.428 : set = _set_font_size
- @export var is_bold := false : set = _set_is_bold
- @export var is_italic := false : set = _set_is_italic
- @export var is_underlined := false : set = _set_is_underlined
- @export var override_font_color: bool = false : set = _set_override_font_color
- @export var font_color: Color = Color.WHITE : set = _set_font_color

## Functions

### func _init() -> void:

**Function:** `_init`

### func _set_font_size(new_font_size: float) -> void:

**Function Name:** `_set_font_size`
**Purpose:** This function sets the font size for an object. It updates the font size to a new value and emits an `_updated` signal.

### func _set_override_font_color(enabled: bool) -> void:

**Function Name:** `_set_override_font_color`

### func _set_font_color(new_font_color: Color) -> void:

**Function Description:**
The `_set_font_color` function sets the font color for a specific object or control. This function updates the font color property and emits an `_updated` signal.

### func _set_is_bold(new_is_bold: bool) -> void:

The function `_set_is_bold` is used to set the value of the `is_bold` property and trigger the `_updated` signal.

### func _set_is_italic(new_is_italic: bool) -> void:

**Function Description:**

### func _set_is_underlined(new_is_underlined: bool) -> void:

**Function:** `_set_is_underlined`
**Purpose:** This function is used to set the `is_underlined` property of an object to a specified value. It is intended to update the state of an object that may have visual or behavioral dependencies on the `is_underlined` property.

## Signals

- signal _updated

## Usage Examples

[To be filled with relevant code examples]

## Related Entities

[To be filled with links to related Archons/Daemons]

## Version History

- Initial documentation generated on 2024-09-12T16:19:47
