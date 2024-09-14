# Codex.gd
extends Node
class_name Codex

signal content_changed
signal frontmatter_changed

@export_multiline var about = """
I am a Codex Daemon, guardian of a single document's mystical essence.

My responsibilities include:
1. Safeguarding the content and metadata of my assigned document
2. Providing access to my document's information
3. Updating my content and metadata as instructed
4. Collaborating with my Scroll partner to manifest the document's wisdom
"""

var file_path: String
var content: String
var frontmatter: Dictionary
var body: String

var librarian: Node
var scroll_partner: Scroll

func get_title() -> String:
	return frontmatter.get("title", "Untitled")

func setup(p_file_path: String, p_librarian: Node):
	file_path = p_file_path
	librarian = p_librarian
	_load_content()
	_parse_content()

func set_scroll_partner(scroll: Node):
	scroll_partner = scroll
	
func update_content(new_content: String):
	body = new_content
	_save_content()
	emit_signal("content_changed")

func get_filename() -> String:
	return file_path.get_file()

func remove_frontmatter(key: String):
	if frontmatter.has(key):
		frontmatter.erase(key)
		_save_content()
		emit_signal("frontmatter_changed")

func update_frontmatter(key: String, new_value: String):
	if frontmatter.get(key) != new_value:
		frontmatter[key] = new_value
		_save_content()
		emit_signal("frontmatter_changed")

func _load_content():
	var file = FileAccess.open(file_path, FileAccess.READ)
	content = file.get_as_text()
	file.close()

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

func _compute_embedding():
	# This function is now a placeholder for future use
	pass

func update():
	var old_content = content
	_load_content()
	if content != old_content:
		_parse_content()
		_compute_embedding()
		emit_signal("content_changed")

func has_changed() -> bool:
	var file = FileAccess.open(file_path, FileAccess.READ)
	var current_content = file.get_as_text()
	file.close()
	return current_content != content

func _save_content():
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	file.store_string("---\n")
	for key in frontmatter:
		file.store_string("%s: %s\n" % [key, frontmatter[key]])
	file.store_string("---\n")
	file.store_string(body)
	file.close()
	
	# After saving, reload the content to ensure consistency
	_load_content()
	_parse_content()
	_compute_embedding()
	emit_signal("content_changed")
