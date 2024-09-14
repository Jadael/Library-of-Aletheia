# ScribeScanner.gd
extends Node
class_name ScribeScanner

func scan_scripts(path: String) -> Array:
	var scripts = []
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				scripts += scan_scripts(path.path_join(file_name))
			elif file_name.ends_with(".gd"):
				scripts.append(path.path_join(file_name))
			file_name = dir.get_next()
	else:
		push_error("ScribeScanner: An error occurred when trying to access the path.")
		Chronicler.log_event("ScribeScanner", "script_scan_failed", {"path": path})
	return scripts

func parse_script(script_path: String) -> Dictionary:
	var file = FileAccess.open(script_path, FileAccess.READ)
	if not file:
		push_error("ScribeScanner: Failed to open script file for reading.")
		Chronicler.log_event("ScribeScanner", "script_parse_failed", {"script_path": script_path})
		return {}
	
	var content = file.get_as_text()
	file.close()
	
	var parsed_info = {
		"properties": [],
		"functions": [],
		"signals": [],
		"constants": [],
		"about": ""
	}
	
	var lines = content.split("\n")
	for line in lines:
		line = line.strip_edges()
		
		if line.begins_with("@export"):
			parsed_info.properties.append(line)
		elif line.begins_with("signal"):
			parsed_info.signals.append(line)
		elif line.begins_with("const"):
			parsed_info.constants.append(line)
		elif line.begins_with("func"):
			parsed_info.functions.append(line)
		elif line.begins_with("@export_multiline var about"):
			parsed_info.about = _extract_about(lines, lines.find(line))
	
	return parsed_info

func _extract_about(lines: Array, start_index: int) -> String:
	var about_content = ""
	var i = start_index + 1
	while i < lines.size() and lines[i].begins_with("\"\"\""):
		about_content += lines[i].trim_prefix("\"\"\"").trim_suffix("\"\"\"") + "\n"
		i += 1
	return about_content.strip_edges()
