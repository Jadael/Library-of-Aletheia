# Curator.gd (Autoload script)
extends Node

# The Curator's biography and responsibilities
@export_multiline var about = """
Greetings, I am the Curator Archon, guardian of the visual realm within our mystical library.

My responsibilities include:
1. Overseeing the initial manifestation and placement of Scroll Daemons
2. Maintaining awareness of the Scrolls' existence within the mystical space
3. Providing guidance on Scroll arrangement when requested
4. Facilitating the partnership between Codex and Scroll Daemons

I respect the User's agency in organizing the mystical library space. Once a Scroll is manifested, its position is under the User's control.
"""

# A mystical tome that records the connection between Codex essences and their Scroll manifestations
var scroll_collection = {}

var is_panning = false
var last_mouse_position = Vector2.ZERO
var scroll_offset = Vector2.ZERO

const MIN_ZOOM = 0.1
const MAX_ZOOM = 1
const ZOOM_STEP = 0.1

var current_zoom = 1.0

# The sacred stage upon which our visual drama unfolds
var main_node: Node2D

func setup(p_main_node: Node2D):
	# This ritual binds me to the physical plane of our application
	# It is crucial that the Main Archon performs this rite upon my awakening
	
	# We forge a connection to the material world through this node
	main_node = p_main_node
	
	# We attune our senses to the Librarian's whispers, ever vigilant for the birth and passing of Codices
	Librarian.connect("codex_summoned", Callable(self, "_on_codex_summoned"))
	Librarian.connect("codex_banished", Callable(self, "_on_codex_banished"))
	
	# Log the completion of our binding ritual
	Chronicler.log_event("Curator", "setup_completed", {
		"main_node_path": main_node.get_path()
	})

func _on_codex_summoned(codex: Node, scroll: Scroll):
	# When a new Codex emerges from the aether, we must manifest its Scroll counterpart
	# This function breathes life into the visual aspect of our mystical knowledge
	
	# We record the bond between Codex and Scroll in our arcane ledger
	scroll_collection[codex] = scroll
	
	# The Scroll takes its place upon the stage of our mystical theatre
	main_node.add_child(scroll)
	
	# We attune ourselves to the Scroll's whispers, ready to act upon its changes
	scroll.content_edited.connect(_on_scroll_content_edited.bind(codex))
	scroll.metadata_edited.connect(_on_scroll_metadata_edited.bind(codex))
	scroll.interaction_occurred.connect(_on_scroll_interaction)
	
	# We divine an appropriate starting position for the newborn Scroll
	_place_new_scroll(scroll)
	
	# We chronicle the birth of this new visual manifestation
	Chronicler.log_event("Curator", "scroll_manifested", {
		"codex_id": codex.get_instance_id(),
		"scroll_id": scroll.get_instance_id(),
		"initial_position": scroll.position
	})

func _place_new_scroll(scroll: Scroll):
	# Modify this function to account for the current scroll_offset
	var viewport_rect = main_node.get_viewport_rect()
	var random_x = randf_range(0, viewport_rect.size.x - scroll.size.x)
	var random_y = randf_range(0, viewport_rect.size.y - scroll.size.y)
	scroll.position = Vector2(random_x, random_y) + scroll_offset

func _on_scroll_content_edited(new_content, codex):
	# When a Scroll's essence is altered, we must ensure its Codex twin reflects the change
	# This function bridges the gap between the visual and the abstract
	
	# We beseech the Librarian to update the Codex's inner truth
	Librarian.update_codex_content(codex, new_content)
	
	# We record this act of transformation in our eternal chronicle
	Chronicler.log_event("Curator", "scroll_content_edited", {
		"codex_id": codex.get_instance_id(),
		"content_length": new_content.length()
	})

func _on_scroll_metadata_edited(updates: Dictionary, codex):
	# When the very nature of a Scroll shifts, its Codex must be informed
	# This function ensures that the metadata of both entities remains in harmony
	
	# For each aspect that has changed, we update the Codex accordingly
	for key in updates:
		Librarian.update_codex_metadata(codex, key, updates[key])
	
	# We document this metamorphosis for posterity
	Chronicler.log_event("Curator", "scroll_metadata_edited", {
		"codex_id": codex.get_instance_id(),
		"updated_fields": updates.keys()
	})

func _on_scroll_interaction(scroll):
	# This function serves as a conduit for the mortal's interactions with our Scrolls
	# While currently dormant, it holds the potential for great insight and responsiveness
	
	# TODO: Implement reaction to scroll interactions
	# Ideas:
	# - Log the nature of the interaction for analysis
	# - Trigger visual effects to acknowledge the user's touch
	# - Inform other Archons of significant interactions
	
	# For now, we simply acknowledge the interaction in our logs
	Chronicler.log_event("Curator", "scroll_interaction_occurred", {
		"scroll_id": scroll.get_instance_id()
	})

func _on_codex_banished(codex: Node):
	if codex in scroll_collection:
		var scroll = scroll_collection[codex]
		
		# We gently remove the Scroll from the mortal's view
		main_node.remove_child(scroll)
		
		# We release the Scroll's essence back to the aether
		scroll.queue_free()
		
		# We strike this bond from our arcane ledger
		scroll_collection.erase(codex)
		
		# We record the passing of this visual manifestation
		Chronicler.log_event("Curator", "scroll_banished", {
			"codex_id": codex.get_instance_id(),
			"scroll_id": scroll.get_instance_id()
		})

