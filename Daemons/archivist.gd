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
	
	var document_ids = card_catalog.keys()
	for i in range(document_ids.size()):
		for j in range(i + 1, document_ids.size()):
			_compare_and_merge_entries(document_ids[i], document_ids[j])
	
	for document_id in card_catalog.keys():
		update_catalog_entry(document_id, UpdateUrgency.LOW)

	_save_card_catalog()
	card_catalog_updated.emit()
	Chronicler.log_event(self, "full_audit_completed", {
		"entries_audited": card_catalog.size()
	})

func _compare_and_merge_entries(id1: String, id2: String) -> void:
	var entry1 = card_catalog.get(id1)
	var entry2 = card_catalog.get(id2)
	
	if not entry1 or not entry2:
		return
	
	var latest_obs1 = _get_latest_observation(entry1)
	var latest_obs2 = _get_latest_observation(entry2)
	
	if not latest_obs1 or not latest_obs2:
		return
	
	# Compare content hashes (most strict)
	if latest_obs1["content_hash"] == latest_obs2["content_hash"]:
		_merge_entries(id1, id2)
		return
	
	# Compare file names
	if latest_obs1["path"].get_file() == latest_obs2["path"].get_file():
		# Check if metadata is compatible
		if _are_metadata_compatible(latest_obs1["metadata"], latest_obs2["metadata"]):
			_merge_entries(id1, id2)
			return
	
	# If we reach here, entries are considered distinct

func _merge_entries(id1: String, id2: String) -> void:
	var entry1 = card_catalog[id1]
	var entry2 = card_catalog[id2]
	
	# Merge observations
	for obs_key in entry2["observations"]:
		if obs_key not in entry1["observations"]:
			entry1["observations"][obs_key] = entry2["observations"][obs_key]
	
	# Merge metadata
	var latest_obs1 = _get_latest_observation(entry1)
	var latest_obs2 = _get_latest_observation(entry2)
	latest_obs1["metadata"] = _merge_metadata(latest_obs1["metadata"], latest_obs2["metadata"])
	
	# Remove the second entry
	card_catalog.erase(id2)
	
	Chronicler.log_event(self, "entries_merged", {
		"merged_id": id2,
		"into_id": id1
	})

func _are_metadata_compatible(metadata1: Dictionary, metadata2: Dictionary) -> bool:
	for key in metadata1:
		if key in metadata2 and metadata1[key] != metadata2[key]:
			return false
	return true

func _merge_metadata(metadata1: Dictionary, metadata2: Dictionary) -> Dictionary:
	var merged = metadata1.duplicate()
	for key in metadata2:
		if key not in merged:
			merged[key] = metadata2[key]
	return merged

func observe_document(file_path: String, metadata: Dictionary = {}) -> void:
	var content_hash = _generate_content_hash(file_path)
	var existing_document_id = _find_existing_document_id(file_path, content_hash)
	
	if existing_document_id:
		var entry = card_catalog[existing_document_id]
		var observation = {
			"timestamp": Time.get_unix_time_from_system(),
			"path": file_path,
			"content_hash": content_hash,
			"metadata": metadata,
			"status": _evaluate_document_status(file_path, content_hash)
		}
		
		var observation_key = file_path
		entry["observations"][observation_key] = observation
		
		update_catalog_entry(existing_document_id, UpdateUrgency.HIGH)
		
		Chronicler.log_event(self, "document_observed", {
			"document_id": existing_document_id,
			"file_path": file_path,
			"content_hash": content_hash,
			"status": DocumentStatus.keys()[observation["status"]],
			"is_existing": true
		})
	else:
		var new_document_id = _generate_document_id()
		var entry = {
			"document_id": new_document_id,
			"observations": {}
		}
		
		var observation = {
			"timestamp": Time.get_unix_time_from_system(),
			"path": file_path,
			"content_hash": content_hash,
			"metadata": metadata,
			"status": _evaluate_document_status(file_path, content_hash)
		}
		
		var observation_key = file_path
		entry["observations"][observation_key] = observation
		card_catalog[new_document_id] = entry
		
		update_catalog_entry(new_document_id, UpdateUrgency.HIGH)
		
		Chronicler.log_event(self, "document_observed", {
			"document_id": new_document_id,
			"file_path": file_path,
			"content_hash": content_hash,
			"status": DocumentStatus.keys()[observation["status"]],
			"is_existing": false
		})

func _find_existing_document_id(file_path: String, content_hash: String) -> String:
	for document_id in card_catalog:
		var entry = card_catalog[document_id]
		for observation in entry["observations"].values():
			if observation["path"] == file_path or observation["content_hash"] == content_hash:
				return document_id
	return ""

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
		return _get_latest_observation(entry)
	return {}

func _migrate_catalog_entry(entry: Dictionary) -> Dictionary:
	if "observations" not in entry or not entry["observations"] is Dictionary:
		var new_entry = {
			"document_id": entry.get("document_id", _generate_document_id()),
			"observations": {}
		}
		if "observations" in entry and entry["observations"] is Array:
			for observation in entry["observations"]:
				var observation_key = observation["path"]
				new_entry["observations"][observation_key] = observation
		return new_entry
	return entry

func _evaluate_document_status(file_path: String, known_hash: String) -> int:
	# Defer to Librarian for file status
	var file_status = Librarian.get_file_status(file_path)
	
	match file_status:
		Librarian.FileStatus.MISSING:
			return DocumentStatus.MISSING
		Librarian.FileStatus.AVAILABLE:
			var current_hash = Librarian.get_file_content_hash(file_path)
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
		Librarian.FileStatus.CORRUPTED:
			return DocumentStatus.CORRUPTED
		_:
			return DocumentStatus.AMBIGUOUS

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

func _generate_content_hash(file_path: String) -> String:
	return Librarian.get_file_content_hash(file_path)

func _find_or_create_document_id(file_path: String, content_hash: String) -> String:
	var file_name = file_path.get_file()
	
	for document_id in card_catalog:
		var entry = card_catalog[document_id]
		for observation in entry["observations"].values():
			if observation["content_hash"] == content_hash and observation["path"].get_file() == file_name:
				return document_id
	
	return _generate_document_id()

func _generate_document_id() -> String:
	return str(Time.get_unix_time_from_system()) + "_" + str(randi())

func _get_latest_observation(entry: Dictionary) -> Dictionary:
	var latest_obs = {}
	var latest_timestamp = 0
	for obs in entry["observations"].values():
		if obs["timestamp"] > latest_timestamp:
			latest_obs = obs
			latest_timestamp = obs["timestamp"]
	return latest_obs
