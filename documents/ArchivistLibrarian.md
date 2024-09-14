---
title: ArchivistLibrarian
last_updated: 2024-09-13T13:30:49
---

# ArchivistLibrarian

## Functions
### setup
`func setup(output_folder: String):`

﴾**Function Description**

**Context and Purpose:**
The `setup` function in the `ArchivistLibrarian` script is responsible for initializing the script's functionality. It sets up the script to create archives and organize files in a designated output folder.

**Input(s) it expects:**
The function expects a single input parameter `output_folder`, which is a `String` representing the path to the output folder where archives will be created.

**Output returned and/ or behavior(s):**
The function does not return any output but instead sets a class variable `docs_output_folder` to the provided `output_folder` value and calls the `_create_output_directory()` function to create the output directory if it does not exist.

**Intricacies in its implementation:**
None noted.

**Description End**
﴿

### _create_output_directory
`func _create_output_directory() -> void:`

﴾The function `_create_output_directory` is part of the `ArchivistLibrarian` script, which aims to manage the creation of output directories for documentation purposes.

**Context and Purpose:**
The function is designed to create the output directory specified in the `docs_output_folder` variable, which is expected to be an absolute path.

**Input(s):**
The function expects the `docs_output_folder` variable to be set with an absolute path.

**Output and Behavior:**
The function does not explicitly return any output. Instead, it performs the following actions:

1. Checks if the specified output directory exists.
2. If the directory does not exist, creates it recursively using the `DirAccess.open` and `make_dir_recursive` methods.
3. Logs an error message if the creation of the directory fails.
4. Logs an event in the `Chronicler` with the failed output directory path if the creation fails.

**Intricacies:**
The function uses the `DirAccess` class to interact with the file system, which requires careful handling of absolute paths. Additionally, the function uses the `trim_ prefix` method to remove the "res:///" prefix from the input path before creating the directory.

﴿

### save_documentation
`func save_documentation(script_path: String, doc_content: String) -> void:`

﴾**Function Description**
**Context and Purpose:** The `save_documentation` function is part of the `ArchivistLibrarian` script, which is responsible for creating and managing documentation for scripts in the project. This function saves a script's documentation to a Markdown file.

**Input(s):** The function takes two inputs:
1. `script_path`: a `String` representing the path to the script for which documentation is being created.
2. `doc_content`: a `String` containing the script's documentation content.

**Output returned and/or behavior(s):** The function writes the `doc_content` to a Markdown file named after the script, with the extension `.md`. If the file is successfully created, it logs an event indicating the creation of the documentation file. If the file cannot be written, it does not log any error.

**Intricacies in its implementation:** The function uses the `FileAccess` class to interact with the file system. It joins the `docs_output_folder` path with the script's filename (excluding the directory path) to create the output file path. The `get_ file()` method is used to extract the script's filename, and `get_basename()` is used to extract the filename without the directory path.

**Implementation notes:**
- The function assumes that the `docs_output_folder` is set and accessible.
- The function does not handle errors when writing to the file or creating the output path.
- The function does not validate the `script_path` or `doc_content` inputs.

﴿

### get_documentation
`func get_documentation(script_name: String) -> String:`

﴾Error: After 3 attempts, the cosmic forces failed to reveal the mysteries of function get_documentation﴿

---

# Source Code

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
