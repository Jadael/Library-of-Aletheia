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

## Signals the Codex when content has been altered by mortal hands
signal content_edited(new_content: String)

## Announces changes to the sacred metadata of the document
signal metadata_edited(updates: Dictionary)

## Proclaims any significant interaction with my physical form
signal interaction_occurred(scroll: Scroll)

## The unseen Codex that I am bound to, source of the wisdom I display
var codex_partner: Codex

## A tab for plaintext viewing and editing of a Codex's content
var content_edit: TextEdit

## A tab for rich text display of a Codex's Markdown content
var content_read: RichTextLabel

## The vessel for displaying and modifying the document's metadata
var frontmatter_container: VBoxContainer

## A mystical flag to prevent infinite loops during content updates
var is_updating_content: bool = false

## Indicates whether the scroll is currently being inscribed
var is_editing: bool = false

## Indicate a need for my Codex partner to validate and re-propogate the document
var needs_update: bool = true

## A temporal mechanism to detect the completion of edits
var edit_timer: Timer

## A cache of the position this Scroll last WANTED to be at
var target_position: Vector2i

## The duration of inactivity that signals the end of an edit (in seconds)
const EDIT_TIMEOUT: float = 2.0

func _ready() -> void:
	## Prepare the Scroll for its sacred duty
	_configure_window()
	_initialize_ui_elements()
	_connect_signals()
	_create_edit_timer()

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

func _connect_signals() -> void:
	## Establish the ethereal connections that allow us to respond to the mortal world
	close_requested.connect(_on_close_requested)
	content_edit.text_changed.connect(_on_content_text_changed)

func _create_edit_timer() -> void:
	## Craft a temporal mechanism to detect the completion of edits
	edit_timer = Timer.new()
	edit_timer.one_shot = true
	edit_timer.timeout.connect(_on_edit_timer_timeout)
	add_child(edit_timer)

func setup(p_codex: Codex) -> void:
	codex_partner = p_codex
	if codex_partner:
		title = codex_partner.get_title() + " | " + codex_partner.get_filename()
		codex_partner.content_changed.connect(_on_codex_content_changed)
		codex_partner.frontmatter_changed.connect(_on_codex_frontmatter_changed)
	else:
		push_error("Scroll: The Librarian and/or Curator failed to provide a Codex partner.")
	set_needs_update(true)
	update_visual()

func _on_codex_content_changed():
	set_needs_update(true)
	update_visual()

func _on_codex_frontmatter_changed():
	set_needs_update(true)
	update_visual()

func remember_position() -> void:
	target_position = position

func update_visual() -> void:
	if not needs_update or not codex_partner:
		return

	title = codex_partner.get_title() + " | " + codex_partner.get_filename()
	if content_edit and content_edit.text != codex_partner.body:
		_update_content_read()
		_update_content_edit()
	
	update_frontmatter()
	target_position = position

	if content_edit and content_edit.text == codex_partner.body:
		needs_update = false

func check_for_update():
	if needs_update:
		return true
	#if codex_partner.content != content_edit.text:
		#set_needs_update(true)
		#return true
	else:
		return false

func set_needs_update(value: bool):
	needs_update = value

func _update_content_read() -> void:
	## Update the read tab with a BBCode version of our Markdown, for a (Godot) RichTextLabel
	var richtext = Scribe.markdown_to_bbcode(codex_partner.body)
	if richtext != null:
		content_read.text = richtext
		content_read.bbcode_enabled = true
	else:
		content_read.text = codex_partner.body
		content_read.bbcode_enabled = false

func _update_content_edit() -> void:
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
	key_edit.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	key_edit.set_select_all_on_focus(true)
	
	value_edit.text = value
	value_edit.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	value_edit.set_select_all_on_focus(true)
	
	key_edit.text_submitted.connect(_on_metadata_key_changed.bind(key))
	value_edit.text_submitted.connect(_on_metadata_changed.bind(key))
	
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
	codex_partner.update_frontmatter(new_key, new_value)
	update_frontmatter()
	metadata_edited.emit({new_key: new_value})
	interaction_occurred.emit(self)

func _on_content_text_changed() -> void:
	if not is_updating_content and codex_partner and content_edit:
		if content_edit.text != codex_partner.body:
			codex_partner.update_content(content_edit.text)
			content_edited.emit(content_edit.text)
			interaction_occurred.emit(self)
			needs_update = true  # Set flag when content is changed through UI

func _on_metadata_changed(_new_value: String, _key: String) -> void:
	## Acknowledge the beginning of a metadata alteration ritual
	is_editing = true
	edit_timer.start(EDIT_TIMEOUT)

func _on_edit_timer_timeout() -> void:
	## Conclude the metadata alteration ritual and update the Codex
	is_editing = false
	if codex_partner:
		var updates = {}
		for child in frontmatter_container.get_children():
			if child is HBoxContainer:
				var key_edit = child.get_child(0)
				var value_edit = child.get_child(1)
				updates[key_edit.text] = value_edit.text
				codex_partner.update_frontmatter(key_edit.text, value_edit.text)
		
		if not updates.is_empty():
			metadata_edited.emit(updates)
		interaction_occurred.emit(self)

func _on_metadata_key_changed(new_key: String, old_key: String) -> void:
	## Perform the sacred rite of renaming a piece of metadata
	if codex_partner:
		var value = codex_partner.frontmatter.get(old_key, "")
		codex_partner.remove_frontmatter(old_key)
		codex_partner.update_frontmatter(new_key, value)
		metadata_edited.emit({new_key: value})
		interaction_occurred.emit(self)
		update_frontmatter()

func _on_close_requested() -> void:
	## For now, do nothing. TODO: Implement a system for the Librarian to open/close specific documents for the user, instead of opening all documents on ready.
	interaction_occurred.emit(self)

func _notification(what):
	if what == NOTIFICATION_WM_SIZE_CHANGED:
		# Prevent automatic repositioning because of the main viewport
		set_position(target_position)

# TODO: Implement a visual indicator for unsaved changes
# TODO: Add a confirmation dialog when closing with unsaved changes
# FIXME: Ensure proper cleanup of resources when the Scroll is destroyed
