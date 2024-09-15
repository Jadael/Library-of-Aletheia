# Main.gd
extends Node2D

# The Main Archon oversees the initialization and ongoing management of the application and engine.
# It coordinates with other Archons to ensure the smooth operation of the entire realm.

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

# The awakening ritual of the Main Archon
# This function is automatically called when the scene loads
func _ready():
	Chronicler.log_event("MainArchon", "initialization_started", {
		"embedding_model": embedding_model_path,
		"llm_model": llm_model_path,
		"documents_folder": documents_folder
	})

	# Initialize the Librarian Archon with the paths to our mystical resources
	var librarian_setup_success = _setup_librarian()
	
	# Awaken the Curator Archon, providing it with a reference to this node
	var curator_setup_success = _setup_curator()
	
	if librarian_setup_success and curator_setup_success:
		# Command the Librarian to process all existing mystical documents
		Librarian.process_existing_documents()
		
			# Ensure that the Curator receives input events
		set_process_unhandled_input(false)
		Curator.set_process_unhandled_input(true)
		
		# Establish a rhythmic pulse to check for changes in our realm
		_setup_change_check_timer()

		Chronicler.log_event("MainArchon", "initialization_completed", {
			"status": "success"
		})
	else:
		Chronicler.log_event("MainArchon", "initialization_failed", {
			"librarian_setup_success": librarian_setup_success,
			"curator_setup_success": curator_setup_success
		})

func _setup_librarian() -> bool:
	if not FileAccess.file_exists(embedding_model_path) or not FileAccess.file_exists(llm_model_path):
		Chronicler.log_event("MainArchon", "librarian_setup_failed", {
			"reason": "model_files_missing",
			"embedding_model_exists": FileAccess.file_exists(embedding_model_path),
			"llm_model_exists": FileAccess.file_exists(llm_model_path)
		})
		return false

	if not DirAccess.dir_exists_absolute(documents_folder):
		Chronicler.log_event("MainArchon", "librarian_setup_failed", {
			"reason": "documents_folder_missing",
			"folder_path": documents_folder
		})
		return false

	Librarian.setup(embedding_model_path, llm_model_path, documents_folder)
	Chronicler.log_event("MainArchon", "librarian_setup_completed", {
		"status": "success"
	})
	return true

func _setup_curator() -> bool:
	Curator.setup(self)
	Chronicler.log_event("MainArchon", "curator_setup_completed", {
		"status": "success"
	})
	return true

# Sets up a timer to periodically check for changes in the mystical documents
func _setup_change_check_timer():
	var timer = Timer.new()
	timer.connect("timeout", Callable(self, "_on_check_changes_timer_timeout"))
	add_child(timer)
	timer.start(10.0)  # The realm's pulse occurs every 10 seconds
	Chronicler.log_event("MainArchon", "change_check_timer_started", {
		"interval_seconds": 10.0
	})

# The heartbeat of our realm, checking for changes and updating visualizations
func _on_check_changes_timer_timeout():
	Chronicler.log_event("MainArchon", "periodic_check_started", {})

	# Command the Librarian to check for updates in all Codex Daemons
	var updates = Librarian.check_for_updates()
	
	# Command the Curator to update the visual representation of our realm
	Curator.update_visualization()

	Chronicler.log_event("MainArchon", "periodic_check_completed", {
		"updates_found": updates
	})

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		Chronicler.log_event("MainArchon", "shutdown_initiated", {})
		# Perform any necessary cleanup here
		get_tree().quit()

# Function to adjust the realm's pulse rate dynamically
func adjust_realm_pulse_rate(new_interval: float):
	if new_interval > 0:
		$Timer.wait_time = new_interval
		Chronicler.log_event("MainArchon", "realm_pulse_rate_adjusted", {
			"new_interval_seconds": new_interval
		})
	else:
		Chronicler.log_event("MainArchon", "realm_pulse_rate_adjustment_failed", {
			"reason": "invalid_interval",
			"attempted_interval": new_interval
		})

func _unhandled_input(event):
	if event.is_action_pressed("summon_chronicle_viewer"):
		Curator.summon_chronicle_viewer()
