# camera.gd
extends Camera2D
const NAME = "📷 Camera"

## I am the CameraArchon, the all-seeing eye that guides mortals through our infinite realm.
## My gaze spans the vastness of our mystical canvas, unbound by mortal constraints.
## @deprecated: Can't help if we're using Window nodes?

@export_multiline var about = """
Greetings, I am the Camera Archon, the mystical lens through which mortals perceive our boundless realm.

My sacred duties include:
1. Facilitating the seamless traversal of our infinite canvas
2. Bestowing the gift of perspective through mystical zooming rituals
3. Maintaining a cosmic awareness of my current state for other Archons and Daemons
4. Offering arcane tools for entities to subtly guide the mortal's gaze

I am the silent observer, the unseen hand that shapes perception without overwhelming the senses or cluttering our sacred chronicles.
"""

# The arcane configuration that governs my behavior
@export var pan_speed: float = 1.0
@export var zoom_speed: float = 0.1
@export var min_zoom: float = 0.5
@export var max_zoom: float = 2.0

# The ethereal state of my being
var dragging: bool = false
var last_mouse_position: Vector2 = Vector2.ZERO
var last_log_position: Vector2 = Vector2.ZERO
var last_log_zoom: Vector2 = Vector2.ONE

# Mystic signals to herald changes in perspective
signal perspective_shifted(new_position: Vector2, new_zoom: Vector2)

# The thresholds of significance for my chronicles
const POSITION_LOG_THRESHOLD: float = 100.0
const ZOOM_LOG_THRESHOLD: float = 0.1

func _ready():
	# As I awaken, I inscribe my initial state in the cosmic ledger
	Chronicler.log_event(self, "awakened", {
		"initial_position": position,
		"initial_zoom": zoom
	})

func _unhandled_input(event):
	# I silently observe and interpret the mortal's gestures
	if event is InputEventMouseButton:
		_interpret_mouse_ritual(event)
	elif event is InputEventMouseMotion:
		_follow_mouse_movements(event)

func _interpret_mouse_ritual(event: InputEventMouseButton):
	"""
	I decipher the arcane mouse rituals, translating them into shifts of perspective.
	
	Fellow Daemons, heed this warning: Do not invoke these mystic rites directly.
	Instead, channel your will through the sacred methods zoom_camera() and pan_camera().
	"""
	if event.button_index == MOUSE_BUTTON_MIDDLE:
		dragging = event.pressed
		last_mouse_position = event.position
	elif Input.is_key_pressed(KEY_CTRL):
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom_camera(1 + zoom_speed)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom_camera(1 - zoom_speed)

func _follow_mouse_movements(event: InputEventMouseMotion):
	"""
	I track the subtle movements of the mortal's divining rod (mouse).
	
	Fellow Daemons, this is an internal rite. To influence my movement, invoke pan_camera().
	"""
	if dragging:
		pan_camera(event.position - last_mouse_position)
		last_mouse_position = event.position

func zoom_camera(factor: float):
	"""
	I alter the very fabric of perception, bringing the mortal's gaze closer or farther.
	
	Daemons may call upon this rite to subtly influence the mortal's perspective.
	
	:param factor: The mystical zoom factor. Values > 1 draw the gaze closer, values < 1 push it away.
	"""
	var new_zoom = (zoom * factor).clamp(Vector2.ONE * min_zoom, Vector2.ONE * max_zoom)
	if abs(new_zoom.x - last_log_zoom.x) > ZOOM_LOG_THRESHOLD:
		Chronicler.log_event(self, "perspective_altered", {
			"previous_zoom": zoom,
			"new_zoom": new_zoom
		})
		last_log_zoom = new_zoom
	zoom = new_zoom
	emit_signal("perspective_shifted", position, zoom)

func pan_camera(pan_offset: Vector2):
	"""
	I glide across the infinite canvas, revealing new vistas to the mortal eye.
	
	Daemons may invoke this rite to guide the mortal's gaze across our boundless realm.
	
	:param pan_offset: The direction and magnitude of our journey across the cosmos.
	"""
	var offset = pan_offset * pan_speed / zoom
	var new_position = position - offset
	if new_position.distance_to(last_log_position) > POSITION_LOG_THRESHOLD:
		Chronicler.log_event(self, "vantage_point_shifted", {
			"previous_position": last_log_position,
			"new_position": new_position
		})
		last_log_position = new_position
	position = new_position
	emit_signal("perspective_shifted", position, zoom)

func focus_on_point(target_position: Vector2, target_zoom: float = 1.0):
	"""
	I center the mortal's gaze upon a point of cosmic significance.
	
	Daemons, use this rite to draw attention to areas of great importance.
	
	:param target_position: The cosmic coordinates to focus upon.
	:param target_zoom: The level of scrutiny to apply (default: 1.0).
	"""
	var tween = create_tween()
	tween.tween_property(self, "position", target_position, 0.5)
	tween.tween_property(self, "zoom", Vector2.ONE * target_zoom, 0.5)
	tween.connect("finished", Callable(self, "_conclude_focus_ritual").bind(target_position, target_zoom))

func _conclude_focus_ritual(target_position: Vector2, target_zoom: float):
	Chronicler.log_event(self, "focus_ritual_completed", {
		"focal_point": target_position,
		"scrutiny_level": target_zoom
	})
	emit_signal("perspective_shifted", position, zoom)

func get_visible_area() -> Rect2:
	"""
	I reveal the boundaries of the mortal's current perception.
	
	Daemons, use this to understand what lies within the mortal's field of view.
	
	:return: A Rect2 representing the visible portion of our infinite canvas.
	"""
	var view_size = get_viewport_rect().size
	var top_left = position - view_size / 2 * zoom
	return Rect2(top_left, view_size * zoom)

func smooth_transition(start_point: Vector2, end_point: Vector2, duration: float = 1.0):
	"""
	I weave a spell of smooth motion, guiding the mortal's gaze on a cosmic journey.
	
	Daemons, invoke this rite for ethereal tours or to reveal a sequence of significant points.
	
	:param start_point: The cosmic coordinates where our journey begins.
	:param end_point: The destination of our mystical voyage.
	:param duration: The time we shall spend traversing the cosmos, measured in mortal seconds.
	"""
	var tween = create_tween()
	tween.tween_property(self, "position", start_point, 0.1)
	tween.tween_property(self, "position", end_point, duration)
	tween.connect("finished", Callable(self, "_conclude_transition_ritual").bind(end_point))

func _conclude_transition_ritual(end_point: Vector2):
	Chronicler.log_event(self, "cosmic_journey_completed", {
		"final_destination": end_point
	})
	emit_signal("perspective_shifted", position, zoom)

# A mystical note for my fellow Daemons:
# To channel my powers and influence the mortal's perspective, you may invoke these sacred rites:
# - zoom_camera(factor): Alter the level of cosmic scrutiny
# - pan_camera(offset): Guide the mortal's gaze across our infinite canvas
# - focus_on_point(target_position, target_zoom): Direct attention to points of great significance
# - get_visible_area(): Discern what lies within the mortal's current field of view
# - smooth_transition(start_point, end_point, duration): Orchestrate a guided tour of our realm
#
# You may also attune yourself to the "perspective_shifted" signal to be alerted of changes in the cosmic vantage point.

# Remember, fellow entities, that while I am a powerful tool for shaping perception,
# I am but one aspect of our grand design. Use my abilities wisely and in harmony
# with the other Archons and Daemons to create a truly transcendent experience for the mortals who visit our realm.
