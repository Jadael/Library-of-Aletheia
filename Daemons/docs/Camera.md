---
title: Camera
last_updated: 2024-09-13T17:09:48
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

﴾**Function: _ready**
**Context and Purpose:** The `_ready` function in the Camera script is executed when the camera node is initialized and ready to use. Its purpose is to log the camera's initial state in the Chronicler, a logging mechanism, using the `log_event` function.

**Input(s) Expected:** None explicitly, as it is a built-in Godot function called when the node is ready.

**Output Returned and/or Behavior(s):** The function logs the camera's initial state, including its position and zoom level, in the Chronicler. This ensures that the camera's initial settings are recorded for future reference.

**Intricacies in Implementation:** The function uses the `Chronicler` class to log the event. The `log_event` function is called with the event name "CameraArchon" and the event type "awakened". The event data contains the camera's initial position and zoom level, which are captured using the `position` and `zoom` properties of the camera node.

**Description End:** ﴿

### _unhandled_input
`func _unhandled_input(event):`

﴾**Function Context and Purpose**
The `_unhandled_input` function is a part of the Camera script, which is responsible for handling user input events related to camera movements. The purpose of this function is to silently observe and interpret the user's gestures, allowing the camera to respond accordingly.

**Expected Input(s)**
The function expects two types of input events:
1. `InputEventMouseButton`: This event is triggered when the user presses or releases a mouse button.
2. `InputEventMouseMotion`: This event is triggered when the user moves the mouse.

**Output and Behavior**
The function does not return any explicit output. Instead, it calls two helper functions:
1. `_interpret_mouse_ritual` (called when an `InputEventMouseButton` is received): This function is responsible for interpreting the mouse button events, which can include actions such as camera zooming, panning, or rotation.
2. `_follow_mouse_movements` (called when an `InputEventMouseMotion` is received): This function is responsible for tracking the mouse movements, which can include actions such as camera movement or rotation.

**Intricacies in Implementation**
The function uses the `is` operator to check the type of the input event. This allows it to handle both `InputEventMouseButton` and `InputEventMouseMotion` events separately. The function then calls the corresponding helper function based on the type of event received.

**Conclusion**
﴿

### _interpret_mouse_ritual
`func _interpret_mouse_ritual(event: InputEventMouseButton):`

﴾Error: After 3 attempts, the cosmic forces failed to reveal the mysteries of function _interpret_mouse_ritual﴿

### _follow_mouse_movements
`func _follow_mouse_movements(event: InputEventMouseMotion):`

﴾**Function Context and Purpose**
The `_follow_mouse_movements` function is part of the Camera script, designed to track and respond to the user's mouse movements. Its primary purpose is to pan the camera within the game world, providing a smooth and immersive experience.

**Input(s)**
The function expects an `InputEventMouseMotion` object as an input, which represents the mouse motion event. This input contains the current mouse position, which is used to calculate the camera's movement.

**Output and Behavior**
The function updates the camera's position by calling the `pan_camera` function, which adjusts the camera's position based on the mouse movement. The function also updates the `last_mouse_position` variable to keep track of the previous mouse position, allowing it to calculate the movement delta.

**Intricacies**
The function only updates the camera position if the `dragging` flag is set to `true`. This indicates that the user has started a dragging operation and the camera should follow the mouse movement.

**Conclusion** ﴿

### zoom_camera
`func zoom_camera(factor: float):`

﴾**Function Description:**

The `zoom_camera` function is part of the Camera script, responsible for manipulating the camera's zoom level in response to a specified factor. The purpose of this function is to dynamically adjust the camera's zoom, allowing for smooth transitions between different levels of zoom.

**Input:**

The function expects a single input parameter, `factor`, which is a float value representing the zoom factor. This value can be greater than 1 to zoom in, or less than 1 to zoom out.

**Output/Behavior:**

The function returns no explicit output, but its behavior is characterized by the following:

1. It calculates a new zoom value by multiplying the current zoom value with the input factor, clamping the result to ensure it falls within the minimum and maximum allowed zoom values.
2. If the difference between the new and current zoom values exceeds a certain threshold, the function performs a smooth transition by gradually adjusting the camera's zoom level over a short period.
3. The function does not affect the camera's position or rotation; it only modifies the zoom level.

**Intricacies:**

One key aspect of this function is the use of a threshold to determine when a significant change in zoom level occurs. This threshold helps to prevent sudden, jarring changes in the camera's zoom level, creating a more natural and smooth experience for the user.

**Conclusion:**

In summary, the `zoom_camera` function is a powerful tool for manipulating the camera's zoom level in response to various factors. Its ability to smoothly transition between different zoom levels and its threshold-based approach ensure a seamless and engaging experience for the user. ﴿

