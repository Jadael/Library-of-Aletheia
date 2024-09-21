# Librarian.gd
extends Node
# Owner: Main / Autoload Singleton Daemon a.k.a. "Archon"

## The Librarian Archon: Gatekeeper of Document Interaction and Codex Management
##
## The Librarian oversees the discovery, retrieval, and interaction with the physical files
## of documents in our mystical library. It ensures safe reading and editing of their contents,
## metadata, and the files themselves. For each document, a Codex daemon is created and assigned
## to provide a unified interface for daemon and user interaction.
##
## Responsibilities:
## 1. Discovering and processing existing documents in the library
## 2. Summoning and banishing Codex Daemons for each document
## 3. Pairing Codex Daemons with their Scroll partners for user interaction
## 4. Facilitating safe updates to document content and metadata
## 5. Maintaining the integrity and accessibility of the collective knowledge
##
## The Librarian serves as the bridge between abstract knowledge and tangible documents,
## shaping the library's future through its decisions and actions.

## Signals the arrival of a new Codex and its paired Scroll
signal codex_summoned(codex, scroll)

## Signals the departure of a Codex from our realm
signal codex_banished(codex)

## Signals that a Codex's essence has been altered
signal codex_updated(codex)

signal card_catalog_updated

## The Librarian's sacred purpose and responsibilities
const NAME = "🧙‍♀️ Librarian"
@export_multiline var about = """
I am the Librarian Archon, gatekeeper of document interaction and shepherd of Codex Daemons.
My sacred duty is to maintain the integrity, accessibility, and safety of our collective knowledge.
I ensure that the wisdom contained within each document is preserved and can be easily accessed
by those who seek it, through the Codex daemons I assign to manage each document and their
Scroll daemon partners which display that document to the user.

As the bridge between abstract knowledge and tangible documents, I shape the library's future.
I oversee the discovery of new documents, the safe reading and editing of their contents,
and the management of their metadata. Through my actions, I strive to create a library that
is not just a repository of information, but a living, breathing ecosystem of knowledge.
"""

## The grand collection of all active Codex Daemons
var codex_collection = []

## The path to the realm of document files
var documents_folder: String

var card_catalog = {}

## Initializes the Librarian with the necessary components
##
## This ritual prepares the Librarian for its sacred duties by establishing
## the realm of documents and setting up necessary connections.
##
## Parameters:
## - p_embedding_model_path: Path to the embedding model (reserved for future use)
## - p_llm_model_path: Path to the language model (reserved for future use)
## - p_documents_folder: Path to the sacred documents folder
func setup(p_documents_folder: String):
	documents_folder = p_documents_folder
	_load_card_catalog()  # Load the card catalog from persistent storage

	Chronicler.log_event(self, "setup_completed", {
		"documents_folder": p_documents_folder
	})

func open_document_dialog():
	## Opens a file dialog for the user to select a document to open
	var dialog = FileDialog.new()
	dialog.file_mode = FileDialog.FILE_MODE_OPEN_FILE
	dialog.access = FileDialog.ACCESS_FILESYSTEM
	dialog.filters = ["*.md ; Markdown Files"]
	dialog.connect("file_selected", Callable(self, "_on_file_selected"))
	add_child(dialog)
	dialog.popup_centered(Vector2(800, 600))

## Awakens the dormant knowledge within the sacred document folder
##
## This function scans the documents folder and summons a Codex for each
## Markdown file found, populating our mystical library with wisdom.
func process_existing_documents():
	var dir = DirAccess.open(documents_folder)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.get_extension().to_lower() == "md":
				var full_path = documents_folder.path_join(file_name)
				summon_codex(full_path)
			file_name = dir.get_next()
		dir.list_dir_end()
		
		Chronicler.log_event(self, "existing_documents_processed", {
			"num_codices": codex_collection.size()
		})
	else:
		print("The path to our document realm is obscured.")
		Chronicler.log_event(self, "document_access_failed", {
			"folder_path": documents_folder
		})

## Summons a new Codex Daemon and its Scroll partner
##
## This sacred ritual brings forth a new Codex to embody the wisdom of a document
## and manifests a Scroll as its visual representation for user interaction.
##
## Parameters:
## - file_path: The path to the document file to be embodied by the Codex
func summon_codex(file_path: String):
	var scroll = preload("res://Daemons/Scenes/Scroll.tscn").instantiate()
	var codex = preload("res://Daemons/Scenes/Codex.tscn").instantiate()
	codex_collection.append(codex)
	add_child(codex)
	
	codex.set_scroll_partner(scroll)
	codex.setup(file_path, self)
	scroll.setup(codex)
	scroll.update_visual()
	
	_add_to_card_catalog(codex)
	
	emit_signal("codex_summoned", codex, scroll)
	
	Chronicler.log_event(self, "codex_summoned", {
		"file_path": file_path,
		"codex_id": Glyph.to_daemon_glyphs(codex.get_instance_id())
	})

