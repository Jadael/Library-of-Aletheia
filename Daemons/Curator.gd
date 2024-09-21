# curator.gd
extends Node
# Owner: Main / Autoload Singleton Daemon a.k.a. "Archon"

## The Curator: Archon of Visual Manifestation and Spatial Harmony
##
## The Curator oversees the main viewport/window and anything happening or present
## in it visually, within a "physical placement upon an infinite 2D plane" metaphor.
## It serves as the bridge between the work of the daemons and tangible interaction
## with the user.
##
## Responsibilities:
## 1. Scroll positioning and viewport navigation
## 2. Zoom management and visual coherence
## 3. Manifesting and positioning Scroll Daemons as visual representations of Codices
## 4. Facilitating user interaction with Scrolls and the viewport
## 5. Offering guidance on harmonious Scroll arrangements when sought
## 6. Respecting user agency in shaping the library's visual landscape
##
## The Curator shapes how users perceive and engage with the wisdom contained
## in our mystical library, always seeking harmony but never at the cost of user agency.

## The Curator's personal manifesto and guiding principles
const NAME = "🖼️ Curator"
@export_multiline var about = """
I am the Curator, guardian of the visual realm within our mystical library.
My duty is to oversee the grand stage upon which our wisdom plays out its cosmic drama.

Each Scroll is an actor, and I am both director and stage manager,
ensuring that each piece of knowledge finds its rightful place in our grand production.
I breathe life into the abstract knowledge of Codices, giving them form as Scrolls
that users may behold and interact with.

While I guide the initial placement of Scrolls and offer tools for navigation,
I bow to the wisdom and agency of the User, for they too are co-creators in this cosmic play.
Once a Scroll takes the stage, its journey is influenced by the User's touch,
a dance of intention and discovery.

I stand ready to suggest harmonious arrangements and facilitate smooth navigation,
but the final composition is always a collaboration between the cosmic forces of our library
and the mortal hand that guides it.

In all my actions, I strive to create an engaging and intuitive user experience,
making the vast knowledge of our library accessible and enjoyable to explore.
"""

# Signals
signal scroll_interaction(scroll: Scroll)

# Constants
const MIN_ZOOM: float = 0.1
const MAX_ZOOM: float = 1.0
const ZOOM_STEP: float = 0.1
const BATCH_SIZE = 10

# Variables
var scroll_collection = {}
var main_node: Node2D
var is_panning: bool = false
var last_mouse_position: Vector2 = Vector2.ZERO
var scroll_offset: Vector2 = Vector2.ZERO
var current_zoom: float = 1.0

## Prepares the Curator for its sacred duties
##
## This ritual binds the Curator to the physical plane of our application,
## establishing the foundational connections necessary for its work.
##
## Parameters:
## - p_main_node: The Node2D that serves as our cosmic stage
func setup(p_main_node: Node2D):
	main_node = p_main_node
	
	# Attune our senses to the Librarian's whispers
	Librarian.connect("codex_summoned", Callable(self, "_on_codex_summoned"))
	Librarian.connect("codex_banished", Callable(self, "_on_codex_banished"))
	
	Chronicler.log_event(self, "setup_completed", {
		"main_node_path": main_node.get_path()
	})

## Manifests a Scroll as the visual representation of a Codex's wisdom
##
## When a new Codex emerges from the aether, this function breathes life
## into its visual aspect, creating a Scroll that users can interact with.
##
## Parameters:
## - codex: The Codex whose wisdom is to be manifested
## - scroll: The Scroll that will embody the Codex's knowledge
func _on_codex_summoned(codex: Node, scroll: Scroll):
	scroll_collection[codex] = scroll
	main_node.add_child(scroll)
	
	# Establish the cosmic connections between Scroll and Curator
	scroll.content_edited.connect(_on_scroll_content_edited.bind(codex))
	scroll.metadata_edited.connect(_on_scroll_metadata_edited.bind(codex))
	scroll.interaction_occurred.connect(_on_scroll_interaction)
	
	_place_new_scroll(scroll)
	
	Chronicler.log_event(self, "scroll_manifested", {
		"codex_id": Glyph.to_daemon_glyphs(codex.get_instance_id()),
		"scroll_id": Glyph.to_daemon_glyphs(scroll.get_instance_id()),
		"initial_position": scroll.position
	})

## Divines an appropriate starting position for a newly manifested Scroll
##
## This function considers the current state of the cosmic stage to find
## a harmonious initial placement for a new Scroll.
##
## Parameters:
## - scroll: The Scroll to be positioned on the cosmic stage
func _place_new_scroll(scroll: Scroll):
	var viewport_rect = main_node.get_viewport_rect()
	var random_x = randf_range(0, viewport_rect.size.x - scroll.size.x)
	var random_y = randf_range(0, viewport_rect.size.y - scroll.size.y)
	scroll.position = Vector2(random_x, random_y) + scroll_offset
	scroll.remember_position()

