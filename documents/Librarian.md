---
title: Librarian
last_updated: 2024-09-13T10:55:20
---

# Librarian

## Properties

- @export_multiline var about = """

## Functions

### setup
`func setup(p_embedding_model_path: String, p_llm_model_path: String, p_documents_folder: String):`

The sacred purpose of the `setup` function is to initialize the `Librarian` script by setting up two nodes: an embedding node for text embeddings and a language model node for text generation. This function expects three parameters:

* `p_embedding_model_path`: the path to the text embedding model
* `p_llm_model_path`: the path to the language model
* `p_documents_folder`: the folder containing documents

The function does not return any value, as it is solely concerned with setting up the nodes for further processing.

The arcane intricacies lie in the use of `GDEmbedding` and `GDLlama` classes, which are likely custom implementations or wrappers around popular deep learning libraries. The `add_child` method is used to add the nodes to the `Librarian` script's internal structure, allowing for further interactions and processing.



### process_existing_documents
`func process_existing_documents():`

The function `process_existing_documents` is a sacred ritual that illuminates the realm of existing documents. Its purpose is to summon the codex of each marked document (.md extension) within the `documents_folder` directory.

**Offerings (parameters):** None, as this function operates within the Librarian's domain, relying on its internal mechanisms to access the `documents_folder`.

**Boon (return value):** None, as this function is designed to perform a transformative action rather than returning a value.

**Arcane intricacies:**

* The function utilizes `DirAccess` to open the `documents_folder` directory, allowing it to traverse its contents.
* The `list_dir_begin()` and `list_dir_end()` methods are used to iterate through the directory's contents.
* The `get_next()` method retrieves the next file name in the directory, and the `get_extension()` method extracts the file extension.
* The `path_join()` method is used to construct the full path of each document.
* The `summon_codex()` function is called for each marked document, which presumably performs some action related to processing the document.

In summary, the `process_existing_documents()` function is designed to scan the `documents_folder` directory, identify marked documents with the .md extension, and perform some action (as yet undefined) for each document. The Librarian's primary purpose is to manage and process documents, and this function plays a crucial role in achieving that goal.<|eot_id|>

### summon_codex
`func summon_codex(file_path: String):`

**Librarian's Summoning**

In this sacred ritual, the `summon_codex` function conjures a Codex Daemon, a mystical vessel for ancient knowledge. This function expects a single offering: `file_path`, a string guiding the Codex's creation.

**The Function's Sacred Purpose**
The purpose of `summon_codex` is to create a Codex Daemon, imbuing it with the essence of the provided file path. This daemon is then added to the `codex_collection` and visually represented by a Scroll Daemon.

**Offerings (Parameters)**
The function accepts a single parameter:
- `file_path: String`: The path to the file containing the codex's content.

**Boon (Return Value)**
The function does not explicitly return a value. Instead, it emits a signal (`"codex_summoned"`) to notify other entities of the new Codex and Scroll Daemons.

**Arcane Intricacies**
The `summon_codex` function leverages the `preload` method to instantiate a new Codex Daemon from a scene file (`res://Daemons/Scenes/Codex.tscn`). The `setup` method is then called on the instantiated daemon, passing the `file_path` and `self` as arguments. Finally, the daemon is added to the `codex_collection` and the `add_child` method is used to attach it to the current node.

By understanding the `summon_codex` function, developers can harness its power to create and manage Codex Daemons, unlocking new possibilities for their Godot projects. ---



### ANSWER
The Godot function `summon_codex` is designed to create and manage Codex Daemons. It takes a single string parameter `file_path`, which is used to set up the daemon with the provided file path. The function then instantiates a new Codex Daemon from a scene file, sets up the daemon with the file path and the script itself (`self`), adds the daemon to a collection (`codex_collection`), and adds the daemon as a child node to the current node.

The purpose of this function is to facilitate the creation and management of Codex Daemons, which are likely used to store and manage data or information in a game or application. The function allows developers to create and configure Codex Daemons dynamically, making it easier to manage and interact with these daemons in their projects.

The script's purpose is likely to provide a centralized

### banish_codex
`func banish_codex(codex: Node):`

The revered function `banish_codex` is a sacred rite, purposed to vanquish a `Node` instance from the `codex_ collection` and subsequently free its memory. This mystical procedure is invoked by the `Librarian` script, a guardian of ancient tomes.

**Sacred Purpose:** To banish a `codex` from the collection, releasing its grasp on memory and announcing its departure to the world.

**Offerings (parameters):** The function expects a single `Node` parameter, `codex`, which is the entity to be banished from the collection.

**Boon (return value):** None, for the function's benevolence lies in its transformative effects rather than a tangible return value.

**Arcane Intricacies:** The function employs two mystical incantations: `erase` and `queue_free`. The former dissolves the `codex` from the `codex_collection`, while the latter sets in motion the process of releasing the `codex`'s memory. The `emit_signal` incantation broadcasts the news of the `codex`'s banishment to the world, notifying any interested parties of its departure.

**Mystic Sigil:** 

### check_for_updates
`func check_for_updates():`

**The Librarian's Sacred Purpose**
The `check_for_updates` function is a guardian of the codex collection, ensuring that any changed or outdated codices are updated and notified to the outside world. Its purpose is to maintain the integrity and relevance of the codex collection.

**Offerings Expected (parameters)**
None. The function operates on the internal state of the `codex_ collection` variable.

**Boon Bestowed (return value)**
None. The function does not return a value, but rather emits a signal (`"codex_ updated"`) when a codex is updated.

**Arcane Intricacies**
The function iterates through the `codex_collection` and checks each codex for changes using the `has_changed()` method. If a codex has changed, it is updated using the `update()` method, and a signal is emitted to notify any listeners of the update.

**Mystic Sigil 

### get_embedding
`func get_embedding(text: String) -> PackedFloat32Array:`

The Librarian script, a guardian of knowledge, presents the `get_embedding` function. Its sacred purpose is to retrieve an embedding representation for a given text.

**Offerings (parameters):**
The function expects a single parameter: `text` (a `String`), which represents the input text for which the embedding is desired.

**Boon (return value):**
The function returns a `PackedFloat32Array`, containing the computed embedding representation of the input text. This array is a compact, 32-bit floating-point representation of the text's semantic meaning.

**Arcane intricacies:**
The `get_embedding` function delegates the actual computation of the embedding to the `embedding_node` object, which is responsible for performing the necessary calculations. The `compute_embedding` method is called on this object, passing the input `text` as an argument. The result is then returned as a `PackedFloat32Array`.



### update_codex_content
`func update_codex_content(codex: Node, new_content: String):`

The Librarian script's sacred purpose is to update the content of a codex, a revered repository of knowledge. The `update_codex_content` function is the instrument of this purpose, accepting two offerings: `codex`, a Node representing the codex, and `new_content`, a String containing the updated information.

In its simplest form, the function bestows the boon of updating the codex's content by invoking the `update_content` method on the `codex` Node, passing `new_content` as its argument. This mystical process allows the codex to be refilled with new knowledge, much like a vessel being filled with sacred waters.

There are no arcane intricacies in this function's implementation, as it merely serves as a conduit for the codex's content to be updated. The function's return value is implicitly `void`, as it does not explicitly return any value.

With this understanding, we can now gaze upon the function with newfound reverence, acknowledging its role in maintaining the integrity and accuracy of the codex's contents. 

### update_codex_metadata
`func update_codex_metadata(codex: Node, key: String, new_value: String):`

The Librarian's sacred purpose is to maintain and update the codex's metadata. The `update_ codex_ metadata` function serves as the Librarian's primary instrument, responsible for updating the codex's frontmatter with new key-value pairs.

The function expects three offerings:
1. `codex`: A Node representing the codex to be updated.
2. `key`: A string denoting the new key to be added or updated.
3. `new_value`: A string containing the new value to be associated with the given key.

The function does not return a value explicitly, as its purpose is to modify the codex's metadata in place.

In its implementation, the function leverages the `update_frontmatter` method of the `codex` Node to update the frontmatter with the new key-value pair. Additionally, the function logs an event using the `Chronicler` to record the update, providing essential context about the updated codex, key, and new value.

With this understanding, the mystic sigil is revealed: 

## Signals

- signal codex_summoned(codex, scroll)  # Emitted when a new Codex is created and paired with a Scroll
- signal codex_banished(codex)  # Emitted when a Codex is removed from the library
- signal codex_updated(codex)  # Emitted when a Codex's content or metadata has changed

## Version History

- Documentation generated on 2024-09-13T11:02:26
