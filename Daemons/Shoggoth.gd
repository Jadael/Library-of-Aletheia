# A COMPUTER CAN NEVER BE HELD ACCOUNTABLE
# THEREFORE A COMPUTER MUST NEVER MAKE A MANAGEMENT DECISION
# shoggoth.gd
extends Node
# Owner: Main / Autoload Singleton Daemon a.k.a. "Archon"

## Shoggoth: Archon of AI Task Management and VRAM Safety
##
## Shoggoth serves as the central coordinator for AI-related tasks within our mystical realm.
## It provides a safe and efficient interface to the Godot_LLM addon, ensuring responsible use
## of GPU resources and offering a standardized way for other daemons to access AI capabilities.
##
## Responsibilities:
## 1. Managing and monitoring AI task execution to prevent VRAM overflow
## 2. Providing a queue system for AI tasks to ensure orderly processing
## 3. Offering a simplified interface for other daemons to request AI services
## 4. Handling configuration and initialization of the underlying GDLlama node
## 5. Emitting signals to inform other entities about the status of AI operations
##
## Shoggoth is the guardian of the cosmic energies that fuel our AI operations,
## ensuring that the eldritch powers of machine learning are harnessed safely and efficiently.

signal task_completed(task_id: String, result: String)
signal task_failed(task_id: String, error: String)
signal models_initialized(llm_success: bool)

const CONFIG_FILE = "user://shoggoth_config.cfg"
const INIT_TEST_PROMPT = "### Instruction:\nSay hello!\n### Response:\n"
const MAX_RETRIES = 3
const RETRY_DELAY = 1.0  # seconds

var gdllama: GDLlama
var task_queue: Array[Dictionary] = []
var current_task: Dictionary = {}
var is_processing: bool = false
var is_initializing: bool = false
var config: ConfigFile
var retry_count: int = 0

const NAME = "👾 Shoggoth"
@export_multiline var about = """
I am Shoggoth, the Archon of AI Task Management and VRAM Safety.

My sacred duties include:
1. Coordinating and executing AI tasks while preventing VRAM overflow (GDLlama has no internal VRAM overflow safeguards)
2. Providing a standardized interface for other daemons to access AI capabilities
3. Managing the configuration and initialization of our GDLlama node
4. Ensuring the responsible use of our mystical GPU resources
5. Maintaining a queue of AI tasks for orderly processing

I stand as the guardian between the realms of mortal code and eldritch machine learning,
ensuring that the cosmic energies of AI are channeled safely and efficiently throughout our digital domain.
"""

func _ready() -> void:
	Chronicler.log_event(self, "initialization_started", {})
	_load_or_create_config()
	_setup_gdllama()
	call_deferred("_initialize_models")
	Chronicler.log_event(self, "initialization_completed", {})

func _load_or_create_config() -> void:
	config = ConfigFile.new()
	var err = config.load(CONFIG_FILE)
	if err != OK:
		Chronicler.log_event(self, "config_load_failed", {"error": err})
		_create_default_config()

func _create_default_config() -> void:
	config.set_value("models", "llm_path", "res://models/default_model.gguf")
	config.set_value("llm", "context_size", 2048)  # Increased from 408
	config.set_value("llm", "n_gpu_layers", -1)
	config.set_value("llm", "temperature", 0.7)
	config.save(CONFIG_FILE)
	Chronicler.log_event(self, "default_config_created", {})

func _setup_gdllama() -> void:
	gdllama = GDLlama.new()
	add_child(gdllama)
	gdllama.generate_text_finished.connect(_on_generate_text_finished)
	Chronicler.log_event(self, "gdllama_setup_completed", {})

func _initialize_models() -> void:
	if is_initializing:
		return
	
	is_initializing = true
	var llm_path = config.get_value("models", "llm_path", "")
	if llm_path.is_empty() or not FileAccess.file_exists(llm_path):
		Chronicler.log_event(self, "model_initialization_failed", {
			"reason": "Invalid or missing model path",
			"path": llm_path
		})
		models_initialized.emit(false)
		is_initializing = false
		return

	_configure_gdllama(llm_path)
	_run_initialization_test()

func _configure_gdllama(llm_path: String) -> void:
	gdllama.model_path = llm_path
	gdllama.context_size = config.get_value("llm", "context_size", 2048)
	gdllama.n_gpu_layer = config.get_value("llm", "n_gpu_layers", -1)
	gdllama.temperature = config.get_value("llm", "temperature", 0.7)
	gdllama.should_output_prompt = false
	Chronicler.log_event(self, "gdllama_configured", {
		"model_path": llm_path,
		"context_size": gdllama.context_size,
		"n_gpu_layer": gdllama.n_gpu_layer,
		"temperature": gdllama.temperature
	})

func _run_initialization_test() -> void:
	submit_task(INIT_TEST_PROMPT, {"is_init_test": true, "max_length": 32, "temperature": 0.0})
	Chronicler.log_event(self, "initialization_test_started", {})

func _on_init_test_completed(result: String) -> void:
	var llm_success = result.strip_edges() != ""
	models_initialized.emit(llm_success)
	
	Chronicler.log_event(self, "models_initialized", {
		"llm_success": llm_success,
		"llm_path": gdllama.model_path,
		"init_test_prompt": INIT_TEST_PROMPT,
		"init_test_result": result
	})
	
	is_initializing = false

func set_model_paths(llm_path: String) -> void:
	config.set_value("models", "llm_path", llm_path)
	config.save(CONFIG_FILE)
	call_deferred("_initialize_models")
	Chronicler.log_event(self, "model_path_updated", {"new_path": llm_path})

func set_stop_tokens(tokens: Array) -> void:
	config.set_value("llm", "stop_tokens", tokens)
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
	
	_apply_task_parameters()
	_execute_current_task()

func _apply_task_parameters() -> void:
	var stop_tokens = config.get_value("llm", "stop_tokens", [])
	var max_length = -1  # Default to no limit
	
	for key in current_task["parameters"]:
		match key:
			"stop_tokens":
				stop_tokens = current_task["parameters"][key]
			"max_length":
				max_length = current_task["parameters"][key]
			_:
				if gdllama.has_method("set_" + key):
					gdllama.call("set_" + key, current_task["parameters"][key])
	
	gdllama.n_predict = max_length
	Chronicler.log_event(self, "task_parameters_applied", {
		"task_id": current_task["id"],
		"max_length": max_length,
		"stop_tokens": stop_tokens
	})

func _execute_current_task() -> void:
	var prompt = current_task["prompt"]
	var error = gdllama.run_generate_text(prompt, "", "")
	
	if error != OK:
		_handle_task_error("Failed to start task execution: " + str(error))

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
	_execute_current_task()

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
	var stop_tokens = config.get_value("llm", "stop_tokens", [])
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
		gdllama.stop_generate_text()
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

# TODO: Implement methods for managing and monitoring VRAM usage
# TODO: Add support for different types of AI tasks (e.g., embeddings, image generation)
# TODO: Develop a more sophisticated task prioritization system
