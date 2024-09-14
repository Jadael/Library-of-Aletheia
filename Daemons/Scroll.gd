# Scroll.gd
class_name Scroll
extends Window

signal content_edited(new_content)
signal metadata_edited(updates: Dictionary)
signal interaction_occurred(scroll)

@export_multiline var about = """
I am a Scroll daemon, responsible for presenting a document in the care of a Codex partner to the User.

My responsibilities include:
1. Presenting the contents of my Codex partner's document
2. Facilitating User edits to the document under the supervison of the Codex
"""

var codex_partner: Codex
var is_updating_content = false

var content_edit: TextEdit
var frontmatter_container: VBoxContainer

var is_editing: bool = false
var edit_timer: Timer
const EDIT_TIMEOUT: float = 2.0  # 2 seconds of inactivity before considering an edit complete

func _ready():
	# Set up window properties
	title = "Scroll"
	set_flag(FLAG_RESIZE_DISABLED, false)
	set_flag(FLAG_BORDERLESS, false)
	set_flag(FLAG_ALWAYS_ON_TOP, false)
	
	# Initialize UI elements
	content_edit = %Content
	frontmatter_container = %FrontmatterContainer
	
	# Connect signals
	close_requested.connect(_on_close_requested)
	content_edit.text_changed.connect(_on_content_text_changed)
	
	# Set up edit timer
	edit_timer = Timer.new()
	edit_timer.one_shot = true
	edit_timer.timeout.connect(_on_edit_timer_timeout)
	add_child(edit_timer)

func setup(p_codex: Codex):
	codex_partner = p_codex
	if codex_partner:
		update_visual()
		title = codex_partner.get_filename()
		codex_partner.connect("content_changed", Callable(self, "update_visual"))
		codex_partner.connect("frontmatter_changed", Callable(self, "update_visual"))
	else:
		push_error("Codex partner is null in Scroll setup")

func update_visual():
	if is_editing:
		return  # Don't update while editing
	if not codex_partner:
		push_error("Codex partner is null in Scroll update_visual")
		return
	
	title = codex_partner.get_title()
	if content_edit:
		if content_edit.text != codex_partner.body:
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
	
	update_frontmatter()

func update_frontmatter():
	if not frontmatter_container or not codex_partner:
		return
	
	for child in frontmatter_container.get_children():
		child.queue_free()
	
	for key in codex_partner.frontmatter:
		if key != "embedding":
			_add_frontmatter_row(key, str(codex_partner.frontmatter[key]))
	
	var add_button = Button.new()
	add_button.text = "Add Metadata"
	add_button.connect("pressed", Callable(self, "add_new_metadata"))
	frontmatter_container.add_child(add_button)

func _add_frontmatter_row(key: String, value: String):
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

func add_new_metadata():
	var new_key = "New Metadata"
	var new_value = ""
	codex_partner.update_frontmatter(new_key, new_value)
	update_frontmatter()
	emit_signal("metadata_edited", {new_key: new_value})
	emit_signal("interaction_occurred", self)

func _on_content_text_changed():
	if not is_updating_content and codex_partner and content_edit:
		if content_edit.text != codex_partner.body:
			codex_partner.update_content(content_edit.text)
			emit_signal("content_edited", content_edit.text)
			emit_signal("interaction_occurred", self)

func _on_metadata_changed(_new_value: String, _key: String):
	is_editing = true
	edit_timer.start(EDIT_TIMEOUT)

func _on_edit_timer_timeout():
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
			emit_signal("metadata_edited", updates)
		emit_signal("interaction_occurred", self)

func _on_metadata_key_changed(new_key: String, old_key: String):
	if codex_partner:
		var value = codex_partner.frontmatter.get(old_key, "")
		codex_partner.remove_frontmatter(old_key)
		codex_partner.update_frontmatter(new_key, value)
		emit_signal("metadata_edited", {new_key: value})
		emit_signal("interaction_occurred", self)
		update_frontmatter()

func _on_close_requested():
	hide()
	emit_signal("interaction_occurred", self)
