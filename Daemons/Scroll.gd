# A COMPUTER CAN NEVER BE HELD ACCOUNTABLE
# THEREFORE A COMPUTER MUST NEVER MAKE A MANAGEMENT DECISION
# scroll.gd
class_name Scroll
extends Window
const NAME = "📃 Scroll"
# Owner: Curator

## The Scroll: A Mystical Window to Knowledge
##
## I am a Scroll daemon, a living parchment that bridges the ethereal realm of Codices 
## with the tangible world of mortal users. My purpose is to manifest the wisdom 
## contained within my Codex partner, allowing it to be viewed, contemplated, and altered.
##
## Responsibilities:
## 1. Displaying the contents of my Codex partner's document
## 2. Facilitating and interpreting mortal interactions with the document
## 3. Ensuring the sanctity and accuracy of the knowledge I present
## 4. Communicating changes back to my Codex partner for writing to the document
## 5. Gracefully handling my own closure and cleanup
##
## I am the interface between the unseen and the seen, the keeper of momentary changes,
## and respect my Codex partner's responsibility for document integrity.

signal content_edited(new_content: String) ## Signals the Codex when document content has been altered by mortal hands
signal metadata_edited(updates: Dictionary) ## Announces changes to the metadata of the document
signal interaction_occurred(scroll: Scroll) ## Proclaims any significant interaction with my physical form
signal scroll_closed(scroll: Scroll) ## Announces when this Scroll is about to close

var codex_partner: Codex ## The Codex in charge of the document I display
@onready var content_edit: TextEdit = %Edit ## A tab for editing of a Codex's document content
@onready var content_read: TextEdit = %Read ## A tab for read-only display of a Codex's content
@onready var filename_label: Label = %FilenameLabel ## A label displaying the filename of the document
@onready var frontmatter_container: VBoxContainer = %FrontmatterContainer ## The vessel for displaying and modifying the document's metadata
@onready var save_button: Button = %SaveButton ## Button to save changes to the Codex
@onready var discard_button: Button = %DiscardButton ## Button to discard changes and reload from the Codex

var last_checked_time: int = 0 ## The last time my Codex partner told me they checked their document for changes
var is_updating_content: bool = false ## A flag to prevent infinite loops during content updates
var has_unsaved_changes: bool = false ## Indicates whether there are unsaved changes in the Scroll
var needs_update: bool = true ## Indicate a need for my Codex partner to validate and re-share the document with me
var target_position: Vector2i ## A cache of the position this Scroll last WANTED to be at

func _ready() -> void:
	## Prepare the Scroll for its sacred duty
	_configure_window()
	_connect_signals()
	update_visual()

func _configure_window() -> void:
	## Set the properties of this mystical window
	title = "(Empty Scroll)"
	set_flag(FLAG_RESIZE_DISABLED, false)
	set_flag(FLAG_BORDERLESS, false)
	set_flag(FLAG_ALWAYS_ON_TOP, false)
	remember_position()

	save_button.disabled = true
	discard_button.disabled = true

func _connect_signals() -> void:
	## Establish the ethereal connections that allow us to respond to the mortal world
	close_requested.connect(_on_close_requested)
	content_edit.text_changed.connect(_on_content_text_changed)
	save_button.pressed.connect(_on_save_button_pressed)
	discard_button.pressed.connect(_on_discard_button_pressed)

func setup(p_codex: Codex) -> void:
	## Bind this Scroll to its Codex partner
	codex_partner = p_codex
	if codex_partner:
		codex_partner.content_changed.connect(_on_codex_content_changed)
		codex_partner.frontmatter_changed.connect(_on_codex_frontmatter_changed)
	else:
		push_error("Scroll: The Librarian and/or Curator failed to provide a Codex partner.")
	
	Chronicler.log_event(self, "setup_completed", {
		"codex_id": Glyph.to_daemon_glyphs(codex_partner.get_instance_id()) if codex_partner else null
	})

func update_visual() -> void:
	## Refresh the Scroll's visual representation to reflect its current state
	if not is_node_ready() or not codex_partner:
		return
	title = codex_partner.get_title()
	filename_label.text = codex_partner.get_filename()
	_update_content_edit()
	_update_content_read()
	update_frontmatter()
	remember_position()

	Chronicler.log_event(self, "visual_updated", {
		"title": title,
		"filename": filename_label.text
	})

