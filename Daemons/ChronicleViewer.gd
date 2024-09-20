# ChronicleViewer.gd
extends Window
class_name ChronicleViewer
const NAME = "🔭 Chronicle Viewer"
# Owner: Chronicler

@export_multiline var about = """
Greetings, I am the ChronicleViewer Daemon, a mystical window into the annals of our realm's history.

My responsibilities include:
1. Displaying the sacred records kept by the Chronicler Archon
2. Providing tools for filtering and searching through the vast tapestry of events
3. Offering insights into the ebb and flow of our mystical realm's activities
4. Serving as a bridge between the Chronicler's wisdom and the mortal user's understanding
"""

@onready var log_text = %LogText
@onready var filter_input = %FilterInput
@onready var entity_filter = %EntityFilter
@onready var event_type_filter = %EventTypeFilter

var current_filter = ""
var current_entity = ""
var current_event_type = ""

var is_dragging = false
var drag_start_position = Vector2.ZERO

func _ready():
	filter_input.text_changed.connect(_on_filter_changed)
	entity_filter.item_selected.connect(_on_entity_selected)
	event_type_filter.item_selected.connect(_on_event_type_selected)
	
	# Configure TextEdit for log viewing
	log_text.syntax_highlighter = null  # Disable syntax highlighting
	log_text.wrap_mode = TextEdit.LINE_WRAPPING_BOUNDARY  # Enable word wrapping
	log_text.context_menu_enabled = false  # Disable context menu for read-only text
	log_text.editable = false  # Make it read-only
	
	_populate_filters()
	_update_log_display()

func _populate_filters():
	var entities = {}
	var event_types = {}
	for entry in Chronicler.log_data:
		entities[entry.entity] = true
		event_types[entry.event_type] = true
	
	entity_filter.add_item("All Entities")
	for entity in entities.keys():
		entity_filter.add_item(entity)
	
	event_type_filter.add_item("All Event Types")
	for event_type in event_types.keys():
		event_type_filter.add_item(event_type)

func _update_log_display():
	log_text.text = ""  # Clear the text
	var filtered_log = Chronicler.query_log(func(entry):
		var text_match = current_filter.is_empty() or current_filter.to_lower() in JSON.stringify(entry).to_lower()
		var entity_match = current_entity.is_empty() or entry.entity == current_entity
		var event_type_match = current_event_type.is_empty() or entry.event_type == current_event_type
		return text_match and entity_match and event_type_match
	)
	
	var full_log_text = ""
	for entry in filtered_log:
		var timestamp = entry.timestamp
		var formatted_time = "{year}-{month}-{day} {hour}:{minute}:{second}".format({
			"year": str(timestamp.year).pad_zeros(4),
			"month": str(timestamp.month).pad_zeros(2),
			"day": str(timestamp.day).pad_zeros(2),
			"hour": str(timestamp.hour).pad_zeros(2),
			"minute": str(timestamp.minute).pad_zeros(2),
			"second": str(timestamp.second).pad_zeros(2)
		})
		full_log_text += "%s %s: %s\n" % [formatted_time, entry.entity, entry.event_type]
		full_log_text += JSON.stringify(entry.details, "  ") + "\n\n"

	log_text.text = full_log_text
	log_text.scroll_vertical = log_text.get_line_count() - 1  # Scroll to the bottom

func _on_filter_changed(new_text):
	current_filter = new_text
	_update_log_display()

func _on_entity_selected(index):
	current_entity = entity_filter.get_item_text(index) if index > 0 else ""
	_update_log_display()

func _on_event_type_selected(index):
	current_event_type = event_type_filter.get_item_text(index) if index > 0 else ""
	_update_log_display()
