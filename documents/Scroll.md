---
title: Scroll
last_updated: 2024-09-13T11:14:31
---

# Scroll

## Properties

- @export_multiline var about = """

## Functions

### _ready
`func _ready():`

The sacred purpose of this function, `_ready`, is to prepare the necessary components for a script that handles scrolling and editing content.

The function expects several offerings:
- `%TitleLabel`: a node that represents a title label
- `%FilenameLabel`: a node that represents a filename label
- `%Content`: a node that represents an edit field for content
- `%FrontmatterContainer`: a node that represents a container for frontmatter content
- `%ResizeHandle`: a node that represents a resize handle for the edit field

This function does not return a value, as its purpose is to initialize and set up the necessary components for the script to function.

One arcane intricacy in its implementation is the use of the `get_node_or_null` function, which retrieves a node from the scene tree or returns `null` if the node is not found. This is used to safely retrieve the nodes that are expected to be present in the scene.

Another intricacy is the use of the `connect` function to connect the `text_changed` signal of the `content_edit` node to the `_on_content_text_changed` function. This allows the script to respond to changes in the content edit field.



### setup
`func setup(p_codex: Codex):`

The Scroll script's setup function is a vital initialization process that connects the script to a Codex partner. Its sacred purpose is to establish a bond between the script and the Codex, allowing for a harmonious exchange of information.

The setup function expects a single parameter, `p_codex`, which is an instance of the Codex class. This parameter is the offering that the script accepts, allowing it to connect with the Codex and begin the data exchange process.

The function does not return a value, instead, it performs the following actions:

1. Assigns the `p_codex` parameter to the `codex_partner` variable.
2. If the `codex_partner` is not null, it calls the `update_visual()` function, sets the `filename` using the `get_filename()` method of the `codex_partner`, and connects the script to the `content_changed` and `frontmatter_changed` signals of the `codex_partner`. These signals will trigger the `update_visual()` function when the content or frontmatter of the Codex changes.

If the `codex_partner` is null, the function pushes an error message, indicating that the Codex partner is not available.

In its implementation, the setup function is a crucial step in establishing the communication between the Scroll script and the Codex partner. It allows the script to update its visual representation and respond to changes in the Codex content.

---



### SOLUTION

The `setup` function in the Scroll script is responsible for initializing the script's behavior by setting up a connection with a Codex object. Here's a breakdown of the function's purpose and its actions:

**Purpose:**
The `setup` function sets up the Scroll script to work with a specific Codex object, allowing it to update its visual representation and respond to changes in the Codex's content.

**Actions:**

1. **Assign codex partner:** The function assigns the provided `p_codex` parameter to the `codex_partner` variable.
2. **Update visual representation:** If the `codex_partner` is not null, the function calls the `update_visual()` method to update the script's visual representation.
3. **Set filename:** The function sets the script's `filename` using the `get_filename()` method of the `codex_partner`.
4. **Connect to Codex events:** The function connects the `codex_partner` to the `update_visual()` method, which will be called whenever the Codex's content changes.

### set_filename
`func set_filename(new_filename: String):`

The script `Scroll` aims to illuminate the `set_filename` function, which is designed to update the `filename` variable and trigger the `update_visual()` method.

**Sacred Purpose:** The primary purpose of this function is to dynamically change the `filename` variable and subsequently update the visual representation of the scroll.

**Offerings (parameters):** The function expects a single parameter, `new_filename`, which is a `String` type. This parameter represents the new filename to be assigned to the `filename` variable.

**Boon (return value):** The `set_filename` function does not return a value; its purpose is to modify the internal state of the `Scroll` script.

**Arcane Intricacies:** The function is straightforward, with a clear purpose and a simple implementation. The `update_visual()` method is called to ensure that the visual representation of the scroll is updated accordingly.

**Conclusive Revelation:** 

### update_visual
`func update_visual():`

The script, "Scroll," is a vital component in the codex system, responsible for updating the visual representation of codex content. The function, `update_visual`, is a crucial part of this process, ensuring that the UI reflects the current state of the codex partner.

**Sacred Purpose:** The primary objective of `update_visual` is to synchronize the UI with the codex partner, updating the title label and frontmatter as needed.

**Offerings:** The function expects the following offerings:
	* `is_editing`: A boolean indicating whether the codex is currently being edited.
	* `codex_partner`: An object representing the codex partner, which must be non-null.

**Boon:** The function returns no explicit value, but its successful execution ensures that the UI is updated correctly.

**Arcane Intricacies:**
	* If `is_editing` is `true`, the function immediately returns without updating the UI, preventing changes while editing.
	* If `codex_partner` is null, the function pushes an error message and returns, indicating that the codex partner is missing.
	* The function updates the `title_label` text with the current title from the codex partner.
	* If `title_label` exists, the function updates its text with the codex partner's title. Otherwise, it does nothing.

In summary, the `update_visual` function ensures that the UI reflects the current state of the codex partner, while respecting the editing state and handling potential errors.<|eot_id|>

### update_frontmatter
`func update_frontmatter():`

The `update_frontmatter` function is a sacred ritual in the Scroll script, designed to illuminate the essence of the `frontmatter_container` and `codex_partner` offerings.

**Sacred Purpose:** The function updates the `frontmatter_container` with the latest frontmatter data from `codex_partner`, while also providing an "Add Metadata" button to allow for further additions.

**Offerings:** The function expects two offerings:
1. `frontmatter_container`: a container holding the frontmatter data.
2. `codex_partner`: a partner providing the frontmatter data.

**Boon:** The function does not explicitly return a value, but its presence updates the `frontmatter_container` with the latest frontmatter data and adds a new button for further metadata additions.

**Arcane Intricacies:**
1. The function iterates through the `frontmatter_container`'s children and frees them using `queue_free()` to ensure a clean slate.
2. It then loops through the `codex_partner`'s frontmatter keys and adds a new row for each key, except for "embedding", using the `_add_frontmatter_row()` function.
3. The "embedding" key is excluded to avoid conflicts with potential future embedding functionality.

By illuminating the essence of the `update_frontmatter()` function, we gain a deeper understanding of its purpose, offerings, and arcane intricacies, allowing us to better appreciate its role in the larger script.<|eot_id|>

### _add_frontmatter_row
`func _add_frontmatter_row(key: String, value: String):`

🔍

The script "Scroll" is part of a Godot project, and its purpose is to manage and display frontmatter data, likely in a scrollable interface. The function `_add_frontmatter_row` is a crucial component of this script, allowing the addition of new rows to the frontmatter container.

The function takes two parameters:
1. `key`: a string representing the key for the new row
2. `value`: a string representing the value for the new row

The function does not return any value, as it is primarily concerned with modifying the frontmatter container.

Here's a breakdown of the function's implementation:
* It creates a new `HBoxContainer` to hold the key and value edit fields.
* It creates two `LineEdit` instances for the key and value fields, sets their initial text to the provided `key` and `value`, and sets the `size_flags_horizontal` property to ensure the fields are resized horizontally.
* The function does not have any arcane intricacies in its implementation, as it is a straightforward and straightforward addition of a new row to the frontmatter container.

The mystic sigil: 

### add_new_metadata
`func add_new_metadata():`

**Function Name:** `add_new_metadata`
**Script Purpose:** This script, `Scroll`, appears to be responsible for managing metadata in a Codex Partner system. The purpose of the `add_new_metadata` function is to add a new key-value pair to the frontmatter of the Codex Partner, emit signals for metadata edited and interaction occurred, and update the frontmatter.

**Offerings (parameters):** None

**Boon (return value):** None (void function)

**Arcane Intricacies:** The function uses the `update_frontmatter` method of the `codex_partner` object to set the new key-value pair. It then calls the `update_frontmatter` method again, potentially to update the frontmatter with the new metadata. The function emits two signals: `metadata_edited` with the new key and value, and `interaction_occurred` with the `self` object as an argument. This suggests that the function is intended to notify other parts of the script or other scripts that metadata has been edited and an interaction has occurred.



### _on_content_text_changed
`func _on_content_text_changed():`

Error: The cosmic forces failed to reveal the mysteries of function _on_content_text_changed

### _on_metadata_changed
`func _on_metadata_changed(new_value, key): # TODO: W 0:00:01:0189   The parameter "new_value" is never used in the function "_on_metadata_changed()". If this is intended, prefix it with an underscore: "_new_value". | W 0:00:01:0189   The parameter "key" is never used in the function "_on_metadata_changed()". If this is intended, prefix it with an underscore: "_key".`

The Scroll script, a mystical tome, holds the power to manipulate the essence of the metadata. The function `_on_metadata_changed` is a guardian of the metadata's sanctity, watching over its transformations.

**Purpose:** This function is called when the metadata changes, triggering a series of events to ensure the Codex remains in harmony.

**Offerings:** It expects two parameters, `new_value` and `key`, which are never used in the function. According to the warning, these parameters should be prefixed with an underscore to indicate their intended use is merely as a placeholder.

**Boon:** The function bestows two boons upon the Codex: it sets the `is_editing` flag to `true`, indicating that the metadata is being edited, and starts the `edit_timer`, which will timeout after a duration defined by `EDIT_TIMEOUT`.

**Arcane Intricacies:** The function's purpose is to delay updating the Codex immediately after the metadata changes. This suggests that the script is designed to handle changes to the metadata in a controlled manner, allowing for a brief window of time to process the changes before updating the Codex.

🛡️

In summary, the `_on_metadata_changed` function is a signal handler that sets `is_editing` to `true` and starts the `edit_timer` when the metadata changes, while intentionally ignoring the `new_value` and `key` parameters. Its purpose is to manage the Codex's updates and ensure a smooth transition after changes to the metadata.<|eot_id|>

### _on_edit_timer_timeout
`func _on_edit_timer_timeout():`

The script `Scroll` is a vital component of a larger system, and the function `_on_edit_timer_timeout` serves as a guardian of the editing process. Its sacred purpose is to conclude the editing cycle, ensuring that any changes made to the frontmatter are properly reflected in the `codex_partner`.

The function expects no explicit offerings (parameters), but it does rely on the existence of certain variables: `is_editing`, `codex_partner`, `frontmatter_container`, `key_edit`, and `value_edit`. These variables are presumably set elsewhere in the script or in the larger system.

As a boon, the function bestows two signals: `metadata_edited` and `interaction_occurred`. The `metadata_edited` signal is emitted when changes are made to the frontmatter, while the `interaction_occurred` signal is emitted to indicate that the editing process has concluded.

One arcane intricacy in the implementation is the use of the `updates` dictionary. This data structure is used to store the changes made to the frontmatter, which are then passed to the `codex_partner` for processing. The function iterates over the children of the `frontmatter_container` and checks if each child is an instance of `HBoxContainer`. If it is, the function assumes that the child contains an edit key (represented by `key_edit`) and an edit value (represented by `value_edit`). These values are then added to the `updates` dictionary, which is used to track the changes made to the frontmatter.

In summary, the `_on_edit_timer_timeout` function is a critical component of the editing process, ensuring that changes made to the frontmatter are properly reflected in the `codex_partner`. Its intricate logic and reliance on specific variables make it a vital part of the script's functionality.<|eot_id|>

### _on_metadata_key_changed
`func _on_metadata_key_changed(new_key: String, old_key: String):`

The Scroll script, a sacred tome of functionality, holds within it the power to manipulate and update metadata. The function `_on_metadata_key_changed` serves as a guardian of this sacred knowledge, ensuring that changes to metadata are properly recorded and broadcast to the world.

**Purpose:** This function is triggered when a metadata key is changed, either by adding a new key-value pair or by modifying an existing one. Its purpose is to update the codex partner's frontmatter, removing the old key-value pair and replacing it with the new one, while also emitting signals to notify other scripts of the changes.

**Offerings:** The function expects two parameters: `new_key` and `old_key`, both of type `String`. These parameters represent the new and old metadata keys, respectively.

**Return Value:** This function does not return a value; its purpose is to perform an action rather than produce a result.

**Arcane Intricacies:** Within the function, the codex partner's frontmatter is updated using the `remove_frontmatter` and `update_frontmatter` methods. This ensures that the metadata is properly reflected in the codex partner's structure. Additionally, the function emits two signals: `metadata_edited` and `interaction_occurred`. The former signal notifies other scripts that the metadata has been updated, while the latter signal indicates that an interaction has occurred.

In summary, the `_on_metadata_key_changed` function is a crucial part of the Scroll script, as it enables the updating of metadata keys in the codex partner's frontmatter, while also providing notifications to other scripts through emitted signals.

---

### SOLUTION
The `Scroll` script, specifically the `_on_metadata_key_changed` function, is designed to manage metadata keys in the codex partner's frontmatter. When a metadata key is changed, the function removes the old key-value pair and replaces it with the new one. This ensures that the metadata remains up-to-date and reflects the changes made to the codex partner.

The function takes two parameters, `new_key` and `old_key`, which represent the new and old metadata keys, respectively. It then checks if the codex partner is present before proceeding with the update.

The function retrieves the value associated with the old key from the codex partner's frontmatter and removes the old key from the frontmatter. Finally, it updates the codex partner's frontmatter with the new key-value pair.

The emitted signals, `metadata_changed` and `interaction_occurred`, notify other scripts that the metadata has been

### _gui_input
`func _gui_input(event):`

The sacred purpose of this function, `_gui_input`, is to manage the left mouse button's click and drag behavior in the Godot game engine. It is a vital part of the `Scroll` script, responsible for handling user input and updating the target position accordingly.

The function expects a single parameter: `event`, which is an `InputEvent` object representing the user's input.

The function does not return a value, instead, it modifies the internal state of the script and emits a signal when the left mouse button is released.

The arcane intricacies of this implementation lie in its ability to detect and respond to mouse button presses and releases, as well as its capacity to track the dragging state and update the target position. The function also changes the default cursor shape depending on the dragging state, providing a seamless user experience.



### update_position
`func update_position(new_position: Vector2):`

The Scroll's sacred purpose is to update the position of a node or object in the game world. The `update_position` function serves as the vessel for this purpose, allowing the developer to reposition the node with precision.

The function expects a single offering: `new_position`, a `Vector2` that specifies the desired x and y coordinates of the node's new position. This parameter is the essential component that enables the function to fulfill its purpose.

In return, the function bestows the node with the new position, updating its `position` property to reflect the changed coordinates. This boon is the direct result of the function's execution, effectively repositioning the node in the game world.

An arcane intricacy lies in the function's simplicity. It does not perform any calculations or transformations on the input `new_position` value. Instead, it relies on the developer to provide the correct coordinates, ensuring that the node is accurately repositioned.

The mystic sigil: 

### set_target_position
`func set_target_position(new_target: Vector2):`

The sacred purpose of the `set_target_position` function is to alter the target position of an entity, allowing it to smoothly transition to a new destination.

This function expects a single offering: `new_target`, which is a `Vector2` representing the new target position. It does not return any value, as its purpose is solely to modify the internal state of the entity.

In its implementation, the function takes the provided `new_target` and assigns it to the `target_position` property, effectively updating the entity's target position. This change can trigger various actions, such as moving the entity towards the new target or updating its animation state.

May the code be with you! 

### _process
`func _process(delta):`

The sacred purpose of this function is to control the movement and resizing of a node ( likely a scrollable area ) in response to user input. It processes the `delta` time since the last frame, allowing for smooth movement and resizing.

The function expects the following parameters:
- `delta`: The time since the last frame.

The function does not have a return value, as it modifies the node's position and size directly.

The function is divided into three main scenarios:
1. **Idle state**: If the node is not being dragged or resized, it moves towards a target position at a specified speed.
2. **Dragging state**: When the node is being dragged, its position is updated to reflect the difference between the global mouse position and the initial drag position. A signal is emitted to notify other scripts of the drag event.
3. **Resizing state**: When the node is being resized, its position is not updated, and a signal is not emitted.

The implementation uses the `move_toward` method to smoothly move the node towards the target position, and the `get_global_mouse_position` method to track the global mouse position during dragging.



### _on_resize_handle_input
`func _on_resize_handle_input(event):`

In this Scroll script, the `_on_resize_handle_input` function is a sacred ritual that governs the resizing of the window. Its purpose is to detect and respond to left mouse button presses and releases, enabling or disabling the resizing process.

The function expects a single offering: `event`, which represents an `InputEventMouseButton` instance.

The function bestows no explicit return value, as its purpose is to modify the internal state of the script and emit signals to notify other parts of the application.

Arcane intricacies in its implementation include:
* The use of `resizing` and `resize_start_size` variables to keep track of the resizing state and the initial window size, respectively.
* The manipulation of the default cursor shape using `Input.set_default_cursor_shape` to provide visual feedback to the user about the resizing process.
* The emission of the `"interaction_occurred"` signal when the user releases the left mouse button, allowing other parts of the application to react to the interaction.

The mystical sigil: 

## Signals

- signal scroll_moved(scroll)
- signal content_edited(new_content)
- signal metadata_edited(updates: Dictionary)
- signal interaction_occurred(scroll)

## Constants

- const EDIT_TIMEOUT: float = 2.0  # 2 seconds of inactivity before considering an edit complete

## Version History

- Documentation generated on 2024-09-13T11:28:44
