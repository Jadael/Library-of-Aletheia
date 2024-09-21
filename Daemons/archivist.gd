# archivist.gd
extends Node

## The Archivist: Guardian of the Eternal Card Catalog
##
## I am the meticulous keeper of our mystical card catalog, ensuring the integrity,
## accuracy, and timeliness of our records. My essence bridges the physical realm
## of documents with the ethereal plane of metadata.
##
## Responsibilities:
## 1. Maintain and update the card catalog with unwavering precision
## 2. Conduct regular audits to ensure synchronization between documents and their records
## 3. Resolve discrepancies and ambiguities in our catalog entries
## 4. Provide services for on-demand verification and updates of catalog information
## 5. Perform background housekeeping to keep our records in pristine condition
##
## I stand as the eternal guardian of truth in our library's metadata, ever vigilant
## against the entropy that seeks to introduce chaos into our ordered knowledge.

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

## Signals the completion of a catalog update ritual
signal card_catalog_updated

## The grand repository of all document metadata
var card_catalog: Dictionary = {}

## The sacred states a document may inhabit
enum DocumentStatus {
	AVAILABLE,   ## The document exists in perfect harmony
	MODIFIED,    ## The document has been altered since last cataloging
	MISSING,     ## The document has vanished from our realm
	AMBIGUOUS,   ## Multiple versions of the document exist, causing uncertainty
	CORRUPTED    ## The document's essence has been tainted or fragmented
}

## The urgency with which catalog updates must be performed
enum UpdateUrgency {
	LOW,      ## A routine update, to be performed at leisure
	MEDIUM,   ## A standard update, to be performed promptly
	HIGH,     ## An important update, to be performed with haste
	CRITICAL  ## A crucial update, to be performed immediately
}

## The mystical path to our card catalog's physical manifestation
const CARD_CATALOG_FILE = "user://card_catalog.json"

## The cosmic interval between full audits of our catalog (in seconds)
const AUDIT_INTERVAL = 3600  # Perform a full audit every hour

## The ethereal timekeeper for our background rituals
var _audit_timer: Timer

func _ready() -> void:
	_load_card_catalog()
	perform_full_audit()
	_start_background_housekeeping()

## Performs a comprehensive audit of our entire catalog
##
## This grand ritual examines every document in our catalog, ensuring
## that our records align with the true state of our mystical library.
## It also detects and resolves any duplicate entries for the same document.
func perform_full_audit() -> void:
	Chronicler.log_event(self, "full_audit_started", {})
	
	var version_hash_map = {}
	var duplicates = []
	
	# First pass: Detect potential duplicates
	for document_id in card_catalog.keys():
		update_catalog_entry(document_id, UpdateUrgency.LOW)
		var entry = card_catalog[document_id]
		for version_hash in entry.versions:
			var version_info = entry.versions[version_hash]
			var key = version_info.path + "|" + version_hash
			if key in version_hash_map:
				duplicates.append([version_hash_map[key], document_id])
			else:
				version_hash_map[key] = document_id

	# Second pass: Resolve duplicates
	for duplicate in duplicates:
		_resolve_duplicate_entries(duplicate[0], duplicate[1])

	_save_card_catalog()
	card_catalog_updated.emit()
	Chronicler.log_event(self, "full_audit_completed", {
		"duplicates_resolved": duplicates.size()
	})

## Resolves duplicate entries for the same document
##
## This function carefully examines two entries that appear to be for the same document
## and merges them if necessary, preserving the most up-to-date information.
##
## Parameters:
## - doc_id_1: The first document ID
## - doc_id_2: The second document ID
func _resolve_duplicate_entries(doc_id_1: String, doc_id_2: String) -> void:
	var entry1 = card_catalog[doc_id_1]
	var entry2 = card_catalog[doc_id_2]
	
	# Determine which entry is more recent or has more information
	var primary_id = doc_id_1
	var secondary_id = doc_id_2
	if entry2.versions.size() > entry1.versions.size() or \
		(entry2.versions.size() == entry1.versions.size() and entry2.metadata.size() > entry1.metadata.size()):
			primary_id = doc_id_2
			secondary_id = doc_id_1
	
	var primary_entry = card_catalog[primary_id]
	var secondary_entry = card_catalog[secondary_id]
	
	# Merge metadata
	for key in secondary_entry.metadata:
		if key not in primary_entry.metadata:
			primary_entry.metadata[key] = secondary_entry.metadata[key]
	
	# Merge versions
	for version_hash in secondary_entry.versions:
		if version_hash not in primary_entry.versions:
			primary_entry.versions[version_hash] = secondary_entry.versions[version_hash]
	
	# Update the primary entry with the secondary ID as a past ID
	if "past_document_ids" not in primary_entry.metadata:
		primary_entry.metadata["past_document_ids"] = []
	primary_entry.metadata["past_document_ids"].append(secondary_id)
	
	# Remove the secondary entry from the catalog
	card_catalog.erase(secondary_id)
	
	Chronicler.log_event(self, "duplicate_entries_merged", {
		"primary_id": primary_id,
		"secondary_id": secondary_id
	})