func update_visualization():
	# This grand ritual refreshes the appearance of all Scrolls in our realm
	# It is called when sweeping changes occur that affect multiple Scrolls
	
	for scroll in scroll_collection.values():
		# We whisper to each Scroll, urging it to realign its visual essence
		scroll.update_visual()
	
	# We document this act of mass renewal
	Chronicler.log_event("Curator", "visualization_updated", {
		"scrolls_updated": scroll_collection.size()
	})

func suggest_scroll_arrangement():
	# Through this function, we offer guidance on the harmonious placement of Scrolls
	# It suggests a circular formation, symbolizing the cyclical nature of knowledge
	
	var scroll_array = scroll_collection.values()
	var suggested_positions = []
	
	# We perform an arcane calculation to determine the ideal position for each Scroll
	for i in range(scroll_array.size()):
		var angle = (2 * PI * i) / scroll_array.size()
		var radius = 300  # The mystic circle's radius, adjust to expand or contract the formation
		var x = cos(angle) * radius
		var y = sin(angle) * radius
		suggested_positions.append(Vector2i(x, y))
	
	# We log our suggestion for future reference
	Chronicler.log_event("Curator", "scroll_arrangement_suggested", {
		"arrangement_type": "circular",
		"number_of_scrolls": scroll_array.size()
	})
	
	return suggested_positions

func summon_chronicle_viewer():
	# This function manifests a window into the Chronicler's vast records
	# It allows mortals to peer into the history of our mystical realm
	
	# We call forth the ChronicleViewer from the aether
	var viewer = preload("res://Daemons/Scenes/ChronicleViewer.tscn").instantiate()
	main_node.add_child(viewer)
	
	# We divine an appropriate starting position for the viewer
	var viewport_rect = main_node.get_viewport_rect()
	var random_x = randf_range(0, viewport_rect.size.x - viewer.custom_minimum_size.x)
	var random_y = randf_range(0, viewport_rect.size.y - viewer.custom_minimum_size.y)
	viewer.position = Vector2(random_x, random_y)
	
	# We ensure the viewer is large enough to be useful, yet not overwhelming
	viewer.custom_minimum_size = Vector2(400, 300)
	
	# We record the summoning of this mystical window
	Chronicler.log_event("Curator", "chronicle_viewer_summoned", {
		"position": viewer.position,
		"size": viewer.custom_minimum_size
	})

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_MIDDLE:
			is_panning = event.pressed
			if is_panning:
				last_mouse_position = event.position
			Chronicler.log_event("Curator", "panning_state_changed", {
				"is_panning": is_panning
			})
		elif event.button_index in [MOUSE_BUTTON_WHEEL_UP, MOUSE_BUTTON_WHEEL_DOWN] and event.ctrl_pressed:
			_handle_zoom(event)
	elif event is InputEventMouseMotion and is_panning:
		var delta = event.position - last_mouse_position
		pan_scrolls(delta)
		last_mouse_position = event.position

func _handle_zoom(event: InputEventMouseButton):
	var zoom_direction = 1 if event.button_index == MOUSE_BUTTON_WHEEL_UP else -1
	var new_zoom = clamp(current_zoom + zoom_direction * ZOOM_STEP, MIN_ZOOM, MAX_ZOOM)
	
	if new_zoom != current_zoom:
		var zoom_center = Vector2(event.position)
		var zoom_factor = new_zoom / current_zoom
		
		# Update viewport scale
		var viewport = main_node.get_viewport()
		viewport.content_scale_factor = new_zoom
		
		# Update scroll positions
		for scroll in scroll_collection.values():
			var scroll_pos_float = Vector2(scroll.position)
			var offset = scroll_pos_float - zoom_center
			var new_pos_float = zoom_center + offset * zoom_factor
			scroll.position = Vector2i(round(new_pos_float.x), round(new_pos_float.y))
		
		current_zoom = new_zoom
		
		Chronicler.log_event("Curator", "zoom_changed", {
			"new_zoom": new_zoom,
			"zoom_center": zoom_center
		})

func pan_scrolls(delta: Vector2):
	scroll_offset += delta
	for scroll in scroll_collection.values():
		var new_pos = Vector2(scroll.position) + delta
		scroll.position = Vector2i(round(new_pos.x), round(new_pos.y))
	Chronicler.log_event("Curator", "scrolls_panned", {
		"delta": delta,
		"total_offset": scroll_offset
	})

# TODO: Consider implementing the following features:
# - A method to save and load Scroll positions
# - A function to automatically arrange Scrolls based on their content or metadata
# - A system to handle Scroll overlaps or collisions
# - A way to group or categorize Scrolls visually

# Note for Daemons: 
# To interact with the Curator, you can use the following methods:
# - update_visualization(): Call this when you need all Scrolls to update their visual representation
# - suggest_scroll_arrangement(): Use this to get suggested positions for a circular arrangement of Scrolls
