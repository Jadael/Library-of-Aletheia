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
@onready var temperature_input: SpinBox = %TemperatureInput
@onready var max_tokens_input: SpinBox = %MaxTokensInput

# Advanced parameters
@onready var advanced_toggle: Button = %AdvancedToggle
@onready var advanced_panel: PanelContainer = %AdvancedPanel
@onready var top_k_input: SpinBox = %TopKInput
@onready var top_p_input: SpinBox = %TopPInput
@onready var min_p_input: SpinBox = %MinPInput
@onready var repeat_penalty_input: SpinBox = %RepeatPenaltyInput
@onready var repeat_last_n_input: SpinBox = %RepeatLastNInput
@onready var num_ctx_input: SpinBox = %NumCtxInput
@onready var seed_input: SpinBox = %SeedInput

var config: ConfigFile

func _ready():
	config = ConfigFile.new()
	var err = config.load(Shoggoth.CONFIG_FILE)
	if err != OK:
		Chronicler.log_event(self, "config_load_failed", {"error": err})
		# Config doesn't exist yet - create default values
		_create_default_config()

	apply_button.pressed.connect(_on_apply_button_pressed)
	advanced_toggle.pressed.connect(_on_advanced_toggle_pressed)

	Shoggoth.models_initialized.connect(_on_models_initialized_after_apply)

	_load_current_settings()
	_update_status_display("Initializing...", false)

func _create_default_config():
	## Create default configuration if config file doesn't exist
	config.set_value("ollama", "host", "http://localhost:11434")
	config.set_value("ollama", "model", "mistral-small:24b")
	config.set_value("ollama", "temperature", 0.7)
	config.set_value("ollama", "max_tokens", 2048)
	config.set_value("ollama", "stop_tokens", [])
	config.set_value("ollama", "top_k", 40)
	config.set_value("ollama", "top_p", 0.9)
	config.set_value("ollama", "min_p", 0.0)
	config.set_value("ollama", "repeat_penalty", 1.1)
	config.set_value("ollama", "repeat_last_n", 64)
	config.set_value("ollama", "num_ctx", 4096)
	config.set_value("ollama", "seed", 0)
	config.save(Shoggoth.CONFIG_FILE)
	Chronicler.log_event(self, "default_config_created", {})

func _on_advanced_toggle_pressed():
	advanced_panel.visible = not advanced_panel.visible
	advanced_toggle.text = "⚙️ Advanced Parameters " + ("▼" if advanced_panel.visible else "▶")

func _load_current_settings():
	model_name_input.text = config.get_value("ollama", "model", "mistral-small:24b")
	ollama_host_input.text = config.get_value("ollama", "host", "http://localhost:11434")
	temperature_input.value = config.get_value("ollama", "temperature", 0.7)
	max_tokens_input.value = config.get_value("ollama", "max_tokens", 2048)

	var stop_tokens = config.get_value("ollama", "stop_tokens", [])
	stop_tokens_input.text = ", ".join(stop_tokens)

	# Load advanced parameters
	top_k_input.value = config.get_value("ollama", "top_k", 40)
	top_p_input.value = config.get_value("ollama", "top_p", 0.9)
	min_p_input.value = config.get_value("ollama", "min_p", 0.0)
	repeat_penalty_input.value = config.get_value("ollama", "repeat_penalty", 1.1)
	repeat_last_n_input.value = config.get_value("ollama", "repeat_last_n", 64)
	num_ctx_input.value = config.get_value("ollama", "num_ctx", 4096)
	seed_input.value = config.get_value("ollama", "seed", 0)

func _on_apply_button_pressed():
	var new_model = model_name_input.text
	var new_host = ollama_host_input.text
	var new_temperature = temperature_input.value
	var new_max_tokens = int(max_tokens_input.value)

	config.set_value("ollama", "model", new_model)
	config.set_value("ollama", "host", new_host)
	config.set_value("ollama", "temperature", new_temperature)
	config.set_value("ollama", "max_tokens", new_max_tokens)

	var stop_tokens_raw = stop_tokens_input.text.split(",")
	var stop_tokens = []
	for token in stop_tokens_raw:
		var cleaned_token = token.strip_edges()
		if not cleaned_token.is_empty():
			stop_tokens.append(cleaned_token)

	config.set_value("ollama", "stop_tokens", stop_tokens)

	# Save advanced parameters
	config.set_value("ollama", "top_k", int(top_k_input.value))
	config.set_value("ollama", "top_p", top_p_input.value)
	config.set_value("ollama", "min_p", min_p_input.value)
	config.set_value("ollama", "repeat_penalty", repeat_penalty_input.value)
	config.set_value("ollama", "repeat_last_n", int(repeat_last_n_input.value))
	config.set_value("ollama", "num_ctx", int(num_ctx_input.value))
	config.set_value("ollama", "seed", int(seed_input.value))

	config.save(Shoggoth.CONFIG_FILE)

	_update_status_display("Applying changes...", false)
	apply_button.disabled = true

	Shoggoth.set_model(new_model)
	Shoggoth.set_stop_tokens(stop_tokens)

	Chronicler.log_event(self, "ai_settings_updated", {
		"new_model": new_model,
		"new_host": new_host,
		"temperature": new_temperature,
		"max_tokens": new_max_tokens,
		"stop_tokens": stop_tokens,
		"top_k": int(top_k_input.value),
		"top_p": top_p_input.value,
		"min_p": min_p_input.value,
		"repeat_penalty": repeat_penalty_input.value,
		"repeat_last_n": int(repeat_last_n_input.value),
		"num_ctx": int(num_ctx_input.value),
		"seed": int(seed_input.value)
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
