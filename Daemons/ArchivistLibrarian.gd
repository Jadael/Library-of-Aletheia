# ArchivistLibrarian.gd
extends Node
class_name ArchivistLibrarian

var docs_output_folder: String

func setup(output_folder: String):
	docs_output_folder = output_folder
	_create_output_directory()

func _create_output_directory() -> void:
	if not DirAccess.dir_exists_absolute(docs_output_folder):
		var dir = DirAccess.open("res://")
		if dir.make_dir_recursive(docs_output_folder.trim_prefix("res://")) != OK:
			push_error("ArchivistLibrarian: Failed to create output directory.")
			Chronicler.log_event("ArchivistLibrarian", "output_directory_creation_failed", {
				"path": docs_output_folder
			})

func save_documentation(script_path: String, doc_content: String) -> void:
	var output_path = docs_output_folder.path_join(script_path.get_file().get_basename() + ".md")
	var file = FileAccess.open(output_path, FileAccess.WRITE)
	if file:
		file.store_string(doc_content)
		file.close()
		Chronicler.log_event("ArchivistLibrarian", "documentation_file_created", {
			"script_name": script_path.get_file().get_basename(),
			"output_path": output_path
		})
	else:
		push_error("ArchivistLibrarian: Failed to create documentation file.")
		Chronicler.log_event("ArchivistLibrarian", "documentation_file_creation_failed", {
			"script_name": script_path.get_file().get_basename(),
			"output_path": output_path
		})

func get_documentation(script_name: String) -> String:
	var doc_path = docs_output_folder.path_join(script_name + ".md")
	if FileAccess.file_exists(doc_path):
		var file = FileAccess.open(doc_path, FileAccess.READ)
		if file:
			var content = file.get_as_text()
			file.close()
			return content
		else:
			push_error("ArchivistLibrarian: Failed to open documentation file for reading.")
			return "Error: Could not read documentation for " + script_name
	else:
		return "Documentation not found for " + script_name
