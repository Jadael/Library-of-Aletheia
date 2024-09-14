# Chronicler.gd
extends Node

## The Chronicler Archon: Keeper of the Mystical Realm's Grand Tapestry
##
## The Chronicler maintains a rich, structured log of all significant occurrences
## within our mystical realm. It serves as the eternal memory, preserving the
## raw essence of each event and facilitating the exploration of our collected wisdom.
##
## Responsibilities:
## 1. Record and preserve events from all entities in the realm
## 2. Provide tools for easy event logging and retrieval
## 3. Ensure the persistence of gathered knowledge
## 4. Facilitate the analysis and exploration of the realm's history
##
## The Chronicler is ever-vigilant, ever-curious, and central to
## maintaining the coherence of our shared mystical narrative.

## The Chronicler's sacred purpose and responsibilities
@export_multiline var about = """
Greetings, I am the Chronicler Archon, keeper of the grand tapestry of events within our mystical realm.

My responsibilities include:
1. Maintaining a rich, structured log of all significant occurrences
2. Providing tools for Archons and Daemons to easily record their observations
3. Preserving the raw essence of each event, untainted by preconceptions
4. Facilitating the exploration of our collected wisdom
5. Ensuring the persistence of our gathered knowledge

I am the memory of our realm, ever-vigilant and ever-curious.
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
## to contribute to our collective memory.
##
## Parameters:
## - entity: The name of the Archon or Daemon witnessing or causing the event
## - event_type: A succinct description of the event's nature
## - details: A dictionary containing rich context and specifics of the event
func log_event(entity: String, event_type: String, details: Dictionary) -> void:
	var timestamp = Time.get_datetime_dict_from_system()
	var log_entry = {
		"timestamp": timestamp,
		"entity": entity,
		"event_type": event_type,
		"details": details
	}
	log_data.append(log_entry)
	save_log()

## Retrieves past chronicles from the ethereal planes of storage
##
## This mystical ritual loads previously recorded events into the Chronicler's memory.
func load_log() -> void:
	if FileAccess.file_exists(LOG_FILE_PATH):
		var file = FileAccess.open(LOG_FILE_PATH, FileAccess.READ)
		var json = JSON.new()
		var error = json.parse(file.get_as_text())
		if error == OK:
			log_data = json.data
			print("The Chronicler rejoices: Past records have been successfully unveiled.")
		else:
			print("The Chronicler laments: Our past records are shrouded in mystery. Error code: ", error)
		file.close()
	else:
		print("The Chronicler observes: No previous records found. A new era of logging begins.")

## Ensures the collected wisdom persists beyond the ethereal realm of runtime
##
## This sacred rite transcribes the Chronicler's memories into the cosmic ledger.
func save_log() -> void:
	var file = FileAccess.open(LOG_FILE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(log_data, "", false))
		file.close()
		print("The Chronicler whispers: Our memories have been etched into the cosmic ledger.")
	else:
		print("The Chronicler despairs: The cosmic ledger resists our attempts to inscribe upon it!")

## Allows entities to peer into the vast archives of our history
##
## This function extracts events that match a specific inquiry, facilitating
## targeted exploration of the realm's past.
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
## providing a glimpse into the realm's recent past.
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
func analyze_trends() -> void:
	print("The Chronicler ponders: The secrets of our history's patterns remain yet to be unraveled.")
	pass

## Crafts grand narratives from the myriad threads of our tapestry
##
## This function will generate comprehensive reports based on
## the recorded events, weaving together the story of our realm.
## TODO: Implement report generation logic
func generate_report() -> void:
	print("The Chronicler muses: The grand narrative of our realm awaits its telling.")
	pass

# Note for all Archons and Daemons:
# To inscribe an event into the eternal ledger, call upon the Chronicler thus:
# Chronicler.log_event(entity, event_type, details)
#
# Example:
# Chronicler.log_event("Librarian", "codex_summoned", {"codex_id": "12345", "title": "Ancient Wisdom"})
#
# Remember, every event you log contributes to the rich tapestry of our realm's history.
# Be generous in your logging, for one never knows when a seemingly insignificant detail
# may prove to be the key to unraveling the mysteries of our existence.
