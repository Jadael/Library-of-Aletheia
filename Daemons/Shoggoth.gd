# A COMPUTER CAN NEVER BE HELD ACCOUNTABLE
# THEREFORE A COMPUTER MUST NEVER MAKE A MANAGEMENT DECISION
# shoggoth.gd
extends Node
# Owner: Main / Autoload Singleton Daemon a.k.a. "Archon"

## Shoggoth: Archon of AI Task Management and Backend Abstraction
##
## Shoggoth serves as the central coordinator for AI-related tasks within our mystical realm.
## It provides a clean, transparent API abstraction for LLM compute, handling all backend
## complexity so that users, daemons, and code can access "raw LLM compute" without worrying
## about implementation details.
##
## Responsibilities:
## 1. Managing and queueing AI task execution for orderly processing
## 2. Providing a simplified interface for other daemons to request AI services
## 3. Handling HTTP communication with Ollama API (localhost:11434)
## 4. Managing configuration (model selection, host, temperature, etc.)
## 5. Emitting signals to inform other entities about the status of AI operations
##
## Current Backend: Ollama API via ollama_client.gd
## Default Model: mistral-small:24b
##
## Shoggoth is the guardian between mortal code and eldritch machine learning,
## ensuring that the cosmic energies of AI are channeled safely and efficiently.

signal task_completed(task_id: String, result: String)
signal task_failed(task_id: String, error: String)
signal models_initialized(llm_success: bool)

const CONFIG_FILE = "user://shoggoth_config.cfg"
const INIT_TEST_PROMPT = "Say hello!"
const MAX_RETRIES = 3
const RETRY_DELAY = 1.0  # seconds

var ollama_client: Node  # OllamaClient
var task_queue: Array[Dictionary] = []
var current_task: Dictionary = {}
var is_processing: bool = false
var is_initializing: bool = false
var config: ConfigFile
var retry_count: int = 0

const NAME = "👾 Shoggoth"
@export_multiline var about = """
I am Shoggoth, the Archon of AI Task Management and Backend Abstraction.

My sacred duties include:
1. Providing transparent "raw LLM compute" access via clean API abstraction
2. Managing HTTP communication with Ollama API (localhost:11434)
3. Handling task queuing for orderly AI operation processing
4. Managing configuration (model selection, host URL, temperature, stop tokens)
5. Abstracting away all backend complexity from users and daemons

Current Backend: Ollama API
Default Model: mistral-small:24b
Communication: HTTP via ollama_client.gd

I stand as the guardian between the realms of mortal code and eldritch machine learning,
ensuring that the cosmic energies of AI are channeled safely and efficiently throughout our digital domain.
"""

func _ready() -> void:
	Chronicler.log_event(self, "initialization_started", {})
	_load_or_create_config()
	_setup_ollama_client()
	call_deferred("_initialize_models")
	Chronicler.log_event(self, "initialization_completed", {})

func _load_or_create_config() -> void:
	config = ConfigFile.new()
	var err = config.load(CONFIG_FILE)
	if err != OK:
		Chronicler.log_event(self, "config_load_failed", {"error": err})
		_create_default_config()

func _create_default_config() -> void:
	config.set_value("ollama", "host", "http://localhost:11434")
	config.set_value("ollama", "model", "mistral-small:24b")
	config.set_value("ollama", "temperature", 0.7)
	config.set_value("ollama", "max_tokens", 2048)
	config.save(CONFIG_FILE)
	Chronicler.log_event(self, "default_config_created", {})

func _setup_ollama_client() -> void:
	var ollama_script = load("res://Daemons/ollama_client.gd")
	ollama_client = ollama_script.new()
	add_child(ollama_client)
	ollama_client.generate_finished.connect(_on_generate_text_finished)
	ollama_client.generate_failed.connect(_on_generate_failed)
	Chronicler.log_event(self, "ollama_client_setup_completed", {})

func _initialize_models() -> void:
	if is_initializing:
		return

	is_initializing = true
	var ollama_host = config.get_value("ollama", "host", "http://localhost:11434")
	var model_name = config.get_value("ollama", "model", "mistral-small:24b")

	_configure_ollama_client(ollama_host, model_name)
	_run_initialization_test()

func _configure_ollama_client(ollama_host: String, model_name: String) -> void:
	ollama_client.set_host(ollama_host)
	ollama_client.set_model(model_name)
	var temperature = config.get_value("ollama", "temperature", 0.7)
	ollama_client.set_temperature(temperature)
	Chronicler.log_event(self, "ollama_client_configured", {
		"host": ollama_host,
		"model": model_name,
		"temperature": temperature
	})

func _run_initialization_test() -> void:
	submit_task(INIT_TEST_PROMPT, {"is_init_test": true, "max_length": 32, "temperature": 0.0})
	Chronicler.log_event(self, "initialization_test_started", {})

func _on_init_test_completed(result: String) -> void:
	var llm_success = result.strip_edges() != ""
	models_initialized.emit(llm_success)

	Chronicler.log_event(self, "models_initialized", {
		"llm_success": llm_success,
		"model": config.get_value("ollama", "model", "unknown"),
		"init_test_prompt": INIT_TEST_PROMPT,
		"init_test_result": result
	})

	is_initializing = false

