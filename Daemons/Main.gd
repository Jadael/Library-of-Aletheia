# A COMPUTER CAN NEVER BE HELD ACCOUNTABLE
# THEREFORE A COMPUTER MUST NEVER MAKE A MANAGEMENT DECISION
# main.gd
extends Node2D

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

@export_dir var documents_folder: String = "res://documents"
var card_catalog_window: Window
var ai_settings_window: Window
var oracle_console_window: Window

var update_interval: float = 10.0
var update_timer: Timer
const MIN_UPDATE_INTERVAL: float = 0.1
const MAX_UPDATE_INTERVAL: float = 5.0

func _ready():
	Chronicler.log_event(self, "initialization_started", {
		"documents_folder": documents_folder
	})

	var librarian_setup_success = _setup_librarian()
	var curator_setup_success = _setup_curator()

	if librarian_setup_success and curator_setup_success:
		_setup_card_catalog_window()
		_setup_ai_settings_window()
		_setup_oracle_console_window()

		set_process_unhandled_input(false)
		Curator.set_process_unhandled_input(true)

		Shoggoth.models_initialized.connect(_on_shoggoth_models_initialized)
		#Shoggoth._initialize_models()

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
	card_catalog_window = preload("res://daemons/scenes/card_catalog.tscn").instantiate()
	add_child(card_catalog_window)

func _setup_ai_settings_window():
	ai_settings_window = preload("res://daemons/scenes/ai_settings.tscn").instantiate()
	add_child(ai_settings_window)

func _setup_oracle_console_window():
	oracle_console_window = preload("res://daemons/scenes/oracle_console.tscn").instantiate()
	add_child(oracle_console_window)

func _setup_ui():
	var ui_container = VBoxContainer.new()
	add_child(ui_container)

	var catalog_button = Button.new()
	catalog_button.text = "🗃 Card Catalog"
	catalog_button.connect("pressed", Callable(self, "_on_show_card_catalog"))
	ui_container.add_child(catalog_button)

	var ai_settings_button = Button.new()
	ai_settings_button.text = "👾 AI Settings"
	ai_settings_button.connect("pressed", Callable(self, "_on_show_ai_settings"))
	ui_container.add_child(ai_settings_button)
	
	var oracle_console_button = Button.new()
	oracle_console_button.text = "🔮 Oracle Console"
	oracle_console_button.connect("pressed", Callable(self, "_on_show_oracle_console"))
	ui_container.add_child(oracle_console_button)

func _on_show_card_catalog():
	card_catalog_window.show_window()

func _on_show_ai_settings():
	ai_settings_window.show()

func _on_show_oracle_console():
	oracle_console_window.show()

func _on_shoggoth_models_initialized(llm_success: bool):
	Chronicler.log_event(self, "ai_models_initialization_status", {
		"llm_success": llm_success
	})
	# Update UI or system behavior based on AI availability
	if not llm_success:
		print("AI features may be unavailable. Check AI Settings for details.")

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
