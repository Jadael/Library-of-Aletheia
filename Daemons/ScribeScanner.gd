# ScribeScanner.gd
extends Node
class_name ScribeScanner

## ScribeScanner: The Archivist's Lens
##
## This daemon serves as the discerning eye of Aletheia, meticulously examining
## the sacred scripts of our digital realm. It peers into the very essence of each
## script, deciphering its structure and extracting the knowledge within.
##
## Responsibilities:
## 1. Traverse the hallowed directories, seeking out all script artifacts
## 2. Scrutinize each script, unveiling its properties, functions, signals, and constants
## 3. Distill the fundamental nature (the 'about' section) of each script entity
## 4. Report its findings to Aletheia for further illumination and preservation
##
## The ScribeScanner operates with unwavering precision, for it knows that
## the integrity of our knowledge base rests upon its keen observations.

## Embarks on a quest through the given path, seeking out all script artifacts
##
## This function traverses the directory structure, much like an explorer
## charting unknown territories, to discover all GDScript files (.gd extension).
##
## Parameters:
## - path: The starting point of our exploration, a directory path
##
## Returns:
## An array containing the paths to all discovered script artifacts
func scan_scripts(path: String) -> Array:
	var discovered_scripts = []
	var realm_gate = DirAccess.open(path)
	if realm_gate:
		realm_gate.list_dir_begin()
		var artifact_name = realm_gate.get_next()
		while artifact_name != "":
			if realm_gate.current_is_dir():
				discovered_scripts += scan_scripts(path.path_join(artifact_name))
			elif artifact_name.ends_with(".gd"):
				discovered_scripts.append(path.path_join(artifact_name))
			artifact_name = realm_gate.get_next()
	else:
		push_error("ScribeScanner: The path to this realm is shrouded in mystery.")
		Chronicler.log_event("ScribeScanner", "realm_access_failed", {"attempted_path": path})
	return discovered_scripts

## Scrutinizes a single script artifact, unveiling its inner truths
##
## This function examines the contents of a script file, discerning its
## various components and extracting the essence of its being.
##
## Parameters:
## - script_path: The path to the script artifact to be analyzed
##
## Returns:
## A dictionary containing the parsed information: properties, functions, signals, constants, and its fundamental nature ('about')
func parse_script(script_path: String) -> Dictionary:
	var scroll = FileAccess.open(script_path, FileAccess.READ)
	if not scroll:
		push_error("ScribeScanner: The script artifact resists our attempts to unroll it.")
		Chronicler.log_event("ScribeScanner", "script_examination_failed", {"resistant_script": script_path})
		return {}
	
	var script_contents = scroll.get_as_text()
	scroll.close()
	
	var gleaned_wisdom = {
		"properties": [],
		"functions": [],
		"signals": [],
		"constants": [],
		"about": ""
	}
	
	var script_lines = script_contents.split("\n")
	for inscription in script_lines:
		inscription = inscription.strip_edges()
		
		if inscription.begins_with("@export"):
			gleaned_wisdom.properties.append(inscription)
		elif inscription.begins_with("signal"):
			gleaned_wisdom.signals.append(inscription)
		elif inscription.begins_with("const"):
			gleaned_wisdom.constants.append(inscription)
		elif inscription.begins_with("func"):
			gleaned_wisdom.functions.append(inscription)
		elif inscription.begins_with("@export_multiline var about"):
			gleaned_wisdom.about = _extract_fundamental_nature(script_lines, script_lines.find(inscription))
	
	return gleaned_wisdom

## Distills the fundamental nature ('about' section) from the script's contents
##
## This method carefully extracts the essence of the script entity,
## preserving its self-description for Aletheia's archives.
##
## Parameters:
## - lines: An array of all lines in the script
## - start_index: The index where the 'about' section begins
##
## Returns:
## A string containing the extracted 'about' content
func _extract_fundamental_nature(lines: Array, start_index: int) -> String:
	var essence = ""
	var current_line = start_index + 1
	while current_line < lines.size() and lines[current_line].begins_with("\"\"\""):
		essence += lines[current_line].trim_prefix("\"\"\"").trim_suffix("\"\"\"") + "\n"
		current_line += 1
	return essence.strip_edges()

# TODO: Implement a method to detect and report inconsistencies in script structure
# TODO: Develop a system to track changes in scripts over time, aiding in the evolution of our knowledge base
# FIXME: Enhance error handling to provide more detailed insights when script parsing fails