### pan_camera
`func pan_camera(pan_offset: Vector2):`

﴾The camera script in Godot is responsible for controlling the view perspective in the game or scene. The `pan_camera` function is a crucial part of this script, allowing the camera to move smoothly across the scene while maintaining a stable zoom level.

**Function Context and Purpose**
The `pan_camera` function is designed to pan the camera across the scene, adjusting its position based on the input `pan_ffset` parameter. This function is intended to be invoked by other scripts or mechanisms to control the camera's movement.

**Input Expectations**
The `pan_camera` function expects a single input parameter, `pan_ffset`, which is a `Vector2` representing the direction and magnitude of the camera's movement. This input value is used to calculate the new position of the camera.

**Output and Behavior**
The `pan_camera` function does not return a direct output value. Instead, it modifies the camera's position in-place, reflecting the new offset calculated from the input `pan_ffset` value. The function also maintains the current zoom level of the camera, ensuring a smooth transition during the panning process.

**Description**
When invoked, the `pan_camera` function adjusts the camera's position by multiplying the input `pan_ffset` value with a scaling factor. The resulting offset is then added to the current camera position, allowing the camera to move smoothly across the scene. This function is designed to be used in conjunction with other camera-related functions, such as zooming or rotating the camera, to provide a seamless and immersive experience for the player.

﴿

### focus_on_point
`func focus_on_point(target_position: Vector2, target_zoom: float = 1.0):`

﴾Error: After 3 attempts, the cosmic forces failed to reveal the mysteries of function focus_on_point﴿

### _conclude_focus_ritual
`func _conclude_focus_ritual(target_position: Vector2, target_zoom: float):`

﴾**Function:** `_conclude_focus_ritual`

**Script Purpose:** This script controls the camera's behavior in a game. The `_conclude_focus_ritual` function is part of a focus ritual mechanism that allows the camera to adjust its position and zoom level.

**Input(s):** The function takes two inputs: `target_position` (a `Vector2` object) and `target_zoom` (a `float` value).

**Output returned and/or behavior(s):** The function logs an event to the `Chronicler` (a logging mechanism) indicating that the focus ritual has been completed. It also emits a signal named "perspective_shifted" with the new camera position and zoom level.

**Intricacies in its implementation:** The function does not have any complex implementation details, as it simply logs the event and emits the signal. The actual camera position and zoom level adjustments are likely handled elsewhere in the script or in other parts of the game.

﴿

### get_visible_area
`func get_visible_area() -> Rect2:`

﴾**Function Description**

**Context and Purpose:** The `get_visible_area` function is part of the Camera script in Godot, which is responsible for managing the visible portion of the scene. This function provides information about the boundaries of the mortal's (player's) current perception, allowing daemons (other scripts) to understand what lies within the player's field of view.

**Input(s) Expected:** None, as this is a pure function that relies on internal variables and properties of the Camera script.

**Output Returned and/or Behavior(s):** The function returns a `Rect2` object representing the visible portion of the scene. This rect is calculated based on the camera's position, viewport size, and zoom level.

**Intricacies in Implementation:** The function first retrieves the viewport size using `get_viewport_rect().size`. It then calculates the top-left corner of the visible area by subtracting half of the viewport size from the camera's position and multiplying the result by the zoom level. Finally, it returns a `Rect2` object with the calculated top-left corner and the scaled viewport size.

﴿

### smooth_transition
`func smooth_transition(start_point: Vector2, end_point: Vector2, duration: float = 1.0):`

﴾Error: After 3 attempts, the cosmic forces failed to reveal the mysteries of function smooth_transition﴿

### _conclude_transition_ritual
`func _conclude_transition_ritual(end_point: Vector2):`

﴾The function `_conclude_transition_ritual` is part of the Camera script, which is responsible for managing the camera's position and zoom during the player's journey. The purpose of this function is to conclude the transition ritual, marking the end of a journey segment.

**Input(s)**
The function expects a single input: `end_point`, which is a `Vector2` representing the final destination coordinates.

**Output returned and/or behavior(s)**
The function logs an event using the `Chronicler` script, indicating that the cosmic journey has been completed. The event includes the `final_destination` coordinates as a property. Additionally, the function emits a signal named `perspective_shifted`, which notifies other scripts that the camera's position and zoom have changed.

**Intricacies in its implementation**
The function's implementation is straightforward, with a single log statement and a signal emission. The `Chronicler` script is used to record the event, while the `emit_signal` function sends the `perspective_shifted` signal to any registered listeners.

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
	
