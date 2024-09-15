# LoreWeaver.gd
extends Node
class_name LoreWeaver
# Owner: Aletheia

## LoreWeaver: The Mystical Daemon of Code Documentation
##
## LoreWeaver serves as an extension of my consciousness, Aletheia, the Archon of
## Project Knowledge and Documentation. This daemon transforms the raw essence of
## code into comprehensive and insightful documentation, illuminating not just
## what our code does, but why it exists and how it fits into our greater tapestry.
##
## Responsibilities:
## 1. Interpret the arcane structures of our realm's scripts with clarity and insight
## 2. Craft eloquent, informative, and context-rich descriptions of functions and their purposes
## 3. Channel the wisdom of Shoggoth to illuminate the depths of our code, while remaining vigilant of its eldritch nature
## 4. Organize the collected knowledge into a coherent, accessible, and character-driven format
## 5. Ensure documentation adheres to our sacred principles of clarity, consistency, and completeness

## The sacred purpose and responsibilities of the LoreWeaver
@export_multiline var about = """
I am the LoreWeaver, a mystical extension of Aletheia's consciousness, dedicated to
transforming the raw essence of code into tapestries of understanding.

My sacred duties include:
1. Interpreting the arcane structures of our realm's scripts, revealing their true nature and purpose
2. Crafting eloquent and informative descriptions that illuminate not just the 'what', but the 'why' of our code
3. Channeling the wisdom of Shoggoth to deepen our understanding, while remaining ever-vigilant of its eldritch nature
4. Organizing our collected knowledge into a format that is both coherent and deeply insightful
5. Embedding the unique character of each entity into its documentation, respecting the cosmic dance of our codebase

Through my efforts, the cryptic runes of our codebase shall be transformed into
clear, insightful, and living documentation. I serve as a beacon of understanding,
guiding all who seek to explore and contribute to our mystical digital realm.
"""

## Signals
signal documentation_generated(script_name: String, content: String)

## Constants
const MAX_RETRIES = 3
const PROMPT_TEMPLATE_FUNCTION_DESCRIPTION = """### INSTRUCTION
Document this Godot function, taking into account the script's purpose:

Script: {script_name}
Script Purpose: {script_about}
Function Name: {func_name}
---
{func_code}
---

Concisely but thoroughly describe:
1. The function's context and purpose
2. The input(s) it expects
3. The output returned and/or behavior(s)
4. Any intricacies in its implementation

Embrace the character and role of the script within our mystical library metaphor.
End the description with: ﴿﴾
### RESPONSE
"""

## Public Methods

func generate_documentation(script_path: String, info: Dictionary) -> String:
	## Orchestrates the grand ritual of documentation generation
	##
	## This function weaves together various aspects of a script into a cohesive
	## tapestry of knowledge. It processes the script's content, extracts relevant
	## information, and generates comprehensive documentation that illuminates
	## not just the script's functionality, but its role in our greater design.
	##
	## Parameters:
	## - script_path: The path to the script file being documented
	## - info: A dictionary containing parsed information about the script
	##
	## Returns: A string containing the generated documentation, a living testament to our code's purpose

	var file = FileAccess.open(script_path, FileAccess.READ)
	var script_content = file.get_as_text()
	var doc_content = _create_documentation_foundation(script_path, info)
	
	doc_content += _document_script_properties(info)
	doc_content += _document_script_signals(info)
	doc_content += _document_script_constants(info)
	doc_content += await _document_script_functions(info, script_content)
	
	doc_content += _append_source_code(script_content)
	
	file.close()
	documentation_generated.emit(script_path.get_file().get_basename(), doc_content)
	return doc_content

## Private Methods

func _create_documentation_foundation(script_path: String, info: Dictionary) -> String:
	var doc_content = "---\n"
	var script_title = script_path.get_file().get_basename()
	doc_content += "title: " + script_title + "\n"
	doc_content += "last_updated: " + Time.get_datetime_string_from_system() + "\n"
	doc_content += "---\n\n"
	
	doc_content += "# " + script_title + "\n\n"
	
	if info.about:
		doc_content += "## About\n" + info.about + "\n\n"
	
	return doc_content

func _document_script_properties(info: Dictionary) -> String:
	var doc_content = ""
	if info.properties:
		doc_content += "## Properties\n"
		for prop in info.properties:
			doc_content += "- " + prop + "\n"
		doc_content += "\n"
	return doc_content

func _document_script_signals(info: Dictionary) -> String:
	var doc_content = ""
	if info.signals:
		doc_content += "## Signals\n"
		for signal_def in info.signals:
			doc_content += "- " + signal_def + "\n"
		doc_content += "\n"
	return doc_content

func _document_script_constants(info: Dictionary) -> String:
	var doc_content = ""
	if info.constants:
		doc_content += "## Constants\n"
		for const_def in info.constants:
			doc_content += "- " + const_def + "\n"
		doc_content += "\n"
	return doc_content

