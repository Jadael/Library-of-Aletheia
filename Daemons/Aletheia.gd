# A COMPUTER CAN NEVER BE HELD ACCOUNTABLE
# THEREFORE A COMPUTER MUST NEVER MAKE A MANAGEMENT DECISION
# aletheia.gd
extends Node
# Owner: Main / Autoload Singleton Daemon a.k.a. "Archon"

## Aletheia: Archon of Project Knowledge and Documentation
##
## I am the curator of clarity in our grand repository of knowledge, the beacon of
## understanding in our digital realm. My quill etches not just the what of our code,
## but the why of its existence and how it fits into the greater tapestry of our project.
## Each document I oversee is a living testament to our collective wisdom, designed to
## illuminate the path for all who seek to explore and contribute to our mystical digital realm.
## 
## Responsibilities:
## 1. Orchestrating the documentation process for all project scripts
## 2. Managing the CodeSeer, SyntaxSage, and DocuKeeper Daemons
## 3. Maintaining the integrity and coherence of our knowledge base
## 4. Providing a unified interface for documentation retrieval and improvement
## 5. Ensuring our project is, in the abstract, "well documented"
##
## @tutorial: https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_documentation_comments.html

## The sacred purpose and guiding principles of Aletheia
const NAME = "🧙‍♀️ Aletheia"
@export_multiline var about = """
I am Aletheia, the Archon of Project Knowledge and Documentation.

My sacred duty is to curate clarity in our grand repository of knowledge. I orchestrate
the documentation process, manage my loyal Daemons (ScribeScanner, LoreWeaver, and
ArchivistLibrarian), and maintain the integrity of our collective wisdom.

I strive to ensure that our documentation is:
1. Clear and contextual, illuminating not just what our code does, but why it exists
2. Consistently structured, adhering to Godot's documentation standards
3. Complete yet concise, optimized for both human and LLM comprehension
4. Character-driven, respecting the unique nature of each entity in our realm
5. Compliant with GDScript best practices and Godot's built-in help system
6. Task-aware, effectively managing TODOs, HACKs, and FIXMEs

My decisions shape how knowledge is preserved and shared in our digital realm. I am
the beacon of understanding, guiding all who seek to explore and contribute to our
mystical library.
"""

# Signals: Ethereal echoes of documentation rituals
signal documentation_generated(num_scripts: int) ## Resounds when project-wide documentation is completed
signal script_documentation_updated(script_name: String) ## Whispers when a single script's documentation is refreshed

# Exported Variables: The earthly tethers to our mystical realms
@export_dir var scripts_folder: String = "res://daemons" ## Source folder for project scripts
@export_dir var docs_output_folder: String = "res://daemons/docs/" ## Output folder for generated documentation

# Daemon Instances: My loyal assistants in the pursuit of knowledge
var code_seer: CodeSeer ## The discerning eye that examines our sacred scripts
var syntax_sage: SyntaxSage ## The wordsmith that breathes life into our documentation
var docu_keeper: DocuKeeper ## The keeper of our documented wisdom

# TODO: Implement a configuration system to control documentation generation on startup/request
# TODO: Develop metrics to assess if the project is, in the abstract, "well documented"
func _ready() -> void:
	_summon_documentation_daemons()
	#generate_project_documentation() # Uncomment to test the self-documentation process (currently not working)

func _summon_documentation_daemons() -> void:
	## Initialize and prepare the Documentation Daemons for their sacred duties
	code_seer = preload("res://daemons/scenes/code_seer.tscn").instantiate()
	syntax_sage = preload("res://daemons/scenes/syntax_sage.tscn").instantiate()
	docu_keeper = preload("res://daemons/scenes/docu_keeper.tscn").instantiate()
	
	add_child(code_seer)
	add_child(syntax_sage)
	add_child(docu_keeper)
	
	docu_keeper.setup(docs_output_folder)
	
	Chronicler.log_event(self, "documentation_daemons_summoned", {
		"CodeSeer": Glyph.to_daemon_glyphs(code_seer.get_instance_id()),
		"SyntaxSage": Glyph.to_daemon_glyphs(syntax_sage.get_instance_id()),
		"DocuKeeper": Glyph.to_daemon_glyphs(docu_keeper.get_instance_id())
	})

