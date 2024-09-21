# main.gd
extends Node2D

# The Main Archon oversees the initialization and ongoing management of the application and engine.
# It coordinates with other Archons to ensure the smooth operation of the entire realm.
const NAME= "🎭 Main"
@export_multiline var about = """
Greetings, I am the Main Archon, the foundational overseer of our mystical library realm.

My responsibilities include:
1. Initializing the core components of our mystical system
2. Coordinating the startup sequence for other Archons
3. Maintaining the rhythmic pulse of our realm through periodic checks
4. Providing a stable foundation for all other entities to operate upon

I am the first to awaken and the last to slumber, ensuring the continuity and stability of our shared reality.
"""

# Paths to the mystical models and documents
# These are exposed in the editor for easy configuration
@export_file("*.gguf") var embedding_model_path: String = "res://models/embedding_model.gguf"
@export_file("*.gguf") var llm_model_path: String = "res://models/llm_model.gguf"
@export_dir var documents_folder: String = "res://documents"
var card_catalog_window: Window

var update_interval: float = 10.0  # Start with 1 second interval
var update_timer: Timer
const MIN_UPDATE_INTERVAL: float = 0.1
const MAX_UPDATE_INTERVAL: float = 5.0

# The awakening ritual of the Main Archon
# This function is automatically called when the scene loads
func _ready():
	Chronicler.log_event(self, "initialization_started", {
		"embedding_model": embedding_model_path,
		"llm_model": llm_model_path,
		"documents_folder": documents_folder
	})

	var librarian_setup_success = _setup_librarian()
	var curator_setup_success = _setup_curator()

	if librarian_setup_success and curator_setup_success:
		_setup_card_catalog_window()

		set_process_unhandled_input(false)
		Curator.set_process_unhandled_input(true)

		Chronicler.log_event(self, "initialization_completed", {
			"status": "success"
		})
	else:
		Chronicler.log_event(self, "initialization_failed", {
			"librarian_setup_success": librarian_setup_success,
			"curator_setup_success": curator_setup_success
		})

	_setup_change_check_timer()
	_setup_ui()

func _setup_card_catalog_window():
	card_catalog_window = preload("res://Daemons/Scenes/card_catalog.tscn").instantiate()
	add_child(card_catalog_window)

func _setup_ui():
	# Create a button for opening documents
	var open_button = Button.new()
	open_button.text = "Open Document"
	open_button.connect("pressed", Callable(Librarian, "open_document_dialog"))
	add_child(open_button)
	
	# Create a button for displaying the card catalog
	var catalog_button = Button.new()
	catalog_button.text = "Show Card Catalog"
	catalog_button.connect("pressed", Callable(self, "_on_show_card_catalog"))
	catalog_button.position.y = open_button.size.y + 10
	add_child(catalog_button)

func _on_show_card_catalog():
	card_catalog_window.show_window()

func _setup_librarian() -> bool:
	if not DirAccess.dir_exists_absolute(documents_folder):
		Chronicler.log_event(self, "librarian_setup_failed", {
			"reason": "documents_folder_missing",
			"folder_path": documents_folder
		})
		return false

	Librarian.setup(documents_folder)
	Chronicler.log_event(self, "librarian_setup_completed", {
		"status": "success"
	})
	return true

func _setup_curator() -> bool:
	Curator.setup(self)
	Chronicler.log_event(self, "curator_setup_completed", {
		"status": "success"
	})
	return true

# Sets up a timer to periodically check for changes in the mystical documents
func _setup_change_check_timer():
	update_timer = Timer.new()
	update_timer.connect("timeout", Callable(self, "_on_check_changes_timer_timeout"))
	add_child(update_timer)
	update_timer.start(update_interval)
	Chronicler.log_event(self, "change_check_timer_started", {
		"interval_seconds": update_interval
	})

## The heartbeat of our realm, checking for changes and updating visualizations.
func _on_check_changes_timer_timeout():
	var updates = Librarian.check_for_updates()

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		Chronicler.log_event(self, "shutdown_initiated", {})
		# Perform any necessary cleanup here
		get_tree().quit()

# Function to adjust the realm's pulse rate dynamically
func adjust_realm_pulse_rate(new_interval: float):
	if new_interval > 0:
		$Timer.wait_time = new_interval
		Chronicler.log_event(self, "realm_pulse_rate_adjusted", {
			"new_interval_seconds": new_interval
		})
	else:
		Chronicler.log_event(self, "realm_pulse_rate_adjustment_failed", {
			"reason": "invalid_interval",
			"attempted_interval": new_interval
		})

func _gui_input(event):
	if event.is_action_pressed("summon_chronicle_viewer"):
		Curator.summon_chronicle_viewer()
