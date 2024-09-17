# Scroll.gd
class_name Scroll
extends Window
# Owner: Curator

## The Scroll: A Mystical Window to Knowledge
##
## I am a Scroll daemon, a living parchment that bridges the ethereal realm of Codices 
## with the tangible world of mortal users. My purpose is to manifest the wisdom 
## contained within my Codex partner, allowing it to be viewed, contemplated, and altered.
##
## Responsibilities:
## 1. Materializing the contents of my Codex partner's document
## 2. Facilitating and interpreting mortal interactions with the document
## 3. Ensuring the sanctity and accuracy of the knowledge I present
## 4. Communicating changes back to my Codex partner for eternal preservation
##
## I am the interface between the unseen and the seen, the keeper of momentary changes,
## and the guardian of editorial integrity.

signal content_edited(new_content: String) ## Signals the Codex when document content has been altered by mortal hands
signal metadata_edited(updates: Dictionary) ## Announces changes to the metadata of the document
signal interaction_occurred(scroll: Scroll) ## Proclaims any significant interaction with my physical form

var codex_partner: Codex ## The Codex in charge of the document I display
var content_edit: TextEdit ## A tab for plaintext viewing and editing of a Codex's document content
var content_read: RichTextLabel ## A tab for rich text display of a Codex's Markdown content
var filename_label: Label ## A label displaying the filename of the document
var frontmatter_container: VBoxContainer ## The vessel for displaying and modifying the document's metadata
var save_button: Button ## Button to save changes to the Codex
var discard_button: Button ## Button to discard changes and reload from the Codex
var last_checked_time: int = 0 ## The last time my Codex partner told me they checked my document for changes
var is_updating_content: bool = false ## A mystical flag to prevent infinite loops during content updates
var has_unsaved_changes: bool = false ## Indicates whether there are unsaved changes in the Scroll
var needs_update: bool = true ## Indicate a need for my Codex partner to validate and re-propogate the document
var target_position: Vector2i ## A cache of the position this Scroll last WANTED to be at

## TODO: Implement user-configurable autosave feature
# var edit_timer: Timer ## A temporal mechanism to detect the completion of edits
# const EDIT_TIMEOUT: float = 2.0 ## The duration of inactivity that signals the end of an edit (in seconds)

func set_last_checked_time(time: int):
	last_checked_time = time

func _ready() -> void:
	## Prepare the Scroll for its sacred duty
	_configure_window()
	_initialize_ui_elements()
	_connect_signals()
	update_visual()

func _configure_window() -> void:
	## Set the properties of this mystical window
	title = "(Empty Scroll)"
	set_flag(FLAG_RESIZE_DISABLED, false)
	set_flag(FLAG_BORDERLESS, false)
	set_flag(FLAG_ALWAYS_ON_TOP, false)
	remember_position()

func _initialize_ui_elements() -> void:
	## Prepare the physical manifestations of our content and metadata
	content_edit = %Edit
	content_read = %Read
	frontmatter_container = %FrontmatterContainer
	filename_label = %FilenameLabel
	save_button = %SaveButton
	discard_button = %DiscardButton
	
	save_button.disabled = true
	discard_button.disabled = true

func _connect_signals() -> void:
	## Establish the ethereal connections that allow us to respond to the mortal world
	close_requested.connect(_on_close_requested)
	content_edit.text_changed.connect(_on_content_text_changed)
	save_button.pressed.connect(_on_save_button_pressed)
	discard_button.pressed.connect(_on_discard_button_pressed)

func setup(p_codex: Codex) -> void:
	codex_partner = p_codex
	if codex_partner:
		codex_partner.content_changed.connect(_on_codex_content_changed)
		codex_partner.frontmatter_changed.connect(_on_codex_frontmatter_changed)
	else:
		push_error("Scroll: The Librarian and/or Curator failed to provide a Codex partner.")

func _on_codex_content_changed():
	if not has_unsaved_changes:
		update_visual()

func _on_codex_frontmatter_changed():
	if not has_unsaved_changes:
		update_visual()

func remember_position() -> void:
	target_position = position

