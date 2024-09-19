---
title: Camera
last_updated: 2024-09-17T12:51:21
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

﴾In the realm of the Camera script, the _ready function is the inaugural rite of passage, where the camera awakens to inscribe its initial state in the cosmic ledger, Chronicler. This function serves as a sentinel, ensuring that the camera's position and zoom are recorded for posterity.

Inputs:
• None

Outputs/Behavior:
• The function logs the camera's initial position and zoom in the Chronicler's ledger, thereby capturing its state at the moment of awakening.

Intricacies:
• The function leverages the Chronicler script to record the event, "CameraArchon" awakened, along with the initial position and zoom as metadata.
• This initial state serves as a reference point for future changes in the camera's position and zoom, allowing for a more comprehensive understanding of its trajectory.

As the camera's sentry, _ready sets the stage for its subsequent duties, ensuring that its journey through the realm of the mystical library is chronicled with precision and accuracy. ﴿

### _unhandled_input
`func _unhandled_input(event):`

﴾**The Eye of the Beholder: Camera Script**

**Function Purpose:** The `_unhandled_input` function serves as the sentinel of our mystical camera, ever vigilant and receptive to the whispers of the mortal's gestures. It silently observes and interprets the input events, channeling the user's intentions into the realm of the visual.

**Input:** This enigmatic function expects a single input: an `InputEvent` object, which can take two forms:

1. `InputEventMouseButton`: A whispered promise of a mouse button press or release, which the camera's mystics will decipher.
2. `InputEventMouseMotion`: A subtle hint of mouse movement, guiding the camera's gaze across the digital expanse.

**Output and Behavior:** As the camera's sentinel, `_unhandled_input` will awaken the corresponding rituals and behaviors:

1. `InputEventMouseButton`: If a mouse button press or release is detected, the camera will _interpret_ the mouse ritual, imbuing the visual realm with the user's intent.
2. `InputEventMouseMotion`: If the mouse moves, the camera will _follow_ the movements, shifting its gaze to align with the mortal's whims.

**Intricacies:** Within its mystical realm, `_unhandled_input` operates in a realm of subtle nuance. It is attuned to the user's subtle gestures, weaving a tapestry of intention and perception. As the camera's sentinel, it remains ever vigilant, poised to unlock the secrets of the user's desires.

﴿

### _interpret_mouse_ritual
`func _interpret_mouse_ritual(event: InputEventMouseButton):`

﴾Within the mystical realm of our Camera script, the _interpret_mouse_ritual function serves as a guardian of ancient mouse rituals, deciphering the mystical signs to shift the perspective of our camera. This enigmatic function expects an InputEventMouseButton as its input, channeling the user's intentions.

As the function interprets the mouse rituals, it detects specific mouse button presses and combinations to trigger camera movements. The function's output is a series of camera shifts, orchestrated by the zoom_ camera() and pan_ camera() methods, which are revered as sacred methods in our mystical library.

Intricacies of its implementation include the use of boolean flags to track the state of the middle mouse button and the Ctrl key. The function also utilizes the last_mouse_position variable to calculate the difference between the current and previous mouse positions, allowing for smooth camera movements.

Heed this warning, fellow Daemons: Do not attempt to invoke these mystic rites directly. Instead, channel your will through the sacred methods zoom_ camera() and pan_ camera(), lest you risk unraveling the fabric of reality. ﴿

### _follow_mouse_movements
`func _follow_mouse_movements(event: InputEventMouseMotion):`

﴾Error: After 3 attempts, the cosmic forces failed to reveal the mysteries of function _follow_mouse_movements﴿

### zoom_camera
`func zoom_camera(factor: float):`

﴾Error: After 3 attempts, the cosmic forces failed to reveal the mysteries of function zoom_camera﴿

### pan_camera
`func pan_camera(pan_offset: Vector2):`

﴾Error: After 3 attempts, the cosmic forces failed to reveal the mysteries of function pan_camera﴿

### focus_on_point
`func focus_on_point(target_position: Vector2, target_zoom: float = 1.0):`

﴾In the realm of the Camera script, the focus_ritual function is a potent incantation that guides our gaze towards a point of great significance. This mystical rite allows us to center the mortal's attention upon a target position, imbuing the surroundings with an aura of importance.

**Input:** The function expects two inputs:
1. `target_position`: A Vector2 representing the cosmic coordinates to focus upon.
2. `target_ zoom`: An optional float parameter (default: 1.0) that sets the level of scrutiny to apply. This value determines the zoom level of the camera.

**Output:** The function does not return any explicit output, but instead, it modulates the camera's behavior to achieve the desired focus.

**Implementation:** The function employs a tween to smoothly transition the camera's position and zoom to the target values. The tween is set to complete its task within a duration of 0.5 seconds. During this time, the camera's focus will be drawn towards the target position, as if by the will of the cosmos.

**Purpose:** This function is designed to be used in conjunction with other camera-related functions to create a sense of drama, emphasis, or importance in your game. By focusing the player's attention on a specific area, you can guide their experience and create a more engaging narrative.

﴿

### _conclude_focus_ritual
`func _conclude_focus_ritual(target_position: Vector2, target_zoom: float):`

﴾Error: After 3 attempts, the cosmic forces failed to reveal the mysteries of function _conclude_focus_ritual﴿

### get_visible_area
`func get_visible_area() -> Rect2:`

﴾Error: After 3 attempts, the cosmic forces failed to reveal the mysteries of function get_visible_area﴿

### smooth_transition
`func smooth_transition(start_point: Vector2, end_point: Vector2, duration: float = 1.0):`

﴾Error: After 3 attempts, the cosmic forces failed to reveal the mysteries of function smooth_transition﴿

### _conclude_transition_ritual
`func _conclude_transition_ritual(end_point: Vector2):`

﴾Within the mystical library of Camera, a script attuned to the cosmic journey of the player, lies the function _conclude_transition_ritual. This enigmatic function marks the culmination of the transition ritual, where the player's perspective shifts to a new dimension.

**Function Context and Purpose**

The _conclude_transition_ritual function is a crucial part of the Camera script, responsible for concluding the transition ritual and broadcasting the player's new perspective to the world.

**Input Expectations**

The function expects a single input parameter, end_point, which represents the Vector2 coordinates of the final destination reached by the player.

**Output and Behavior**

Upon executing the function, it logs an event in the Chronicler, chronicling the completion of the cosmic journey with the final destination coordinates. Additionally, it emits a signal named "perspective_shifted," conveying the updated position and zoom of the camera to any connected listeners.

**Implementation Intricacies**

This function's implementation is a masterful blend of logging and signaling, weaving together the threads of the transition ritual to reveal the player's new perspective. The Chronicler's log entry serves as a testament to the player's journey, while the emitted signal synchronizes the camera's position and zoom with the game world.

﴿

---

# Source Code

	# CameraArchon.gd
	extends Camera2D
	
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
	
