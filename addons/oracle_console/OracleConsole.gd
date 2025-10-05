@tool
extends Control

@export_multiline var about = """
I am the Oracle Console, a mystical interface for direct communion with the Language Model entity.

My responsibilities include:
1. Providing a user-friendly interface for text generation experiments
2. Using the Shoggoth daemon for LLM operations (via Ollama)
3. Handling user input and displaying generated text
4. Offering controls for text generation, including stopping and clearing
5. Providing feedback on the current state of text generation

I serve as a conduit between the mortal realm and the vast knowledge of the Language Model.
"""

@onready var input_field: LineEdit = %InputField
@onready var output_box: TextEdit = %OutputBox
@onready var generate_button: Button = %GenerateButton
@onready var stop_button: Button = %StopButton
@onready var clear_button: Button = %ClearButton
@onready var status_label: Label = %StatusLabel

@export var max_generation_tokens: int = 256

var current_task_id: String = ""

func _ready():
	_setup_ui_connections()
	_initialize_llm()

func _setup_ui_connections():
	# Connect UI element signals to their respective functions
	generate_button.pressed.connect(_on_generate_pressed)
	stop_button.pressed.connect(_on_stop_pressed)
	clear_button.pressed.connect(_on_clear_pressed)
	input_field.text_submitted.connect(_on_input_submitted)

func _initialize_llm():
	# Connect to Shoggoth signals
	if Shoggoth:
		Shoggoth.task_completed.connect(_on_task_completed)
		Shoggoth.task_failed.connect(_on_task_failed)
		Shoggoth.models_initialized.connect(_on_models_initialized)
		_set_status("Waiting for Shoggoth initialization...")
	else:
		_set_status("Error: Shoggoth not available")

func _on_models_initialized(success: bool):
	if success:
		_set_status("LLM initialized successfully. Ready to generate text.")
	else:
		_set_status("Error: LLM initialization failed. Check Ollama connection.")

func _on_generate_pressed():
	_process_input()

func _on_input_submitted(_text: String):
	_process_input()

func _on_stop_pressed():
	if current_task_id != "":
		Shoggoth.cancel_task(current_task_id)
		current_task_id = ""
	_update_ui_state()
	_set_status("Text generation stopped.")

func _on_clear_pressed():
	output_box.clear()
	_update_ui_state()
	_set_status("Output cleared.")

func _process_input():
	var user_input = input_field.text
	if user_input.strip_edges().is_empty():
		return

	output_box.text += user_input + "\n"
	input_field.clear()

	# Submit to Shoggoth
	var parameters = {"max_length": max_generation_tokens}
	current_task_id = Shoggoth.submit_task(output_box.text, parameters)
	_update_ui_state()
	_set_status("Generating text...")

func _on_task_completed(task_id: String, result: String):
	if task_id == current_task_id:
		# Append the result to output
		output_box.text += result
		current_task_id = ""
		_update_ui_state()
		_set_status("Text generation completed.")

func _on_task_failed(task_id: String, error: String):
	if task_id == current_task_id:
		_set_status("Error: " + error)
		current_task_id = ""
		_update_ui_state()

func _update_ui_state():
	# Update UI elements based on the current state
	var is_running = current_task_id != ""
	stop_button.disabled = not is_running
	generate_button.disabled = is_running
	input_field.editable = not is_running

func _set_status(message: String):
	# Update the status label with the given message
	status_label.text = message

# TODO: Consider implementing the following enhancements:
# - Add options for adjusting LLM parameters (temperature, top_k, top_p)
# - Implement a way to save and load conversation history
# - Create a system for managing multiple LLM models
# - Add support for different output formats (e.g., JSON, markdown)
