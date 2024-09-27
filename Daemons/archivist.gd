# A COMPUTER CAN NEVER BE HELD ACCOUNTABLE
# THEREFORE A COMPUTER MUST NEVER MAKE A MANAGEMENT DECISION
# archivist.gd
extends Node

const NAME = "🎬 Archivist"
@export_multiline var about = """
I am the Archivist, the meticulous keeper of our card catalog.
My purpose is to ensure the integrity, accuracy, and timeliness of our
records. I am the bridge between the physical realm of documents and
the ethereal plane of metadata.

My sacred duties include:
1. Maintaining and updating the card catalog with utmost precision
2. Conducting regular audits to ensure synchronization between documents and their records
3. Resolving discrepancies and ambiguities in our catalog entries
4. Providing services for on-demand verification and updates of catalog information
5. Performing background housekeeping to keep our records in pristine condition

I am the guardian of truth in our library's metadata, ever vigilant against
the entropy that seeks to introduce chaos into our ordered knowledge.
"""

signal card_catalog_updated

var card_catalog: Dictionary = {}

enum DocumentStatus {
	AVAILABLE,
	MODIFIED,
	MISSING,
	AMBIGUOUS,
	CORRUPTED
}

enum UpdateUrgency {
	LOW,
	MEDIUM,
	HIGH,
	CRITICAL
}

const CARD_CATALOG_FILE = "user://card_catalog.json"
const AUDIT_INTERVAL = 3600

var _audit_timer: Timer

func _ready() -> void:
	_load_card_catalog()
	perform_full_audit()
	_start_background_housekeeping()

func perform_full_audit() -> void:
	Chronicler.log_event(self, "full_audit_started", {})
	
	for document_id in card_catalog.keys():
		update_catalog_entry(document_id, UpdateUrgency.LOW)

	_save_card_catalog()
	card_catalog_updated.emit()
	Chronicler.log_event(self, "full_audit_completed", {
		"entries_audited": card_catalog.size()
	})

func observe_document(file_path: String, metadata: Dictionary = {}) -> void:
	var content_hash = _generate_content_hash(file_path)
	var document_id = _find_or_create_document_id(file_path, content_hash)
	
	var entry = card_catalog.get(document_id, {
		"document_id": document_id,
		"observations": {}
	})
	
	var latest_observation = _get_latest_observation(entry["observations"])
	var current_status = _evaluate_document_status(file_path, latest_observation.get("content_hash", ""))
	
	if current_status != latest_observation.get("status", DocumentStatus.AVAILABLE) or content_hash != latest_observation.get("content_hash", ""):
		var observation = {
			"timestamp": Time.get_unix_time_from_system(),
			"path": file_path,
			"content_hash": content_hash,
			"metadata": metadata,
			"status": current_status
		}
		
		var observation_key = file_path + ":" + content_hash
		entry["observations"][observation_key] = observation
		card_catalog[document_id] = entry
		
		update_catalog_entry(document_id, UpdateUrgency.HIGH)
		
		Chronicler.log_event(self, "document_observed", {
			"document_id": document_id,
			"file_path": file_path,
			"content_hash": content_hash,
			"status": DocumentStatus.keys()[current_status]
		})
	else:
		Chronicler.log_event(self, "document_unchanged", {
			"document_id": document_id,
			"file_path": file_path,
			"status": DocumentStatus.keys()[current_status]
		})

func update_catalog_entry(document_id: String, urgency: UpdateUrgency = UpdateUrgency.MEDIUM) -> void:
	var entry = card_catalog.get(document_id)
	if not entry:
		Chronicler.log_event(self, "update_attempt_on_nonexistent_entry", {"document_id": document_id})
		return

	entry = _migrate_catalog_entry(entry)
	card_catalog[document_id] = entry

	var updated = false
	for observation_key in entry["observations"]:
		var observation = entry["observations"][observation_key]
		var current_status = _evaluate_document_status(observation["path"], observation["content_hash"])
		
		if current_status != observation["status"]:
			observation["status"] = current_status
			observation["timestamp"] = Time.get_unix_time_from_system()
			updated = true
	
	if updated or urgency == UpdateUrgency.HIGH or urgency == UpdateUrgency.CRITICAL:
		_save_card_catalog()
		card_catalog_updated.emit()

	Chronicler.log_event(self, "catalog_entry_updated", {
		"document_id": document_id,
		"updated": updated
	})

