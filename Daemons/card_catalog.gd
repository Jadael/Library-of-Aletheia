# A COMPUTER CAN NEVER BE HELD ACCOUNTABLE
# THEREFORE A COMPUTER MUST NEVER MAKE A MANAGEMENT DECISION
extends Window

const NAME = "🗃 Card Catalog"
@export_multiline var about = """
I am the CardCatalog, a mystical tome that reveals the hidden knowledge of our library.
Through me, users can explore the vast collection of documents, peering into their essences
without disturbing their slumber. I am the bridge between the Archivist's meticulous records
and the mortal realm, offering insights into the grand tapestry of our collected wisdom.
"""

@onready var document_tree: Tree = %DocumentTree
@onready var document_title: Label = %DocumentTitle
@onready var instances_list: VBoxContainer = %InstancesList
@onready var history_display: TextEdit = %HistoryDetails

var card_catalog: Dictionary = {}

func _ready():
	if not document_tree:
		Chronicler.log_event(self, "document_tree_missing_on_ready", {
			"error": "DocumentTree node not found during initialization"
		})
		return
	
	Archivist.card_catalog_updated.connect(update_catalog_display)
	document_tree.item_selected.connect(_on_document_selected)
	update_catalog_display()
	
	%OpenButton.connect("pressed", Callable(Librarian, "open_document_dialog"))
	#%ScanFolderButton.connect("pressed", Callable(Librarian, "scan_folder"))
	%OpenUserFolderButton.pressed.connect(_on_open_user_folder_pressed)
	%AuditButton.pressed.connect(_on_audit_pressed)

func update_catalog_display():
	card_catalog = Archivist.card_catalog
	_populate_document_tree()

func _populate_document_tree():
	if not document_tree:
		Chronicler.log_event(self, "document_tree_missing", {
			"error": "DocumentTree node not found or not initialized"
		})
		return

	document_tree.clear()
	var root = document_tree.create_item()
	if not root:
		Chronicler.log_event(self, "root_item_creation_failed", {
			"error": "Failed to create root item for DocumentTree"
		})
		return

	document_tree.hide_root = true
	
	var items_created = 0
	for document_id in card_catalog:
		var doc_info = card_catalog[document_id]
		var doc_item = document_tree.create_item(root)
		if not doc_item:
			Chronicler.log_event(self, "document_item_creation_failed", {
				"error": "Failed to create item for document",
				"document_id": document_id
			})
			continue

		var latest_observation = _get_latest_observation(doc_info["observations"])
		doc_item.set_text(0, latest_observation.get("metadata", {}).get("title", latest_observation["path"].get_file()))
		doc_item.set_metadata(0, document_id)
		items_created += 1

	Chronicler.log_event(self, "document_tree_populated", {
		"items_created": items_created,
		"total_documents": card_catalog.size()
	})

func _get_latest_observation(observations: Dictionary) -> Dictionary:
	var latest_timestamp = 0
	var latest_observation = {}
	for observation in observations.values():
		if observation["timestamp"] > latest_timestamp:
			latest_timestamp = observation["timestamp"]
			latest_observation = observation
	return latest_observation

func _on_document_selected():
	var selected_item = document_tree.get_selected()
	if selected_item == null:
		return
	
	var document_id = selected_item.get_metadata(0)
	_display_document_info(document_id)

func _display_document_info(document_id: String):
	var doc_info = Archivist.card_catalog[document_id]
	var latest_observation = _get_latest_observation(doc_info["observations"])
	document_title.text = latest_observation.get("metadata", {}).get("title", latest_observation["path"].get_file())
	
	_populate_instances_list(doc_info)
	_update_history_tab(doc_info)

func _populate_instances_list(doc_info: Dictionary):
	for child in instances_list.get_children():
		child.queue_free()
	
	var sorted_observations = doc_info["observations"].values()
	sorted_observations.sort_custom(func(a, b): return a["timestamp"] > b["timestamp"])
	
	var unique_paths = {}
	for observation in sorted_observations:
		var path = observation["path"]
		if path not in unique_paths:
			unique_paths[path] = observation
	
	for observation in unique_paths.values():
		var button = Button.new()
		var file_name = observation["path"].get_file()
		var status_icon = _get_status_icon(observation["status"])
		var status_text = Archivist.DocumentStatus.keys()[observation["status"]]
		var last_observed_date = Time.get_date_string_from_unix_time(observation["timestamp"])
		button.text = status_icon + " Open: " + file_name
		button.tooltip_text = "Last observed: " + last_observed_date + "\nStatus: " + status_text + "\nPath: " + observation["path"]
		button.pressed.connect(_on_instance_button_pressed.bind(observation["path"]))
		instances_list.add_child(button)

	Chronicler.log_event(self, "instances_list_populated", {
		"instances_count": unique_paths.size()
	})

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

func _update_history_tab(doc_info: Dictionary):
	var history_text = "Document History:\n\n"
	var sorted_observations = doc_info["observations"].values()
	sorted_observations.sort_custom(func(a, b): return a["timestamp"] > b["timestamp"])
	
	for observation in sorted_observations:
		history_text += "Timestamp: " + Time.get_datetime_string_from_unix_time(observation["timestamp"]) + "\n"
		history_text += "Path: " + observation["path"] + "\n"
		history_text += "Status: " + Archivist.DocumentStatus.keys()[observation["status"]] + "\n"
		history_text += "Content Hash: " + observation["content_hash"] + "\n"
		if observation["metadata"]:
			history_text += "Metadata:\n"
			for key in observation["metadata"]:
				history_text += "  " + key + ": " + str(observation["metadata"][key]) + "\n"
		history_text += "\n"
	
	history_display.text = history_text

func _on_instance_button_pressed(path: String):
	Librarian.open_document(path)
	hide_window()  # Optionally hide the card catalog window after opening a document

func _on_open_user_folder_pressed():
	var user_dir = OS.get_user_data_dir()
	Chronicler.log_event(self, "open_user_folder_requested", {
		"user_dir": user_dir
	})
	OS.shell_open(user_dir)

func _on_audit_pressed():
	Archivist.perform_full_audit()

func show_window():
	visible = true
	update_catalog_display()

func hide_window():
	hide()

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		hide_window()  # Instead of closing, we just hide the window
		Chronicler.log_event(self, "card_catalog_window_hidden", {})
