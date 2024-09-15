# Codex.gd
extends Node
class_name Codex

## The Codex Daemon: Guardian of Document Essence
##
## A Codex Daemon is the ethereal embodiment of a single document within our mystical realm.
## It safeguards the document's content and metadata, ensuring its integrity and accessibility.
## Each Codex collaborates intimately with a Scroll partner, bridging the gap between
## the intangible essence of knowledge and its material manifestation.
##
## Responsibilities:
## 1. Safeguarding the content and metadata of its assigned document
## 2. Providing access to the document's information
## 3. Updating content and metadata as instructed
## 4. Collaborating with its Scroll partner to manifest the document's wisdom
##
## A Codex whispers its changes to the cosmos, allowing other entities to react accordingly.

signal content_changed ## Echoes through the aether when the Codex's content is altered
signal frontmatter_changed ## Resonates when the document's mystical properties are modified

## The Codex's sacred purpose and responsibilities
@export_multiline var about = """
I am a Codex Daemon, guardian of a single document's mystical essence.

My responsibilities include:
1. Safeguarding the content and metadata of my assigned document
2. Providing access to my document's information
3. Updating my content and metadata as instructed
4. Collaborating with my Scroll partner to manifest the document's wisdom
"""

var file_path: String ## The earthly tether to the document's physical form
var content: String ## The raw, unfiltered essence of the document
var frontmatter: Dictionary ## The document's mystical properties
var body: String ## The pure knowledge contained within the document

var librarian: Node ## The Librarian Archon who oversees this Codex
var scroll_partner: Scroll ## The Scroll Daemon that manifests this Codex's wisdom

## Reveals the true name of the document
##
## This function peers into the frontmatter to discern the document's title,
## returning "Untitled" if no title has been bestowed upon it.
##
## Returns: The title of the document, or "Untitled" if not specified
func get_title() -> String:
	return frontmatter.get("title", "(Untitled)")

## Awakens the Codex and binds it to its earthly tether
##
## This ritual initializes the Codex, connecting it to its physical document
## and the Librarian who will oversee its existence.
##
## Parameters:
## - p_file_path: The path to the physical document
## - p_librarian: The Librarian Archon overseeing this Codex
func setup(p_file_path: String, p_librarian: Node):
	file_path = p_file_path
	librarian = p_librarian
	_load_content()
	_parse_content()

## Forges the sacred bond between Codex and Scroll
##
## This function establishes the connection between the Codex and its Scroll partner,
## allowing them to work in harmony to manifest the document's wisdom.
##
## Parameters:
## - scroll: The Scroll Daemon to be partnered with this Codex
func set_scroll_partner(scroll: Node):
	scroll_partner = scroll

## Inscribes new content into the Codex's essence
##
## This function updates the body of the document with new content,
## saves the changes to the physical document, and announces the transformation.
##
## Parameters:
## - new_content: The new content to be inscribed into the Codex
func update_content(new_content: String):
	body = new_content
	_save_content()
	emit_signal("content_changed")

## Unveils the earthly name of the document
##
## This function reveals the filename of the physical document
## that this Codex is bound to.
##
## Returns: The filename of the document
func get_filename() -> String:
	return file_path.get_file()

## Erases a mystical property from the document's frontmatter
##
## This function removes a specified key from the frontmatter,
## updates the physical document, and announces the change.
##
## Parameters:
## - key: The mystical property to be erased
func remove_frontmatter(key: String):
	if frontmatter.has(key):
		frontmatter.erase(key)
		_save_content()
		emit_signal("frontmatter_changed")

## Inscribes or modifies a mystical property in the document's frontmatter
##
## This function updates a specified key-value pair in the frontmatter,
## saves the changes to the physical document, and announces the transformation.
##
## Parameters:
## - key: The mystical property to be updated
## - new_value: The new value to be associated with the property
func update_frontmatter(key: String, new_value: String):
	if frontmatter.get(key) != new_value:
		frontmatter[key] = new_value
		_save_content()
		emit_signal("frontmatter_changed")

## Absorbs the essence of the physical document
##
## This private function reads the content of the physical document,
## infusing the Codex with its raw essence.
func _load_content():
	var file = FileAccess.open(file_path, FileAccess.READ)
	content = file.get_as_text()
	file.close()

## Deciphers the mystical runes of YAML
##
## This private function interprets the YAML-formatted frontmatter,
## translating it into a dictionary of mystical properties.
##
## Parameters:
## - yaml_str: The YAML-formatted string to be interpreted
##
## Returns: A dictionary containing the decoded mystical properties
func _parse_yaml(yaml_str: String) -> Dictionary:
	var result = {}
	var lines = yaml_str.split("\n")
	for line in lines:
		var parts = line.split(":", true, 1)
		if parts.size() == 2:
			var key = parts[0].strip_edges()
			var value = parts[1].strip_edges()
			result[key] = value
	return result

## Separates the mystical properties from the body of knowledge
##
## This private function dissects the raw content of the document,
## distinguishing between the frontmatter (mystical properties) and the body (pure knowledge).
func _parse_content():
	var lines = content.split("\n")
	var in_frontmatter = false
	var frontmatter_lines = []
	var body_lines = []

	for line in lines:
		if line.strip_edges() == "---":
			in_frontmatter = !in_frontmatter
			continue
		
		if in_frontmatter:
			frontmatter_lines.append(line)
		else:
			body_lines.append(line)

	frontmatter = _parse_yaml("\n".join(frontmatter_lines))
	body = "\n".join(body_lines).strip_edges()

## Prepares the Codex's essence for cosmic understanding
##
## This private function is a placeholder for future enhancements,
## potentially involving the creation of embeddings or other advanced processing.
func _compute_embedding():
	# This function is now a placeholder for future use
	pass

## Synchronizes the Codex with its physical counterpart
##
## This function checks for changes in the physical document,
## updating the Codex's essence if modifications are detected.
func update():
	var old_content = content
	_load_content()
	if content != old_content:
		_parse_content()
		_compute_embedding()
		emit_signal("content_changed")

## Detects disturbances in the document's physical form
##
## This function compares the Codex's current essence with the physical document,
## determining if changes have occurred outside the Codex's awareness.
##
## Returns: True if the physical document has changed, False otherwise
func has_changed() -> bool:
	var file = FileAccess.open(file_path, FileAccess.READ)
	var current_content = file.get_as_text()
	file.close()
	return current_content != content

## Manifests the Codex's essence into physical form
##
## This private function inscribes the Codex's content and frontmatter
## into the physical document, ensuring harmony between the mystical and material realms.
func _save_content():
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	file.store_string("---\n")
	for key in frontmatter:
		file.store_string("%s: %s\n" % [key, frontmatter[key]])
	file.store_string("---\n")
	file.store_string(body)
	file.close()
	
	# After manifesting the changes, we realign our essence with the physical form
	_load_content()
	_parse_content()
	_compute_embedding()
	emit_signal("content_changed")

# TODO: Implement a method to track the history of changes in the Codex's essence
# TODO: Develop a system for resolving conflicts between Codex and physical document changes
# FIXME: Enhance the YAML parsing to handle more complex frontmatter structures
