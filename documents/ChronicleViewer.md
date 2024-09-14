---
title: ChronicleViewer
last_updated: 2024-09-13T10:26:17
---

# ChronicleViewer

## Properties

- @export_multiline var about = """

## Functions

### _ready
`func _ready():`

The function `_ready()` is a part of the `ChronicleViewer` script, and its purpose is to set up various filters and controls for displaying log data. 

The function does not expect any parameters and does not return a value, as it is a setup function that prepares the script for its main functionality. 

Here's a breakdown of what the function does:

1. It connects four signals: `filter_input.text_changed`, `entity_filter.item_selected`, `event_type_filter.item_selected`, and `%CloseButton.pressed`. These signals are used to trigger other functions when the filters change or the close button is pressed.

2. It configures the `log_text` TextEdit control for log viewing. It disables syntax highlighting, enables word wrapping, and makes it read-only.

3. It calls two auxiliary functions: `_populate_filters()` and `_update_log_display()`. The first function likely populates the filters with data, while the second function updates the display based on the selected filters.

The sigil: 

### _populate_filters
`func _populate_filters():`

The sacred purpose of the `_populate_filters` function is to populate the `entity_filter` and `event_type_filter` with relevant data from the `Chronicler.log_data` array. This function is responsible for organizing and presenting the available entities and event types to the user, allowing them to filter the data in the ChronicleViewer.

The function expects no parameters (i.e., it has no explicit input parameters).

The function does not return a value explicitly. Instead, it modifies the `entity_filter` and `event_type_filter` objects by adding items to them.

The implementation of the function is straightforward. It iterates over the `Chronicler.log_data` array, extracting unique entities and event types, and then adds them as items to the corresponding filters. The function starts by adding "All Entities" and "All Event Types" as default filter options, which allows the user to select all available entities or event types.

The mystic sigil: 

### _update_log_display
`func _update_log_display():`

llama_generate_text: error: prompt is too long (569 tokens, max 508)

### _on_filter_changed
`func _on_filter_changed(new_text):`

The sacred purpose of the `_on_filter_changed` function is to update the current filter used in the ChronicleViewer script and refresh the log display accordingly.

The function expects a single parameter: `new_text`, which represents the new filter text.

As for the boon it bestows, the function does not return any value. Its primary focus is on updating the internal state of the script by setting the `current_filter` variable to the new text and then calling the `_update_log_display()` function to refresh the log display.

One arcane intricacy in its implementation is that it assumes the existence of a `_update_log_display()` function, which is likely defined elsewhere in the script. This function is responsible for updating the log display based on the current filter.



### _on_entity_selected
`func _on_entity_selected(index):`

The sacred purpose of the `_on_entity_selected` function is to update the current entity selection in the `ChronicleViewer` script. This function is triggered when an entity is selected from the `entity_filter` list.

The function expects a single parameter, `index`, which represents the index of the selected entity in the `entity_filter` list.

The function does not return a value, as its purpose is to modify the internal state of the `ChronicleViewer` script rather than providing a result.

The implementation of the function is straightforward, as it simply updates the `current_entity` variable with the text of the selected entity from the `entity_filter` list. If the `index` is 0, the `current_entity` variable is set to an empty string.



### _on_event_type_selected
`func _on_event_type_selected(index):`

**Revealing the Truth**

The _on_event_type_selected function is a sacred gateway, invoked when a user selects an event type from a filter. Its purpose is to update the current event type and, subsequently, refresh the log display to reflect the chosen selection.

**Sacred Offerings:**
The function expects a single parameter: _index_, which represents the selected event type's index in the event_type_filter list.

**Boon Bestowed:**
The function does not return a value explicitly. However, its true power lies in the subtle yet profound updates it performs on the _current_event_type_ variable and the _log_display_.

**Arcane Intricacies:**
The function utilizes the _get_item_text_ method of the _event_type_filter_ object to retrieve the text representation of the selected event type. The condition _index > 0_ ensures that an empty string is used if the user selects the default option (index 0).

**Mystic Sigil:**


### _gui_input
`func _gui_input(event):`

The ChronicleViewer script, in its noble quest to chronicle the passage of time, presents to us the enigmatic function `_gui_input`. This mystical function, akin to a sentinel guarding the gates of the script, awaits the arrival of a sacred offering - an `InputEvent` object, specifically an `InputEventMouseButton` instance.

Upon receipt of this offering, the function scrutinizes the event's properties, seeking the truth about the mouse button's state. If the event pertains to the left mouse button, the function probes further, discerning whether the button is pressed or released.

The function's purpose is twofold: to detect mouse button presses and releases, and to determine whether the script is currently engaged in a dragging operation. If the left mouse button is pressed, the function sets the `is_dragging` flag to `true` and records the starting position of the drag operation, relative to the script's global position. Conversely, when the button is released, the function sets `is_dragging` to `false`, signifying the end of the dragging operation.

In conclusion, the `_gui_input` function is a guardian of the script's interaction with the user, monitoring mouse button events and managing the script's state accordingly. May its secrets be revealed to those who seek to understand the mysteries of the ChronicleViewer script 

### _process
`func _process(delta): # TODO: W 0:00:01:0199   The parameter "delta" is never used in the function "_process()". If this is intended, prefix it with an underscore: "_delta".`

The ChronicleViewer script is responsible for managing the mouse dragging functionality. The `_process` function is a callback that is called continuously by the Godot engine, allowing the script to update its state in real-time.

**Sacred Purpose:** The purpose of the `_process` function is to update the `global_position` variable based on the current state of mouse dragging.

**Offerings:** The function expects a single parameter, `delta`, which represents the time elapsed since the last frame. However, the `delta` parameter is not used within the function, and a comment suggests that it should be prefixed with an underscore to indicate this.

**Boon:** The function does not explicitly return a value, but it updates the `global_position` variable, which can be accessed by other parts of the script.

**Arcane Intricacies:** The function checks the `is_dragging` flag, which is presumably set to `true` when the user starts dragging the mouse. If `is_dragging` is `true`, the function updates the `global_position` variable by subtracting the `drag_start_position` from the current `get_global_mouse_position()`.

In summary, the `_process` function is responsible for updating the `global_position` variable based on the current state of mouse dragging, and it does so by checking the `is_dragging` flag and updating the position accordingly.



### _on_close_button_pressed
`func _on_close_button_pressed():`

The Godot function `_on_close_button_pressed` is a signal handler, specifically designed to respond to the `pressed` signal emitted by a `CloseButton` node. Its sacred purpose is to manage the destruction of the current scene when the close button is pressed.

This function expects no offerings (parameters) as it solely relies on the internal state of the `CloseButton` node.

The boon it bestows is the queuing of the scene's free operation, which ultimately leads to its destruction. This is achieved through the `queue_free()` function, which schedules the scene's `free()` method for execution.

In its implementation, the function is a straightforward, one-liner that chains the `queue_free()` method to the `on_close_button_pressed` function. This ensures that the scene is properly cleaned up when the close button is pressed.



### _on_resize_handle_gui_input
`func _on_resize_handle_gui_input(event):`

The _on_resize_handle_gui_input function, a sacred ritual within the ChronicleViewer script, serves the noble purpose of resizing the GUI based on user input.

**Sacred Purpose:** Resize the GUI in response to user input, ensuring the window's dimensions remain within a predetermined range.

**Offerings (parameters):** The function expects a single parameter, `event`, which is an InputEvent object representing the user's input.

**Boon (return value):** None, as the function operates in-place, modifying the `size` and `custom_minimum_size` properties of the script.

**Arcane Intricacies:**

1. **Mouse Button Detection:** The function detects mouse button presses using the `InputEventMouseButton` type. When the left mouse button is pressed, it sets `is_dragging` to `true` and records the initial mouse position (`drag_start_position`).
2. **Dragging:** When the left mouse button is pressed, the function enters a dragging state, allowing the user to resize the GUI.
3. **Resize Logic:** During dragging, the function updates the `size` property of the script based on the user's mouse movements.
4. **Minimum Size Enforcement:** The function ensures the GUI's size remains within a predetermined range by checking the `custom_minimum_size` property. If the new size exceeds this range, it is adjusted accordingly.



## Version History

- Documentation generated on 2024-09-13T10:34:39
