extends Control
class_name InstanceCard

signal open_document_requested(path: String)

@onready var title_label: Label = %TitleLabel
@onready var path_label: TextEdit = %PathLabel
@onready var status_label: Label = %StatusLabel
@onready var date_label: Label = %DateLabel
@onready var hash_label: TextEdit = %HashLabel
@onready var metadata_label: TextEdit = %MetadataLabel
@onready var open_button: Button = %OpenButton

func _ready():
	open_button.pressed.connect(_on_open_button_pressed)

func setup(observation: Dictionary):
	var file_name = observation["path"].get_file()
	var status_icon = _get_status_icon(observation["status"])
	var status_text = Archivist.DocumentStatus.keys()[observation["status"]]
	var last_observed_date = Time.get_datetime_string_from_unix_time(observation["timestamp"])
	
	%TitleLabel.text = status_icon + " " + file_name
	%PathLabel.text = "Path: " + observation["path"]
	%StatusLabel.text = "Status: " + status_text
	%DateLabel.text = "Last observed: " + last_observed_date
	%HashLabel.text = "Content Hash: " + observation["content_hash"].substr(0, 8) + "..."
	
	if observation["metadata"]:
		%MetadataLabel.text = "Metadata: " + str(observation["metadata"])
		%MetadataLabel.visible = true
	else:
		%MetadataLabel.visible = false

func _get_status_icon(status: int) -> String:
	match status:
		Archivist.DocumentStatus.AVAILABLE:
			return "✔"
		Archivist.DocumentStatus.MODIFIED:
			return "➰"
		Archivist.DocumentStatus.MISSING:
			return "❌"
		Archivist.DocumentStatus.AMBIGUOUS:
			return "⚠"
		Archivist.DocumentStatus.CORRUPTED:
			return "💀"
		_:
			return "❓"

func _on_open_button_pressed():
	open_document_requested.emit(path_label.text.split(": ", true, 1)[1])