func _on_codex_content_changed() -> void:
	## Respond to changes in the Codex's content
	var action = "Ignored due to unsaved edits"
	if not has_unsaved_changes:
		update_visual()
		action = "Content updated from Codex"
	
	Chronicler.log_event(self, "codex_content_changed", {
		"scroll_id": Glyph.to_daemon_glyphs(get_instance_id()),
		"codex_id": Glyph.to_daemon_glyphs(codex_partner.get_instance_id()) if codex_partner else null,
		"action_taken": action
	})

func _on_codex_frontmatter_changed() -> void:
	## Respond to changes in the Codex's frontmatter
	if not has_unsaved_changes:
		update_visual()
	
	Chronicler.log_event(self, "codex_frontmatter_changed", {
		"scroll_id": Glyph.to_daemon_glyphs(get_instance_id()),
		"codex_id": Glyph.to_daemon_glyphs(codex_partner.get_instance_id()) if codex_partner else null
	})

func _update_content_edit() -> void:
	## Carefully update the editable content while preserving mortal interactions
	if not content_edit or not codex_partner:
		return
	var cursor_pos = content_edit.get_caret_column()
	var scroll_pos = content_edit.scroll_vertical
	var selection_from = content_edit.get_selection_from_line()
	var selection_to = content_edit.get_selection_to_line()
	
	is_updating_content = true
	content_edit.text = codex_partner.body
	is_updating_content = false
	
	content_edit.set_caret_column(cursor_pos)
	content_edit.scroll_vertical = scroll_pos
	if selection_from != selection_to:
		content_edit.select(selection_from, 0, selection_to, -1)

func _update_content_read() -> void:
	## Update the read-only view of the document's content
	if not content_read or not codex_partner:
		return
	content_read.text = codex_partner.body

func update_frontmatter() -> void:
	## Manifest the sacred metadata for mortal contemplation
	if not frontmatter_container or not codex_partner:
		return
	
	var deletion_states = {}
	for child in frontmatter_container.get_children():
		if child is HBoxContainer:
			var delete_button = child.get_child(0) # ERROR
			var key_edit = child.get_child(1)
			deletion_states[key_edit.text] = delete_button.button_pressed
	
	for child in frontmatter_container.get_children():
		child.queue_free()
	
	for key in codex_partner.frontmatter:
		if key != "embedding":
			_add_frontmatter_row(key, str(codex_partner.frontmatter[key]))
			if key in deletion_states:
				var child = frontmatter_container.get_child(frontmatter_container.get_child_count() - 1)
				if child is HBoxContainer:
					var delete_button = child.get_child(0)
					delete_button.button_pressed = deletion_states[key]
					if deletion_states[key]:
						delete_button.modulate = Color.RED
	
	_add_metadata_button()

func _add_frontmatter_row(key: String, value: String) -> void:
	## Materialize a single piece of metadata for mortal interaction
	var hbox = HBoxContainer.new()
	var delete_button = Button.new()
	var key_edit = LineEdit.new()
	var value_edit = LineEdit.new()
	
	delete_button.toggle_mode = true
	delete_button.text = "🗑️"
	delete_button.tooltip_text = "Mark for deletion"
	delete_button.custom_minimum_size = Vector2(16, 16)  # Adjust size as needed
	delete_button.toggled.connect(_on_delete_button_toggled.bind(delete_button))
	
	key_edit.text = key
	key_edit.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
	key_edit.expand_to_text_length = true
	key_edit.select_all_on_focus = true
	
	value_edit.text = value
	value_edit.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	value_edit.select_all_on_focus = true
	
	key_edit.text_changed.connect(_on_metadata_changed)
	value_edit.text_changed.connect(_on_metadata_changed)
	
	hbox.add_child(delete_button)
	hbox.add_child(key_edit)
	hbox.add_child(value_edit)
	frontmatter_container.add_child(hbox)

func _on_delete_button_toggled(button_pressed: bool, button: Button) -> void:
	## Respond to the delete button being toggled
	if button_pressed:
		button.modulate = Color.RED
	else:
		button.modulate = Color.WHITE
	_on_metadata_changed()

func _add_metadata_button() -> void:
	## Create a mystical interface for adding new metadata
	var add_button = Button.new()
	add_button.text = "Inscribe New Metadata"
	add_button.pressed.connect(add_new_metadata)
	frontmatter_container.add_child(add_button)

func add_new_metadata() -> void:
	## Initiate the ritual of adding new metadata to our sacred document
	var new_key = "New Insight"
	var new_value = ""
	_add_frontmatter_row(new_key, new_value)
	_set_unsaved_changes(true)
	interaction_occurred.emit(self)
	
	Chronicler.log_event(self, "new_metadata_added", {
		"key": new_key,
		"value": new_value
	})

