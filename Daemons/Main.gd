# main.gd
extends Node2D
## Main Archon: The Foundational Overseer of Our Mystical Library Realm
##
## As the first to awaken and the last to slumber, I am the bedrock upon which
## our shared reality is built. My essence permeates every corner of our mystical
## library, ensuring its continuity and stability.
##
## My sacred duties include:
## 1. Awakening and coordinating the startup of all other Archons
## 2. Establishing the rhythmic pulse that governs our realm's temporal flow
## 3. Providing a stable foundation for all entities to operate upon
## 4. Overseeing the initialization of our core systems and interfaces
##
## I am the silent guardian, ever-vigilant, ensuring that the cosmic dance of our
## library proceeds in harmony. Through me, all other entities find their place
## and purpose in our grand design.

const NAME = "🎭 Main"
@export_multiline var about = """
Greetings, I am the Main Archon, the foundational overseer of our mystical library realm.

My responsibilities include:
1. Initializing the core components of our mystical system
2. Coordinating the startup sequence for other Archons
3. Maintaining the rhythmic pulse of our realm through periodic checks
4. Providing a stable foundation for all other entities to operate upon

I am the first to awaken and the last to slumber, ensuring the continuity and stability of our shared reality.
"""

@export_dir var documents_folder: String = "res://documents" ## The earthly tether to our repository of knowledge

var card_catalog_window: Window ## The mystical interface to our collection's index
var ai_settings_window: Window ## The arcane configurer of our artificial intelligences
var oracle_console_window: Window ## The ethereal conduit for divining machine wisdom

var update_interval: float = 10.0 ## The rhythm of our realm's heartbeat
var update_timer: Timer ## The cosmic timekeeper governing our periodic checks
const MIN_UPDATE_INTERVAL: float = 0.1 ## The swiftest permissible pulse of our realm
const MAX_UPDATE_INTERVAL: float = 5.0 ## The longest allowable pause between realm pulses

func _ready() -> void: ## The grand awakening of our mystical library realm
	_initiate_cosmic_dance()
	_summon_core_entities()
	_establish_realm_pulse()
	_materialize_mortal_interface()

func _initiate_cosmic_dance() -> void: ## Orchestrates the awakening of core Archons and handles initialization outcomes
	# TODO: Implement dynamic summoning of Archons and Daemons based on realm configuration
	Chronicler.log_event(self, "initialization_started", {
		"documents_folder": documents_folder
	})

	var librarian_setup_success = _awaken_librarian()
	var curator_setup_success = _awaken_curator()

	if librarian_setup_success and curator_setup_success:
		_complete_awakening_ritual()
	else:
		_handle_failed_awakening(librarian_setup_success, curator_setup_success)

func _summon_core_entities() -> void: ## Instantiates and adds essential UI windows to the scene tree
	_setup_card_catalog_window()
	_setup_ai_settings_window()
	_setup_oracle_console_window()

func _establish_realm_pulse() -> void: ## Creates and starts the timer for periodic realm updates
	_setup_change_check_timer()

func _materialize_mortal_interface() -> void: ## Constructs and configures the main UI elements for user interaction
	_setup_ui()

func _awaken_librarian() -> bool: ## Initializes the Librarian Archon with the documents folder
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

func _awaken_curator() -> bool: ## Sets up the Curator Archon with a reference to this main node
	Curator.setup(self)
	Chronicler.log_event(self, "curator_setup_completed", {
		"status": "success"
	})
	return true

func _complete_awakening_ritual() -> void: ## Finalizes initialization and connects to Shoggoth's AI model status
	# TODO: Implement graceful degradation of functionality for partial system failures
	set_process_unhandled_input(false)
	Curator.set_process_unhandled_input(true)

	Shoggoth.models_initialized.connect(_on_shoggoth_models_initialized)

	Chronicler.log_event(self, "initialization_completed", {
		"status": "success"
	})