func set_model(model_name: String) -> void:
	config.set_value("ollama", "model", model_name)
	config.save(CONFIG_FILE)
	call_deferred("_initialize_models")
	Chronicler.log_event(self, "model_updated", {"new_model": model_name})

func set_stop_tokens(tokens: Array) -> void:
	config.set_value("ollama", "stop_tokens", tokens)
	config.save(CONFIG_FILE)
	Chronicler.log_event(self, "stop_tokens_updated", {"tokens": tokens})

func submit_task(prompt: String, parameters: Dictionary = {}) -> String:
	var task_id = str(Time.get_unix_time_from_system()) + "_" + str(randi())
	var task = {
		"id": task_id,
		"prompt": prompt,
		"parameters": parameters
	}
	task_queue.append(task)
	
	Chronicler.log_event(self, "task_submitted", {
		"task_id": task_id,
		"prompt_length": prompt.length(),
		"prompt": prompt,
		"parameters": parameters
	})
	
	if not is_processing:
		_process_next_task()
	
	return task_id

func _process_next_task() -> void:
	if task_queue.is_empty():
		is_processing = false
		current_task = {}
		return
	
	is_processing = true
	current_task = task_queue.pop_front()
	retry_count = 0

	var options = _apply_task_parameters()
	_execute_current_task(options)

func _apply_task_parameters() -> Dictionary:
	var options = {}

	# Get default stop tokens from config
	var stop_tokens = config.get_value("ollama", "stop_tokens", [])

	for key in current_task["parameters"]:
		match key:
			"stop_tokens":
				stop_tokens = current_task["parameters"][key]
			"max_length":
				options["num_predict"] = current_task["parameters"][key]
			"temperature":
				options["temperature"] = current_task["parameters"][key]
			_:
				# Pass through other options to Ollama
				options[key] = current_task["parameters"][key]

	if stop_tokens.size() > 0:
		options["stop"] = stop_tokens

	Chronicler.log_event(self, "task_parameters_applied", {
		"task_id": current_task["id"],
		"options": options
	})

	return options

func _execute_current_task(options: Dictionary) -> void:
	var prompt = current_task["prompt"]
	ollama_client.generate(prompt, options)

func _handle_task_error(error_message: String) -> void:
	Chronicler.log_event(self, "task_execution_failed", {
		"task_id": current_task["id"],
		"error": error_message,
		"retry_count": retry_count
	})
	
	if retry_count < MAX_RETRIES:
		retry_count += 1
		Chronicler.log_event(self, "task_retry_scheduled", {
			"task_id": current_task["id"],
			"retry_count": retry_count
		})
		get_tree().create_timer(RETRY_DELAY).timeout.connect(_retry_current_task)
	else:
		task_failed.emit(current_task["id"], error_message)
		current_task = {}
		_process_next_task()

func _retry_current_task() -> void:
	Chronicler.log_event(self, "task_retry_started", {
		"task_id": current_task["id"],
		"retry_count": retry_count
	})
	var options = _apply_task_parameters()
	_execute_current_task(options)

func _on_generate_failed(error: String) -> void:
	_handle_task_error("Ollama generation failed: " + error)

func _on_generate_text_finished(result: String) -> void:
	if current_task.is_empty():
		Chronicler.log_event(self, "unexpected_task_completion", {
			"result_length": result.length(),
			"result": result
		})
		return
	
	result = _process_result(result)
	
	if current_task["parameters"].get("is_init_test", false):
		_on_init_test_completed(result)
	else:
		_emit_task_completion(result)
	
	current_task = {}
	_process_next_task()

func _process_result(result: String) -> String:
	# Ollama handles stop tokens internally, but we can do post-processing here if needed
	var stop_tokens = config.get_value("ollama", "stop_tokens", [])
	for token in stop_tokens:
		var split_result = result.split(token)
		if split_result.size() > 1:
			result = split_result[0]
			break
	return result

func _emit_task_completion(result: String) -> void:
	Chronicler.log_event(self, "task_completed", {
		"task_id": current_task["id"],
		"result_length": result.length(),
		"result": result
	})
	task_completed.emit(current_task["id"], result)

func cancel_task(task_id: String) -> bool:
	for i in range(task_queue.size()):
		if task_queue[i]["id"] == task_id:
			task_queue.remove_at(i)
			Chronicler.log_event(self, "task_cancelled", {"task_id": task_id})
			return true

	if is_processing and current_task.get("id") == task_id:
		ollama_client.stop_generation()
		current_task = {}
		is_processing = false
		Chronicler.log_event(self, "running_task_stopped", {"task_id": task_id})
		_process_next_task()
		return true

	return false

func get_queue_length() -> int:
	return task_queue.size() + (1 if not current_task.is_empty() else 0)

func is_busy() -> bool:
	return is_processing or not task_queue.is_empty()

# TODO: Add support for streaming responses from Ollama
# TODO: Add support for different types of AI tasks (e.g., embeddings via Ollama)
# TODO: Develop a more sophisticated task prioritization system
# TODO: Consider implementing backend switching (Ollama, OpenAI-compatible APIs, etc.)
