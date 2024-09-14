## Scroll.gd
#class_name Scroll
#extends Control
#
#signal scroll_moved(scroll)
#signal content_edited(new_content)
#signal metadata_edited(updates: Dictionary)
#signal interaction_occurred(scroll)
#
#@export_multiline var about = """
#I am a Scroll Daemon, the visual manifestation of a Codex's wisdom.
#
#My responsibilities include:
#1. Presenting the contents of my Codex partner in a visually pleasing manner
#2. Handling mortal interactions with my visual form, including resizing
#3. Communicating changes and interactions to my Codex partner and the Curator Archon
#4. Adapting my form to the will of the user, allowing for mystical expansion and contraction
#"""
#
#var codex_partner: Codex
#var is_updating_content = false
#
#var dragging = false
#var drag_start_position = Vector2.ZERO
#var target_position: Vector2
#var move_speed: float = 512.0
#
#var resizing = false
#var resize_start_size = Vector2.ZERO
#var min_size = Vector2(256, 384)
#var max_size = Vector2(1024, 1536)
#
#var title_label: Label
#var content_edit: TextEdit
#var frontmatter_container: VBoxContainer
#
#var is_editing: bool = false
#var edit_timer: Timer
#const EDIT_TIMEOUT: float = 2.0  # 2 seconds of inactivity before considering an edit complete
#
#func _ready():
	#title_label = get_node_or_null("%TitleLabel")
	#filename_label = get_node_or_null("%FilenameLabel")
	#content_edit = get_node_or_null("%Content")
	#if content_edit:
		#content_edit.text_changed.connect(_on_content_text_changed)
	#frontmatter_container = get_node_or_null("%FrontmatterContainer")
	#var resize_handle = get_node_or_null("%ResizeHandle")
	#if resize_handle:
		#resize_handle.gui_input.connect(_on_resize_handle_input)
	#edit_timer = Timer.new()
	#edit_timer.one_shot = true
	#edit_timer.timeout.connect(_on_edit_timer_timeout)
	#add_child(edit_timer)
#
#func setup(p_codex: Codex):
	#codex_partner = p_codex
	#if codex_partner:
		#update_visual()
		#set_filename(codex_partner.get_filename())
		#codex_partner.connect("content_changed", Callable(self, "update_visual"))
		#codex_partner.connect("frontmatter_changed", Callable(self, "update_visual"))
	#else:
		#push_error("Codex partner is null in Scroll setup")
#
#var filename: String = ""
#var filename_label: Label
#
#func set_filename(new_filename: String):
	#filename = new_filename
	#update_visual()
#
#func update_visual():
	#if is_editing:
		#return  # Don't update while editing
	#if not codex_partner:
		#push_error("Codex partner is null in Scroll update_visual")
		#return
	#
	#if title_label:
		#title_label.text = codex_partner.get_title()
	#if filename_label:
		#filename_label.text = filename
	#if content_edit:
		#if content_edit.text != codex_partner.body:
			#var cursor_pos = content_edit.get_caret_column()
			#var scroll_pos = content_edit.scroll_vertical
			#var selection_from = content_edit.get_selection_from_line()
			#var selection_to = content_edit.get_selection_to_line()
			#
			#is_updating_content = true
			#content_edit.text = codex_partner.body
			#is_updating_content = false
			#
			#content_edit.set_caret_column(cursor_pos)
			#content_edit.scroll_vertical = scroll_pos
			#if selection_from != selection_to:
				#content_edit.select(selection_from, 0, selection_to, -1)
			#
			##_mystical_content_update_effect()
	#
	#update_frontmatter()
#
#func update_frontmatter():
	#if not frontmatter_container or not codex_partner:
		#return
	#
	#for child in frontmatter_container.get_children():
		#child.queue_free()
	#
	#for key in codex_partner.frontmatter:
		#if key != "embedding":
			#_add_frontmatter_row(key, str(codex_partner.frontmatter[key]))
	#
	#var add_button = Button.new()
	#add_button.text = "Add Metadata"
	#add_button.connect("pressed", Callable(self, "add_new_metadata"))
	#frontmatter_container.add_child(add_button)
#
#func _add_frontmatter_row(key: String, value: String):
	#var hbox = HBoxContainer.new()
	#var key_edit = LineEdit.new()
	#var value_edit = LineEdit.new()
	#
	#key_edit.text = key
	#key_edit.size_flags_horizontal = SIZE_EXPAND_FILL
	#key_edit.set_select_all_on_focus(true)
	#
	#value_edit.text = value
	#value_edit.size_flags_horizontal = SIZE_EXPAND_FILL
	#value_edit.set_select_all_on_focus(true)
	#
	#key_edit.text_submitted.connect(_on_metadata_key_changed.bind(key))
	#value_edit.text_submitted.connect(_on_metadata_changed.bind(key))
	#
	#hbox.add_child(key_edit)
	#hbox.add_child(value_edit)
	#frontmatter_container.add_child(hbox)
