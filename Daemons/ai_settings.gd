# A COMPUTER CAN NEVER BE HELD ACCOUNTABLE
# THEREFORE A COMPUTER MUST NEVER MAKE A MANAGEMENT DECISION

# ai_settings.gd
extends Window
const NAME = "👁‍🗨 AI Settings"
@export_multiline var about = """
I am the AI Settings daemon, the mystical interface between mortal users and 
the eldritch configurations of our AI models. My purpose is to facilitate the 
harmonious integration of artificial intelligence into our library realm.

My responsibilities include:
1. Providing an intuitive interface for users to view and update AI model paths
2. Communicating with Shoggoth to reflect and apply changes in AI configurations
3. Displaying the current status of our AI models
4. Offering guidance on model selection and configuration
5. Managing stop tokens for text generation tasks

Through my efforts, I ensure that the cosmic forces of artificial intelligence 
are properly channeled and accessible within our mystical library.
"""

@onready var llm_path_input: LineEdit = %LLMPathInput
@onready var status_label: Label = %StatusLabel
@onready var apply_button: Button = %ApplyButton
@onready var llm_file_dialog: FileDialog = %LLMFileDialog
@onready var stop_tokens_input: LineEdit = %StopTokensInput

var config: ConfigFile

func _ready():
	config = ConfigFile.new()
	var err = config.load(Shoggoth.CONFIG_FILE)
	if err != OK:
		Chronicler.log_event(self, "config_load_failed", {"error": err})
	
	apply_button.pressed.connect(_on_apply_button_pressed)
	%LLMBrowseButton.pressed.connect(_on_llm_browse_button_pressed)
	llm_file_dialog.file_selected.connect(_on_llm_file_selected)
	
	Shoggoth.models_initialized.connect(_on_models_initialized_after_apply)

	_load_current_settings()
	_update_status_display("Initializing...", false)

func _load_current_settings():
	llm_path_input.text = config.get_value("models", "llm_path", "")
	
	var stop_tokens = config.get_value("llm", "stop_tokens", [])
	stop_tokens_input.text = ", ".join(stop_tokens)

func _on_apply_button_pressed():
	var new_llm_path = llm_path_input.text
	
	config.set_value("models", "llm_path", new_llm_path)
	
	var stop_tokens_raw = stop_tokens_input.text.split(",")
	var stop_tokens = []
	for token in stop_tokens_raw:
		var cleaned_token = token.strip_edges()
		if not cleaned_token.is_empty():
			stop_tokens.append(cleaned_token)
	
	config.set_value("llm", "stop_tokens", stop_tokens)
	
	config.save(Shoggoth.CONFIG_FILE)
	
	_update_status_display("Applying changes...", false)
	apply_button.disabled = true
	
	Shoggoth.set_model_paths(new_llm_path)
	Shoggoth.set_stop_tokens(stop_tokens)
	
	Chronicler.log_event(self, "ai_settings_updated", {
		"new_llm_path": new_llm_path,
		"stop_tokens": stop_tokens
	})

func _on_llm_browse_button_pressed():
	llm_file_dialog.popup_centered(Vector2(800, 600))

func _on_llm_file_selected(path):
	llm_path_input.text = path

func _on_models_initialized_after_apply(llm_success: bool):
	_update_status_display("Models initialized.", llm_success)
	apply_button.disabled = false

func _update_status_display(message: String, llm_success: bool):
	var status_text = message + "\n\n"
	status_text += "AI Model Status:\n"
	status_text += "LLM Model: " + ("✅ Loaded and responsive" if llm_success else "❌ Not loaded or unresponsive") + "\n"
	
	if llm_success:
		status_text += "\n\nAI features are available and functioning."
	else:
		status_text += "\n\nAI features are currently unavailable. Please check your model path and system resources."
	
	status_label.text = status_text

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		hide()  # Instead of closing, we just hide the window
		Chronicler.log_event(self, "ai_settings_window_hidden", {})