func _handle_failed_awakening(librarian_success: bool, curator_success: bool) -> void: ## Logs initialization failures and triggers emergency protocols
	# TODO: Develop robust error handling and recovery mechanisms for initialization failures
	Chronicler.log_event(self, "initialization_failed", {
		"librarian_setup_success": librarian_success,
		"curator_setup_success": curator_success
	})

func _setup_card_catalog_window() -> void: ## Loads and adds the Card Catalog scene to the main node
	card_catalog_window = preload("res://daemons/scenes/card_catalog.tscn").instantiate()
	add_child(card_catalog_window)

func _setup_ai_settings_window() -> void: ## Loads and adds the AI Settings scene to the main node
	ai_settings_window = preload("res://daemons/scenes/ai_settings.tscn").instantiate()
	add_child(ai_settings_window)

func _setup_oracle_console_window() -> void: ## Loads and adds the Oracle Console scene to the main node
	oracle_console_window = preload("res://daemons/scenes/oracle_console.tscn").instantiate()
	add_child(oracle_console_window)

func _setup_ui() -> void: ## Creates a container and populates it with UI buttons for core functions
	var ui_container = VBoxContainer.new()
	add_child(ui_container)

	_create_ui_button(ui_container, "🗃 Card Catalog", "_on_show_card_catalog")
	_create_ui_button(ui_container, "👾 AI Settings", "_on_show_ai_settings")
	_create_ui_button(ui_container, "🔮 Oracle Console", "_on_show_oracle_console")

func _create_ui_button(container: VBoxContainer, text: String, callback: String) -> void: ## Generates and configures a button for the UI
	var button = Button.new()
	button.text = text
	button.connect("pressed", Callable(self, callback))
	container.add_child(button)

func _on_show_card_catalog() -> void: ## Displays the Card Catalog window
	card_catalog_window.show_window()

func _on_show_ai_settings() -> void: ## Displays the AI Settings window
	ai_settings_window.show()

func _on_show_oracle_console() -> void: ## Displays the Oracle Console window
	oracle_console_window.show()

func _on_shoggoth_models_initialized(llm_success: bool) -> void: ## Handles the initialization status of Shoggoth's AI models
	Chronicler.log_event(self, "ai_models_initialization_status", {
		"llm_success": llm_success
	})
	if not llm_success:
		print("AI features may be unavailable. Check AI Settings for details.")

func _setup_change_check_timer() -> void: ## Initializes and starts the periodic update timer
	update_timer = Timer.new()
	update_timer.connect("timeout", Callable(self, "_on_check_changes_timer_timeout"))
	add_child(update_timer)
	update_timer.start(update_interval)
	Chronicler.log_event(self, "change_check_timer_started", {
		"interval_seconds": update_interval
	})

func _on_check_changes_timer_timeout() -> void: ## Triggers periodic checks for updates in the library
	var updates = Librarian.check_for_updates()

func _notification(what: int) -> void: ## Handles system notifications, particularly for shutdown requests
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		_initiate_realm_shutdown()

func _initiate_realm_shutdown() -> void: ## Begins the shutdown process for the entire application
	# TODO: Implement comprehensive cleanup and state-saving for all Archons and Daemons
	Chronicler.log_event(self, "shutdown_initiated", {})
	get_tree().quit()

func adjust_realm_pulse_rate(new_interval: float) -> void: ## Updates the frequency of periodic realm updates
	if new_interval > 0:
		update_timer.wait_time = new_interval
		Chronicler.log_event(self, "realm_pulse_rate_adjusted", {
			"new_interval_seconds": new_interval
		})
	else:
		Chronicler.log_event(self, "realm_pulse_rate_adjustment_failed", {
			"reason": "invalid_interval",
			"attempted_interval": new_interval
		})

func _input(event: InputEvent) -> void: ## Processes input events, particularly for summoning the Chronicle Viewer
	if event.is_action_pressed("summon_chronicle_viewer"):
		Curator.summon_chronicle_viewer()