#
#func add_new_metadata():
	#var new_key = "New Metadata"
	#var new_value = ""
	#codex_partner.update_frontmatter(new_key, new_value)
	#update_frontmatter()
	#emit_signal("metadata_edited", new_key, new_value)
	#emit_signal("interaction_occurred", self)
#
#func _on_content_text_changed():
	#if not is_updating_content and codex_partner and content_edit:
		#if content_edit.text != codex_partner.body:
			#codex_partner.update_content(content_edit.text)
			#emit_signal("content_edited", content_edit.text)
			#emit_signal("interaction_occurred", self)
#
#func _on_metadata_changed(new_value, key): # TODO: W 0:00:01:0189   The parameter "new_value" is never used in the function "_on_metadata_changed()". If this is intended, prefix it with an underscore: "_new_value". | W 0:00:01:0189   The parameter "key" is never used in the function "_on_metadata_changed()". If this is intended, prefix it with an underscore: "_key".
	#is_editing = true
	#edit_timer.start(EDIT_TIMEOUT)
	## Don't update the Codex immediately
#
#func _on_edit_timer_timeout():
	#is_editing = false
	#if codex_partner:
		#var updates = {}
		#for child in frontmatter_container.get_children():
			#if child is HBoxContainer:
				#var key_edit = child.get_child(0)
				#var value_edit = child.get_child(1)
				#updates[key_edit.text] = value_edit.text
				#codex_partner.update_frontmatter(key_edit.text, value_edit.text)
		#
		#if not updates.is_empty():
			#emit_signal("metadata_edited", updates)
		#emit_signal("interaction_occurred", self)
#
#func _on_metadata_key_changed(new_key: String, old_key: String):
	#if codex_partner:
		#var value = codex_partner.frontmatter.get(old_key, "")
		#codex_partner.remove_frontmatter(old_key)
		#codex_partner.update_frontmatter(new_key, value)
		#emit_signal("metadata_edited", new_key, value)
		#emit_signal("interaction_occurred", self)
		#update_frontmatter()
#
#func _gui_input(event):
	#if event is InputEventMouseButton:
		#if event.button_index == MOUSE_BUTTON_LEFT:
			#if event.pressed:
				#dragging = true
				#drag_start_position = get_global_mouse_position() - global_position
				#Input.set_default_cursor_shape(Input.CURSOR_DRAG)
			#else:
				#dragging = false
				#Input.set_default_cursor_shape(Input.CURSOR_ARROW)
				#emit_signal("interaction_occurred", self)
				## Update target position to current position after drag
				#target_position = position
#
#func update_position(new_position: Vector2):
	#position = new_position
#
#func set_target_position(new_target: Vector2):
	#target_position = new_target
#
#func _process(delta):
	#if not dragging and not resizing:
		## Move towards target position
		#position = position.move_toward(target_position, move_speed * delta)
	#elif dragging:
		## Handle dragging
		#position = get_global_mouse_position() - drag_start_position
		#emit_signal("scroll_moved", self)
	#elif resizing:
		## Handle resizing
		#var new_size = resize_start_size + get_global_mouse_position() - (position + resize_start_size)
		#new_size = new_size.clamp(min_size, max_size)
		#if new_size != size:
			#custom_minimum_size = new_size
			#size = new_size
			##_mystical_resize_effect()
		#emit_signal("interaction_occurred", self)
#
#func _on_resize_handle_input(event):
	#if event is InputEventMouseButton:
		#if event.button_index == MOUSE_BUTTON_LEFT:
			#if event.pressed:
				#resizing = true
				#resize_start_size = size
				#Input.set_default_cursor_shape(Input.CURSOR_FDIAGSIZE)
			#else:
				#resizing = false
				#Input.set_default_cursor_shape(Input.CURSOR_ARROW)
				#emit_signal("interaction_occurred", self)
#
##func _mystical_resize_effect():
	##var tween = create_tween()
	##tween.tween_property($PanelContainer, "modulate", Color(1.2, 1.2, 1.2), 0.1)
	##tween.tween_property($PanelContainer, "modulate", Color(1, 1, 1), 0.1)
##
##func _mystical_content_update_effect():
	##var tween = create_tween()
	##tween.tween_property(content_edit, "modulate", Color(1.1, 1.1, 1.3), 0.2)
	##tween.tween_property(content_edit, "modulate", Color(1, 1, 1), 0.2)
