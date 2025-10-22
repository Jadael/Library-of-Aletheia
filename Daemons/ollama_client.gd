## OllamaClient - HTTP Client for Ollama API
##
## Provides a clean HTTP interface for communicating with Ollama's localhost API.
## Used by Shoggoth daemon to abstract away backend implementation details.
##
## Responsibilities:
## 1. Managing HTTP requests to Ollama's /api/generate and /api/chat endpoints
## 2. Handling JSON request/response serialization
## 3. Emitting signals for generation lifecycle (started, finished, failed)
## 4. Supporting all Ollama API parameters dynamically
## 5. Providing both text completion and chat modes
##
## Default Configuration:
## - Host: http://localhost:11434
## - Model: mistral-small:24b
## - Temperature: 0.7
## - Streaming: Currently disabled (may be added later)
##
## Supported Ollama Parameters:
## - temperature, num_predict, top_k, top_p, min_p, repeat_penalty,
## - repeat_last_n, seed, num_ctx, stop, system, template, format,
## - suffix, raw, keep_alive, and more
##
## Note: This is a backend implementation detail. Most code should interact
## with Shoggoth daemon instead of using this directly.
extends Node

signal generate_started()
signal generate_updated(delta: String)
signal generate_finished(full_response: String)
signal generate_failed(error: String)

const DEFAULT_HOST = "http://localhost:11434"

var http_request: HTTPRequest
var ollama_host: String = DEFAULT_HOST
var model_name: String = "mistral-small:24b"
var temperature: float = 0.7
var current_response: String = ""
var is_generating: bool = false

func _ready() -> void:
	http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(_on_request_completed)
	# Set generous timeout for local LLM inference (3 minutes)
	# Local GPU inference can take 6-90+ seconds even on high-end hardware
	http_request.timeout = 180.0

func set_model(new_model: String) -> void:
	model_name = new_model
	Chronicler.log_event(self, "model_changed", {"model": model_name})

func set_temperature(new_temp: float) -> void:
	temperature = new_temp

func set_host(new_host: String) -> void:
	ollama_host = new_host

## Generate text using /api/generate endpoint (text completion mode)
## If streaming is enabled, generate_updated signal will emit partial responses
func generate(prompt: String, options: Dictionary = {}, stream: bool = false) -> void:
	if is_generating:
		Chronicler.log_event(self, "generation_already_running", {})
		return

	is_generating = true
	current_response = ""
	generate_started.emit()

	var body = {
		"model": model_name,
		"prompt": prompt,
		"stream": stream,
		"options": {}
	}

	# Separate top-level parameters from model options
	const TOP_LEVEL_PARAMS = ["system", "template", "format", "suffix", "raw", "keep_alive", "images"]
	const MODEL_OPTIONS = ["temperature", "num_predict", "top_k", "top_p", "min_p",
		"repeat_penalty", "repeat_last_n", "seed", "num_ctx", "stop"]

	# Apply default temperature if not overridden
	if not options.has("temperature") and temperature != 0.7:
		body["options"]["temperature"] = temperature

	# Process all options dynamically
	for key in options:
		if key in TOP_LEVEL_PARAMS:
			body[key] = options[key]
		elif key in MODEL_OPTIONS:
			body["options"][key] = options[key]
		else:
			# Pass through unknown options to model options (future-proofing)
			body["options"][key] = options[key]

	var json_body = JSON.stringify(body)
	var headers = ["Content-Type: application/json"]

	Chronicler.log_event(self, "generate_request_started", {
		"model": model_name,
		"prompt_length": prompt.length(),
		"options": options
	})

	var error = http_request.request(
		ollama_host + "/api/generate",
		headers,
		HTTPClient.METHOD_POST,
		json_body
	)

	if error != OK:
		is_generating = false
		var error_msg = "Failed to start HTTP request: " + str(error)
		Chronicler.log_event(self, "generate_request_failed", {"error": error_msg})
		generate_failed.emit(error_msg)