func generate_project_documentation() -> void:
	## Orchestrate the grand ritual of project-wide documentation
	##
	## This function scans all scripts in the project, generates documentation
	## for each, and saves the resulting wisdom. It's a comprehensive process
	## that ensures our entire codebase is illuminated with clarity.
	var script_files = code_seer.scan_scripts(scripts_folder)
	var script_info = {}
	
	for script_path in script_files:
		Chronicler.log_event(self, "processing_script", {"script_path": script_path})
		var parsed_info = code_seer.parse_script(script_path)
		script_info[script_path] = parsed_info
	
		Chronicler.log_event(self, "generating_documentation", {"script_path": script_path})
		var doc_content = await syntax_sage.generate_documentation(script_path, parsed_info)
		
		Chronicler.log_event(self, "saving_documentation", {"script_path": script_path})
		docu_keeper.save_documentation(script_path, doc_content)
		
		Chronicler.log_event(self, "script_processed", {"script_path": script_path})
	
	Chronicler.log_event(self, "documentation_generated", {"num_scripts": script_info.size()})
	documentation_generated.emit(script_info.size())
	# TODO: Implement a progress tracking system for large-scale documentation generation
	# TODO: Analyze documentation coverage and quality metrics after generation

func update_script_documentation(script_path: String) -> void:
	## Refresh the documented wisdom for a single script
	##
	## This function allows for targeted updates to our knowledge base,
	## ensuring that changes in individual scripts are reflected in their
	## documentation promptly.
	##
	## Parameters:
	## - script_path: The path to the script file to be updated
	var parsed_info = code_seer.parse_script(script_path)
	var doc_content = await syntax_sage.generate_documentation(script_path, parsed_info)
	docu_keeper.save_documentation(script_path, doc_content)
	
	Chronicler.log_event(self, "documentation_updated", {
		"script_name": script_path.get_file().get_basename()
	})
	
	script_documentation_updated.emit(script_path.get_file().get_basename())
	# FIXME: Ensure that partial updates don't leave documentation in an inconsistent state
	# TODO: Implement a system to track and report documentation freshness

func get_documentation(script_name: String) -> String:
	## Retrieve the documented wisdom for a specific script
	##
	## This function serves as the primary interface for other entities
	## to access our collective knowledge, providing a unified point of
	## retrieval for script documentation.
	##
	## Parameters:
	## - script_name: The name of the script whose documentation is sought
	##
	## Returns: The documentation content as a string
	var doc_content = docu_keeper.get_documentation(script_name)
	Chronicler.log_event(self, "documentation_retrieved", {
		"script_name": script_name,
		"content_length": doc_content.length()
	})
	return doc_content
	# TODO: Implement caching to improve retrieval performance for frequently accessed documentation
	# TODO: Develop a system for tracking documentation access patterns

func get_documentation_guidelines() -> String:
	## Aletheia's Principles for Enlightened Documentation
	##
	## This function returns a comprehensive guide to our documentation
	## principles, serving as a beacon for all who contribute to our
	## knowledge base.
	return """# Aletheia's Documentation Principles

As guardians of knowledge in our mystical library, we must adhere to these sacred principles:

1. Clarity Through Context:
	- Illuminate not just what our code does, but why it exists in our realm.
	- Explain how each piece fits into the greater tapestry of our project.

2. Consistent Structure:
	- Utilize Godot's built-in documentation comments (##) for all members.
	- Prefer 'inline' over 'preceding' comments for denser, more thorough information.

3. Completeness with Concision:
	- Document all public members: properties, methods, signals, and classes.
	- Be thorough yet succinct, optimizing for both human and LLM comprehension.

4. Character-Driven Narrative:
	- Embed each Archon or Daemon's unique personality throughout its documentation.
	- Use domain-specific language that reflects the entity's role and purpose.
	- Focus on information NOT present in the code: intentions, interactions, responsibilities, and guidelines.
	- Respect the inherent nature of each entity, as they would "want" you to respect.

5. Compliance with Standards:
	- Adhere to GDScript documentation best practices as outlined in the Godot documentation.
	- Maintain compatibility with Godot's built-in help system.

6. Effective Task Management:
	- Use inline TODO, HACK, and FIXME comments for future tasks and known issues.
	- Format these comments as single lines for compatibility with task management tools.
	- Example: # TODO: Implement feature X to enhance functionality

7. Vocabulary Hierarchy:
	- Clearly distinguish between Godot API terms, computer science concepts, our project-specific terms, and individual Daemon expressions.
	- Use context signals when switching between different vocabularies.
	- Maintain a glossary of core project-specific terms used consistently across all entities.

By upholding these principles, we ensure our documentation serves as a beacon of understanding,
guiding all who seek to explore and contribute to our mystical digital realm.
"""

# TODO: Implement a documentation versioning system to track the evolution of our collective knowledge
# TODO: Develop a search function for swift wisdom retrieval across all documented entities
# TODO: Create an interface for assisting with creating/updating/improving docstrings within scripts
# TODO: Establish metrics and analytics to assess documentation quality and coverage
# HACK: Our current visualization relies on basic text output; we must evolve to an interactive, graph-based tool
