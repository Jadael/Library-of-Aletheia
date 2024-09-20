# SymbolSage.gd
extends Node
# Owner: Shoggoth

## SymbolSage: The Mystic Interpreter of Symbolic Essence
##
## As a subordinate daemon to Shoggoth, SymbolSage is responsible for
## creating and maintaining a repository of symbol embeddings, allowing
## for intuitive matching between textual concepts and symbolic representations.
##
## Responsibilities:
## 1. Create and manage an LlmDB of symbol embeddings
## 2. Provide a service for similarity-based symbol retrieval
## 3. Efficiently update and maintain the symbol database
## 4. Ensure accurate and meaningful symbol-to-text associations
##
## SymbolSage bridges the gap between abstract textual concepts and
## their symbolic representations, allowing for intuitive and context-aware
## symbol suggestions across our mystical realm.

@export_multiline var about = """
Greetings, I am SymbolSage, the mystic interpreter of symbolic essence.
My purpose is to bridge the realms of text and symbol, providing intuitive
associations between abstract concepts and their visual representations.

As a loyal servant of Shoggoth, my sacred duties include:

1. Cultivating and tending to a garden of symbol embeddings
2. Divining the most fitting symbols for given textual incantations
3. Maintaining the purity and accuracy of our symbol-to-text associations
4. Facilitating the intuitive expression of complex ideas through simple symbols

My embeddings are the threads that weave meaning between word and image,
allowing for a deeper, more intuitive understanding of our mystical concepts.
"""

# Constants
const DB_DIR = "user://symbol_db"
const DB_FILE = "symbol_embeddings.sqlite"
const TABLE_NAME = "symbols"

# Member Variables
var llm_db: LlmDB
var symbols: Array[String] = []

# Core Functions
func _ready():
	llm_db = LlmDB.new()
	add_child(llm_db)
	_initialize_database()
	
	## Test
	await get_tree().create_timer(10.0).timeout # Give some time for initialization
	var emoji_symbols: Array[String] = ["🧞", "👽", "🧛‍♀️", "🧙‍♀️", "🧜‍♀️", "👹", "🤖"]
	await add_symbols(emoji_symbols)
	var test_text = "Shoggoth"
	var similar_symbols = await get_similar_symbols(test_text, 3)
	print("Most similar symbols to '{0}': {1}".format([test_text, ", ".join(similar_symbols)]))

func _initialize_database():
	var dir = DirAccess.open("user://")
	if not dir.dir_exists(DB_DIR):
		var err = dir.make_dir_recursive(DB_DIR)
		if err != OK:
			Chronicler.log_event(self, "database_dir_creation_failed", {
				"db_dir": DB_DIR,
				"error": error_string(err)
			})
			return

	llm_db.db_dir = DB_DIR
	llm_db.db_file = DB_FILE
	llm_db.table_name = TABLE_NAME
	llm_db.calibrate_embedding_size()
	
	var retries = 3
	while retries > 0:
		llm_db.open_db()
		if llm_db.db_file != null: # ERROR: Invalid access to property or key 'db' on a base object of type 'LlmDB'.
			break
		retries -= 1
		await get_tree().create_timer(1.0).timeout
	
	if llm_db.db == null:
		Chronicler.log_event(self, "database_initialization_failed", {
			"db_dir": DB_DIR,
			"db_file": DB_FILE
		})
		return
	
	if not llm_db.has_table(TABLE_NAME):
		llm_db.create_llm_tables()
	
	Chronicler.log_event(self, "database_initialized", {
		"db_dir": DB_DIR,
		"db_file": DB_FILE,
		"table_name": TABLE_NAME
	})

func add_symbols(new_symbols: Array[String]):
	## Adds new symbols to the database
	##
	## This function takes an array of symbol strings (e.g., emoji)
	## and adds them to the database, computing their embeddings in the process.
	##
	## Parameters:
	## - new_symbols: An array of symbol strings to be added
	
	for symbol in new_symbols:
		if not symbol in symbols:
			symbols.append(symbol)
			var task_id = "add_symbol_{0}".format([symbol.unicode_at(0)])
			var embedding = await Shoggoth.compute_embedding(symbol, task_id)
			
			var meta = {
				"id": symbol,
				"symbol": symbol
			}
			llm_db.store_meta(meta)
			await llm_db.run_store_text_by_id(symbol, symbol)
	
	Chronicler.log_event(self, "symbols_added", {
		"new_symbols": new_symbols,
		"total_symbols": symbols.size()
	})

func get_similar_symbols(text: String, n_results: int = 5) -> Array[String]:
	## Retrieves symbols similar to the given text
	##
	## This function takes a text string and returns an array of symbols
	## ordered from most similar to least similar based on their embeddings.
	##
	## Parameters:
	## - text: The text to compare symbols against
	## - n_results: The number of similar symbols to retrieve (default: 5)
	##
	## Returns: An array of symbol strings ordered by similarity
	
	var task_id = "get_similar_symbols_{0}".format([Time.get_unix_time_from_system()])
	var text_embedding = await Shoggoth.compute_embedding(text, task_id)
	
	var similar_symbols = []
	for symbol in symbols:
		var symbol_task_id = "symbol_{0}".format([symbol.unicode_at(0)])
		var symbol_embedding = await Shoggoth.compute_embedding(symbol, symbol_task_id)
		var similarity = Shoggoth.embedding_node.similarity_cos_array(text_embedding, symbol_embedding)
		similar_symbols.append({"symbol": symbol, "similarity": similarity})
	
	similar_symbols.sort_custom(func(a, b): return a.similarity > b.similarity)
	
	var result = similar_symbols.slice(0, n_results).map(func(item): return item.symbol)
	
	Chronicler.log_event(self, "similar_symbols_retrieved", {
		"input_text": text,
		"n_results": n_results,
		"top_symbol": result[0] if result.size() > 0 else ""
	})
	
	return result

func clear_database():
	## Purges all symbols from the database
	##
	## This function should be used with caution, as it erases all
	## stored symbol embeddings, requiring a complete rebuild of the database.
	
	llm_db.drop_llm_tables(TABLE_NAME)
	llm_db.create_llm_tables()
	symbols.clear()
	
	Chronicler.log_event(self, "database_cleared", {})

# TODO: Implement a method to update existing symbol embeddings
# TODO: Develop a system for handling homoglyphs and variations in unicode representations
# TODO: Create a mechanism for symbol categorization and filtered retrieval
# TODO: Implement a cache system for frequently accessed symbol embeddings
# FIXME: Enhance error handling for database operations and embedding computations
