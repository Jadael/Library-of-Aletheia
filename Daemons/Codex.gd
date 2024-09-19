# Codex.gd
extends Node
class_name Codex
# Owner: Librarian

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
var last_modified_time: int ## The last time my document was modified
var last_checked_time: int ## The last time I checked my document for changes

var librarian: Node ## The Librarian Archon who oversees this Codex
var scroll_partner: Scroll ## The Scroll Daemon that manifests this Codex's wisdom

## Reveals the true name of the document
func get_title() -> String:
	return frontmatter.get("title", get_filename())

## Awakens the Codex and binds it to its earthly tether
func setup(p_file_path: String, p_librarian: Node):
	file_path = p_file_path
	librarian = p_librarian
	_load_content()
	emit_signal("content_changed")
	emit_signal("frontmatter_changed")

## Forges the sacred bond between Codex and Scroll
func set_scroll_partner(scroll: Node):
	scroll_partner = scroll

## Inscribes new content into the Codex's essence
func update_content(new_content: String):
	if body != new_content:
		body = new_content
		_save_content()
		emit_signal("content_changed")

## Unveils the earthly name of the document
func get_filename() -> String:
	return file_path.get_file()

## Erases a mystical property from the document's frontmatter
func remove_frontmatter(key: String):
	if frontmatter.has(key):
		frontmatter.erase(key)
		_save_content()
		emit_signal("frontmatter_changed")

## Inscribes or modifies a mystical property in the document's frontmatter
func update_frontmatter(key: String, new_value: String):
	if frontmatter.get(key) != new_value:
		frontmatter[key] = new_value
		_save_content()
		emit_signal("frontmatter_changed")

## Absorbs the essence of the physical document
func _load_content():
	var file = FileAccess.open(file_path, FileAccess.READ)
	if file:
		content = file.get_as_text()
		file.close()
		last_modified_time = FileAccess.get_modified_time(file_path)
		set_last_checked_time(Time.get_ticks_msec())
		_parse_content()

## Deciphers the mystical runes of YAML
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

## Synchronizes the Codex with its physical counterpart
func update():
	if has_changed():
		await _load_content()
		emit_signal("content_changed")
		emit_signal("frontmatter_changed")

## Detects disturbances in the document's physical form
func has_changed() -> bool:
	## if my scroll partner is out of date, default to assuming there was an update (HACK: Is this the best way for this to work and the best place for it to happen?)
	var current_time = Time.get_ticks_msec()
	#if scroll_partner and scroll_partner.last_checked_time != self.last_checked_time:
		#set_last_checked_time(current_time)
		#var file_time = FileAccess.get_modified_time(file_path)
		#if file_time != last_modified_time:
			#return true
	if current_time - last_checked_time > 1000:  # Check no more than once per second
		set_last_checked_time(current_time)
		var file_time = FileAccess.get_modified_time(file_path)
		if file_time != last_modified_time:
			return true
	return false

## Manifests the Codex's essence into physical form
func _save_content():
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	if file:
		file.store_string("---\n")
		for key in frontmatter:
			file.store_string("%s: %s\n" % [key, frontmatter[key]])
		file.store_string("---\n")
		file.store_string(body)
		file.close()
		last_modified_time = FileAccess.get_modified_time(file_path)
		set_last_checked_time(Time.get_ticks_msec())

func set_last_checked_time(time: int):
	last_checked_time = time

# TODO: Implement a method to track the history of changes in the Codex's essence
# TODO: Develop a system for resolving conflicts between Codex and physical document changes
# FIXME: Enhance the YAML parsing to handle more complex frontmatter structures
