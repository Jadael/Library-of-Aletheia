# card_catalog.gd
extends Window

const NAME = "🗃 Card Catalog"
@export_multiline var about = """
I am the CardCatalog, a mystical tome that reveals the hidden knowledge of our library.
Through me, users can explore the vast collection of documents, peering into their essences
without disturbing their slumber. I am the bridge between the Librarian's meticulous records
and the mortal realm, offering insights into the grand tapestry of our collected wisdom.
"""

@onready var document_tree: Tree = %DocumentTree
@onready var document_title: Label = %DocumentTitle
@onready var instances_list: VBoxContainer = %InstancesList
@onready var versions_display: TextEdit = %VersionDetails
@onready var locations_display: TextEdit = %LocationDetails

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
	
	%OpenUserFolderButton.pressed.connect(_on_open_user_folder_pressed)

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

		doc_item.set_text(0, doc_info.get("title", doc_info["filename"]))
		doc_item.set_metadata(0, document_id)
		items_created += 1

	Chronicler.log_event(self, "document_tree_populated", {
		"items_created": items_created,
		"total_documents": card_catalog.size()
	})

func _on_document_selected():
	var selected_item = document_tree.get_selected()
	if selected_item == null:
		return
	
	var document_id = selected_item.get_metadata(0)
	_display_document_info(document_id)

func _display_document_info(document_id: String):
	var doc_info = Archivist.card_catalog[document_id]
	document_title.text = doc_info.get("title", doc_info["filename"])
	
	Archivist.update_catalog_entry(document_id, Archivist.UpdateUrgency.HIGH)
	_populate_instances_list(doc_info)
	_update_versions_tab(doc_info)
	_update_locations_tab(doc_info)

func _populate_instances_list(doc_info: Dictionary):
	for child in instances_list.get_children():
		child.queue_free()
	
	var locations = []
	for version_hash in doc_info.get("versions", {}):
		var version_info = doc_info["versions"][version_hash]
		if not _is_valid_version_info(version_info):
			continue
		
		var path = version_info["path"]
		var existing_location = locations.filter(func(loc): return loc["path"] == path)
		
		if existing_location.is_empty():
			locations.append({
				"path": path,
				"last_opened": version_info["last_opened"],
				"version_hash": version_hash,
				"status": version_info["status"]
			})
		elif version_info["last_opened"] > existing_location[0]["last_opened"]:
			existing_location[0] = {
				"path": path,
				"last_opened": version_info["last_opened"],
				"version_hash": version_hash,
				"status": version_info["status"]
			}
	
	locations.sort_custom(func(a, b): return a["last_opened"] > b["last_opened"])
	
	for location in locations:
		var button = Button.new()
		var file_name = location["path"].get_file()
		var status_icon = _get_status_icon(location["status"])
		var status_text = Archivist.DocumentStatus.keys()[location["status"]]
		var last_opened_date = Time.get_date_string_from_unix_time(location["last_opened"])
		button.text = status_icon + " Open: " + file_name
		button.tooltip_text = "Last known version from: " + last_opened_date + "\nStatus: " + status_text + "\nPath: " + location["path"]
		button.pressed.connect(_on_instance_button_pressed.bind(location["path"]))
		instances_list.add_child(button)

	Chronicler.log_event(self, "locations_list_populated", {
		"locations_count": locations.size()
	})

func _is_valid_version_info(info: Variant) -> bool:
	if typeof(info) != TYPE_DICTIONARY:
		return false
	if not "path" in info or not "last_opened" in info or not "status" in info:
		return false
	if typeof(info.status) != TYPE_INT:
		return false
	return true

func _get_status_icon(status: Variant) -> String:
	if typeof(status) != TYPE_INT:
		return "❓"
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

func _update_versions_tab(doc_info: Dictionary):
	var versions_text = "Versions:\n\n"
	for version_hash in doc_info["versions"]:
		var version_info = doc_info["versions"][version_hash]
		versions_text += "Version: " + version_hash + "\n"
		versions_text += "Path: " + version_info["path"] + "\n"
		
		var status = version_info.get("status", Archivist.DocumentStatus.MISSING)
		if typeof(status) == TYPE_INT:
			versions_text += "Status: " + Archivist.DocumentStatus.keys()[status] + "\n"
		else:
			versions_text += "Status: Unknown\n"
			Chronicler.log_event(self, "invalid_status_type", {
				"version_hash": version_hash,
				"status_type": typeof(status)
			})
		
		versions_text += "Last Opened: " + Time.get_datetime_string_from_unix_time(version_info["last_opened"]) + "\n"
		
		if status == Archivist.DocumentStatus.MODIFIED:
			versions_text += "Current Hash: " + version_info.get("current_hash", "unknown") + "\n"
		
		versions_text += "\n"
	
	versions_display.text = versions_text

func _update_locations_tab(doc_info: Dictionary):
	var locations_text = "Locations:\n\n"
	var unique_locations = {}
	for version_hash in doc_info["versions"]:
		var version_info = doc_info["versions"][version_hash]
		var path = version_info["path"]
		if path not in unique_locations:
			unique_locations[path] = {
				"last_opened": version_info["last_opened"],
				"status": version_info.get("status", Archivist.DocumentStatus.MISSING)
			}
	
	for path in unique_locations:
		var info = unique_locations[path]
		locations_text += "Path: " + path + "\n"
		if typeof(info["status"]) == TYPE_INT:
			locations_text += "Status: " + Archivist.DocumentStatus.keys()[info["status"]] + "\n"
		else:
			locations_text += "Status: Unknown\n"
		locations_text += "Last Opened: " + Time.get_datetime_string_from_unix_time(info["last_opened"]) + "\n\n"
	
	locations_display.text = locations_text

func _on_instance_button_pressed(path: String):
	Librarian.open_document(path)
	hide_window()  # Optionally hide the card catalog window after opening a document

func _on_open_user_folder_pressed():
	var user_dir = OS.get_user_data_dir()
	Chronicler.log_event(self, "open_user_folder_requested", {
		"user_dir": user_dir
	})
	OS.shell_open(user_dir)

func show_window():
	visible = true
	update_catalog_display()

func hide_window():
	visible = false
