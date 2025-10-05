## OllamaClient - HTTP Client for Ollama API
##
## Provides a clean HTTP interface for communicating with Ollama's localhost API.
## Used by Shoggoth daemon to abstract away backend implementation details.
##
## Responsibilities:
## 1. Managing HTTP requests to Ollama's /api/generate endpoint
## 2. Handling JSON request/response serialization
## 3. Emitting signals for generation lifecycle (started, finished, failed)
## 4. Configurable model, temperature, and host settings
##
## Default Configuration:
## - Host: http://localhost:11434
## - Model: mistral-small:24b
## - Temperature: 0.7
## - Streaming: Currently disabled (may be added later)
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

func set_model(new_model: String) -> void:
	model_name = new_model
	Chronicler.log_event(self, "model_changed", {"model": model_name})

func set_temperature(new_temp: float) -> void:
	temperature = new_temp

func set_host(new_host: String) -> void:
	ollama_host = new_host

func generate(prompt: String, options: Dictionary = {}) -> void:
	if is_generating:
		Chronicler.log_event(self, "generation_already_running", {})
		return

	is_generating = true
	current_response = ""
	generate_started.emit()

	var body = {
		"model": model_name,
		"prompt": prompt,
		"stream": false,  # We'll use non-streaming for simplicity
		"options": {}
	}

	# Apply options
	if options.has("temperature"):
		body["options"]["temperature"] = options["temperature"]
	elif temperature != 0.7:
		body["options"]["temperature"] = temperature

	if options.has("num_predict"):
		body["options"]["num_predict"] = options["num_predict"]

	if options.has("stop"):
		body["options"]["stop"] = options["stop"]

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
		generate_failed.emit(error_msg + " - " + body_text)
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

	if response_data.has("response"):
		current_response = response_data["response"]
		Chronicler.log_event(self, "generate_completed", {
			"response_length": current_response.length(),
			"model": response_data.get("model", "unknown")
		})
		generate_finished.emit(current_response)
	else:
		var error_msg = "No 'response' field in Ollama API response"
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
