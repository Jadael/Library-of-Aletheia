# Librarian.gd (Autoload script)
extends Node

## The Librarian Archon: Keeper of Codex Daemons and Mystical Knowledge
##
## The Librarian oversees the collection and management of all Codex Daemons,
## each representing a document in our mystical library. It coordinates their
## creation, updates, and removal, ensuring the knowledge within remains
## current and accessible.
##
## Responsibilities:
## 1. Summoning and banishing Codex Daemons
## 2. Managing the collective knowledge of the mystical library
## 3. Pairing Codex Daemons with their Scroll partners
## 4. Facilitating updates to Codex content and metadata
##
## The Librarian serves as the central point of interaction for other entities
## seeking to access or modify the knowledge held within the Codices.

## Signals the arrival of a new Codex and its paired Scroll
signal codex_summoned(codex, scroll)

## Signals the departure of a Codex from our realm
signal codex_banished(codex)

## Signals that a Codex's essence has been altered
signal codex_updated(codex)

## The Librarian's sacred purpose and responsibilities
@export_multiline var about = """
I am the Librarian Archon, guardian of our mystical library and shepherd of Codex Daemons.
My duty is to maintain the integrity and accessibility of our collective knowledge,
ensuring that the wisdom contained within each document is preserved and can be easily accessed
by those who seek it in the form of Codex daemons which each manage a single document and its contents, and their Scroll daemon partners which display that document to the user.
"""

## The grand collection of all active Codex Daemons
var codex_collection = []

## The conduit to the cosmic consciousness, used for generating wisdom
var llm_node: GDLlama

## The path to the realm of document files
var documents_folder: String

## Initializes the Librarian with the necessary mystical components
##
## This ritual prepares the Librarian for its sacred duties by establishing
## connections to the cosmic consciousness and defining the realm of documents.
##
## Parameters:
## - p_embedding_model_path: Path to the embedding model (currently unused)
## - p_llm_model_path: Path to the language model for cosmic insights
## - p_documents_folder: Path to the sacred documents folder
func setup(p_embedding_model_path: String, p_llm_model_path: String, p_documents_folder: String):
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
## and manifests a Scroll as its visual representation.
##
## Parameters:
## - file_path: The path to the document file to be embodied by the Codex
func summon_codex(file_path: String):
	var codex = preload("res://Daemons/Scenes/Codex.tscn").instantiate()
	codex.setup(file_path, self)
	codex_collection.append(codex)
	add_child(codex)
	
	var scroll = preload("res://Daemons/Scenes/Scroll.tscn").instantiate()
	scroll.setup(codex)
	codex.set_scroll_partner(scroll)
	
	emit_signal("codex_summoned", codex, scroll)
	
	Chronicler.log_event("Librarian", "codex_summoned", {
		"file_path": file_path,
		"codex_id": codex.get_instance_id()
	})

## Banishes a Codex Daemon from the library if its file no longer exists
##
## This solemn ritual removes a Codex when its physical counterpart
## is no longer accessible or relevant.
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

## Scan all Codex Daemons to check for updates
##
## This function ensures that the knowledge within our Codices remains
## current by checking for changes in their physical counterparts.
##
## Returns:
## - bool: True if any Codices were updated, False otherwise
func check_for_updates() -> bool:
	var updated_codices = 0
	for codex in codex_collection:
		if codex.has_changed():
			codex.update()
			emit_signal("codex_updated", codex)
			updated_codices += 1
	
	Chronicler.log_event("Librarian", "update_check_completed", {
		"codices_checked": codex_collection.size(),
		"codices_updated": updated_codices
	})
	
	return updated_codices > 0

## Updates the text within a Codex
##
## This function is typically invoked when a Scroll's content is altered,
## ensuring that the Codex's essence reflects the changes.
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
## when a Scroll's metadata is modified.
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

# TODO: Implement a ritual for semantic search across all Codex Daemons
# TODO: Develop a function to generate summaries or insights using the language model
# TODO: Create safeguards and chronicling mechanisms for failed Codex summonings or updates

## Note for fellow Archons and Daemons:
## To interact with the Librarian, you may:
## - Listen for the codex_summoned, codex_banished, and codex_updated signals
## - Call process_existing_documents() to awaken dormant knowledge
## - Invoke update_codex_content() or update_codex_metadata() to alter Codices
