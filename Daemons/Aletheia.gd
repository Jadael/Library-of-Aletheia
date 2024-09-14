# Aletheia.gd
extends Node

## Aletheia: Archon of Project Knowledge and Documentation
##
## Aletheia orchestrates the documentation process for the project,
## ensuring transparency, accuracy, and accessibility of information.
## 
## Responsibilities:
## 1. Coordinating documentation generation for all project scripts
## 2. Managing ScribeScanner, LoreWeaver, and ArchivistLibrarian Daemons
## 3. Maintaining the integrity and coherence of the knowledge base
## 4. Providing access to project documentation for all entities
##
## @tutorial: https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_documentation_comments.html

# Paths for script source and documentation output
@export_dir var scripts_folder: String = "res://Daemons" ## Source folder for project scripts
@export_dir var docs_output_folder: String = "res://Daemons/docs/" ## Output folder for generated documentation

# Daemon instances for documentation tasks
var scribe_scanner: ScribeScanner ## Daemon for script parsing and analysis
var lore_weaver: LoreWeaver ## Daemon for documentation content generation
var archivist_librarian: ArchivistLibrarian ## Daemon for documentation storage and retrieval

## Emitted when project-wide documentation is completed
signal documentation_generated(num_scripts: int)

## Emitted when a single script's documentation is updated
signal script_documentation_updated(script_name: String)

func _ready() -> void:
	_summon_daemons()
	# TODO: Implement a configuration system to control documentation generation on startup

func _summon_daemons() -> void:
	## Initialize and prepare Daemons for documentation tasks
	scribe_scanner = preload("res://Daemons/Scenes/ScribeScanner.tscn").instantiate()
	lore_weaver = preload("res://Daemons/Scenes/LoreWeaver.tscn").instantiate()
	archivist_librarian = preload("res://Daemons/Scenes/ArchivistLibrarian.tscn").instantiate()
	
	add_child(scribe_scanner)
	add_child(lore_weaver)
	add_child(archivist_librarian)
	
	archivist_librarian.setup(docs_output_folder)

func generate_project_documentation() -> void:
	## Orchestrate the documentation process for all project scripts
	var script_files = scribe_scanner.scan_scripts(scripts_folder)
	var script_info = {}
	
	for script_path in script_files:
		Chronicler.log_event("Aletheia", "processing_script", {"script_path": script_path})
		var parsed_info = scribe_scanner.parse_script(script_path)
		script_info[script_path] = parsed_info
	
		Chronicler.log_event("Aletheia", "generating_documentation", {"script_path": script_path})
		var doc_content = await lore_weaver.generate_documentation(script_path, parsed_info)
		
		Chronicler.log_event("Aletheia", "saving_documentation", {"script_path": script_path})
		archivist_librarian.save_documentation(script_path, doc_content)
		
		Chronicler.log_event("Aletheia", "script_processed", {"script_path": script_path})
	
	Chronicler.log_event("Aletheia", "documentation_generated", {"num_scripts": script_info.size()})
	emit_signal("documentation_generated", script_info.size())
	# TODO: Implement a progress tracking system for large-scale documentation generation

func update_script_documentation(script_path: String) -> void:
	## Update documentation for a single script
	var parsed_info = scribe_scanner.parse_script(script_path)
	var doc_content = await lore_weaver.generate_documentation(script_path, parsed_info)
	archivist_librarian.save_documentation(script_path, doc_content)
	
	Chronicler.log_event("Aletheia", "documentation_updated", {
		"script_name": script_path.get_file().get_basename()
	})
	
	emit_signal("script_documentation_updated", script_path.get_file().get_basename())
	# FIXME: Ensure that partial updates don't leave documentation in an inconsistent state

func get_documentation(script_name: String) -> String:
	## Retrieve documentation for a specific script
	return archivist_librarian.get_documentation(script_name)
	# TODO: Implement caching to improve retrieval performance for frequently accessed documentation

func get_documentation_guidelines() -> String:
	## Aletheia's Principles for Enlightened Documentation
	return """# Aletheia's Documentation Principles

As guardians of knowledge, we must adhere to these principles:

1. Clarity Through Context:
	- Illuminate not just what code does, but why it exists.
	- Explain how each piece fits into the greater whole.

2. Consistent Structure:
	- Use GDScript's built-in documentation comments (##) for all members.
	- Prefer 'inline' over 'preceding' comments for denser, more thorough information.

3. Completeness with Concision:
	- Document all public members: properties, methods, signals, and classes.
	- Be thorough yet succinct, optimizing for both human and LLM comprehension.

4. Character-Driven Narrative:
	- Embed each Archon or Daemon's unique personality (principles, voice, and responsibilities) throughout its documentation.
	- Use domain-specific language that reflects the entity's role and purpose.
	- Focus on information NOT present in the code: intentions, other daemons, responsbilities, assumptions, guidelines, etc.
	- Respect their principles and responsibilities, i.e. don't change them in ways they wouldn't "want".

5. Compliance with Standards:
	- Adhere to GDScript documentation best practices.
	- Maintain compatibility with Godot's built-in help system.

6. Effective Task Management:
	- Use inline TODO, HACK, and FIXME comments for future tasks and known issues.
	- Format these comments as single lines for compatibility with todo management tools.
	- Example: # TODO: Implement feature X to enhance functionality

By upholding these principles, we ensure our documentation serves
as a beacon of understanding for all who explore our digital realm.
"""

# TODO: Implement documentation versioning system for tracking knowledge evolution
# TODO: Develop a search function for quick knowledge retrieval across all documented entities
# HACK: Current visualization uses basic text output; replace with an interactive graph-based tool