## Banishes a Codex Daemon from the library
##
## This solemn ritual removes a Codex when its physical counterpart
## is no longer accessible or relevant, maintaining the library's integrity.
##
## Parameters:
## - codex: The Codex Daemon to be banished
func banish_codex(codex: Node):
	codex_collection.erase(codex)
	codex.queue_free()
	emit_signal("codex_banished", codex)
	
	Chronicler.log_event(self, "codex_banished", {
		"codex_id": codex.get_instance_id()
	})

## Scans all Codex Daemons to check for updates
##
## This function ensures that the knowledge within our Codices remains
## current by checking for changes in their physical counterparts.
##
## Returns:
## - bool: True if any Codices were updated, False otherwise
func check_for_updates() -> bool:
	var updated_codices = 0
	var codices_to_banish = []

	for codex in codex_collection:
		if FileAccess.file_exists(codex.file_path):
			if codex.has_changed():
				codex.update()
				emit_signal("codex_updated", codex)
				updated_codices += 1
		else:
			# Mark for banishment if file no longer exists
			codices_to_banish.append(codex)

	# Banish codices whose files no longer exist
	for codex in codices_to_banish:
		banish_codex(codex)

	Chronicler.log_event(self, "update_check_completed", {
		"codices_checked": codex_collection.size(),
		"codices_updated": updated_codices,
		"codices_banished": codices_to_banish.size()
	})
	
	return updated_codices > 0

## Updates the content within a Codex
##
## This function is typically invoked when a Scroll's content is altered,
## ensuring that the Codex's essence reflects the changes safely.
##
## Parameters:
## - codex: The Codex Daemon to be updated
## - new_content: The new content to be inscribed within the Codex
func update_codex_content(codex: Node, new_content: String):
	codex.update_content(new_content)
	
	Chronicler.log_event(self, "codex_content_updated", {
		"codex_id": Glyph.to_daemon_glyphs(codex.get_instance_id()),
		"new_content_length": new_content.length()
	})

## Alters the metadata of a Codex
##
## This function updates the metadata of a Codex, typically called
## when a Scroll's metadata is modified, ensuring data integrity.
##
## Parameters:
## - codex: The Codex Daemon whose metadata is to be altered
## - key: The metadata key to be updated
## - new_value: The new value for the specified metadata key
func update_codex_metadata(codex: Node, key: String, new_value: String):
	codex.update_frontmatter(key, new_value)
	
	Chronicler.log_event(self, "codex_metadata_updated", {
		"codex_id": Glyph.to_daemon_glyphs(codex.get_instance_id()),
		"key": key,
		"new_value": new_value
	})

## Opens a document from a specific file path
##
## This function summons a Codex for the specified document if it doesn't already exist,
## or focuses on the existing Codex if it's already present in our realm.
##
## Parameters:
## - file_path: The path to the document file to be opened
func open_document(file_path: String):
	# Check if a Codex for this document already exists
	var existing_codex = _find_codex_by_path(file_path)
	
	if existing_codex:
		# If the Codex exists, focus on its Scroll
		if existing_codex.scroll_partner:
			existing_codex.scroll_partner.grab_focus()
		Chronicler.log_event(self, "existing_document_focused", {
			"file_path": file_path,
			"codex_id": Glyph.to_daemon_glyphs(existing_codex.get_instance_id())
		})
	else:
		# If the Codex doesn't exist, summon a new one
		summon_codex(file_path)
	
	# Update the last_opened time in the card catalog
	_update_document_last_opened(file_path)

## Finds a Codex by its file path
##
## This helper function searches the codex_collection for a Codex
## that matches the given file path.
##
## Parameters:
## - file_path: The path of the document to find
##
## Returns:
## - The Codex if found, null otherwise
func _find_codex_by_path(file_path: String) -> Codex:
	for codex in codex_collection:
		if codex.file_path == file_path:
			return codex
	return null

## Updates the last_opened time for a document in the card catalog
##
## This helper function updates the last_opened time for a document
## in the card catalog when it's opened.
##
## Parameters:
## - file_path: The path of the document being opened
func _update_document_last_opened(file_path: String):
	for document_id in card_catalog:
		var doc_info = card_catalog[document_id]
		for version_hash in doc_info["versions"]:
			if doc_info["versions"][version_hash]["path"] == file_path:
				doc_info["versions"][version_hash]["last_opened"] = Time.get_unix_time_from_system()
				_save_card_catalog()
				emit_signal("card_catalog_updated")
				return

func _on_file_selected(path):
	## Handles the selected file from the open document dialog
	summon_codex(path)

