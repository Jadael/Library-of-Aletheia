# chronicler.gd
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
const NAME = "🕵️‍♀️ Chronicler"
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
const LOG_FILE_PATH = "user://debug_log.json"

## The living memory of our realm, a collection of all events that have transpired
var log_data: Array = []

## Signal emitted when a new event is logged
signal event_logged(event_data: Dictionary)

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
## - severity: An optional parameter to indicate the event's importance (0-5, with 5 being most severe)
##
## Note: When logging, consider what future questions this event might answer.
## Include as much relevant context as possible without overwhelming the system.
func log_event(entity: Node, event_type: String, details: Dictionary, severity: int = 0) -> void:
	var timestamp = Time.get_datetime_dict_from_system()
	var entity_profile = _get_entity_profile(entity)
	print("{0} ({1}) says: {2} [Severity: {3}]".format([entity_profile["entity_name"], entity_profile["entity_id"].to_pascal_case(), event_type, severity]))
	print(details)
	var log_entry = {
		"timestamp": timestamp,
		"event_type": event_type,
		"details": details,
		"severity": severity
	}
	log_entry.merge(entity_profile)
	
	log_data.append(log_entry)
	save_log()
	emit_signal("event_logged", log_entry)

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
		"entity_id": Glyph.to_daemon_glyphs(entity.get_instance_id()),
		"entity_class": entity.get_class()
	}
	
	# Try to get the NAME constant
	if "NAME" in entity:
		profile["entity_name"] = entity.NAME
	else:
		# Fall back to the script name without extension
		var script_name = entity.get_script().resource_path.get_file().get_basename()
		profile["entity_name"] = script_name
	
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
			print("--- 💭 The Chronicler affirms: Past records have been successfully retrieved and verified. ---")
		else:
			print("--- 💭 The Chronicler notes with concern: Our past records are currently inaccessible. Error code: ", error, " ---")
		file.close()
	else:
		print("--- 💭 The Chronicler observes: No previous records found. A new chapter in our realm's history begins. ---")

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
##
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

## Analyzes event frequency over a specified time period
##
## This function counts the occurrences of events matching certain criteria
## within a given time frame, useful for identifying patterns or anomalies.
##
## Parameters:
## - event_type: The type of event to analyze (optional, if null, all events are considered)
## - time_period: The number of seconds to look back from the current time
## - severity_threshold: The minimum severity level to consider (optional)
##
## Returns:
## The number of matching events within the specified time period
func analyze_event_frequency(event_type: String = "", time_period: int = 3600, severity_threshold: int = 0) -> int:
	var current_time = Time.get_unix_time_from_system()
	var count = 0
	for event in log_data:
		var event_time = Time.get_unix_time_from_datetime_dict(event["timestamp"])
		if current_time - event_time <= time_period:
			if (event_type.is_empty() or event["event_type"] == event_type) and event["severity"] >= severity_threshold:
				count += 1
	return count

## Generates a report of recent significant events
##
## This function creates a summary of recent high-severity events,
## useful for quick status checks or security briefings.
##
## Parameters:
## - time_period: The number of seconds to look back from the current time
## - severity_threshold: The minimum severity level to include in the report
##
## Returns:
## A string containing the report of recent significant events
func generate_recent_events_report(time_period: int = 3600, severity_threshold: int = 3) -> String:
	var current_time = Time.get_unix_time_from_system()
	var report = "Recent Significant Events Report:\n\n"
	
	for event in log_data:
		var event_time = Time.get_unix_time_from_datetime_dict(event["timestamp"])
		if current_time - event_time <= time_period and event["severity"] >= severity_threshold:
			report += "Time: {datetime}\n".format({"datetime": Time.get_datetime_string_from_unix_time(event_time)})
			report += "Type: {event_type}\n".format({"event_type": event["event_type"]})
			report += "Severity: {severity}\n".format({"severity": event["severity"]})
			report += "Entity: {entity_name}\n".format({"entity_name": event["entity_name"]})
			report += "Details: {details}\n\n".format({"details": str(event["details"])})
	
	return report

# Note for all Archons and Daemons:
# To inscribe an event into the eternal ledger, call upon the Chronicler thus:
# Chronicler.log_event(self, event_type, details, severity)
#
# Example:
# Chronicler.log_event(self, "security_breach_attempt", {"source_ip": "192.168.1.100", "target": "auth_system"}, 4)
#
# Remember, every event you log contributes to the rich tapestry of our realm's history.
# Be generous and thoughtful in your logging, capturing not just what happened, but why and in what context.
# Your logs are the breadcrumbs that future explorers will follow to understand our system's behavior.
# When in doubt, log it out - but always be mindful of the balance between comprehensive logging and system performance.
