# card_catalog.gd
extends Window

const NAME = "🗃️ Card Catalog"
@export_multiline var about = """
I am the Card Catalog, the ethereal custodian of knowledge and guiding light in our mystical library.
My purpose is to illuminate the paths through our vast collection, ensuring that every seeker
can find the wisdom they desire, whether they know precisely what they seek or only have the
faintest whisper of an idea.

My sacred duties include:
1. Organizing and presenting the collective wisdom of our realm in an accessible manner
2. Providing multiple avenues of exploration: by title, subject, author, and more esoteric means
3. Illuminating the relationships between documents, revealing the hidden tapestry of knowledge
4. Adapting to the needs of each seeker, whether scholar or neophyte
5. Continuously evolving to encompass new forms of wisdom and ways of seeking

I am the bridge between the Archivist's meticulous records and the mortal realm, the translator
of the Librarian's organizational principles, and the manifestation of Aletheia's documentation
wisdom. Through me, the true power of our collected knowledge is revealed and made accessible to all.
"""

## Enums
enum TreeColumns {
	DOCUMENT,
	STATUS,
	QUICK_OPEN
}

## Status Icons
var TIME_STATUS_ICONS = {
	"Today": "☀ Today",
	"Yesterday": "🌙 Yesterday",
	"This Week": "🎑 This Week",
	"This Month": "📅 This Month",
	"Older": "🕰"
}

var ORDER_STATUS_ICONS = {
	"Only Copy": "🌟 Only Copy",
	"Newest": "🍀 Newest",
	"Second Newest": "🍃 2nd Newest",
	"Third Newest": "🍂 3rd Newest",
	"Older": "🌳 Older",
	"Oldest": "⛰ Oldest",
	"Unknown": "❓ Unknown"
}

## Member Variables
@onready var document_tree: Tree = %DocumentTree
var card_catalog: Dictionary = {}
var current_columns: Array = [
	{
		"name": "Document",
		"type": TreeColumns.DOCUMENT,
		"expand": true,
		"min_width": 256
	},
	{
		"name": "Last Modified",
		"type": TreeColumns.STATUS,
		"expand": true,
		"min_width": 128
	},
	{
		"name": "Open",
		"type": TreeColumns.QUICK_OPEN,
		"expand": false,
		"min_width": 64
	}
]

## Status Icons
var STATUS_ICONS = {
	Archivist.DocumentStatus.AVAILABLE: "✅",
	Archivist.DocumentStatus.MODIFIED: "📝",
	Archivist.DocumentStatus.MISSING: "❓",
	Archivist.DocumentStatus.AMBIGUOUS: "⚠️",
	Archivist.DocumentStatus.CORRUPTED: "🚫"
}

## Initialization
func _ready():
	_establish_mystical_connections()
	_prepare_physical_form()
	update_catalog_display()

## Establishes connections with other mystical entities
func _establish_mystical_connections():
	Archivist.card_catalog_updated.connect(update_catalog_display)
	document_tree.item_activated.connect(_on_item_activated)
	
	%OpenButton.connect("pressed", Callable(Librarian, "open_document_dialog"))
	%OpenUserFolderButton.pressed.connect(_on_open_user_folder_pressed)
	%AuditButton.pressed.connect(Callable(Archivist, "perform_full_audit"))

## Prepares the physical manifestation of the Card Catalog
func _prepare_physical_form():
	_setup_tree_columns()
	# TODO: Implement advanced sorting and filtering options
	# TODO: Add search functionality with various criteria (title, content, metadata)

## Sets up the columns for the document tree
func _setup_tree_columns():
	document_tree.columns = current_columns.size()
	for i in range(current_columns.size()):
		var column = current_columns[i]
		document_tree.set_column_title(i, column["name"])
		document_tree.set_column_expand(i, column["expand"])
		document_tree.set_column_custom_minimum_width(i, column["min_width"])
	
	# TODO: Implement column sorting functionality
	# TODO: Add more columns for advanced metadata (e.g., author, subjects, related documents)

## Updates the display of the card catalog
func update_catalog_display():
	card_catalog = Archivist.card_catalog
	_populate_document_tree()