## Chat mode using /api/chat endpoint with message history
func chat(messages: Array, options: Dictionary = {}) -> void:
	if is_generating:
		Chronicler.log_event(self, "generation_already_running", {})
		return

	is_generating = true
	current_response = ""
	generate_started.emit()

	var body = {
		"model": model_name,
		"messages": messages,
		"stream": false,
		"options": {}
	}

	# Separate top-level parameters from model options
	const TOP_LEVEL_PARAMS = ["format", "keep_alive", "tools"]
	const MODEL_OPTIONS = ["temperature", "num_predict", "top_k", "top_p", "min_p",
		"repeat_penalty", "repeat_last_n", "seed", "num_ctx", "stop"]

	# Apply default temperature if not overridden
	if not options.has("temperature") and temperature != 0.7:
		body["options"]["temperature"] = temperature

	# Process all options dynamically
	for key in options:
		if key in TOP_LEVEL_PARAMS:
			body[key] = options[key]
		elif key in MODEL_OPTIONS:
			body["options"][key] = options[key]
		else:
			# Pass through unknown options (future-proofing)
			body["options"][key] = options[key]

	var json_body = JSON.stringify(body)
	var headers = ["Content-Type: application/json"]

	Chronicler.log_event(self, "chat_request_started", {
		"model": model_name,
		"message_count": messages.size(),
		"options": options
	})

	var error = http_request.request(
		ollama_host + "/api/chat",
		headers,
		HTTPClient.METHOD_POST,
		json_body
	)

	if error != OK:
		is_generating = false
		var error_msg = "Failed to start HTTP request: " + str(error)
		Chronicler.log_event(self, "chat_request_failed", {"error": error_msg})
		generate_failed.emit(error_msg)

func _on_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	is_generating = false

	if result != HTTPRequest.RESULT_SUCCESS:
		var error_msg = "HTTP request failed with result: " + str(result)
		Chronicler.log_event(self, "http_request_failed", {
			"result": result,
			"response_code": response_code
		})
		generate_failed.emit(error_msg)
		return

	if response_code != 200:
		var error_msg = "Ollama API returned error code: " + str(response_code)
		var body_text = body.get_string_from_utf8()
		Chronicler.log_event(self, "ollama_api_error", {
			"response_code": response_code,
			"body": body_text
		})
		generate_failed.emit(error_msg + " - " + body_text) # ERROR: Invalid access to property or key 'id' on a base object of type 'Dictionary'.
		return

	var json_text = body.get_string_from_utf8()
	var json = JSON.new()
	var parse_result = json.parse(json_text)

	if parse_result != OK:
		var error_msg = "Failed to parse JSON response"
		Chronicler.log_event(self, "json_parse_failed", {
			"error": json.get_error_message(),
			"line": json.get_error_line()
		})
		generate_failed.emit(error_msg)
		return

	var response_data = json.get_data()

	# Handle both /api/generate (has "response") and /api/chat (has "message")
	if response_data.has("response"):
		# Generate endpoint response
		current_response = response_data["response"]
		Chronicler.log_event(self, "generate_completed", {
			"response_length": current_response.length(),
			"model": response_data.get("model", "unknown")
		})
		generate_finished.emit(current_response)
	elif response_data.has("message"):
		# Chat endpoint response
		var message = response_data["message"]
		current_response = message.get("content", "")
		Chronicler.log_event(self, "chat_completed", {
			"response_length": current_response.length(),
			"model": response_data.get("model", "unknown"),
			"role": message.get("role", "unknown")
		})
		generate_finished.emit(current_response)
	else:
		var error_msg = "No 'response' or 'message' field in Ollama API response"
		Chronicler.log_event(self, "invalid_response_format", {"response_data": response_data})
		generate_failed.emit(error_msg)

func stop_generation() -> void:
	if is_generating and http_request:
		http_request.cancel_request()
		is_generating = false
		Chronicler.log_event(self, "generation_stopped", {})

func is_running() -> bool:
	return is_generating

func get_last_response() -> String:
	return current_response
