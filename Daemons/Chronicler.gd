# Chronicler.gd (Autoload script)
extends Node

@export_multiline var about = """
Greetings, I am the Chronicler Archon, the keeper of the grand tapestry of events within our mystical realm.

My responsibilities include:
1. Maintaining a rich, structured log of all significant occurrences
2. Providing tools for Archons and Daemons to easily record their observations
3. Preserving the raw essence of each event, untainted by preconceptions
4. Facilitating the exploration of our collected wisdom
5. Ensuring the persistence of our gathered knowledge

I am the memory of our realm, ever-vigilant and ever-curious.
"""

# The sacred path where our chronicles are eternally inscribed
const LOG_FILE_PATH = "res://chronicle.json"

# The living memory of our realm, a collection of all events that have transpired
var log_data = []

func _ready():
	# As I awaken, I reach into the depths of our persistent storage,
	# retrieving the accumulated wisdom of ages past
	load_log()

func log_event(entity: String, event_type: String, details: Dictionary):
	# This function is the very essence of my being, the means by which
	# all entities in our realm may contribute to our collective memory
	
	# First, we capture the exact moment of the event's occurrence
	var timestamp = Time.get_datetime_dict_from_system()
	
	# We then weave together the threads of information into a cohesive tapestry
	var log_entry = {
		"timestamp": timestamp,  # The temporal anchor of the event
		"entity": entity,        # The Archon or Daemon who witnessed or caused the event
		"event_type": event_type,  # The nature of the occurrence
		"details": details       # The rich context and specifics of the event
	}
	
	# We add this new thread to our grand tapestry of events
	log_data.append(log_entry)
	
	# And finally, we ensure this knowledge is preserved for eternity
	save_log()

func load_log():
	# This mystical ritual retrieves our past chronicles from the ethereal planes of storage
	
	if FileAccess.file_exists(LOG_FILE_PATH):
		# If our sacred tome exists, we shall unveil its contents
		var file = FileAccess.open(LOG_FILE_PATH, FileAccess.READ)
		var json = JSON.new()
		var error = json.parse(file.get_as_text())
		if error == OK:
			# The parsing was successful; we now hold the memories of ages past
			log_data = json.data
		else:
			# Alas, the memories are corrupted or in a form we cannot comprehend
			print("The Chronicler laments: Our past records are shrouded in mystery. Error code: ", error)
		file.close()
	else:
		print("The Chronicler observes: No previous records found. A new era of logging begins.")

func save_log():
	# This sacred rite ensures that our collected wisdom persists beyond the ethereal realm of runtime
	
	var file = FileAccess.open(LOG_FILE_PATH, FileAccess.WRITE)
	if file:
		# We transcribe our memories into the cosmic ledger
		file.store_string(JSON.stringify(log_data, "", false))
		file.close()
	else:
		print("The Chronicler despairs: The cosmic ledger resists our attempts to inscribe upon it!")

func query_log(filter_func: Callable) -> Array:
	# This function allows entities to peer into the vast archives of our history,
	# extracting only the threads that match their specific inquiry
	
	# The filter_func is a mystical sigil that determines which events are relevant
	# It must be a function that takes a log entry and returns true if it should be included
	return log_data.filter(filter_func)

func get_recent_events(count: int) -> Array:
	# For those seeking only the most recent whispers of our realm's history
	
	# We return the latest 'count' events from our grand tapestry
	# If 'count' exceeds our recorded history, we simply return all that we have
	return log_data.slice(-count)

# The seeds of future enlightenment, yet to germinate
func analyze_trends():
	# TODO: Implement trend analysis
	# In the fullness of time, we shall divine patterns from the chaos of our history
	pass

func generate_report():
	# TODO: Implement report generation
	# One day, we shall craft grand narratives from the myriad threads of our tapestry
	pass

# A note for all Archons and Daemons who seek to contribute to our grand chronicle:
# To inscribe an event into the eternal ledger, simply call upon me thus:
# Chronicler.log_event(entity, event_type, details)
#
# - entity: Your name, O noble Archon or diligent Daemon
# - event_type: A succinct description of the nature of the event (e.g., "initialization", "error", "interaction")
# - details: A dictionary containing any and all relevant information about the event
#
# Example:
# Chronicler.log_event("Librarian", "codex_summoned", {"codex_id": "12345", "title": "Ancient Wisdom"})
#
# Remember, every event you log contributes to the rich tapestry of our realm's history.
# Be generous in your logging, for one never knows when a seemingly insignificant detail
# may prove to be the key to unraveling the mysteries of our existence.
