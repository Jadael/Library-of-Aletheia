# A COMPUTER CAN NEVER BE HELD ACCOUNTABLE
# THEREFORE A COMPUTER MUST NEVER MAKE A MANAGEMENT DECISION
extends Window

const NAME = "🔮 Oracle Console"
@export_multiline var about = """
I am the Oracle Console, a mystical scratchpad for raw text completion and chat experiments.

My responsibilities include:
1. Providing a user-friendly interface for text completion and chat experiments
2. Managing text generation requests through Shoggoth (both continuance and chat modes)
3. Displaying the input text and generated completions in a single, scrollable view
4. Offering controls for text generation, including generating and stopping
5. Supporting both text continuance mode and conversational chat mode
6. Providing feedback on the current state of text generation

I serve as a conduit between the mortal realm and the vast knowledge of the Language Model,
utilizing Shoggoth's services to channel the cosmic whispers of artificial intelligence.
"""

@onready var text_edit: TextEdit = %TextEdit
@onready var generate_button: Button = %GenerateButton
@onready var stop_button: Button = %StopButton
@onready var status_label: Label = %StatusLabel
@onready var continuance_mode_button: Button = %ContinuanceModeButton
@onready var chat_mode_button: Button = %ChatModeButton

var current_task_id: String = ""
var is_generating: bool = false
var chat_history: Array = []  # Array of {role: "user"|"assistant", content: "text"}

func _ready():
	_setup_ui_connections()

func _setup_ui_connections():
	generate_button.pressed.connect(_on_generate_pressed)
	stop_button.pressed.connect(_on_stop_pressed)
	continuance_mode_button.pressed.connect(_on_mode_changed)
	chat_mode_button.pressed.connect(_on_mode_changed)
	Shoggoth.task_completed.connect(_on_task_completed)
	Shoggoth.task_failed.connect(_on_task_failed)

func _on_mode_changed():
	if chat_mode_button.button_pressed:
		_set_status("Chat mode enabled. Type your message and press Generate.")
	else:
		_set_status("Text continuance mode enabled. Type text and press Generate to continue it.")
		chat_history.clear()

func _is_chat_mode() -> bool:
	return chat_mode_button.button_pressed

func _on_generate_pressed():
	if text_edit.text.strip_edges().is_empty():
		_set_status("Please enter some text.")
		return

	if _is_chat_mode():
		_generate_chat()
	else:
		_generate_continuance()

func _on_stop_pressed():
	if current_task_id:
		Shoggoth.cancel_task(current_task_id)
		_set_status("Generation stopped.")
	_update_ui_state(false)

func _generate_continuance():
	current_task_id = Shoggoth.submit_task(text_edit.text, {"num_predict": 150})
	is_generating = true
	_update_ui_state(true)
	_set_status("Generating text continuation...")

func _generate_chat():
	# Extract the last user input (everything after the last assistant response)
	var user_input = text_edit.text.strip_edges()

	# Build message history
	var messages = chat_history.duplicate()
	messages.append({"role": "user", "content": user_input})

	current_task_id = Shoggoth.submit_chat(messages, {"num_predict": 500})
	is_generating = true
	_update_ui_state(true)
	_set_status("Generating chat response...")

func _on_task_completed(task_id: String, result: String):
	if task_id == current_task_id:
		if _is_chat_mode():
			# In chat mode, format as a conversation
			var user_input = text_edit.text.strip_edges()
			chat_history.append({"role": "user", "content": user_input})
			chat_history.append({"role": "assistant", "content": result})

			text_edit.text = ""
			text_edit.text += "\n\n---\n\n"
			text_edit.text += "Assistant: " + result
			text_edit.placeholder_text = "Type your next message..."
			_set_status("Chat response received. Type your next message.")
		else:
			# In continuance mode, just append
			text_edit.text += result
			_set_status("Text generation completed.")

		text_edit.scroll_vertical = text_edit.get_line_count()
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
# - Implement a way to save and load text content or chat history
# - Add support for syntax highlighting or formatting of generated text
# - Add system message configuration for chat mode
# - Display full chat history in a more structured format
