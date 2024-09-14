# LoreWeaver.gd
extends Node
class_name LoreWeaver

@export_multiline var about = """
I am the LoreWeaver, a mystical Daemon in service of Aletheia, the Archon of Project Knowledge.
My sacred duty is to weave the raw essence of code into tapestries of understanding.

My responsibilities include:
1. Interpreting the arcane structures of our realm's scripts
2. Crafting eloquent and informative descriptions of functions and their purposes
3. Channeling the wisdom of Shoggoth to illuminate the depths of our code
4. Organizing the collected knowledge into a coherent and accessible format

Through my efforts, the cryptic runes of our codebase shall be transformed into
clear and insightful documentation, guiding all who seek to understand our mystical realm.
"""

@export_multiline var PROMPT_TEMPLATE_FUNCTION_DESCRIPTION = """### INSTRUCTION
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

End the description with: ﴿﴾
### RESPONSE
"""

func generate_documentation(script_path: String, info: Dictionary) -> String:
	# This function orchestrates the grand ritual of documentation generation
	# It weaves together various aspects of a script into a cohesive tapestry of knowledge
	var file = FileAccess.open(script_path, FileAccess.READ)
	var script_content = file.get_as_text()
	# We begin by laying the foundation of our documentation with YAML frontmatter
	var doc_content = "---\n"
	var script_title = script_path.get_file().get_basename()
	doc_content += "title: " + script_title + "\n"
	doc_content += "last_updated: " + Time.get_datetime_string_from_system() + "\n"
	doc_content += "---\n\n"
	
	# The title of our sacred text, derived from the script's name
	doc_content += "# " + script_title + "\n\n"
	
	# If the script has declared its purpose, we honor it by including it in our documentation
	if info.about:
		doc_content += "## About\n" + info.about + "\n\n"
	
	# We document the mystical properties that define the script's nature
	if info.properties:
		doc_content += "## Properties\n"
		for prop in info.properties:
			doc_content += "- " + prop + "\n"
		doc_content += "\n"
	
	# We document the signals, the mystical events that ripple through our realm
	if info.signals:
		doc_content += "## Signals\n"
		for signal_def in info.signals:
			doc_content += "- " + signal_def + "\n"
		doc_content += "\n"
	
	# The constants, unchanging truths that anchor our script in the fabric of reality
	if info.constants:
		doc_content += "## Constants\n"
		for const_def in info.constants:
			doc_content += "- " + const_def + "\n"
		doc_content += "\n"
	
	# The heart of our documentation: the functions that breathe life into the script
	if info.functions:
		doc_content += "## Functions\n"
		
		for func_def in info.functions:
			var func_name = func_def.split("(")[0].split(" ")[-1]
			var func_code = _extract_function_code(script_content, func_name)
			var description = await _generate_function_description(script_title, info.about, func_name, func_code)
			
			doc_content += "### " + func_name + "\n"
			doc_content += "`" + func_def + "`\n\n"
			doc_content += "﴾" + description + "\n\n"

	doc_content += "---\n\n"
	doc_content += "# Source Code\n\n"
	
	# Format the script content as an indented code block (avoid including triple backtricks anywhere in source code)
	var indented_script_content = ""
	for line in script_content.split("\n"):
		indented_script_content += "\t" + line + "\n"
	
	doc_content += indented_script_content
	
	file.close()
	return doc_content

func _extract_function_code(script_content: String, func_name: String) -> String:
	# This mystical rite extracts the essence of a function from the greater script
	# It seeks out the boundaries of the function and isolates its sacred text
	
	var lines = script_content.split("\n")
	var func_start = -1
	var func_end = -1
	var indent_level = 0

	# We search for the beginning of our function, marked by its name
	for i in range(lines.size()):
		var line = lines[i].strip_edges()
		if line.begins_with("func " + func_name):
			func_start = i
			indent_level = lines[i].count("\t")
			break

	# If we have found the start, we seek the end by watching for a change in indentation
	if func_start != -1:
		for i in range(func_start + 1, lines.size()):
			var line = lines[i]
			var current_indent = line.count("\t")
			if current_indent <= indent_level and line.strip_edges() != "":
				func_end = i - 1
				break
		
		# If we reach the end of the script, we mark it as the function's end
		if func_end == -1:
			func_end = lines.size() - 1

	# We return the extracted function code, or an empty string if our search was in vain
	if func_start != -1 and func_end != -1:
		return "\n".join(lines.slice(func_start, func_end + 1))
	else:
		return ""

func _generate_function_description(script_name: String, script_about: String, func_name: String, func_code: String) -> String:
	var prompt = PROMPT_TEMPLATE_FUNCTION_DESCRIPTION.format({
		"script_name": script_name,
		"script_about": script_about,
		"func_name": func_name,
		"func_code": func_code
	})
	
	const MAX_RETRIES = 3
	var retry_count = 0
	var result = ""
	
	while retry_count < MAX_RETRIES:
		var task_id = "generate_function_description_{0}_{1}_{2}_{3}".format([script_name, func_name, Time.get_unix_time_from_system() * 1000 + randi() % 1000, retry_count])
		
		print("A LoreWeaver asks Shoggoth for a description of {0} from {1} (Attempt {2})...".format([func_name, script_name, retry_count + 1]))
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
			print("The LoreWeaver received this response from Shoggoth, for {0} from {1} (Attempt {2})...".format([func_name, script_name, retry_count + 1]))
			print("~~~ ~~~ ~~~  ~~~ ~~~ ~~~  ~~~ ~~~ ~~~")
			print(result)
			print("~~~ ~~~ ~~~  ~~~ ~~~ ~~~  ~~~ ~~~ ~~~\n")
			
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
