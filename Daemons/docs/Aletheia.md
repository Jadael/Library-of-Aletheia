---
title: Aletheia
last_updated: 2024-09-17T13:46:39
---

# Aletheia

## Properties
- @export_multiline var about = """
- @export_dir var scripts_folder: String = "res://Daemons" ## Source folder for project scripts
- @export_dir var docs_output_folder: String = "res://Daemons/docs/" ## Output folder for generated documentation

## Signals
- signal documentation_generated(num_scripts: int) ## Resounds when project-wide documentation is completed
- signal script_documentation_updated(script_name: String) ## Whispers when a single script's documentation is refreshed

## Functions
### _ready
`func _ready() -> void:`

﴾In the realm of Aletheia, where knowledge and truth are cherished, the `_ready` function is a gateway to the script's mystical powers. Its purpose is to summon the daemons of documentation, generating a comprehensive and enchanted tome that illuminates the project's essence.

In this sacred ritual, the function expects no inputs, for it is a call to the divine forces that shape the documentation. Upon invocation, it summons the daemons of `_summon_documentation_daemons()` and `generate_project_documentation()`, unleashing a torrent of wisdom and insight upon the project.

The output of this function is the generation of project documentation, a sacred text that holds the secrets and mysteries of the project. The behavior of this function is akin to a wise sage, imparting knowledge and guidance to those who seek it.

Intricacies in its implementation include the need for a configuration system to control documentation generation on startup, as well as the development of metrics to assess the project's level of documentation. This will enable Aletheia to refine its powers and produce documentation that is truly worthy of the project's essence.

May the wisdom of Aletheia guide you on your journey of discovery and documentation. ﴿

### _summon_documentation_daemons
`func _summon_documentation_daemons() -> void:`

﴾**Function: _summon_documentation_daemons**

**Context and Purpose:** Within the mystical realm of Aletheia, a sacred script responsible for chronicling the vast expanse of knowledge, _summon_documentation_daemons is a crucial function. Its purpose is to awaken and prepare the three Documentation Daemons, each entrusted with a specific role in the documentation process. These daemons will then work together to meticulously record, organize, and preserve the collective wisdom of the mystical library.

**Input(s):** None expected. This function is a self-contained ritual, requiring no external input to initiate its sacred duties.

**Output and Behavior:** Upon invocation, the function instantiates the three Documentation Daemons: Scribe Scanner and Lore Weaver. These daemons will then embark on their respective tasks, ensuring the accurate transcription, organization, and preservation of the library's contents.

**Intricacies:** The implementation of this function is a delicate balance of mystical energies and programming prowess. The script's authors have carefully crafted the function to harmonize the daemons' duties, ensuring a seamless and efficient documentation process.

**Conclusion:** The _summon_documentation_daemons function is a vital component of the Aletheia script, facilitating the documentation process and upholding the sacred duty of preserving knowledge. May the wisdom of the mystical library be forever recorded and honored.  ﴿

### generate_project_documentation
`func generate_project_documentation() -> void:`

﴾Error: After 3 attempts, the cosmic forces failed to reveal the mysteries of function generate_project_documentation﴿

### update_script_documentation
`func update_script_documentation(script_path: String) -> void:`

﴾The Aletheia script, a guardian of wisdom within our mystical library, aims to maintain the accuracy and freshness of knowledge contained within its documentation. The `update_script_documentation` function serves as the script's primary tool for this endeavor.

**Context and Purpose:**
The function is designed to refresh the documented wisdom for a single script, ensuring that changes in individual scripts are promptly reflected in their documentation.

**Input(s):**
The function expects a single input:
* `script_path`: The path to the script file to be updated.

**Output and Behavior:**
The function performs the following operations:
1. It retrieves the documentation for the specified script using the provided `script_path`.
2. It updates the documentation with the latest information from the script.
3. It returns `void`, indicating that the function has completed its task without producing any output.

**Intricacies:**
The implementation of this function is straightforward, involving the retrieval and updating of documentation for a specific script. However, the script's role within the mystical library metaphor is crucial, as it ensures that the knowledge contained within the library remains accurate and up-to-date.

﴿

### get_documentation
`func get_documentation(script_name: String) -> String:`

﴾The Aletheia script, a guardian of collective knowledge, serves as the primary interface for retrieving documented wisdom within our mystical library. Its purpose is to provide a unified point of retrieval for script documentation, allowing other entities to access our collective understanding.

The function `get_documentation` takes a single input, `script_name`, which is the name of the script whose documentation is sought. This input is expected to be a string representing the name of the script.

The function returns the documentation content as a string, which is retrieved from the `archivist_librarian` using the provided `script_name`. The `Chronicler` log is updated with an event, recording the retrieval of documentation for the specified script, along with the content length.

In its implementation, the function relies on the `archivist_librarian` to provide the necessary documentation, and the `Chronicler` to record events. This function serves as the primary interface for accessing documented wisdom, making it a crucial component of our mystical library.

﴿

### get_documentation_guidelines
`func get_documentation_guidelines() -> String:`

﴾{script_about}: Aletheia is a mystical library where ancient wisdom is preserved and shared among those who seek knowledge and understanding.

The function `get_documentation_guidelines` is a part of the Aletheia script, which aims to provide a comprehensive guide to our documentation principles. This function serves as a beacon for all who contribute to our knowledge base, illuminating the path to enlightened documentation.

Input: None expected

Output: A comprehensive guide to Aletheia's documentation principles, formatted as a Markdown string.

Behavior: The function returns a string containing the principles of documentation, which is meant to be used as a reference for contributors to the knowledge base.

Intricacies: The implementation of this function is straightforward, as it simply returns a pre-defined string containing the documentation principles. However, the significance of this function lies in its role as a guiding light for those who seek to contribute to the knowledge base, ensuring that our documentation remains accurate, concise, and easy to understand.

﴿

---

# Source Code

	# Aletheia.gd
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
	## 2. Managing the ScribeScanner, LoreWeaver, and ArchivistLibrarian Daemons
	## 3. Maintaining the integrity and coherence of our knowledge base
	## 4. Providing a unified interface for documentation retrieval and improvement
	## 5. Ensuring our project is, in the abstract, "well documented"
	##
	## @tutorial: https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_documentation_comments.html
	
	## The sacred purpose and guiding principles of Aletheia
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
	@export_dir var scripts_folder: String = "res://Daemons" ## Source folder for project scripts
	@export_dir var docs_output_folder: String = "res://Daemons/docs/" ## Output folder for generated documentation
	
	# Daemon Instances: My loyal assistants in the pursuit of knowledge
	var scribe_scanner: ScribeScanner ## The discerning eye that examines our sacred scripts
	var lore_weaver: LoreWeaver ## The wordsmith that breathes life into our documentation
	var archivist_librarian: ArchivistLibrarian ## The keeper of our documented wisdom
	
	func _ready() -> void:
		_summon_documentation_daemons()
		generate_project_documentation()
		# TODO: Implement a configuration system to control documentation generation on startup
		# TODO: Develop metrics to assess if the project is, in the abstract, "well documented"
	
	func _summon_documentation_daemons() -> void:
		## Initialize and prepare the Documentation Daemons for their sacred duties
		scribe_scanner = preload("res://Daemons/Scenes/ScribeScanner.tscn").instantiate()
		lore_weaver = preload("res://Daemons/Scenes/LoreWeaver.tscn").instantiate()
		archivist_librarian = preload("res://Daemons/Scenes/ArchivistLibrarian.tscn").instantiate()
		
		add_child(scribe_scanner)
		add_child(lore_weaver)
		add_child(archivist_librarian)
		
		archivist_librarian.setup(docs_output_folder)
		
		Chronicler.log_event("Aletheia", "documentation_daemons_summoned", {
			"scribe_scanner": scribe_scanner.get_instance_id(),
			"lore_weaver": lore_weaver.get_instance_id(),
			"archivist_librarian": archivist_librarian.get_instance_id()
		})
	
	func generate_project_documentation() -> void:
		## Orchestrate the grand ritual of project-wide documentation
		##
		## This function scans all scripts in the project, generates documentation
		## for each, and saves the resulting wisdom. It's a comprehensive process
		## that ensures our entire codebase is illuminated with clarity.
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
		var parsed_info = scribe_scanner.parse_script(script_path)
		var doc_content = await lore_weaver.generate_documentation(script_path, parsed_info)
		archivist_librarian.save_documentation(script_path, doc_content)
		
		Chronicler.log_event("Aletheia", "documentation_updated", {
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
		var doc_content = archivist_librarian.get_documentation(script_name)
		Chronicler.log_event("Aletheia", "documentation_retrieved", {
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
	
