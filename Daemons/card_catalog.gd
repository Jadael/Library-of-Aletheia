# CardCatalogWindow.gd
extends Window

const NAME = "🗃 Card Catalog"
@export_multiline var about = """
I am the CardCatalogWindow, a mystical tome that reveals the hidden knowledge of our library.
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
	Librarian.connect("card_catalog_updated", Callable(self, "update_catalog_display"))
	document_tree.connect("item_selected", Callable(self, "_on_document_selected"))
	update_catalog_display()

func update_catalog_display():
	card_catalog = Librarian.card_catalog
	_populate_document_tree()

func _populate_document_tree():
	document_tree.clear()
	var root = document_tree.create_item()
	document_tree.set_hide_root(true)
	
	for document_id in card_catalog:
		var doc_info = card_catalog[document_id]
		var doc_item = document_tree.create_item(root)
		doc_item.set_text(0, doc_info.get("title", doc_info["filename"]))
		doc_item.set_metadata(0, document_id)

func _on_document_selected():
	var selected_item = document_tree.get_selected()
	if selected_item == null:
		return
	
	var document_id = selected_item.get_metadata(0)
	_display_document_info(document_id)

func _display_document_info(document_id: String):
	var doc_info = card_catalog[document_id]
	document_title.text = doc_info.get("title", doc_info["filename"])
	
	_populate_instances_list(doc_info)
	_update_versions_tab(doc_info)
	_update_locations_tab(doc_info)

func _populate_instances_list(doc_info: Dictionary):
	for child in instances_list.get_children():
		child.queue_free()
	
	var instances = []
	for version_hash in doc_info["versions"]:
		var version_info = doc_info["versions"][version_hash]
		instances.append({
			"path": version_info["path"],
			"last_opened": version_info["last_opened"],
			"version_hash": version_hash
		})
	
	instances.sort_custom(func(a, b): return a["last_opened"] > b["last_opened"])
	
	for instance in instances:
		var button = Button.new()
		button.text = "Open: " + instance["path"].get_file()
		button.tooltip_text = "Version: " + instance["version_hash"] + "\nLast opened: " + Time.get_datetime_string_from_unix_time(instance["last_opened"])
		button.connect("pressed", Callable(self, "_on_instance_button_pressed").bind(instance["path"]))
		instances_list.add_child(button)

func _update_versions_tab(doc_info: Dictionary):
	var versions_text = "Versions:\n\n"
	for version_hash in doc_info["versions"]:
		var version_info = doc_info["versions"][version_hash]
		versions_text += "Version: " + version_hash + "\n"
		versions_text += "Path: " + version_info["path"] + "\n"
		versions_text += "Last Opened: " + Time.get_datetime_string_from_unix_time(version_info["last_opened"]) + "\n\n"
	
	versions_display.text = versions_text

func _update_locations_tab(doc_info: Dictionary):
	var locations_text = "Locations:\n\n"
	var unique_locations = {}
	for version_hash in doc_info["versions"]:
		var version_info = doc_info["versions"][version_hash]
		var path = version_info["path"]
		if path not in unique_locations:
			unique_locations[path] = version_info["last_opened"]
	
	for path in unique_locations:
		locations_text += "Path: " + path + "\n"
		locations_text += "Last Opened: " + Time.get_datetime_string_from_unix_time(unique_locations[path]) + "\n\n"
	
	locations_display.text = locations_text

func _on_instance_button_pressed(path: String):
	Librarian.open_document(path)
	hide_window()  # Optionally hide the card catalog window after opening a document

func show_window():
	visible = true
	update_catalog_display()

func hide_window():
	visible = false
