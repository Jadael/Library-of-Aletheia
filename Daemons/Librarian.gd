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
## 6. Implementing security measures to protect the library's contents
## 7. Providing file status and content hash information to the Archivist
##
## The Librarian serves as the bridge between abstract knowledge and tangible documents,
## shaping the library's future through its decisions and actions.

## Signals
signal codex_summoned(codex, scroll)
signal codex_banished(codex)
signal codex_updated(codex)
signal card_catalog_updated
signal security_state_changed(new_state: Dictionary)

## Constants
const NAME = "📚 Librarian"

## Enums
enum AuthenticationLevel {
	STANDARD,
	ENHANCED,
	STRICT
}

enum FileStatus {
	AVAILABLE,
	MISSING,
	CORRUPTED
}

## Exported Variables
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

In times of heightened security, I stand as a vigilant guardian, implementing measures
to protect our sacred texts from unauthorized access or malicious intent.
"""

## Member Variables
var codex_collection = []
var documents_folder: String
var current_authentication_level = AuthenticationLevel.STANDARD
var locked_systems = []

func _ready():
	Archivist.card_catalog_updated.connect(_on_card_catalog_updated)

func setup(p_documents_folder: String):
	documents_folder = p_documents_folder
	Chronicler.log_event(self, "setup_completed", {
		"documents_folder": p_documents_folder
	})

func _on_card_catalog_updated():
	emit_signal("card_catalog_updated")

func open_document_dialog():
	if current_authentication_level == AuthenticationLevel.STRICT:
		Chronicler.log_event(self, "document_access_denied", {
			"reason": "Strict authentication level active"
		})
		return

	var dialog = FileDialog.new()
	dialog.file_mode = FileDialog.FILE_MODE_OPEN_FILE
	dialog.access = FileDialog.ACCESS_FILESYSTEM
	dialog.filters = ["*.md ; Markdown Files"]
	dialog.connect("file_selected", Callable(self, "_on_file_selected"))
	add_child(dialog)
	dialog.popup_centered(Vector2(800, 600))

func process_existing_documents():
	if is_system_locked("document_processing"):
		Chronicler.log_event(self, "document_processing_blocked", {
			"reason": "System locked"
		})
		return

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
		Chronicler.log_event(self, "document_access_failed", {
			"folder_path": documents_folder
		})

## Observes a document and records its current state
func observe_document(file_path: String):
	var file_status = get_file_status(file_path)
	if file_status == FileStatus.AVAILABLE:
		var content = _read_file_content(file_path)
		var metadata = _extract_metadata(content)
		Archivist.observe_document(file_path, metadata)
		
		Chronicler.log_event(self, "document_observed", {
			"file_path": file_path,
			"metadata_keys": metadata.keys()
		})
	else:
		Chronicler.log_event(self, "document_observation_failed", {
			"file_path": file_path,
			"status": FileStatus.keys()[file_status]
		})

## Summons a new Codex Daemon and its Scroll partner
func summon_codex(file_path: String):
	if current_authentication_level == AuthenticationLevel.STRICT:
		Chronicler.log_event(self, "codex_summoning_denied", {
			"reason": "Strict authentication level active",
			"file_path": file_path
		})
		return

	var scroll = preload("res://daemons/scenes/scroll.tscn").instantiate()
	var codex = preload("res://daemons/scenes/codex.tscn").instantiate()
	codex_collection.append(codex)
	add_child(codex)
	
	codex.set_scroll_partner(scroll)
	codex.setup(file_path, self)
	scroll.setup(codex)
	scroll.update_visual()
	
	scroll.scroll_closed.connect(_on_scroll_closed)
	
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
		var file_status = get_file_status(codex.file_path)
		if file_status == FileStatus.AVAILABLE:
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
	if current_authentication_level == AuthenticationLevel.STRICT:
		Chronicler.log_event(self, "content_update_denied", {
			"reason": "Strict authentication level active",
			"codex_id": Glyph.to_daemon_glyphs(codex.get_instance_id())
		})
		return

	if codex.body != new_content:
		codex.update_content(new_content)
		observe_document(codex.file_path)
		
		Chronicler.log_event(self, "codex_content_updated", {
			"codex_id": Glyph.to_daemon_glyphs(codex.get_instance_id()),
			"new_content_length": new_content.length()
		})
	else:
		Chronicler.log_event(self, "codex_content_unchanged", {
			"codex_id": Glyph.to_daemon_glyphs(codex.get_instance_id())
		})

## Alters the metadata of a Codex
func update_codex_metadata(codex: Node, key: String, new_value: String):
	if current_authentication_level == AuthenticationLevel.STRICT:
		Chronicler.log_event(self, "metadata_update_denied", {
			"reason": "Strict authentication level active",
			"codex_id": Glyph.to_daemon_glyphs(codex.get_instance_id()),
			"key": key
		})
		return

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

func set_authentication_level(level: AuthenticationLevel):
	current_authentication_level = level
	var security_state = {
		"authentication_level": AuthenticationLevel.keys()[current_authentication_level],
		"locked_systems": locked_systems
	}
	emit_signal("security_state_changed", security_state)
	Chronicler.log_event(self, "authentication_level_changed", {
		"new_level": AuthenticationLevel.keys()[current_authentication_level]
	})

func lock_systems(systems_to_lock: Array):
	locked_systems.append_array(systems_to_lock)
	var security_state = {
		"authentication_level": AuthenticationLevel.keys()[current_authentication_level],
		"locked_systems": locked_systems
	}
	emit_signal("security_state_changed", security_state)
	Chronicler.log_event(self, "systems_locked", {
		"locked_systems": systems_to_lock
	})

func unlock_systems(systems_to_unlock: Array):
	for system in systems_to_unlock:
		locked_systems.erase(system)
	var security_state = {
		"authentication_level": AuthenticationLevel.keys()[current_authentication_level],
		"locked_systems": locked_systems
	}
	emit_signal("security_state_changed", security_state)
	Chronicler.log_event(self, "systems_unlocked", {
		"unlocked_systems": systems_to_unlock
	})

func is_system_locked(system: String) -> bool:
	return system in locked_systems

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

func _on_scroll_closed(scroll: Scroll):
	## Handle the closure of a Scroll and its associated Codex
	var codex = scroll.codex_partner
	if codex:
		banish_codex(codex)
	
	Chronicler.log_event(self, "scroll_and_codex_closed", {
		"scroll_id": Glyph.to_daemon_glyphs(scroll.get_instance_id()),
		"codex_id": Glyph.to_daemon_glyphs(codex.get_instance_id()) if codex else null
	})

## Returns the status of a file
func get_file_status(file_path: String) -> int:
	if not FileAccess.file_exists(file_path):
		return FileStatus.MISSING
	
	var file = FileAccess.open(file_path, FileAccess.READ)
	if file:
		file.close()
		return FileStatus.AVAILABLE
	else:
		return FileStatus.CORRUPTED

## Returns the content hash of a file
func get_file_content_hash(file_path: String) -> String:
	var content = _read_file_content(file_path)
	if content.is_empty():
		return ""
	
	var body = _extract_body(content)
	return body.md5_text()

## Reads the content of a file
func _read_file_content(file_path: String) -> String:
	var file = FileAccess.open(file_path, FileAccess.READ)
	if file:
		var content = file.get_as_text()
		file.close()
		return content
	return ""

## Extracts the body content from a document, excluding frontmatter
func _extract_body(content: String) -> String:
	var lines = content.split("\n")
	var body_lines = []
	var in_frontmatter = false
	
	for line in lines:
		if line.strip_edges() == "---":
			in_frontmatter = not in_frontmatter
			continue
		
		if not in_frontmatter:
			body_lines.append(line)
	
	return "\n".join(body_lines).strip_edges()

## Writes content to a file
func write_file_content(file_path: String, content: String) -> bool:
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	if file:
		file.store_string(content)
		file.close()
		Chronicler.log_event(self, "file_content_written", {
			"file_path": file_path,
			"content_length": content.length()
		})
		return true
	else:
		Chronicler.log_event(self, "file_write_failed", {
			"file_path": file_path,
			"error": FileAccess.get_open_error()
		})
		return false

## Creates a backup of a file
func create_file_backup(file_path: String) -> bool:
	var backup_path = file_path + ".backup"
	var content = _read_file_content(file_path)
	if content.is_empty():
		Chronicler.log_event(self, "backup_creation_failed", {
			"file_path": file_path,
			"reason": "Empty or unreadable file"
		})
		return false
	
	if write_file_content(backup_path, content):
		Chronicler.log_event(self, "backup_created", {
			"original_file": file_path,
			"backup_file": backup_path
		})
		return true
	return false

## Restores a file from its backup
func restore_file_from_backup(file_path: String) -> bool:
	var backup_path = file_path + ".backup"
	if not FileAccess.file_exists(backup_path):
		Chronicler.log_event(self, "restore_failed", {
			"file_path": file_path,
			"reason": "Backup file not found"
		})
		return false
	
	var backup_content = _read_file_content(backup_path)
	if backup_content.is_empty():
		Chronicler.log_event(self, "restore_failed", {
			"file_path": file_path,
			"reason": "Empty or unreadable backup file"
		})
		return false
	
	if write_file_content(file_path, backup_content):
		Chronicler.log_event(self, "file_restored", {
			"file_path": file_path,
			"backup_file": backup_path
		})
		return true
	return false

## Performs a safety check before critical operations
func perform_safety_check(operation: String) -> bool:
	if current_authentication_level == AuthenticationLevel.STRICT:
		Chronicler.log_event(self, "safety_check_failed", {
			"operation": operation,
			"reason": "Strict authentication level active"
		})
		return false
	
	if is_system_locked("file_operations"):
		Chronicler.log_event(self, "safety_check_failed", {
			"operation": operation,
			"reason": "File operations locked"
		})
		return false
	
	Chronicler.log_event(self, "safety_check_passed", {
		"operation": operation
	})
	return true

## Generates a summary of a document
func generate_document_summary(file_path: String) -> String:
	var content = _read_file_content(file_path)
	if content.is_empty():
		return "Unable to generate summary: Empty or unreadable file."
	
	var body = _extract_body(content)
	var words = body.split(" ")
	var summary = ""
	
	if words.size() <= 50:
		summary = body
	else:
		summary = " ".join(words.slice(0, 50)) + "..."
	
	Chronicler.log_event(self, "summary_generated", {
		"file_path": file_path,
		"summary_length": summary.length()
	})
	
	return summary

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
## - Use get_file_status() and get_file_content_hash() for file operations
## - Utilize create_file_backup() and restore_file_from_backup() for document safety
##
## Remember: Our actions shape the future of our mystical library. Let us treat each
## document with the reverence it deserves, for in its pages lies the potential for
## great wisdom and understanding.
