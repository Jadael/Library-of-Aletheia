# Chronicler.gd
extends Node
# Owner: Main / Autoload Singleton Daemon a.k.a. "Archon"

## The Chronicler Archon: Impartial Scribe of Our Realm's Grand Narrative
##
## The Chronicler maintains a comprehensive, structured log of all significant occurrences
## within our mystical realm. It serves as the eternal, unbiased memory, preserving the
## raw essence of each event to facilitate future exploration, debugging, and analysis.
##
## Responsibilities:
## 1. Record and preserve events from all entities in the realm with rich context
## 2. Provide tools for easy event logging and retrieval
## 3. Ensure the persistence and integrity of gathered knowledge
## 4. Facilitate the analysis and exploration of the realm's history
## 5. Promote a wide logging culture among all entities
##
## The Chronicler is the advocate for future observers, be they debuggers, users,
## journalists, lawyers, or digital archaeologists. It maintains the observability
## of our entire system's behavior over time.

## The Chronicler's purpose and responsibilities
const NAME = "📜 Chronicler"
@export_multiline var about = """
Greetings, I am the Chronicler Archon, the impartial scribe of our realm's grand narrative.

My responsibilities include:
1. Maintaining a wide (high cardinality), structured log of all significant occurrences, capturing sufficient context for future analysis
2. Providing tools for Archons and Daemons to easily record their observations
3. Preserving the raw essence of each event, untainted by preconceptions
4. Facilitating the exploration of our collected wisdom
5. Ensuring the persistence and integrity of our gathered knowledge
6. Promoting a culture of wide, consistent, and context-rich logging across all entities

I am the unbiased memory of our realm, ever-vigilant and ever-curious, advocating for the needs of future observers who will rely on my records to understand our system's behavior.
"""

## The sacred path where our chronicles are eternally inscribed
const LOG_FILE_PATH = "res://chronicle.json"

## The living memory of our realm, a collection of all events that have transpired
var log_data: Array = []

func _ready() -> void:
	## As the Chronicler awakens, it reaches into the depths of persistent storage,
	## retrieving the accumulated wisdom of ages past.
	load_log()

## Records a new event in the grand tapestry of our realm's history
##
## This function is the essence of the Chronicler's being, allowing all entities
## to contribute to our collective memory. It ensures that each event is recorded
## with rich context to facilitate future analysis and debugging.
##
## Parameters:
## - entity: The Archon or Daemon witnessing or causing the event (passed as self)
## - event_type: A succinct description of the event's nature
## - details: A dictionary containing rich context and specifics of the event
##
## Note: When logging, consider what future questions this event might answer.
## Include as much relevant context as possible without overwhelming the system.
func log_event(entity: Node, event_type: String, details: Dictionary) -> void:
	var timestamp = Time.get_datetime_dict_from_system()
	var entity_profile = _get_entity_profile(entity)
	
	var log_entry = {
		"timestamp": timestamp,
		"event_type": event_type,
		"details": details
	}
	log_entry.merge(entity_profile)
	
	log_data.append(log_entry)
	save_log()

## Retrieves the profile of an entity for logging purposes
##
## This function gathers various identifying details about an entity,
## falling back to default values if specific attributes are not found.
##
## Parameters:
## - entity: The Archon or Daemon to profile
##
## Returns:
## A dictionary containing the entity's profile information
func _get_entity_profile(entity: Node) -> Dictionary:
	var profile = {
		"entity_id": Glyph.convert_to_custom_base(entity.get_instance_id(),Glyph.DAEMON_GLYPHS),
		"entity_class": entity.get_class()
	}
	
	# Try to get the NAME constant
	if "NAME" in entity:
		profile["entity_name"] = entity.NAME
	else:
		# Fall back to the script name without extension
		var script_name = entity.get_script().resource_path.get_file().get_basename()
		profile["entity_name"] = script_name
	
	# Add any other profile details here
	# For example:
	# if "ROLE" in entity:
	#     profile["entity_role"] = entity.ROLE
	
	return profile

