# librarian.gd
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

## Signals that the card catalog has been updated
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

func _ready():
	Archivist.card_catalog_updated.connect(_on_card_catalog_updated)

func _on_card_catalog_updated():
	emit_signal("card_catalog_updated")

## Initializes the Librarian with the necessary components
func setup(p_documents_folder: String):
	documents_folder = p_documents_folder
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
func process_existing_documents():
	var dir = DirAccess.open(documents_folder)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.get_extension().to_lower() == "md":
				var full_path = documents_folder.path_join(file_name)
				observe_document(full_path)
			file_name = dir.get_next()
		dir.list_dir_end()
		
		Chronicler.log_event(self, "existing_documents_processed", {
			"num_documents": codex_collection.size()
		})
	else:
		print("The path to our document realm is obscured.")
		Chronicler.log_event(self, "document_access_failed", {
			"folder_path": documents_folder
		})

## Observes a document and records its current state
func observe_document(file_path: String):
	var file = FileAccess.open(file_path, FileAccess.READ)
	if file:
		var content = file.get_as_text()
		file.close()
		
		var metadata = _extract_metadata(content)
		Archivist.observe_document(file_path, metadata)
		
		Chronicler.log_event(self, "document_observed", {
			"file_path": file_path,
			"metadata_keys": metadata.keys()
		})
	else:
		Chronicler.log_event(self, "document_observation_failed", {
			"file_path": file_path
		})

## Summons a new Codex Daemon and its Scroll partner
func summon_codex(file_path: String):
	var scroll = preload("res://Daemons/Scenes/Scroll.tscn").instantiate()
	var codex = preload("res://Daemons/Scenes/Codex.tscn").instantiate()
	codex_collection.append(codex)
	add_child(codex)
	
	codex.set_scroll_partner(scroll)
	codex.setup(file_path, self)
	scroll.setup(codex)
	scroll.update_visual()
	
	observe_document(file_path)
	
	emit_signal("codex_summoned", codex, scroll)
	
	Chronicler.log_event(self, "codex_summoned", {
		"file_path": file_path,
		"codex_id": Glyph.to_daemon_glyphs(codex.get_instance_id())
	})

## Banishes a Codex Daemon from the library
func banish_codex(codex: Node):
	codex_collection.erase(codex)
	codex.queue_free()
	emit_signal("codex_banished", codex)
	
	Chronicler.log_event(self, "codex_banished", {
		"codex_id": codex.get_instance_id()
	})

## Scans all Codex Daemons to check for updates
func check_for_updates() -> bool:
	var updated_codices = 0
	var codices_to_banish = []

	for codex in codex_collection:
		if FileAccess.file_exists(codex.file_path):
			observe_document(codex.file_path)
			if codex.has_changed():
				codex.update()
				emit_signal("codex_updated", codex)
				updated_codices += 1
		else:
			codices_to_banish.append(codex)

	for codex in codices_to_banish:
		banish_codex(codex)
	
	if updated_codices > 0 or codices_to_banish.size() > 0:
		Chronicler.log_event(self, "update_check_completed", {
			"codices_checked": codex_collection.size(),
			"codices_updated": updated_codices,
			"codices_banished": codices_to_banish.size()
		})
	
	return updated_codices > 0

## Updates the content within a Codex
func update_codex_content(codex: Node, new_content: String):
	codex.update_content(new_content)
	observe_document(codex.file_path)
	
	Chronicler.log_event(self, "codex_content_updated", {
		"codex_id": Glyph.to_daemon_glyphs(codex.get_instance_id()),
		"new_content_length": new_content.length()
	})

## Alters the metadata of a Codex
func update_codex_metadata(codex: Node, key: String, new_value: String):
	codex.update_frontmatter(key, new_value)
	observe_document(codex.file_path)
	
	Chronicler.log_event(self, "codex_metadata_updated", {
		"codex_id": Glyph.to_daemon_glyphs(codex.get_instance_id()),
		"key": key,
		"new_value": new_value
	})

## Opens a document from a specific file path
func open_document(file_path: String):
	var existing_codex = _find_codex_by_path(file_path)
	
	if existing_codex:
		if existing_codex.scroll_partner:
			existing_codex.scroll_partner.grab_focus()
		Chronicler.log_event(self, "existing_document_focused", {
			"file_path": file_path,
			"codex_id": Glyph.to_daemon_glyphs(existing_codex.get_instance_id())
		})
	else:
		summon_codex(file_path)
	
	observe_document(file_path)

## Finds a Codex by its file path
func _find_codex_by_path(file_path: String) -> Codex:
	for codex in codex_collection:
		if codex.file_path == file_path:
			return codex
	return null

func _on_file_selected(path):
	## Handles the selected file from the open document dialog
	open_document(path)

## Extracts metadata from document content
func _extract_metadata(content: String) -> Dictionary:
	var metadata = {}
	var lines = content.split("\n")
	var in_frontmatter = false
	
	for line in lines:
		if line.strip_edges() == "---":
			in_frontmatter = not in_frontmatter
			continue
		
		if in_frontmatter:
			var parts = line.split(":", true, 1)
			if parts.size() == 2:
				var key = parts[0].strip_edges()
				var value = parts[1].strip_edges()
				metadata[key] = value
		else:
			break
	
	return metadata

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