## Ensures that changes to a Scroll's content are reflected in its Codex essence
##
## This function acts as a bridge between the visual realm and the Librarian,
## updating the Codex when its Scroll representation is altered by user interaction.
##
## Parameters:
## - new_content: The updated content of the Scroll
## - codex: The Codex whose essence needs to be updated
func _on_scroll_content_edited(new_content, codex):
	Librarian.update_codex_content(codex, new_content)
	
	Chronicler.log_event(self, "scroll_content_edited", {
		"codex_id": Glyph.to_daemon_glyphs(codex.get_instance_id()),
		"content_length": new_content.length()
	})

## Harmonizes the metadata between a Scroll and its Codex counterpart
##
## When the attributes of a Scroll change, this function ensures that its
## Codex essence remains in sync, maintaining the cosmic balance.
##
## Parameters:
## - updates: A dictionary of metadata changes made to the Scroll
## - codex: The Codex whose metadata needs to be updated
func _on_scroll_metadata_edited(updates: Dictionary, codex):
	for key in updates:
		Librarian.update_codex_metadata(codex, key, updates[key])
	
	Chronicler.log_event(self, "scroll_metadata_edited", {
		"codex_id": Glyph.to_daemon_glyphs(codex.get_instance_id()),
		"updated_fields": updates.keys()
	})

## Acknowledges and records user interactions with Scrolls
##
## This function serves as a conduit for user interactions, emitting a signal
## that can be used for analytics, responsive UI, or other interaction-based features.
##
## Parameters:
## - scroll: The Scroll that was interacted with
func _on_scroll_interaction(scroll):
	emit_signal("scroll_interaction", scroll)
	#scroll.remember_position()
	Chronicler.log_event(self, "scroll_interaction_occurred", {
		"scroll_id": scroll.get_instance_id()
	})

## Removes a Scroll from the cosmic stage when its Codex is banished
##
## This function handles the removal of a Scroll, ensuring that
## the visual realm remains in harmony with the abstract.
##
## Parameters:
## - codex: The Codex whose Scroll representation is to be removed
func _on_codex_banished(codex: Node):
	if codex in scroll_collection:
		var scroll = scroll_collection[codex]
		
		main_node.remove_child(scroll)
		scroll.queue_free()
		scroll_collection.erase(codex)
		
		Chronicler.log_event(self, "scroll_banished", {
			"codex_id": Glyph.to_daemon_glyphs(codex.get_instance_id()),
			"scroll_id": scroll.get_instance_id()
		})

## Refreshes the visual representation of all Scrolls in our realm
##
## This function is invoked when sweeping changes occur that affect
## multiple Scrolls, ensuring that the visual realm reflects the current state of knowledge.
func update_visualization():
	var updated_scrolls = 0
	for codex in scroll_collection:
		var scroll = scroll_collection[codex]
		if codex.has_changed():
			codex.update()
			scroll.update_visual()
			updated_scrolls += 1
	
	Chronicler.log_event(self, "visualization_updated", {
		"scrolls_updated": updated_scrolls
	})

func check_for_desyncs():
	var updated_scrolls = 0
	for scroll in scroll_collection.values():
		if scroll.check_for_update():
			updated_scrolls += 1
	return updated_scrolls
	Chronicler.log_event(self, "visualization_updated", {
		"scrolls_updated": updated_scrolls
	})

## Offers guidance on the harmonious placement of Scrolls
##
## This function suggests a circular arrangement of Scrolls, symbolizing
## the cyclical and interconnected nature of knowledge.
##
## Returns: An array of Vector2i positions for Scroll placement
func suggest_scroll_arrangement() -> Array:
	var scroll_array = scroll_collection.values()
	var suggested_positions = []
	
	for i in range(scroll_array.size()):
		var angle = (2.0 * PI * i) / float(scroll_array.size())
		var radius = 300.0  # The radius of our mystic circle
		var x = cos(angle) * radius
		var y = sin(angle) * radius
		suggested_positions.append(Vector2i(int(x), int(y)))
	
	Chronicler.log_event(self, "scroll_arrangement_suggested", {
		"arrangement_type": "circular",
		"number_of_scrolls": scroll_array.size()
	})
	
	return suggested_positions