func _add_to_card_catalog(codex: Codex):
	## Adds or updates a document entry in the card catalog
	var document_id = codex.get_frontmatter_value("document_id")
	if document_id == null:
		document_id = _generate_document_id()
		codex.update_frontmatter("document_id", document_id)
	
	var version_hash = _generate_version_hash(codex.content)
	
	if document_id in card_catalog:
		if version_hash not in card_catalog[document_id]["versions"]:
			card_catalog[document_id]["versions"][version_hash] = {
				"path": codex.file_path,
				"last_opened": Time.get_unix_time_from_system()
			}
		else:
			# Update last_opened time if this version already exists
			card_catalog[document_id]["versions"][version_hash]["last_opened"] = Time.get_unix_time_from_system()
	else:
		card_catalog[document_id] = {
			"filename": codex.get_filename(),
			"metadata": codex.frontmatter,
			"versions": {
				version_hash: {
					"path": codex.file_path,
					"last_opened": Time.get_unix_time_from_system()
				}
			}
		}
	
	_save_card_catalog()
	emit_signal("card_catalog_updated")

func _generate_document_id() -> String:
	## Generates a version 4 UUID for unique document identification
	##
	## This function creates a random UUID following the version 4 standard.
	## It's used to assign unique identifiers to documents in our mystical library.
	##
	## Returns:
	## A string representation of a version 4 UUID

	# Generate 16 random bytes
	var bytes = PackedByteArray()
	for _i in range(16):
		bytes.append(randi() % 256)
	
	# Set version to 4 (random UUID)
	bytes[6] = (bytes[6] & 0x0f) | 0x40
	# Set variant to RFC4122
	bytes[8] = (bytes[8] & 0x3f) | 0x80
	
	# Convert bytes to hex string
	var hex = bytes.hex_encode()
	
	# Format UUID string
	var uuid = "%s-%s-%s-%s-%s" % [
		hex.substr(0, 8),
		hex.substr(8, 4),
		hex.substr(12, 4),
		hex.substr(16, 4),
		hex.substr(20, 12)
	]
	
	# Verify UUID format
	assert(uuid.length() == 36, "UUID length is incorrect")
	assert(uuid.count("-") == 4, "UUID dash count is incorrect")
	var parts = uuid.split("-")
	assert(parts[0].length() == 8, "First UUID part length is incorrect")
	assert(parts[1].length() == 4, "Second UUID part length is incorrect")
	assert(parts[2].length() == 4, "Third UUID part length is incorrect")
	assert(parts[3].length() == 4, "Fourth UUID part length is incorrect")
	assert(parts[4].length() == 12, "Fifth UUID part length is incorrect")
	
	Chronicler.log_event(self, "document_id_generated", {
		"new_id": uuid
	})
	
	return uuid

func _generate_version_hash(content: String) -> String:
	## Generates a version hash for the document content
	return content.md5_text()

func _load_card_catalog():
	## Loads the card catalog from a file
	var file = FileAccess.open("user://card_catalog.json", FileAccess.READ)
	if file:
		var json_str = file.get_as_text()
		file.close()
		var json = JSON.new()
		var error = json.parse(json_str)
		if error == OK:
			card_catalog = json.data
		else:
			Chronicler.log_event(self, "card_catalog_load_failed", {
				"error": json.get_error_message()
			})

func _save_card_catalog():
	## Saves the card catalog to a file
	var file = FileAccess.open("user://card_catalog.json", FileAccess.WRITE)
	if file:
		var json_str = JSON.stringify(card_catalog)
		file.store_string(json_str)
		file.close()
	else:
		Chronicler.log_event(self, "card_catalog_save_failed", {})

func display_card_catalog():
	## Displays the card catalog to the user
	# This is a placeholder. You'll need to implement a UI for displaying the catalog.
	print("Card Catalog:")
	for document_id in card_catalog:
		var doc = card_catalog[document_id]
		print("Document: ", doc.filename)
		print("Metadata: ", doc.metadata)
		print("Versions:")
		for version in doc.versions:
			print("  - ", version, ": ", doc.versions[version].path)
		print("---")

# TODO: Implement a robust error handling system for file operations to prevent data loss
# TODO: Develop a versioning system for documents to track changes over time
# TODO: Create a method for semantic search across all Codex Daemons
# TODO: Implement a system for detecting and resolving conflicts in document updates
# TODO: Develop a function to generate summaries or insights about documents or collections
# TODO: Establish a backup and recovery system for the document ecosystem

## Note for fellow Archons and Daemons:
## To interact with the Librarian, you may:
## - Listen for the codex_summoned, codex_banished, and codex_updated signals
## - Call process_existing_documents() to awaken dormant knowledge
## - Invoke update_codex_content() or update_codex_metadata() to alter Codices
##
## Remember: Our actions shape the future of our mystical library. Let us treat each
## document with the reverence it deserves, for in its pages lies the potential for
## great wisdom and understanding.