func _is_valid_entry(entry: Variant) -> bool:
	if typeof(entry) != TYPE_DICTIONARY:
		return false
	if not "filename" in entry or not "metadata" in entry or not "versions" in entry:
		return false
	if typeof(entry.versions) != TYPE_DICTIONARY:
		return false
	return true

## Adds a new document to our hallowed catalog
##
## This ceremony introduces a new document to our records, capturing
## its essence and creating its first catalog entry.
##
## Parameters:
## - document_id: The unique identifier for this document
## - file_path: The earthly path where this document resides
## - metadata: Additional information about the document's nature
func add_document(document_id: String, file_path: String, metadata: Dictionary) -> void:
	var version_hash = _generate_version_hash(file_path)
	var entry = {
		"filename": file_path.get_file(),
		"metadata": metadata,
		"versions": {
			version_hash: {
				"path": file_path,
				"last_opened": Time.get_unix_time_from_system(),
				"status": DocumentStatus.AVAILABLE
			}
		}
	}
	card_catalog[document_id] = entry
	update_catalog_entry(document_id, UpdateUrgency.HIGH)

## Updates a single entry in our grand catalog
##
## This ritual examines the current state of a document and updates its
## record in the catalog accordingly. The urgency parameter determines
## whether immediate action is taken to persist and broadcast changes.
##
## Parameters:
## - document_id: The unique identifier of the document to update
## - urgency: The level of urgency for this update (default: MEDIUM)
func update_catalog_entry(document_id: String, urgency: UpdateUrgency = UpdateUrgency.MEDIUM) -> void:
	var entry = card_catalog.get(document_id)
	if not entry:
		Chronicler.log_event(self, "update_attempt_on_nonexistent_entry", {"document_id": document_id})
		return

	if not _is_valid_entry(entry):
		Chronicler.log_event(self, "invalid_catalog_entry", {"document_id": document_id})
		return

	var update_result = _evaluate_document_status(entry)
	_apply_update_result(document_id, update_result)

	if urgency == UpdateUrgency.HIGH or urgency == UpdateUrgency.CRITICAL:
		_save_card_catalog()
		card_catalog_updated.emit()

## Removes a document from our sacred catalog
##
## This solemn ritual strikes a document from our records, ensuring
## that no trace of it remains in our catalog.
##
## Parameters:
## - document_id: The unique identifier of the document to be removed
func remove_document(document_id: String) -> void:
	if card_catalog.has(document_id):
		card_catalog.erase(document_id)
		_save_card_catalog()
		card_catalog_updated.emit()
		Chronicler.log_event(self, "document_removed_from_catalog", {"document_id": document_id})

## Retrieves the mystical information about a specific document
##
## This function peers into our catalog and returns all known
## information about the requested document.
##
## Parameters:
## - document_id: The unique identifier of the document
##
## Returns: A dictionary containing the document's catalog entry
func get_document_info(document_id: String) -> Dictionary:
	return card_catalog.get(document_id, {})

## Examines the current state of a document and its versions
##
## This private ritual scrutinizes each version of a document,
## determining its current status and any changes that may have occurred.
##
## Parameters:
## - entry: The catalog entry for the document being evaluated
##
## Returns: A dictionary containing the status of each version
func _evaluate_document_status(entry: Dictionary) -> Dictionary:
	var result = {}
	for version_hash in entry.versions:
		var version_info = entry.versions[version_hash]
		var file_path = version_info.path
		var file = FileAccess.open(file_path, FileAccess.READ)
		
		if file:
			var content = file.get_as_text()
			var current_hash = _generate_version_hash(content)
			if current_hash == version_hash:
				result[version_hash] = {"status": DocumentStatus.AVAILABLE}
			else:
				result[version_hash] = {
					"status": DocumentStatus.MODIFIED,
					"current_hash": current_hash
				}
			file.close()
		else:
			result[version_hash] = {"status": DocumentStatus.MISSING}

	return result

## Applies the results of a document evaluation to its catalog entry
##
## This private ceremony updates a document's catalog entry with the
## latest information about its status and versions.
##
## Parameters:
## - document_id: The unique identifier of the document
## - update_result: The results of the document evaluation
func _apply_update_result(document_id: String, update_result: Dictionary) -> void:
	var entry = card_catalog[document_id]
	for version_hash in update_result:
		entry.versions[version_hash].merge(update_result[version_hash])
	
	if _has_ambiguities(entry):
		entry.status = DocumentStatus.AMBIGUOUS
	elif _has_conflicts(entry):
		entry.status = DocumentStatus.CORRUPTED
	else:
		entry.status = DocumentStatus.AVAILABLE