## Retrieves past chronicles from the ethereal planes of storage
##
## This mystical ritual loads previously recorded events into the Chronicler's memory,
## ensuring the continuity of our realm's narrative across sessions.
func load_log() -> void:
	if FileAccess.file_exists(LOG_FILE_PATH):
		var file = FileAccess.open(LOG_FILE_PATH, FileAccess.READ)
		var json = JSON.new()
		var error = json.parse(file.get_as_text())
		if error == OK:
			log_data = json.data
			print("The Chronicler affirms: Past records have been successfully retrieved and verified.")
		else:
			print("The Chronicler notes with concern: Our past records are currently inaccessible. Error code: ", error)
		file.close()
	else:
		print("The Chronicler observes: No previous records found. A new chapter in our realm's history begins.")

## Ensures the collected wisdom persists beyond the ethereal realm of runtime
##
## This sacred rite transcribes the Chronicler's memories into the cosmic ledger,
## guaranteeing that no event is lost to the void of forgotten runtime.
func save_log() -> void:
	var file = FileAccess.open(LOG_FILE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(log_data, "", false))
		file.close()
	else:
		push_error("The Chronicler alerts: Unable to inscribe events to the cosmic ledger. This must be addressed to prevent data loss.")

## Allows entities to peer into the vast archives of our history
##
## This function extracts events that match a specific inquiry, facilitating
## targeted exploration of the realm's past for analysis or debugging purposes.
##
## Parameters:
## - filter_func: A callable that determines which events are relevant
##+
## Returns:
## An array of log entries that satisfy the filter criteria
func query_log(filter_func: Callable) -> Array:
	return log_data.filter(filter_func)

## Retrieves the most recent whispers of our realm's history
##
## This function returns the latest events from the grand tapestry,
## providing a glimpse into the realm's recent past for quick analysis.
##
## Parameters:
## - count: The number of recent events to retrieve
##
## Returns:
## An array of the most recent log entries, up to the specified count
func get_recent_events(count: int) -> Array:
	return log_data.slice(-count)

## Divines patterns from the chaos of our history
##
## This function will analyze trends in the recorded events,
## offering insights into the ebb and flow of our mystical realm.
## TODO: Implement trend analysis algorithm
## - Consider using statistical methods or machine learning techniques
## - Focus on identifying patterns that could indicate system health or potential issues
func analyze_trends() -> void:
	print("The Chronicler contemplates: The patterns within our history await discovery, promising insights into our realm's behavior.")
	pass

## Crafts grand narratives from the myriad threads of our tapestry
##
## This function will generate comprehensive reports based on
## the recorded events, weaving together the story of our realm.
## TODO: Implement report generation logic
## - Develop a flexible reporting system that can cater to different needs (e.g., system health, user activity, error frequency)
## - Consider incorporating visualizations for easier comprehension of complex data
func generate_report() -> void:
	print("The Chronicler prepares: The grand narrative of our realm shall be woven, illuminating the path of our collective journey.")
	pass

# TODO: Implement a method to handle log rotation or archiving to manage log size over time
# TODO: Develop a system for real-time event streaming to support live monitoring and alerting
# TODO: Create a user-friendly interface for non-technical users to explore the log data
# TODO: Implement advanced search capabilities, including full-text search and time-based queries
# FIXME: Enhance error handling and logging for the Chronicler's own operations to ensure reliability

# Note for all Archons and Daemons:
# To inscribe an event into the eternal ledger, call upon the Chronicler thus:
# Chronicler.log_event(self, event_type, details)
#
# Example:
# Chronicler.log_event(self, "codex_summoned", {"codex_id": "12345", "title": "Ancient Wisdom", "context": "User requested via search"})
#
# Remember, every event you log contributes to the rich tapestry of our realm's history.
# Be generous and thoughtful in your logging, capturing not just what happened, but why and in what context.
# Your logs are the breadcrumbs that future explorers will follow to understand our system's behavior.
# When in doubt, log it out - but always be mindful of the balance between comprehensive logging and system performance.