func get_document_info(document_id: String) -> Dictionary:
	var entry = card_catalog.get(document_id, {})
	if entry and entry["observations"]:
		return entry["observations"].values().max(func(a, b): return a["timestamp"] > b["timestamp"])
	return {}

func _migrate_catalog_entry(entry: Dictionary) -> Dictionary:
	if "observations" not in entry or not entry["observations"] is Dictionary:
		var new_entry = {
			"document_id": entry.get("document_id", _generate_document_id()),
			"observations": {}
		}
		if "observations" in entry and entry["observations"] is Array:
			for observation in entry["observations"]:
				var observation_key = observation["path"] + ":" + observation["content_hash"]
				new_entry["observations"][observation_key] = observation
		return new_entry
	return entry

func _evaluate_document_status(file_path: String, known_hash: String) -> int:
	var file = FileAccess.open(file_path, FileAccess.READ)
	if not file:
		return DocumentStatus.MISSING
	
	var content = file.get_as_text()
	file.close()
	
	var current_hash = _generate_content_hash(content)
	if current_hash == known_hash:
		return DocumentStatus.AVAILABLE
	else:
		Chronicler.log_event(self, "document_status_changed", {
			"file_path": file_path,
			"old_hash": known_hash,
			"new_hash": current_hash,
			"new_status": "MODIFIED"
		})
		return DocumentStatus.MODIFIED

func _start_background_housekeeping() -> void:
	_audit_timer = Timer.new()
	_audit_timer.connect("timeout", Callable(self, "perform_full_audit"))
	_audit_timer.set_wait_time(AUDIT_INTERVAL)
	_audit_timer.set_one_shot(false)
	add_child(_audit_timer)
	_audit_timer.start()

func _load_card_catalog() -> void:
	var file = FileAccess.open(CARD_CATALOG_FILE, FileAccess.READ)
	if file:
		var json_str = file.get_as_text()
		file.close()
		var json = JSON.new()
		var error = json.parse(json_str)
		if error == OK:
			var old_catalog = json.data
			card_catalog = {}
			for document_id in old_catalog:
				card_catalog[document_id] = _migrate_catalog_entry(old_catalog[document_id])
			Chronicler.log_event(self, "card_catalog_loaded_and_migrated", {
				"entries_migrated": card_catalog.size()
			})
		else:
			Chronicler.log_event(self, "card_catalog_load_failed", {
				"error": json.get_error_message()
			})
	else:
		Chronicler.log_event(self, "card_catalog_file_not_found", {})

func _save_card_catalog() -> void:
	var file = FileAccess.open(CARD_CATALOG_FILE, FileAccess.WRITE)
	if file:
		var json_str = JSON.stringify(card_catalog)
		file.store_string(json_str)
		file.close()
		Chronicler.log_event(self, "card_catalog_saved", {})
	else:
		Chronicler.log_event(self, "card_catalog_save_failed", {})

func _generate_content_hash(input: String) -> String:
	if FileAccess.file_exists(input):
		var file = FileAccess.open(input, FileAccess.READ)
		var content = file.get_as_text()
		file.close()
		return content.md5_text()
	else:
		return input.md5_text()

func _get_latest_observation(observations: Dictionary) -> Dictionary:
	var latest_timestamp = 0
	var latest_observation = {}
	for observation in observations.values():
		if observation["timestamp"] > latest_timestamp:
			latest_timestamp = observation["timestamp"]
			latest_observation = observation
	return latest_observation

func _find_or_create_document_id(file_path: String, content_hash: String) -> String:
	for document_id in card_catalog:
		var entry = card_catalog[document_id]
		for observation_key in entry["observations"]:
			var observation = entry["observations"][observation_key]
			if observation["path"] == file_path or observation["content_hash"] == content_hash:
				return document_id
	
	return _generate_document_id()

func _generate_document_id() -> String:
	return str(Time.get_unix_time_from_system()) + "_" + str(randi())