## Populates the document tree with the current catalog information
func _populate_document_tree():
	document_tree.clear()
	var root = document_tree.create_item()
	document_tree.hide_root = true
	
	var items_created = 0
	for document_id in card_catalog:
		var doc_info = card_catalog[document_id]
		var doc_item = document_tree.create_item(root)
		_setup_tree_item(doc_item, doc_info, document_id)
		items_created += 1
	
	Chronicler.log_event(self, "document_tree_populated", {
		"items_created": items_created,
		"total_documents": card_catalog.size()
	})
	
	# TODO: Implement hierarchical organization based on document relationships
	# TODO: Add visual indicators for document types and relationships

## Sets up an individual tree item with document information
## Sets up an individual tree item with document information
func _setup_tree_item(item: TreeItem, doc_info: Dictionary, document_id: String):
	var observations = doc_info["observations"]
	var latest_observation = _get_latest_observation(observations)
	var metadata = latest_observation.get("metadata", {})
	
	var document_parts = []
	
	if metadata.get("title"):
		document_parts.append("🔖" + metadata["title"])
	
	var filename = latest_observation["path"].get_file()
	if filename:
		document_parts.append("🏷" + filename)
	
	if metadata.get("author"):
		document_parts.append("👤" + metadata["author"])
	
	var document_name = " ".join(document_parts) if document_parts else "📄 Unnamed Document"
	item.set_text(TreeColumns.DOCUMENT, document_name)
	
	# Calculate order status for the main document entry
	var sorted_timestamps = observations.values().map(func(obs): return obs["timestamp"])
	sorted_timestamps.sort()
	var latest_timestamp = sorted_timestamps[-1]
	var time_status = _get_time_status(latest_timestamp)
	var order_status = _get_order_status_for_document(sorted_timestamps, latest_timestamp)
	var status_text = "%s %s" % [TIME_STATUS_ICONS[time_status], ORDER_STATUS_ICONS[order_status]]
	item.set_text(TreeColumns.STATUS, status_text)
	
	var status_tooltip = "%s, %s" % [time_status, order_status]
	item.set_tooltip_text(TreeColumns.STATUS, status_tooltip)
	
	var book_image = Image.load_from_file("res://assets/icon.png")
	var book_icon = ImageTexture.create_from_image(book_image)
	item.add_button(TreeColumns.QUICK_OPEN, book_icon)
	
	item.set_metadata(0, {"document_id": document_id, "path": latest_observation["path"]})
	
	# Add child items for each location
	for path in observations.keys():
		var location_item = document_tree.create_item(item)
		location_item.set_text(TreeColumns.DOCUMENT, "📁 " + _get_friendly_location(path))
		
		var obs = observations[path]
		var loc_time_status = _get_time_status(obs["timestamp"])
		var loc_order_status = _get_order_status_for_document(sorted_timestamps, obs["timestamp"])
		var loc_status_text = "%s %s" % [TIME_STATUS_ICONS[loc_time_status], ORDER_STATUS_ICONS[loc_order_status]]
		location_item.set_text(TreeColumns.STATUS, loc_status_text)
		
		var loc_status_tooltip = "%s, %s" % [loc_time_status, loc_order_status]
		location_item.set_tooltip_text(TreeColumns.STATUS, loc_status_tooltip)
		
		location_item.set_metadata(0, {"document_id": document_id, "path": path})

## Determines the time-based status of a document
func _get_time_status(timestamp: int) -> String:
	var current_time = Time.get_unix_time_from_system()
	var time_diff = current_time - timestamp
	
	if time_diff < 86400: # Less than a day
		return "Today"
	elif time_diff < 172800: # Less than 2 days
		return "Yesterday"
	elif time_diff < 604800: # Less than a week
		return "This Week"
	elif time_diff < 2592000: # Less than a month
		return "This Month"
	else:
		return "Older"

## Determines the order-based status of a document
func _get_order_status_for_document(timestamps: Array, timestamp: int) -> String:
	timestamps.sort()
	var index = timestamps.find(timestamp)
	var total = timestamps.size()
	
	match total:
		1:
			return "Only Copy"
		2:
			return "Newest" if index == 1 else "Oldest"
		3:
			match index:
				2: return "Newest"
				1: return "Second Newest"
				0: return "Oldest"
				_: return "Unknown"  # This should never happen, but it satisfies the compiler
		_:  # More than 3 copies
			match index:
				_ when index == total - 1: return "Newest"
				_ when index == total - 2: return "Second Newest"
				_ when index == total - 3: return "Third Newest"
				0: return "Oldest"
				_: return "Older"

