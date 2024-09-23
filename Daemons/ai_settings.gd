# ai_settings.gd
extends Window

const NAME = "🧠 AI Settings"
@export_multiline var about = """
I am the AI Settings daemon, the mystical interface between mortal users and 
the eldritch configurations of our AI models. My purpose is to facilitate the 
harmonious integration of artificial intelligence into our library realm.

My responsibilities include:
1. Providing an intuitive interface for users to view and update AI model paths
2. Communicating with Shoggoth to reflect and apply changes in AI configurations
3. Displaying the current status of our AI models
4. Offering guidance on model selection and configuration

Through my efforts, I ensure that the cosmic forces of artificial intelligence 
are properly channeled and accessible within our mystical library.
"""

@onready var llm_path_input: LineEdit = %LLMPathInput
@onready var embedding_path_input: LineEdit = %EmbeddingPathInput
@onready var status_label: Label = %StatusLabel
@onready var apply_button: Button = %ApplyButton
@onready var llm_file_dialog: FileDialog = %LLMFileDialog
@onready var embedding_file_dialog: FileDialog = %EmbeddingFileDialog

func _ready():
	apply_button.pressed.connect(_on_apply_button_pressed)
	%LLMBrowseButton.pressed.connect(_on_llm_browse_button_pressed)
	%EmbeddingBrowseButton.pressed.connect(_on_embedding_browse_button_pressed)
	llm_file_dialog.file_selected.connect(_on_llm_file_selected)
	embedding_file_dialog.file_selected.connect(_on_embedding_file_selected)
	
	Shoggoth.models_initialized.connect(_update_status_display)
	
	_load_current_paths()
	_update_status_display(false, false)  # Initial status before checking

func _load_current_paths():
	var config = ConfigFile.new()
	var err = config.load(Shoggoth.CONFIG_FILE)
	if err == OK:
		llm_path_input.text = config.get_value("models", "llm_path", "")
		embedding_path_input.text = config.get_value("models", "embedding_path", "")
	else:
		Chronicler.log_event(self, "config_load_failed", {
			"error": err
		})

func _on_apply_button_pressed():
	var new_llm_path = llm_path_input.text
	var new_embedding_path = embedding_path_input.text
	
	Shoggoth.set_model_paths(new_llm_path, new_embedding_path)
	
	Chronicler.log_event(self, "ai_settings_updated", {
		"new_llm_path": new_llm_path,
		"new_embedding_path": new_embedding_path
	})

func _on_llm_browse_button_pressed():
	llm_file_dialog.popup_centered(Vector2(800, 600))

func _on_embedding_browse_button_pressed():
	embedding_file_dialog.popup_centered(Vector2(800, 600))

func _on_llm_file_selected(path):
	llm_path_input.text = path

func _on_embedding_file_selected(path):
	embedding_path_input.text = path

func _update_status_display(llm_success: bool, embedding_success: bool):
	var status_text = "AI Model Status:\n"
	status_text += "LLM Model: " + ("✅ Loaded" if llm_success else "❌ Not Loaded") + "\n"
	status_text += "Embedding Model: " + ("✅ Loaded" if embedding_success else "❌ Not Loaded")
	
	if llm_success and embedding_success:
		status_text += "\n\nAll AI features are available."
	elif not llm_success and not embedding_success:
		status_text += "\n\nAI features are currently unavailable. Please check your model paths."
	else:
		status_text += "\n\nSome AI features may be limited. Check model paths for the unavailable model."
	
	status_label.text = status_text

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		hide()  # Instead of closing, we just hide the window
		Chronicler.log_event(self, "ai_settings_window_hidden", {})
