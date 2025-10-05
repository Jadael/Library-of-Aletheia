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
1. Providing an intuitive interface for users to configure Ollama settings
2. Communicating with Shoggoth to reflect and apply changes in AI configurations
3. Displaying the current status of our AI models
4. Offering guidance on model selection and configuration
5. Managing stop tokens for text generation tasks

Through my efforts, I ensure that the cosmic forces of artificial intelligence
are properly channeled and accessible within our mystical library.
"""

@onready var model_name_input: LineEdit = %ModelNameInput
@onready var ollama_host_input: LineEdit = %OllamaHostInput
@onready var status_label: Label = %StatusLabel
@onready var apply_button: Button = %ApplyButton
@onready var stop_tokens_input: LineEdit = %StopTokensInput

var config: ConfigFile

func _ready():
	config = ConfigFile.new()
	var err = config.load(Shoggoth.CONFIG_FILE)
	if err != OK:
		Chronicler.log_event(self, "config_load_failed", {"error": err})

	apply_button.pressed.connect(_on_apply_button_pressed)

	Shoggoth.models_initialized.connect(_on_models_initialized_after_apply)

	_load_current_settings()
	_update_status_display("Initializing...", false)

func _load_current_settings():
	model_name_input.text = config.get_value("ollama", "model", "mistral-small:24b")
	ollama_host_input.text = config.get_value("ollama", "host", "http://localhost:11434")

	var stop_tokens = config.get_value("ollama", "stop_tokens", [])
	stop_tokens_input.text = ", ".join(stop_tokens)

func _on_apply_button_pressed():
	var new_model = model_name_input.text
	var new_host = ollama_host_input.text

	config.set_value("ollama", "model", new_model)
	config.set_value("ollama", "host", new_host)

	var stop_tokens_raw = stop_tokens_input.text.split(",")
	var stop_tokens = []
	for token in stop_tokens_raw:
		var cleaned_token = token.strip_edges()
		if not cleaned_token.is_empty():
			stop_tokens.append(cleaned_token)

	config.set_value("ollama", "stop_tokens", stop_tokens)

	config.save(Shoggoth.CONFIG_FILE)

	_update_status_display("Applying changes...", false)
	apply_button.disabled = true

	Shoggoth.set_model(new_model)
	Shoggoth.set_stop_tokens(stop_tokens)

	Chronicler.log_event(self, "ai_settings_updated", {
		"new_model": new_model,
		"new_host": new_host,
		"stop_tokens": stop_tokens
	})

func _on_models_initialized_after_apply(llm_success: bool):
	_update_status_display("Models initialized.", llm_success)
	apply_button.disabled = false

func _update_status_display(message: String, llm_success: bool):
	var status_text = message + "\n\n"
	status_text += "AI Model Status:\n"
	status_text += "LLM: " + ("✅ Connected and responsive" if llm_success else "⚠️ Connection test failed") + "\n"

	if llm_success:
		status_text += "\n\nAI features are available and functioning."
		status_text += "\nCurrent model: " + config.get_value("ollama", "model", "unknown")
	else:
		status_text += "\n\nConnection test did not receive a response."
		status_text += "\nPlease verify:"
		status_text += "\n• Ollama is running (http://localhost:11434)"
		status_text += "\n• Model '" + config.get_value("ollama", "model", "unknown") + "' is pulled"
		status_text += "\n• Host URL is correct"

	status_label.text = status_text

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		hide()  # Instead of closing, we just hide the window
		Chronicler.log_event(self, "ai_settings_window_hidden", {})