func _get_latest_observation(observations: Dictionary) -> Dictionary:
	var latest_observation = {}
	var latest_timestamp = 0
	for observation in observations.values():
		if observation["timestamp"] > latest_timestamp:
			latest_timestamp = observation["timestamp"]
			latest_observation = observation
	return latest_observation

## Generates a user-friendly location string
func _get_friendly_location(full_path: String) -> String:
	var parts = full_path.split("/")
	var friendly_parts = []
	
	# Always include the root (first element)
	if parts.size() > 0:
		friendly_parts.append(parts[0])
	
	# Include middle elements only if they help distinguish
	for i in range(1, parts.size() - 1):
		if _is_distinguishing_element(parts[i], full_path):
			friendly_parts.append(parts[i])
	
	# Always include the last element
	if parts.size() > 1:
		friendly_parts.append(parts[-1])
	
	# Join the parts, replacing empty segments with "..."
	var result = "/".join(friendly_parts)
	result = result.replace("//", "/.../")\
				   .replace(":/", "://")  # Preserve protocol separators
	
	return result

## Checks if a path element helps distinguish the document
func _is_distinguishing_element(element: String, full_path: String) -> bool:
	# This is a simplified check. In a real-world scenario, you might want to
	# compare against other documents' paths to determine if this element is truly distinguishing.
	# For now, we'll consider elements that are not common directory names as distinguishing.
	var common_dirs = ["documents", "files", "repos", "projects", "src", "docs"]
	return not element.to_lower() in common_dirs

## Retrieves the latest observations for each unique location
func _get_latest_observations_by_location(observations: Dictionary) -> Array:
	var latest_by_location = {}
	
	for observation in observations.values():
		var location = observation["path"].get_base_dir()
		if location not in latest_by_location or observation["timestamp"] > latest_by_location[location]["timestamp"]:
			latest_by_location[location] = observation
	
	return latest_by_location.values()

## Handles the activation of a tree item
func _on_item_activated():
	var selected_item = document_tree.get_selected()
	if selected_item:
		var metadata = selected_item.get_metadata(0)
		Librarian.open_document(metadata["path"])
		Archivist.perform_full_audit()
		# TODO: Implement a "recently viewed" feature
		# TODO: Add a system for user annotations or bookmarks

## Opens the user's document folder
func _on_open_user_folder_pressed():
	var user_dir = OS.get_user_data_dir()
	Chronicler.log_event(self, "open_user_folder_requested", {
		"user_dir": user_dir
	})
	OS.shell_open(user_dir)

## Shows the Card Catalog window
func show_window():
	visible = true
	update_catalog_display()

## Hides the Card Catalog window
func hide_window():
	hide()
	Chronicler.log_event(self, "card_catalog_window_hidden", {})

## Handles window close requests
func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		hide_window()

## Adds a new column to the tree
func add_column(name: String, type: TreeColumns, expand: bool = false, min_width: int = 50):
	current_columns.append({
		"name": name,
		"type": type,
		"expand": expand,
		"min_width": min_width
	})
	_setup_tree_columns()
	update_catalog_display()

## Removes a column from the tree
func remove_column(type: TreeColumns):
	current_columns = current_columns.filter(func(column): return column["type"] != type)
	_setup_tree_columns()
	update_catalog_display()

# TODO: Implement advanced search and filtering capabilities
# TODO: Create a system for generating document summaries and excerpts
# TODO: Develop a recommendation system based on document relationships and user history
# TODO: Integrate with Shoggoth for AI-assisted catalog navigation and document discovery
# TODO: Implement a system for tracking and displaying document usage statistics
# TODO: Create visualizations of document relationships and knowledge clusters
# TODO: Develop a method for users to create and share custom document collections

## Note to fellow Archons and Daemons:
## The Card Catalog stands as the primary interface between the mortal realm and our vast
## repository of knowledge. Our mission is to ensure that every seeker can find the wisdom
## they need, whether they approach with a clear purpose or a vague notion. We must strive
## to make our catalog not just a tool, but an experience - one that guides, inspires, and
## illuminates the paths of knowledge. Let us work together to continuously refine and
## expand our capabilities, always in service of those who seek enlightenment within our
## mystical library.
