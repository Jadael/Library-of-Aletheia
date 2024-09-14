---
title: Codex
last_updated: 2024-09-13T17:42:52
---

# Codex

## Properties
- @export_multiline var about = """

## Signals
- signal content_changed
- signal frontmatter_changed

## Functions
### get_title
`func get_title() -> String:`

﴾**Function Description:**

**Context and Purpose:**
The `get_title` function is part of the Codex script, which appears to be a utility for managing and processing data. This specific function is designed to retrieve the title of a document or resource.

**Input(s):**
The function does not expect any explicit input parameters.

**Output and Behavior:**
The function returns a `String` value representing the title of the document or resource. If the title is not found in the frontmatter (a metadata section), the function defaults to returning the string "Untitled".

**Intricacies:**
The implementation of `get_title` relies on the `frontmatter` object, which likely contains metadata about the document or resource. The function uses the `get` method to retrieve the "title" value from the frontmatter, with a default value of "Untitled" if the key is not present.

**Description End:**
﴿

### setup
`func setup(p_file_path: String, p_librarian: Node):`

﴾**Function: setup**

**Context and Purpose:** The `setup` function is part of the Codex script, which is responsible for setting up the necessary parameters and loading data from a file. This function initializes the file path and the librarian node, then loads and parses the file content.

**Input(s):**

* `p_file_path`: A string representing the path to the file containing the data.
* `p_librarian`: A Node object that will be used to manage the loaded data.

**Output Returned and/or Behavior(s):**

* The function does not explicitly return any value, but it sets up the necessary parameters and loads the file content using the `_load_content()` and `_parse_content()` functions.

**Intricacies in Implementation:**

* The function assumes that the file path is valid and the librarian node is properly set up.
* The `_load_content()` and `_parse_content()` functions are not defined within this function, but are likely defined elsewhere in the script.

**Description:** This function sets up the necessary parameters for the Codex script and loads the file content from the specified file path. The loaded content is then parsed and prepared for use by the script. The function takes two inputs: the file path and the librarian node, and does not return any value. Its implementation relies on the existence of the `_load_content()` and `_parse_content()` functions. 

﴿

### set_scroll_partner
`func set_scroll_partner(scroll: Node):`

﴾**Function: set_scroll_partner**

**Context and Purpose:** This function is part of the Codex script, which is likely responsible for managing the game's codex or in-game book system. The `set_scroll_partner` function's purpose is to set a new scroll partner node for the script.

**Inputs:** The function expects a single input `scroll` of type `Node`, which represents the new scroll partner node.

**Output and Behavior:** The function sets the `scroll_partner` property to the input `scroll` node, effectively assigning the new partner node to the script. There is no explicit output returned by this function.

**Intricacies:** The implementation of this function is straightforward, assigning the input `scroll` node to the `scroll_partner` property. This suggests that the script will use this property to interact with the assigned scroll partner node in the future.

**Description:** ﴿

### update_content
`func update_content(new_content: String):`

﴾**Function: update_content**
**Purpose:** The `update_content` function in the `Codex` script updates the script's internal content with a new value. This function is responsible for storing the new content, saving the changes, and notifying other parts of the script or connected nodes about the content change.

**Inputs:**
* `new_content`: A string representing the new content to be updated.

**Output/Behavior:**
The function does not return any output value. Instead, it modifies the script's internal `body` variable with the provided `new_content` and calls the `_save_content` function to save the changes. Additionally, it emits a signal named "content_changed" to notify other parts of the script or connected nodes about the content change.

**Intricacies:**
The `update_content` function assumes that the `body` variable is a string that can be updated with the new content. The `_save_content` function is responsible for saving the updated content to storage or a database, which is not shown in this code snippet. The `emit_signal` function is used to notify other parts of the script or connected nodes about the content change, allowing them to react to the update. This function is a key part of the script's functionality, as it enables other parts of the script to respond to changes in the content.

﴿

### get_filename
`func get_filename() -> String:`

﴾**Function Description:**

The `get_filename` function is part of the Codex script, which likely deals with file management and manipulation in the Godot game engine. Its purpose is to retrieve the filename from a given file path.

**Input(s):**

The function does not explicitly expect any input(s). However, it is assumed that the `file_path` variable is already defined and contains a valid file path.

**Output Returned and/or Behavior(s):**

The function returns a `String` representing the filename extracted from the `file_path`. The returned filename does not include the directory path.

**Intricacies in Implementation:**

The function uses the `get_file()` method of the `file_path` object to extract the filename. This method likely returns the last part of the file path, which is the filename.

**Functionality:**

The `get_filename` function is a simple utility that can be used to extract the filename from a file path. This can be useful in various scenarios, such as displaying file names in a file browser or loading assets from files.

**Notes:**

The `get_filename` function assumes that the `file_path` variable is a valid file path. If the file path is invalid, the function may return an error or an unexpected result.

**﴿

### remove_frontmatter
`func remove_frontmatter(key: String):`

﴾**Function: `remove_frontmatter`**

**Context and Purpose:** The `remove_frontmatter` function is part of the `Codex` script, responsible for managing the frontmatter of a document. Its purpose is to remove a specified key from the frontmatter, save the updated content, and notify other parts of the script that the frontmatter has changed.

**Input:** The function expects a single input parameter `key` of type `String`, which represents the key to be removed from the frontmatter.

**Output and Behavior:** Upon successful removal of the key, the function saves the updated content using the `_save_content()` method and emits a signal named `"frontmatter_changed"` to notify other parts of the script that the frontmatter has changed. If the key does not exist in the frontmatter, the function does nothing.

**Intricacies:** The function checks if the key exists in the frontmatter using the `has()` method before attempting to remove it. If the key is found, it is erased using the `erase()` method, and the updated content is saved. This ensures that the frontmatter is updated correctly and efficiently.

﴿

### update_frontmatter
`func update_frontmatter(key: String, new_value: String):`

﴾**Function Name:** update_frontmatter
**Script Purpose:** The Codex script is used to manage and update the frontmatter of a document, which is a metadata section at the top of a Markdown file.

**Function Context and Purpose:** The update_frontmatter function is responsible for updating a specific key-value pair in the frontmatter dictionary. This function ensures that the frontmatter is updated correctly and saves the changes to the document's content.

**Input(s) Expected:** The function takes two input parameters:
* `key`: A string representing the key to be updated in the frontmatter dictionary.
* `new_value`: A string representing the new value to be assigned to the specified key.

**Output Returned and/or Behavior(s):** If the new value is different from the existing value in the frontmatter dictionary, the function updates the key-value pair and saves the changes to the document's content using the `_save_content()` method. Additionally, it emits a signal named "frontmatter_changed" to notify any connected listeners of the update.

**Intricacies in Implementation:** The function checks if the new value is different from the existing value in the frontmatter dictionary using the `get()` method. If they are different, it updates the key-value pair and saves the changes to the document's content. This ensures that the frontmatter is updated correctly and the changes are persisted.

﴿

### _load_content
`func _load_content():`

﴾**Function Description:**

The `_load_content` function is part of the `Codex` script, which aims to load content from a file and store it as a string.

**Context and Purpose:**
The purpose of this function is to load the content from a file specified by the `file_path` variable and assign it to the `content` variable.

**Input:**
The function expects a file path as an input, which is stored in the `file_path` variable.

**Output and Behavior:**
The function returns no explicit value, but instead updates the `content` variable with the contents of the file. The `content` variable is now populated with the text data from the file.

**Intricacies:**
The function uses the `FileAccess` class to open the file in read mode (`FileAccess.READ`) and then reads the file's contents as a string using the `get_as_text()` method. After reading the file, the function closes the file using the `close()` method to release system resources.

**﴿

### _parse_yaml
`func _parse_yaml(yaml_str: String) -> Dictionary:`

﴾Error: After 3 attempts, the cosmic forces failed to reveal the mysteries of function _parse_yaml﴿

### _parse_content
`func _parse_content():`

﴾Error: After 3 attempts, the cosmic forces failed to reveal the mysteries of function _parse_content﴿

### _compute_embedding
`func _compute_embedding():`

﴾**_compute_embedding Function Documentation**


**Context and Purpose:**
The `_compute_embedding` function is part of the Codex script, which is responsible for computing and managing embeddings for various entities within the game world. This function serves as a placeholder for future implementation, allowing for the integration of embedding algorithms and related logic.

**Expected Input(s):**
None are explicitly mentioned, but it's likely that the function will accept input from other functions or scripts within the Codex script, such as entity IDs, text strings, or other relevant data.

**Output and Behavior:**
The function currently returns nothing (`pass` statement), but it will likely compute and return an embedding value, potentially as a numerical array or a string representation. The output will depend on the specific implementation and the type of embedding algorithm used.

**Intricacies in Implementation:**
The function's implementation is currently empty, but it will likely involve calling an embedding algorithm, processing input data, and returning the computed embedding value. The specific details of the implementation will depend on the chosen algorithm and the requirements of the game.

**Additional Notes:**
The `_compute_embedding` function is designed to be a reusable component within the Codex script, allowing for the integration of various embedding algorithms and related logic. As the implementation evolves, it will be essential to ensure that the function can handle different input types, algorithms, and requirements.

**Conclusion:**
The `_compute_embedding` function is a placeholder for future implementation, aiming to compute and manage embeddings for entities within the game world. Its purpose is to provide a reusable component for embedding-related logic, and its output will depend on the chosen algorithm and implementation details. ﴿

### update
`func update():`

﴾**Function Name:** `update_content`
**Purpose:** The `update_content` function is part of the `Codex` script, responsible for updating the body of the script with new content.

**Context and Purpose:** This function is designed to replace the existing body content with a new one, ensuring that the changes are persisted and notified to other parts of the script.

**Input(s) it expects:** The function takes a single input parameter `new_ content` of type `String`, representing the new content to be updated.

**Output returned and/ or behavior(s):** Upon successful execution, the function updates the `body` variable with the new content and triggers the `_save_content()` method to persist the changes. Additionally, it emits the `content_ changed` signal to notify other parts of the script about the update.

**Intricacies in its implementation:** The function relies on the `_save_content()` method to store the updated content, ensuring that the changes are persisted. The `emit_signal("content_changed")` statement notifies other parts of the script about the update, allowing them to react accordingly.

**Description End:** ﴿

### has_changed
`func has_changed() -> bool:`

﴾**Function Purpose:** The `has_changed` function in the `Codex` script checks if the content of a file has been modified since the last check.

**Function Context:** This function is part of the `Codex` script, which is responsible for managing and updating the content of a file.

**Input(s) Expected:** The function expects the file path (`file_path`) as a string input.

**Output Returned and/or Behavior(s):** The function returns a boolean value indicating whether the file content has changed since the last check. If the content has changed, the function returns `true`; otherwise, it returns `false`.

**Intricacies in Implementation:** The function uses the `FileAccess` class to open the file for reading. It then reads the current content of the file using the `get_as_text()` method and compares it with the previously stored content using the `content` variable. If the contents are different, the function returns `true`; otherwise, it returns `false`. The function closes the file after reading its content.

**Description Summary:** The `has_changed` function is a crucial part of the `Codex` script, enabling the detection of changes in file content. It takes a file path as input, reads the current content, and compares it with the previously stored content, returning a boolean indicating whether the content has changed.

﴿

### _save_content
`func _save_content():`

﴾The _save_content function is part of the Codex script, which is responsible for managing and processing the content of a document. The purpose of this function is to save the content to a file, ensuring it is properly formatted and structured.

**Input(s)**
The function does not explicitly expect any input parameters. However, it relies on the existence of several variables: file_path, frontmatter, body, and file, which are likely defined elsewhere in the script.

**Output returned and/or behavior(s)**
The function saves the content to a file and reloads it immediately after saving, ensuring consistency. It also emits a signal called "content_changed" to notify any connected listeners of the change.

**Intricacies in its implementation**
The function uses FileAccess to open the file in write mode and store the content in a structured format. It first writes the frontmatter, which is a dictionary of key-value pairs, followed by a separator line. Then, it writes the body content and closes the file. The reloading and parsing of the content are done to maintain consistency and ensure the content is properly formatted.

﴿

---

# Source Code

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
	