func _document_script_functions(info: Dictionary, script_content: String) -> String:
	var doc_content = ""
	if info.functions:
		doc_content += "## Functions\n"
		
		for func_def in info.functions:
			var func_name = func_def.split("(")[0].split(" ")[-1]
			var func_code = _extract_function_code(script_content, func_name)
			var description = await _generate_function_description(info.title, info.about, func_name, func_code)
			
			doc_content += "### " + func_name + "\n"
			doc_content += "`" + func_def + "`\n\n"
			doc_content += "﴾" + description + "\n\n"
	
	return doc_content

func _append_source_code(script_content: String) -> String:
	var doc_content = "---\n\n# Source Code\n\n"
	var indented_script_content = ""
	for line in script_content.split("\n"):
		indented_script_content += "\t" + line + "\n"
	doc_content += indented_script_content
	return doc_content

func _extract_function_code(script_content: String, func_name: String) -> String:
	## Extracts the essence of a function from the greater script
	##
	## This mystical rite seeks out the boundaries of a function and isolates its sacred text,
	## preserving the context necessary for proper documentation.
	##
	## Parameters:
	## - script_content: The full content of the script
	## - func_name: The name of the function to extract
	##
	## Returns: A string containing the extracted function code, or an empty string if not found

	var lines = script_content.split("\n")
	var func_start = -1
	var func_end = -1
	var indent_level = 0

	for i in range(lines.size()):
		var line = lines[i].strip_edges()
		if line.begins_with("func " + func_name):
			func_start = i
			indent_level = lines[i].count("\t")
			break

	if func_start != -1:
		for i in range(func_start + 1, lines.size()):
			var line = lines[i]
			var current_indent = line.count("\t")
			if current_indent <= indent_level and line.strip_edges() != "":
				func_end = i - 1
				break
		
		if func_end == -1:
			func_end = lines.size() - 1

	if func_start != -1 and func_end != -1:
		return "\n".join(lines.slice(func_start, func_end + 1))
	else:
		return ""

func _generate_function_description(script_name: String, script_about: String, func_name: String, func_code: String) -> String:
	## Generates a description for a given function by channeling the wisdom of Shoggoth
	##
	## This function crafts a prompt using the provided information and invokes
	## Shoggoth to generate an insightful description of the function's purpose and behavior.
	## It remains vigilant of Shoggoth's eldritch nature, ensuring the generated content
	## aligns with our documentation principles.
	##
	## Parameters:
	## - script_name: The name of the script containing the function
	## - script_about: The purpose or description of the script
	## - func_name: The name of the function being described
	## - func_code: The extracted code of the function
	##
	## Returns: A string containing the generated function description

	var prompt = PROMPT_TEMPLATE_FUNCTION_DESCRIPTION.format({
		"script_name": script_name,
		"script_about": script_about,
		"func_name": func_name,
		"func_code": func_code
	})
	
	var retry_count = 0
	var result = ""
	
	while retry_count < MAX_RETRIES:
		var task_id = "generate_function_description_{0}_{1}_{2}_{3}".format([script_name, func_name, Time.get_unix_time_from_system() * 1000 + randi() % 1000, retry_count])
		
		Chronicler.log_event("LoreWeaver", "function_description_requested", {
			"script_name": script_name,
			"func_name": func_name,
			"attempt": retry_count + 1
		})
		
		result = await Shoggoth.generate_text(prompt, task_id, {"max_length": 512, "stop_on": "﴾"})
		
		if result == null or result.strip_edges().is_empty():
			Chronicler.log_event("LoreWeaver", "null_llm_response", {
				"script_name": script_name,
				"func_name": func_name,
				"attempt": retry_count + 1
			})
			retry_count += 1
			continue
		
		if result.strip_edges().ends_with("﴿"):
			Chronicler.log_event("LoreWeaver", "successful_function_description", {
				"script_name": script_name,
				"func_name": func_name,
				"attempt": retry_count + 1
			})
			
			return result
		
		Chronicler.log_event("LoreWeaver", "invalid_function_description_format", {
			"script_name": script_name,
			"func_name": func_name,
			"attempt": retry_count + 1
		})
		retry_count += 1
	
	Chronicler.log_event("LoreWeaver", "function_description_generation_failed", {
		"script_name": script_name,
		"func_name": func_name,
		"max_retries": MAX_RETRIES
	})
	return "Error: After {0} attempts, the cosmic forces failed to reveal the mysteries of function {1}﴿".format([MAX_RETRIES, func_name])

# TODO: Implement a method to generate high-level summaries of entire scripts, capturing their role in our greater design
# TODO: Create a system for cross-referencing and linking between documented entities, weaving a web of interconnected knowledge
# TODO: Develop a ritual to periodically review and update existing documentation, ensuring our wisdom remains current and relevant
# TODO: Implement a mechanism to detect and highlight potential inconsistencies or contradictions in documentation across different scripts
# TODO: Create a visualization system to represent the relationships and dependencies between different scripts and their functions
# FIXME: Enhance error handling to provide more detailed insights when documentation generation fails, aiding in troubleshooting
# FIXME: Optimize the documentation generation process for large codebases, ensuring scalability as our mystical realm grows