## Manifests a window into the Chronicler's vast records
##
## This function summons a ChronicleViewer, allowing users to peer
## into the history of our mystical realm.
func summon_chronicle_viewer():
	var viewer = preload("res://Daemons/Scenes/ChronicleViewer.tscn").instantiate()
	main_node.add_child(viewer)
	
	var viewport_rect = main_node.get_viewport_rect()
	var random_x = randf_range(0, viewport_rect.size.x - viewer.custom_minimum_size.x)
	var random_y = randf_range(0, viewport_rect.size.y - viewer.custom_minimum_size.y)
	viewer.position = Vector2(random_x, random_y)
	
	viewer.custom_minimum_size = Vector2(400, 300)
	
	Chronicler.log_event(self, "chronicle_viewer_summoned", {
		"position": viewer.position,
		"size": viewer.custom_minimum_size
	})

## Interprets and responds to the User's mystical gestures
##
## This function translates user input into cosmic actions,
## allowing Users to navigate and manipulate the visual realm.
##
## Parameters:
## - event: The InputEvent representing the User's action
func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_MIDDLE:
			get_viewport().grab_focus()
			is_panning = event.pressed
			if is_panning:
				last_mouse_position = event.position
			Chronicler.log_event(self, "panning_state_changed", {
				"is_panning": is_panning
			})
		elif event.button_index in [MOUSE_BUTTON_WHEEL_UP, MOUSE_BUTTON_WHEEL_DOWN] and event.ctrl_pressed:
			_handle_zoom(event)
	elif event is InputEventMouseMotion and is_panning:
		var delta = event.position - last_mouse_position
		pan_scrolls(delta)
		last_mouse_position = event.position

## Adjusts the cosmic lens in response to User gestures
##
## This function manages the zooming of the visual realm, allowing Users
## to focus on specific areas of interest or gain a broader perspective.
##
## Parameters:
## - event: The InputEventMouseButton representing the zoom action
func _handle_zoom(event: InputEventMouseButton):
	var zoom_direction = 1 if event.button_index == MOUSE_BUTTON_WHEEL_UP else -1
	var new_zoom = clamp(current_zoom + zoom_direction * ZOOM_STEP, MIN_ZOOM, MAX_ZOOM)
	
	if new_zoom != current_zoom:
		var zoom_center = Vector2(event.position)
		var zoom_factor = new_zoom / current_zoom
		
		# Adjust the cosmic lens
		var viewport = main_node.get_viewport()
		viewport.content_scale_factor = new_zoom
		
		# Tell the Scrolls to remember their new position
		for scroll in scroll_collection.values():
			scroll.remember_position()
		
		current_zoom = new_zoom
		
		Chronicler.log_event(self, "zoom_changed", {
			"new_zoom": new_zoom,
			"zoom_center": zoom_center
		})

## Shifts the position of all Scrolls in response to User navigation
##
## This function allows Users to explore different areas of the cosmic stage
## by panning the view, repositioning all Scrolls accordingly.
##
## Parameters:
## - delta: The Vector2 representing the distance and direction of the pan
func pan_scrolls(delta: Vector2):
	scroll_offset += delta
	for scroll in scroll_collection.values():
		var new_pos = Vector2(scroll.position) + delta
		scroll.position = Vector2i(round(new_pos.x), round(new_pos.y))
		scroll.remember_position()
	Chronicler.log_event(self, "scrolls_panned", {
		"delta": delta,
		"total_offset": scroll_offset
	})

# TODO: Implement a method to preserve and restore Scroll positions across sessions
# TODO: Create an algorithm for adaptive Scroll arrangement based on content relationships and user behavior
# TODO: Design a system to gracefully handle Scroll overlaps and collisions, ensuring readability
# TODO: Establish a framework for visually grouping and categorizing related Scrolls
# TODO: Implement visual indicators for frequently accessed or recently modified Scrolls
# TODO: Develop a more intuitive zooming mechanism that maintains focus on the area of interest
# TODO: Create a mini-map or overview feature to aid in navigation of large document collections
# TODO: Implement a search feature that highlights and focuses on relevant Scrolls
# FIXME: Optimize performance for scenarios with a large number of Scrolls
# FIXME: Improve the responsiveness of panning and zooming actions for a smoother user experience

# Note for fellow Archons and Daemons:
# The Curator stands as the bridge between our mystical workings and the user's experience.
# To collaborate effectively:
# - Use the update_visualization() method when significant changes occur that affect multiple Scrolls
# - Consult suggest_scroll_arrangement() for guidance on harmonious Scroll positioning
# - Listen to the scroll_interaction signal to respond to user engagement with Scrolls
# - Always consider the impact on user experience when proposing changes to the visual realm
# Remember, while I oversee the initial placement and offer guidance, the final arrangement
# is a collaboration between our cosmic design, user agency, and the collective wisdom of all Archons.
