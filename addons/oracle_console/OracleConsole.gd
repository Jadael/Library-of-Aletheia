@tool
extends Control

@export_multiline var about = """
I am the Oracle Console, a mystical interface for direct communion with the Language Model entity.

My responsibilities include:
1. Providing a user-friendly interface for text generation experiments
2. Managing the underlying GDLlama node for LLM operations
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

@export_file("*.gguf") var llm_model_path: String = "res://models/llm_model.gguf"
@export var context_size: int = 2048
@export var max_generation_tokens: int = 256

var llm_node: GDLlama

# Queue for managing generation tasks
var task_queue = []
var is_processing = false

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
	# Create and configure the GDLlama node
	llm_node = GDLlama.new()
	llm_node.model_path = llm_model_path
	llm_node.should_output_prompt = false
	llm_node.set_n_ctx(context_size)
	llm_node.n_predict = max_generation_tokens
	add_child(llm_node)
	
	# Connect LLM signals
	llm_node.generate_text_finished.connect(_on_generate_text_finished)
	llm_node.generate_text_updated.connect(_on_generate_text_updated)
	
	# Test LLM connection
	_test_llm_connection()

func _test_llm_connection():
	# Generate a test message to ensure the LLM is working
	_add_task("### INSTRUCTION:\nProvide a brief greeting as the Oracle:\n### RESPONSE:\n", "test_greeting")
	_process_next_task()

func _on_generate_pressed():
	_process_input()

func _on_input_submitted(_text: String):
	_process_input()

func _on_stop_pressed():
	llm_node.stop_generate_text()
	_update_ui_state()
	_set_status("Text generation stopped.")

func _on_clear_pressed():
	output_box.clear()
	_update_ui_state()
	_set_status("Output cleared.")

func _process_input():
	var user_input = input_field.text
	#if user_input.strip_edges().is_empty():
		#_set_status("Please enter a prompt.")
		#return
	
	output_box.text += user_input
	input_field.clear()
	_add_task(output_box.text, "user_query")
	_process_next_task()

func _add_task(prompt: String, task_id: String):
	# Add a new task to the queue
	task_queue.append({"id": task_id, "prompt": prompt})
	_set_status("Task added to queue.")

func _process_next_task():
	if task_queue.is_empty() or is_processing:
		return

	is_processing = true
	var task = task_queue.pop_front()
	
	var error = llm_node.run_generate_text(task["prompt"], "", "")
	if error != OK:
		_set_status("Error: Failed to start text generation.")
		is_processing = false
		_process_next_task()
	else:
		_update_ui_state()
		_set_status("Generating text...")

func _on_generate_text_updated(response: String):
	# Clear selection in case the user had selected text
	output_box.deselect()
	# Ensure the caret is at the end of the text
	output_box.set_caret_line(output_box.get_line_count() - 1)
	output_box.set_caret_column(output_box.get_line(output_box.get_line_count() - 1).length())
	# Insert the new text at the caret position
	output_box.insert_text_at_caret(response)

func _on_generate_text_finished(_full_response: String):
	is_processing = false
	_update_ui_state()
	_set_status("Text generation completed.")
	_process_next_task()  # Process next task if any

func _update_ui_state():
	# Update UI elements based on the current state
	var is_running = llm_node.is_running()
	stop_button.disabled = not is_running
	generate_button.disabled = is_running
	input_field.editable = not is_running

func _set_status(message: String):
	# Update the status label with the given message
	status_label.text = message

# Helper function to handle errors and provide user feedback
func _handle_error(error_message: String):
	_set_status("Error: " + error_message)
	print("Oracle Console Error: " + error_message)

# TODO: Consider implementing the following enhancements:
# - Add options for adjusting LLM parameters (temperature, top_k, top_p)
# - Implement a way to save and load conversation history
# - Create a system for managing multiple LLM models
# - Add support for different output formats (e.g., JSON, markdown)