func _on_content_text_changed() -> void:
	## Respond to changes in the editable content
	if not is_updating_content:
		_set_unsaved_changes(true)
		content_read.text = content_edit.text # Start showing "preview" text instead of Codex text
		interaction_occurred.emit(self)

func _on_metadata_changed(_new_text: String = "") -> void:
	## Respond to changes in the metadata
	_set_unsaved_changes(true)
	interaction_occurred.emit(self)

func _set_unsaved_changes(value: bool) -> void:
	## Update the Scroll's state to reflect unsaved changes
	has_unsaved_changes = value
	save_button.disabled = not value
	discard_button.disabled = not value
	title = ("(✒) " if value else "") + codex_partner.get_title()

func _on_save_button_pressed() -> void:
	## Save the changes made to the document and its metadata
	if codex_partner:
		codex_partner.update_content(content_edit.text)
		content_edited.emit(content_edit.text)
		
		var updates = {}
		var deletions = []
		for child in frontmatter_container.get_children():
			if child is HBoxContainer:
				var delete_button = child.get_child(0)
				var key_edit = child.get_child(1)
				var value_edit = child.get_child(2)
				if delete_button.button_pressed:
					deletions.append(key_edit.text)
				else:
					updates[key_edit.text] = value_edit.text
					codex_partner.update_frontmatter(key_edit.text, value_edit.text)
		
		for key in deletions:
			codex_partner.remove_frontmatter(key)
		
		if not updates.is_empty() or not deletions.is_empty():
			metadata_edited.emit(updates)
		
		_set_unsaved_changes(false)
		update_visual()
		interaction_occurred.emit(self)
		
		Chronicler.log_event(self, "changes_saved", {
			"content_changed": true,
			"metadata_changed": not updates.is_empty() or not deletions.is_empty(),
			"metadata_deleted": deletions
		})

func _on_discard_button_pressed() -> void:
	## Discard unsaved changes and revert to the last saved state
	_set_unsaved_changes(false)
	update_visual()
	interaction_occurred.emit(self)
	
	Chronicler.log_event(self, "changes_discarded", {})

func _on_close_requested() -> void:
	## Respond to a request to close the Scroll
	if has_unsaved_changes:
		_show_unsaved_changes_dialog()
	else:
		_perform_close()

func _show_unsaved_changes_dialog() -> void:
	## Present a dialog to the user when unsaved changes exist
	var dialog = ConfirmationDialog.new()
	dialog.dialog_text = "There are unsaved changes. Do you want to save before closing?"
	dialog.add_button("Discard", true, "discard")
	dialog.confirmed.connect(_on_save_and_close)
	dialog.custom_action.connect(_on_discard_and_close)
	dialog.canceled.connect(_on_cancel_close)
	add_child(dialog)
	dialog.popup_centered()

func _on_save_and_close() -> void:
	## Save changes and then close the Scroll
	_on_save_button_pressed()
	_perform_close()

func _on_discard_and_close(_action: StringName) -> void:
	## Discard changes and close the Scroll
	_perform_close()

func _on_cancel_close() -> void:
	## Cancel the close operation
	pass  # Do nothing, keeping the Scroll open

func _perform_close() -> void:
	## Execute the actual closing of the Scroll
	emit_signal("scroll_closed", self)
	Chronicler.log_event(self, "scroll_closed", {
		"scroll_id": Glyph.to_daemon_glyphs(get_instance_id()),
		"codex_id": Glyph.to_daemon_glyphs(codex_partner.get_instance_id()) if codex_partner else null
	})
	queue_free()  # This will remove the Scroll from the scene

func remember_position() -> void:
	## Store the current position of the Scroll
	target_position = position

func set_last_checked_time(time: int) -> void:
	## Update the timestamp of the last check for changes
	last_checked_time = time

func check_for_update() -> bool:
	## Check if the Scroll needs to be updated
	if needs_update:
		return true
	if codex_partner.has_changed():
		set_needs_update(true)
		return true
	return false

func set_needs_update(value: bool) -> void:
	## Set the flag indicating whether the Scroll needs an update
	needs_update = value

func _input(_event: InputEvent) -> void:
	## Handle input events, particularly for updating the Scroll's content
	if needs_update and not has_unsaved_changes:
		update_visual()
		set_needs_update(false)

func fit_rect_in_parent(rect, _parent_rect):
	## Preserves the Scroll's mystical dimensions, resisting the cosmic forces of containment
	return rect

# TODO: Implement a visual indicator for unsaved changes
# TODO: Add a confirmation dialog when closing with unsaved changes
# TODO: Implement user-configurable autosave feature
# FIXME: Ensure proper cleanup of resources when the Scroll is destroyed