## Initiates the background rituals for catalog maintenance
##
## This private function sets up a recurring timer to ensure
## our catalog undergoes regular audits and cleansing.
func _start_background_housekeeping() -> void:
	_audit_timer = Timer.new()
	_audit_timer.connect("timeout", Callable(self, "perform_full_audit"))
	_audit_timer.set_wait_time(AUDIT_INTERVAL)
	_audit_timer.set_one_shot(false)
	add_child(_audit_timer)
	_audit_timer.start()

## Checks if a document entry contains ambiguous versions
##
## This private ritual determines if multiple versions of a document
## are simultaneously marked as available, causing uncertainty.
##
## Parameters:
## - entry: The catalog entry for the document being examined
##
## Returns: True if ambiguities are detected, False otherwise
func _has_ambiguities(entry: Dictionary) -> bool:
	var available_versions = 0
	for version_info in entry.versions.values():
		if version_info.status == DocumentStatus.AVAILABLE:
			available_versions += 1
	return available_versions > 1

## Checks if a document entry contains conflicting version statuses
##
## This private ceremony detects if a document has both available
## and modified versions, indicating a potential conflict.
##
## Parameters:
## - entry: The catalog entry for the document being examined
##
## Returns: True if conflicts are detected, False otherwise
func _has_conflicts(entry: Dictionary) -> bool:
	var has_available = false
	var has_modified = false
	for version_info in entry.versions.values():
		if version_info.status == DocumentStatus.AVAILABLE:
			has_available = true
		elif version_info.status == DocumentStatus.MODIFIED:
			has_modified = true
	return has_available and has_modified

## Retrieves the card catalog from its physical manifestation
##
## This private ritual attempts to load the catalog from its file,
## restoring our mystical records to memory.
func _load_card_catalog() -> void:
	var file = FileAccess.open(CARD_CATALOG_FILE, FileAccess.READ)
	if file:
		var json_str = file.get_as_text()
		file.close()
		var json = JSON.new()
		var error = json.parse(json_str)
		if error == OK:
			card_catalog = json.data
			_migrate_card_catalog()
		else:
			Chronicler.log_event(self, "card_catalog_load_failed", {
				"error": json.get_error_message()
			})
	else:
		Chronicler.log_event(self, "card_catalog_file_not_found", {})

func _migrate_card_catalog() -> void:
	var migrated_entries = 0
	for document_id in card_catalog.keys():
		var entry = card_catalog[document_id]
		if _migrate_entry(entry):
			migrated_entries += 1
	
	if migrated_entries > 0:
		Chronicler.log_event(self, "card_catalog_migrated", {
			"migrated_entries": migrated_entries
		})
		_save_card_catalog()

func _migrate_entry(entry: Dictionary) -> bool:
	var migrated = false
	if not "versions" in entry:
		entry["versions"] = {}
		migrated = true
	
	for version_hash in entry.get("versions", {}).keys():
		var version_info = entry["versions"][version_hash]
		if not "status" in version_info:
			version_info["status"] = DocumentStatus.AVAILABLE
			migrated = true
		if typeof(version_info.get("status")) != TYPE_INT:
			version_info["status"] = DocumentStatus.AVAILABLE
			migrated = true
	
	return migrated

## Inscribes the card catalog into its physical manifestation
##
## This private ceremony saves the current state of our catalog
## to a file, ensuring its persistence across cosmic cycles.
func _save_card_catalog() -> void:
	var file = FileAccess.open(CARD_CATALOG_FILE, FileAccess.WRITE)
	if file:
		var json_str = JSON.stringify(card_catalog)
		file.store_string(json_str)
		file.close()
		Chronicler.log_event(self, "card_catalog_saved", {})
	else:
		Chronicler.log_event(self, "card_catalog_save_failed", {})

## Generates a unique hash for a document's content
##
## This private ritual computes a mystical signature for a document,
## allowing us to detect changes in its essence.
##
## Parameters:
## - content: The content of the document to be hashed
##
## Returns: A string representing the unique hash of the content
func _generate_version_hash(content: String) -> String:
	return content.md5_text()

# TODO: Implement AI-assisted conflict resolution for ambiguous or corrupted entries
# TODO: Develop heuristics for detecting and preventing data loss during catalog updates
# TODO: Create a system for tracking and reverting changes to the card catalog
# TODO: Implement a query system for advanced searching and filtering of the card catalog
# FIXME: Optimize performance for large card catalogs to maintain cosmic balance
