---
title: ChronicleViewer
last_updated: 2024-09-13T17:32:28
---

# ChronicleViewer

## Properties
- @export_multiline var about = """

## Functions
### _ready
`func _ready():`

﴾Error: After 3 attempts, the cosmic forces failed to reveal the mysteries of function _ready﴿

### _populate_filters
`func _populate_filters():`

﴾**Function Context and Purpose:**
The `_populate_filters` function is part of the `ChronicleViewer` script, responsible for populating the filters for the Chronicle system. It aims to populate the filters with available entities and event types from the Chronicler's log data.

**Input(s):**
The function expects no explicit input. It relies on the `Chronicler` object's `log_data` property, which is assumed to be populated with log entries.

**Output returned and/or behavior(s):**
The function populates the `entity_filter` and `event_type_filter` with items. The `entity_filter` adds an "All Entities" item and items for each unique entity found in the log data. Similarly, the `event_type_filter` adds an "All Event Types" item and items for each unique event type found in the log data.

**Intricacies in Implementation:**
The function uses a simple iteration over the `log_data` to collect unique entities and event types. It then uses these collections to populate the filters. This approach assumes that the `log_data` is a collection of log entries with `entity` and `event_type` properties.

﴿

### _update_log_display
`func _update_log_display():`

﴾Error: After 3 attempts, the cosmic forces failed to reveal the mysteries of function _update_log_display﴿

### _on_filter_changed
`func _on_filter_changed(new_text):`

﴾**Function Description**

The `_on_filter_changed` function is part of the `ChronicleViewer` script, responsible for updating the log display based on the new filter text.

**Context and Purpose**
The function is a callback triggered when the filter text input is changed. Its purpose is to reflect the updated filter in the log display, showing only the entries that match the new filter criteria.

**Input(s)**
The function expects one input:
* `new_text`: The new filter text entered by the user.

**Output Returned and/or Behavior(s)**
The function updates the `current_filter` variable with the new filter text and calls the `_update_log_display()` function to refresh the log display with the filtered entries.

**Intricacies in Implementation**
None noted.

﴿

### _on_entity_selected
`func _on_entity_selected(index):`

﴾**Function: `_on_entity_selected`**

**Context and Purpose:** The `_on_entity_selected` function is part of the `ChronicleViewer` script, designed to update the current entity selection in the chronicle viewer when an entity is selected from the entity filter list.

**Input(s):** The function expects a single integer input, `index`, which represents the index of the selected entity in the entity filter list.

**Output and Behavior:** Upon receiving the `index` input, the function updates the `current_entity` variable by getting the text of the selected entity at the specified `index` from the `entity_filter` list. If the `index` is 0 or less, the `current_entity` variable is set to an empty string. The function then calls the `_update_log_display()` function to update the log display accordingly.

**Intricacies:** The function uses the `entity_filter` list to get the text of the selected entity, which is then stored in the `current_entity` variable. The check for `index > 0` ensures that the function does not attempt to access an invalid index in the list, preventing potential errors.

**Description End:** ﴿

### _on_event_type_selected
`func _on_event_type_selected(index):`

﴾**Function Description:**

The `_on_event_type_selected` function is part of the `ChronicleViewer` script, which is designed to manage and display event chronicles in a specific format. This function is called when an event type is selected from a filter menu.

**Function Context and Purpose:**

The function's purpose is to update the current event type selected by the user and, subsequently, refresh the log display to reflect the new selection.

**Input(s):**

* `index`: The index of the selected event type in the filter menu.

**Output and Behavior:**

The function updates the `current_event_type` variable with the text of the selected event type and calls the `_update_log_display()` function to refresh the log display. If the `index` is 0, it sets `current_event_type` to an empty string.

**Intricacies:**

This function is likely part of a more extensive script that handles event filtering and logging. The `event_type_filter` is probably a menu or a dropdown list that allows users to select event types. The `_update_log_display()` function is responsible for updating the log display with the filtered events based on the currently selected event type.

**End of Description:** ﴿

### _gui_input
`func _gui_input(event):`

﴾**Function Name:** `_gui_input`
**Script Name:** `ChronicleViewer`
**Script Purpose:** The script is responsible for handling GUI-related events and updating the viewer's state accordingly.

**Function Purpose:** The `_gui_input` function is a built-in Godot function that is called repeatedly to process user input events. In this specific implementation, it handles mouse button events to facilitate dragging and updating the viewer's position.

**Input:** The function expects an `InputEvent` object as input, which contains information about the event that triggered the function call.

**Output/Behavior:**
The function updates the `is_dragging` and `drag_start_position` variables based on the input event. When the left mouse button is pressed, it sets `is_dragging` to `true` and calculates the starting position of the drag event by subtracting the viewer's global position from the current mouse position. When the left mouse button is released, it sets `is_dragging` to `false`.

**Intricacies:** The implementation is straightforward, with a clear and concise structure. However, it's worth noting that the `get_global_mouse_position()` method returns the mouse position in global coordinates, which is then subtracted from the viewer's global position to calculate the starting position of the drag event. This ensures that the drag event is relative to the viewer's position.

﴿

### _process
`func _process(delta): # TODO: W 0:00:01:0199   The parameter "delta" is never used in the function "_process()". If this is intended, prefix it with an underscore: "_delta".`

﴾**Function:** `_process`

**Script:** ChronicleViewer

**Purpose:** This function is part of the ChronicleViewer script, responsible for handling the mouse dragging behavior in the script.

**Input:** `delta` (an unused parameter, which should be prefixed with an underscore `_delta` for better coding practices)

**Output/Behavior:** When the `is_dragging` variable is `true`, the function updates the `global_position` by subtracting the `drag_start_position` from the current `get_global_mouse_position()`. This effectively updates the position of the ChronicleViewer based on the mouse drag.

**Intricacies:** The implementation of this function relies on the `is_dragging` variable being set to `true` prior to the mouse being dragged. The `delta` parameter is not used in the function, which could be a minor issue if it is intended to be used for something else. Additionally, the `global_position` is updated directly without any validation or constraints, which might lead to unexpected behavior if not properly handled.

﴿

### _on_close_button_pressed
`func _on_close_button_pressed():`

﴾**ChronicleViewer Script Purpose:**
The ChronicleViewer script is responsible for managing the display of a chronicle, a collection of events or stories in a game or simulation. It likely provides an interface for users to view and interact with the chronicle.

**Function Name:** `_on_close_button_pressed`
**Function Context and Purpose:**
This function is a signal handler for a close button press event. Its purpose is to free the current scene or node when the close button is pressed.

**Input(s):** None, as it is a signal handler.

**Output Returned and/or Behavior(s):**
The function queues the current scene or node for free, effectively removing it from the game or simulation. This indicates that the user has decided to exit or move away from the current chronicle display.

**Intricacies in Implementation:**
The implementation of this function is straightforward, as it simply calls the `queue_free()` method to initiate the removal of the current scene or node. This method is a standard part of Godot's scene management system, allowing nodes to be safely removed from the tree and released from memory.

﴿

### _on_resize_handle_gui_input
`func _on_resize_handle_gui_input(event):`

﴾Error: After 3 attempts, the cosmic forces failed to reveal the mysteries of function _on_resize_handle_gui_input﴿

---

# Source Code

	# ChronicleViewer.gd
	extends Control
	
	@export_multiline var about = """
	Greetings, I am the ChronicleViewer Daemon, a mystical window into the annals of our realm's history.
	
	My responsibilities include:
	1. Displaying the sacred records kept by the Chronicler Archon
	2. Providing tools for filtering and searching through the vast tapestry of events
	3. Offering insights into the ebb and flow of our mystical realm's activities
	4. Serving as a bridge between the Chronicler's wisdom and the mortal user's understanding
	"""
	
	@onready var log_text = %LogText
	@onready var filter_input = %FilterInput
	@onready var entity_filter = %EntityFilter
	@onready var event_type_filter = %EventTypeFilter
	
	var current_filter = ""
	var current_entity = ""
	var current_event_type = ""
	
	var is_dragging = false
	var drag_start_position = Vector2.ZERO
	
	func _ready():
		filter_input.text_changed.connect(_on_filter_changed)
		entity_filter.item_selected.connect(_on_entity_selected)
		event_type_filter.item_selected.connect(_on_event_type_selected)
		
		# Configure TextEdit for log viewing
		log_text.syntax_highlighter = null  # Disable syntax highlighting
		log_text.wrap_mode = TextEdit.LINE_WRAPPING_BOUNDARY  # Enable word wrapping
		log_text.context_menu_enabled = false  # Disable context menu for read-only text
		log_text.editable = false  # Make it read-only
		
		_populate_filters()
		_update_log_display()
		
		%CloseButton.pressed.connect(_on_close_button_pressed)
		%ResizeHandle.gui_input.connect(_on_resize_handle_gui_input)
	
	func _populate_filters():
		var entities = {}
		var event_types = {}
		for entry in Chronicler.log_data:
			entities[entry.entity] = true
			event_types[entry.event_type] = true
		
		entity_filter.add_item("All Entities")
		for entity in entities.keys():
			entity_filter.add_item(entity)
		
		event_type_filter.add_item("All Event Types")
		for event_type in event_types.keys():
			event_type_filter.add_item(event_type)
	
	func _update_log_display():
		log_text.text = ""  # Clear the text
		var filtered_log = Chronicler.query_log(func(entry):
			var text_match = current_filter.is_empty() or current_filter.to_lower() in JSON.stringify(entry).to_lower()
			var entity_match = current_entity.is_empty() or entry.entity == current_entity
			var event_type_match = current_event_type.is_empty() or entry.event_type == current_event_type
			return text_match and entity_match and event_type_match
		)
		
		var full_log_text = ""
		for entry in filtered_log:
			var timestamp = entry.timestamp
			var formatted_time = "{year}-{month}-{day} {hour}:{minute}:{second}".format({
				"year": str(timestamp.year).pad_zeros(4),
				"month": str(timestamp.month).pad_zeros(2),
				"day": str(timestamp.day).pad_zeros(2),
				"hour": str(timestamp.hour).pad_zeros(2),
				"minute": str(timestamp.minute).pad_zeros(2),
				"second": str(timestamp.second).pad_zeros(2)
			})
			full_log_text += "%s %s: %s\n" % [formatted_time, entry.entity, entry.event_type]
			full_log_text += JSON.stringify(entry.details, "  ") + "\n\n"
	
		log_text.text = full_log_text
		log_text.scroll_vertical = log_text.get_line_count() - 1  # Scroll to the bottom
	
	func _on_filter_changed(new_text):
		current_filter = new_text
		_update_log_display()
	
	func _on_entity_selected(index):
		current_entity = entity_filter.get_item_text(index) if index > 0 else ""
		_update_log_display()
	
	func _on_event_type_selected(index):
		current_event_type = event_type_filter.get_item_text(index) if index > 0 else ""
		_update_log_display()
	
	func _gui_input(event):
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT:
				if event.pressed:
					is_dragging = true
					drag_start_position = get_global_mouse_position() - global_position
				else:
					is_dragging = false
	
	func _process(delta): # TODO: W 0:00:01:0199   The parameter "delta" is never used in the function "_process()". If this is intended, prefix it with an underscore: "_delta".
		if is_dragging:
			global_position = get_global_mouse_position() - drag_start_position
	
	func _on_close_button_pressed():
		queue_free()
	
	func _on_resize_handle_gui_input(event):
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT:
				if event.pressed:
					is_dragging = true
					drag_start_position = get_global_mouse_position()
				else:
					is_dragging = false
		elif event is InputEventMouseMotion and is_dragging:
			var new_size = size + (get_global_mouse_position() - drag_start_position)
			custom_minimum_size = new_size.clamp(Vector2(200, 150), Vector2(1000, 800))
			size = custom_minimum_size
			drag_start_position = get_global_mouse_position()
	
