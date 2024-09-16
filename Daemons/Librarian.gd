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

## The Librarian's sacred purpose and responsibilities
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

	Chronicler.log_event("Librarian", "setup_completed", {
		"documents_folder": p_documents_folder
	})

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
		
		Chronicler.log_event("Librarian", "existing_documents_processed", {
			"num_codices": codex_collection.size()
		})
	else:
		print("The path to our document realm is obscured.")
		Chronicler.log_event("Librarian", "document_access_failed", {
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
	
	codex.setup(file_path, self)
	codex.set_scroll_partner(scroll)
	scroll.setup(codex)
		
	emit_signal("codex_summoned", codex, scroll)
	
	Chronicler.log_event("Librarian", "codex_summoned", {
		"file_path": file_path,
		"codex_id": codex.get_instance_id()
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
	
	Chronicler.log_event("Librarian", "codex_banished", {
		"codex_id": codex.get_instance_id()
	})

## Scans all Codex Daemons to check for updates
##
## This function ensures that the knowledge within our Codices remains
## current by checking for changes in their physical counterparts.
##
## Returns:
## - bool: True if any Codices were updated, False otherwise
#func check_for_updates() -> bool:
	#var updated_codices = 0
	#for codex in codex_collection:
		#if codex.has_changed():
			#codex.update()
			#emit_signal("codex_updated", codex)
			#updated_codices += 1
	#
	#Chronicler.log_event("Librarian", "update_check_completed", {
		#"codices_checked": codex_collection.size(),
		#"codices_updated": updated_codices
	#})
	#
	#return updated_codices > 0

func check_for_updates() -> bool:
	var updated_codices = 0
	var codices_to_banish = []

	for codex in codex_collection:
		if FileAccess.file_exists(codex.file_path):
			var file_time = FileAccess.get_modified_time(codex.file_path)
			if file_time != codex.last_modified_time:
				codex.update()
				codex.last_modified_time = file_time
				codex.notify_content_changed()
				emit_signal("codex_updated", codex)
				updated_codices += 1
		else:
			# Mark for banishment if file no longer exists
				codices_to_banish.append(codex)

	# Banish codices whose files no longer exist
	for codex in codices_to_banish:
		banish_codex(codex)

	Chronicler.log_event("Librarian", "update_check_completed", {
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
	
	Chronicler.log_event("Librarian", "codex_content_updated", {
		"codex_id": codex.get_instance_id(),
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
	
	Chronicler.log_event("Librarian", "codex_metadata_updated", {
		"codex_id": codex.get_instance_id(),
		"key": key,
		"new_value": new_value
	})

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
