---
title: h6_format
last_updated: 2024-09-12T16:24:41
---

# h6_format

## Properties

- @export var font_size: float = 0.857 : set = _set_font_size
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

### func _set_override_font_color(enabled: bool) -> void:

**Function Description:**
`_set_override_font_color` is a private function in Godot that sets the override font color state and emits a signal to notify other parts of the application about the change.

### func _set_font_color(new_font_color: Color) -> void:

**Function Description**

### func _set_is_bold(new_is_bold: bool) -> void:

Here is the technical documentation for the `_set_is_bold` function:

### func _set_is_italic(new_is_italic: bool) -> void:

**Function:** `_set_is_italic`
**Purpose:** This function is designed to change the `is_italic` property of the script and trigger an update event when the property changes.

### func _set_is_underlined(new_is_underlined: bool) -> void:

**Function Name:** `_set_is_underlined`

## Signals

- signal _updated

## Usage Examples

[To be filled with relevant code examples]

## Related Entities

[To be filled with links to related Archons/Daemons]

## Version History

- Initial documentation generated on 2024-09-12T16:27:14
