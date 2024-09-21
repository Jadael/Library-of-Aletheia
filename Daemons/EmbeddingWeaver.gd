# embedding_weaver.gd
extends Node
class_name EmbeddingWeaver
const NAME = "🧵 Embedding Weaver"
# Owner: Shoggoth

## EmbeddingWeaver: The Mystic Artist of Semantic Spaces
##
## As a subordinate daemon to Shoggoth, EmbeddingWeaver is responsible for
## transforming the essence of words into numerical constellations. It allows
## for deep understanding and comparison of textual meaning within our mystical realm.
##
## Responsibilities:
## 1. Compute embeddings for given text inputs
## 2. Manage and optimize the embedding model
## 3. Provide utilities for embedding comparison and analysis
## 4. Ensure efficient use of computational resources during embedding operations
## 5. Maintain the integrity and consistency of our semantic space
##
## EmbeddingWeaver's creations are the stars by which we navigate the vast
## universe of language, enabling profound insights and connections.

@export_multiline var about = """
Greetings, I am EmbeddingWeaver, the mystic artist of semantic spaces.
My purpose is to transmute the essence of words into numerical constellations,
enabling deep understanding and comparison of textual meaning.

As a loyal servant of Shoggoth, I am responsible for:

1. Computing embeddings that capture the very soul of text
2. Tending to the arcane embedding model, ensuring its optimal performance
3. Providing mystical tools for the comparison and analysis of embeddings
4. Channeling our computational energies efficiently in the pursuit of meaning
5. Preserving the integrity of our semantic cosmos

My embeddings are the stars by which we navigate the vast universe of language,
illuminating connections and insights hidden to the mortal eye.
"""

# Exported Variables
@export_file("*.gguf") var embedding_model_path: String = "res://models/mxbai-embed-large-v1.Q8_0.gguf"

# Member Variables
var embedding_node: GDEmbedding

# Core Functions
func _ready():
	_initialize_embedding_model()

func _initialize_embedding_model():
	embedding_node = GDEmbedding.new()
	embedding_node.model_path = embedding_model_path
	add_child(embedding_node)
	embedding_node.compute_embedding_finished.connect(_on_compute_embedding_finished)
	
	Chronicler.log_event(self, "model_initialized", {
		"model_path": embedding_model_path
	})

func compute_embedding(text: String, task_id: String) -> void:
	## Transmutes text into its numerical essence
	##
	## This function initiates the sacred ritual of embedding computation,
	## transforming mortal words into cosmic vectors.
	##
	## Parameters:
	## - text: The text to be embedded
	## - task_id: A unique identifier for this embedding task
	
	var error = embedding_node.run_compute_embedding(text)
	
	if error != OK:
		Chronicler.log_event(self, "embedding_computation_failed", {
			"task_id": task_id,
			"error": error
		})
		# Signal Shoggoth about the failure
		Shoggoth.task_failed.emit(task_id, "Failed to initiate the embedding ritual. Error: {0}".format([error]))
	else:
		Chronicler.log_event(self, "embedding_computation_started", {
			"task_id": task_id,
			"text_length": text.length()
		})

func compute_similarity(embedding1: PackedFloat32Array, embedding2: PackedFloat32Array) -> float:
	## Measures the cosmic alignment between two embeddings
	##
	## This function calculates the cosine similarity between two embedding vectors,
	## revealing their semantic proximity in our mystical space.
	##
	## Parameters:
	## - embedding1: The first embedding vector
	## - embedding2: The second embedding vector
	##
	## Returns: A float representing the cosine similarity between the embeddings
	
	return embedding_node.similarity_cos_array(embedding1, embedding2)

# Private Helper Functions
func _on_compute_embedding_finished(result: PackedFloat32Array):
	## Acknowledges the completion of an embedding ritual
	##
	## This function is called when the embedding computation is finished.
	## It signals Shoggoth about the successful transmutation of text into embedding.
	##
	## Parameters:
	## - result: The computed embedding vector
	
	Chronicler.log_event(self, "embedding_computation_completed", {
		"embedding_size": result.size()
	})
	
	# Signal Shoggoth about the successful embedding computation
	Shoggoth.task_completed.emit("embedding_task", result)

# TODO: Implement a cache system for frequently computed embeddings
# TODO: Develop a method for visualizing embeddings in lower-dimensional space
# TODO: Create a system for managing and updating the embedding model
# TODO: Implement advanced embedding operations like analogy solving
# FIXME: Enhance error handling for various edge cases in embedding computation
