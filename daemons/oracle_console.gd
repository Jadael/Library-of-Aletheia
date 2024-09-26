# A COMPUTER CAN NEVER BE HELD ACCOUNTABLE
# THEREFORE A COMPUTER MUST NEVER MAKE A MANAGEMENT DECISION
extends Window

const NAME = "🔮 Oracle Console"
@export_multiline var about = """
I am the Oracle Console, a mystical scratchpad for raw text completion experiments.

My responsibilities include:
1. Providing a user-friendly interface for text completion experiments
2. Managing text generation requests through Shoggoth
3. Displaying the input text and generated completions in a single, scrollable view
4. Offering controls for text generation, including generating and stopping
5. Providing feedback on the current state of text generation

I serve as a conduit between the mortal realm and the vast knowledge of the Language Model,
utilizing Shoggoth's services to channel the cosmic whispers of artificial intelligence.
"""

@onready var text_edit: TextEdit = %TextEdit
@onready var generate_button: Button = %GenerateButton
@onready var stop_button: Button = %StopButton
@onready var status_label: Label = %StatusLabel

var current_task_id: String = ""
var is_generating: bool = false

func _ready():
	_setup_ui_connections()

func _setup_ui_connections():
	generate_button.pressed.connect(_on_generate_pressed)
	stop_button.pressed.connect(_on_stop_pressed)
	Shoggoth.task_completed.connect(_on_task_completed)
	Shoggoth.task_failed.connect(_on_task_failed)

func _on_generate_pressed():
	if text_edit.text.strip_edges().is_empty():
		_set_status("Please enter some text to complete.")
		return
	
	_generate_text(text_edit.text)

func _on_stop_pressed():
	if current_task_id:
		Shoggoth.cancel_task(current_task_id)
		_set_status("Text generation stopped.")
	_update_ui_state(false)

func _generate_text(prompt: String):
	current_task_id = Shoggoth.submit_task(prompt, {"max_length": 150})
	is_generating = true
	_update_ui_state(true)
	_set_status("Generating text...")

func _on_task_completed(task_id: String, result: String):
	if task_id == current_task_id:
		text_edit.text += result
		text_edit.scroll_vertical = text_edit.get_line_count()  # Scroll to the bottom
		_set_status("Text generation completed.")
		is_generating = false
		current_task_id = ""
		_update_ui_state(false)

func _on_task_failed(task_id: String, error: String):
	if task_id == current_task_id:
		_set_status("Error: " + error)
		is_generating = false
		current_task_id = ""
		_update_ui_state(false)

func _update_ui_state(is_running: bool):
	stop_button.disabled = not is_running
	generate_button.disabled = is_running
	text_edit.editable = not is_running

func _set_status(message: String):
	status_label.text = message

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		hide()
		Chronicler.log_event(self, "oracle_console_closed", {})

# TODO: Consider implementing the following enhancements:
# - Add options for adjusting generation parameters (max_length, temperature, etc.)
# - Implement a way to save and load text content
# - Add support for syntax highlighting or formatting of generated text
# - Integrate with the SymbolSage for emoji suggestions based on generated text