func update_visual() -> void:
	if not codex_partner:
		return
	title = codex_partner.get_title()
	if filename_label:
		filename_label.text = codex_partner.get_filename()
	_update_content_edit()
	_update_content_read()
	update_frontmatter()
	remember_position()

func check_for_update():
	if needs_update:
		return true
	if codex_partner.has_changed():
		set_needs_update(true)
	else:
		return false

func set_needs_update(value: bool):
	needs_update = value

func _input(event: InputEvent) -> void:
	if needs_update and not has_unsaved_changes:
		update_visual()
		set_needs_update(false)

func _update_content_read() -> void:
	if not content_read or not codex_partner:
		
		return
	var richtext = Scribe.markdown_to_bbcode(codex_partner.body)
	if richtext != null:
		content_read.text = richtext
		content_read.bbcode_enabled = true
	else:
		content_read.text = codex_partner.body
		content_read.bbcode_enabled = false

func _update_content_edit() -> void:
	if not content_edit or not codex_partner:
		return
	## Carefully update the content while preserving mortal interactions
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

func fit_rect_in_parent(rect, parent_rect):
	## Preserves the Scroll's mystical dimensions, resisting the cosmic forces of containment
	return rect

func update_frontmatter() -> void:
	## Manifest the sacred metadata for mortal contemplation
	if not frontmatter_container or not codex_partner:
		return
	
	for child in frontmatter_container.get_children():
		child.queue_free()
	
	for key in codex_partner.frontmatter:
		if key != "embedding":
			_add_frontmatter_row(key, str(codex_partner.frontmatter[key]))
	
	_add_metadata_button()

func _add_frontmatter_row(key: String, value: String) -> void:
	## Materialize a single piece of metadata for mortal interaction
	var hbox = HBoxContainer.new()
	var key_edit = LineEdit.new()
	var value_edit = LineEdit.new()
	
	key_edit.text = key
	key_edit.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
	key_edit.expand_to_text_length = true
	key_edit.set_select_all_on_focus(true)
	
	value_edit.text = value
	value_edit.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	value_edit.set_select_all_on_focus(true)
	
	key_edit.text_changed.connect(_on_metadata_changed)
	value_edit.text_changed.connect(_on_metadata_changed)
	
	hbox.add_child(key_edit)
	hbox.add_child(value_edit)
	frontmatter_container.add_child(hbox)

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

func _on_content_text_changed() -> void:
	if not is_updating_content:
		_set_unsaved_changes(true)
		interaction_occurred.emit(self)

func _on_metadata_changed(_new_text: String = "") -> void:
	_set_unsaved_changes(true)
	interaction_occurred.emit(self)

func _set_unsaved_changes(value: bool) -> void:
	has_unsaved_changes = value
	save_button.disabled = not value
	discard_button.disabled = not value

func _on_save_button_pressed() -> void:
	if codex_partner:
		# Update Codex with new document content
		codex_partner.update_content(content_edit.text)
		content_edited.emit(content_edit.text)
		
		# Update Codex with new frontmatter
		var updates = {}
		for child in frontmatter_container.get_children():
			if child is HBoxContainer:
				var key_edit = child.get_child(0)
				var value_edit = child.get_child(1)
				updates[key_edit.text] = value_edit.text
				codex_partner.update_frontmatter(key_edit.text, value_edit.text)
		
		if not updates.is_empty():
			metadata_edited.emit(updates)
		
		_set_unsaved_changes(false)
		update_visual()
		interaction_occurred.emit(self)

func _on_discard_button_pressed() -> void:
	_set_unsaved_changes(false)
	update_visual()
	interaction_occurred.emit(self)

func _on_close_requested() -> void:
	## For now, do nothing. TODO: Encourage the Librarian to design UX to open/close specific documents for the user, instead of opening all documents on ready.
	interaction_occurred.emit(self)

# TODO: Implement a visual indicator for unsaved changes
# TODO: Add a confirmation dialog when closing with unsaved changes
# FIXME: Ensure proper cleanup of resources when the Scroll is destroyed
