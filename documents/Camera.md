---
title: Camera
last_updated: 2024-09-13T13:37:08
---

# Camera

## Properties
- @export_multiline var about = """
- @export var pan_speed: float = 1.0
- @export var zoom_speed: float = 0.1
- @export var min_zoom: float = 0.5
- @export var max_zoom: float = 2.0

## Signals
- signal perspective_shifted(new_position: Vector2, new_zoom: Vector2)

## Constants
- const POSITION_LOG_THRESHOLD: float = 100.0
- const ZOOM_LOG_THRESHOLD: float = 0.1

## Functions
### _ready
`func _ready():`

﴾**Function: _ready()**

**Context and Purpose:** The _ready() function is part of the Camera script, which initializes the camera's initial state when the scene is loaded. This function is responsible for logging the camera's initial position and zoom level to a chronicler.

**Input(s):** None

**Output returned and/ or behavior(s):** The function logs the initial position and zoom level of the camera to the chronicler using the log_ event() function.

**Intricacies in its implementation:** The function uses the Chronicler script to log events, which is a common pattern in Godot for tracking important events or state changes in the game. The log_ event() function expects a string for the event name, the camera archon as the event source, and a dictionary of key-value pairs to describe the event.

**Description:** The _ready() function is executed when the scene is loaded, allowing the camera to establish its initial state. By logging this information, the camera provides a record of its starting conditions for future reference or debugging purposes. This ensures that the camera's position and zoom level are properly set at the start of the game, allowing for precise control and consistency throughout the player's experience.

﴿

### _unhandled_input
`func _unhandled_input(event):`

﴾**Function Description:**

The `_unhandled_input` function is a part of the Camera script in Godot, designed to intercept and process unhandled input events from the user. Its purpose is to enable the camera to respond to user gestures, such as mouse clicks and movements.

**Input Expectations:**

This function expects the following input(s):

* `event`: an `InputEvent` object, which represents a user input event.

**Output and Behavior:**

The function does not explicitly return any output. Instead, it processes the input event and triggers specific behaviors based on the type of event. When a mouse button is clicked, the function calls `_interpret_mouse_ritual` to handle the event. For mouse motion events, the function calls `_follow_mouse_movements` to track the user's gestures.

**Implementation Intricacies:**

The function uses the `if`-`elif` statement to check the type of input event. This allows it to selectively call the corresponding processing function based on the event type. The `_interpret_mouse_ritual` and `_follow_mouse_movements` functions are not explicitly defined in this script, but they likely contain the specific logic for handling mouse clicks and movements, respectively.

**Conclusion:**

In summary, the `_unhandled_input` function is a critical component of the Camera script, responsible for processing unhandled input events and triggering specific behaviors. Its implementation is designed to be flexible and adaptable to various input events, making it a key element in creating interactive camera controls in Godot. ﴿

### _interpret_mouse_ritual
`func _interpret_mouse_ritual(event: InputEventMouseButton):`

﴾Error: After 3 attempts, the cosmic forces failed to reveal the mysteries of function _interpret_mouse_ritual﴿

### _follow_mouse_movements
`func _follow_mouse_movements(event: InputEventMouseMotion):`

﴾Error: After 3 attempts, the cosmic forces failed to reveal the mysteries of function _follow_mouse_movements﴿

### zoom_camera
`func zoom_camera(factor: float):`

﴾**Function Context and Purpose**

The `zoom_camera` function is part of the Camera script, which aims to dynamically adjust the camera's zoom level in response to various factors. This function specifically allows daemons (presumably external entities) to influence the camera's perspective by applying a zoom factor.

**Input Expectations**

The function expects a single input parameter `factor`, which represents the zoom factor. This value can be greater than 1 to zoom in (bring the gaze closer) or less than 1 to zoom out (push the gaze away).

**Output and Behavior**

The function calculates a new zoom value by multiplying the current zoom level with the input factor, then clamping the result to ensure it falls within the allowed range defined by `min_zoom` and `max_zoom`. If the absolute difference between the new and current zoom levels exceeds a certain threshold (not explicitly specified), the function logs a message to the console, indicating the successful adjustment.

**Intricacies in Implementation**

The function uses the `var` keyword to declare a local variable `new`, which holds the calculated zoom value. The comment block provides a brief explanation of the function's purpose and the significance of the input factor. The use of mystical terms like "daemons" and "mystical zoom factor" adds a touch of whimsy to the script.

**Conclusion** ﴿

### pan_camera
`func pan_camera(pan_offset: Vector2):`

﴾**Function Context and Purpose:**
The `pan_camera` function is part of the Camera script, responsible for panning the camera across the infinite canvas, revealing new vistas to the player. It allows daemons to guide the player's gaze across the boundless realm.

**Input(s):**
The function expects a single input: `pan_offset`, a `Vector2` that represents the direction and magnitude of the camera's movement.

**Output and Behavior:**
The function does not return a specific output. Instead, it modifies the camera's position and emits a signal to notify other scripts of the perspective shift.

**Intricacies:**
The function first calculates the `offset` by multiplying the `pan_offset` with the `pan_speed` and dividing by the `zoom` factor. This ensures that the camera movement is proportional to the zoom level. It then updates the camera's position by adding the calculated `offset` to the current position.

The function also emits a signal to notify other scripts of the perspective shift, allowing them to respond accordingly.

﴿

### focus_on_point
`func focus_on_point(target_position: Vector2, target_zoom: float = 1.0):`

﴾Error: After 3 attempts, the cosmic forces failed to reveal the mysteries of function focus_on_point﴿

### _conclude_focus_ritual
`func _conclude_focus_ritual(target_position: Vector2, target_zoom: float):`

﴾**Function Description:**

The _conclude_focus_ritual function is a part of the Camera script, which is responsible for managing the camera's perspective and focus. The function's purpose is to conclude a focus ritual, which is likely a mechanism for adjusting the camera's focus to a specific point or level of scrutiny.

**Inputs:**

1. `target_position`: A `Vector2` representing the target position in the game world where the camera should focus.
2. `target_ zoom`: A `float` value representing the desired level of scrutiny or zoom.

**Output and Behavior:**

The function logs an event in the `Chronicler` using the `log_ event` method, indicating that the focus ritual has been completed. It also emits a signal named `perspective_shifted`, which likely notifies other parts of the game that the camera's perspective has changed.

**Implementation Intricacies:**

The function does not appear to have any complex implementation details, as it simply logs an event and emits a signal. However, the underlying logic for adjusting the camera's focus and perspective is likely handled elsewhere in the script or by other components.

**Conclusion:**
﴿

### get_visible_area
`func get_visible_area() -> Rect2:`

﴾**Function Description:**

**Context and Purpose:**
The `get_visible_area` function is part of the Camera script in Godot, responsible for determining the boundaries of the visible area within the game's infinite canvas. This information is crucial for daemons, as it helps them understand what lies within the mortal's field of view.

**Input(s):**
None. The function does not expect any input parameters.

**Output and Behavior:**
The function returns a `Rect2` object representing the visible portion of the infinite canvas. The returned rectangle's top-left corner is calculated by subtracting half of the viewport's size from the camera's position, scaled by the camera's zoom factor. The rectangle's size is the product of the viewport's size and the camera's zoom factor.

**Intricacies:**
The function uses the `get_viewport_rect` method to retrieve the viewport's size and the `position` and `zoom` properties to calculate the top-left corner of the visible area. The zoom factor is used to scale the viewport's size, taking into account the camera's perspective.

**Conclusion:** ﴿

### smooth_transition
`func smooth_transition(start_point: Vector2, end_point: Vector2, duration: float = 1.0):`

﴾Error: After 3 attempts, the cosmic forces failed to reveal the mysteries of function smooth_transition﴿

### _conclude_transition_ritual
`func _conclude_transition_ritual(end_point: Vector2):`

﴾**Function: _conclude_transition_ritual**

**Context and Purpose:** The _conclude_transition_ritual function is part of the Camera script, which appears to be responsible for managing the camera's perspective and transition rituals. This specific function marks the end of a transition ritual, logging an event and emitting a signal to indicate the completion of the process.

**Input(s):** The function expects a single input, `end_point`, which is a 2D vector representing the final destination of the transition ritual.

**Output returned and/or behavior(s):**

* The function logs an event with the Chronicler, indicating the completion of the cosmic journey with the final destination specified.
* It emits a signal named "perspective_shifted" with the current position and zoom values, informing other parts of the script or connected nodes that the perspective has been shifted.

**Intricacies in implementation:** None mentioned in the provided code snippet.

**Summary:**

The _conclude_transition_ritual function is a crucial part of the Camera script, responsible for concluding a transition ritual by logging an event and emitting a signal. It takes a single input, `end_ point`, which represents the final destination of the transition. The function's output is the emission of a signal and the logging of an event, indicating the completion of the process.

﴿

---

# Source Code

# CameraArchon.gd
extends Camera2D

# I am the CameraArchon, the all-seeing eye that guides mortals through our infinite realm.
# My gaze spans the vastness of our mystical canvas, unbound by mortal constraints.

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
	Chronicler.log_event("CameraArchon", "awakened", {
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
		Chronicler.log_event("CameraArchon", "perspective_altered", {
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
		Chronicler.log_event("CameraArchon", "vantage_point_shifted", {
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
	Chronicler.log_event("CameraArchon", "focus_ritual_completed", {
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
	Chronicler.log_event("CameraArchon", "cosmic_journey_completed", {
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
