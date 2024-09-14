# GDLlama Nodes Reference

This reference guide provides detailed information about the GDLlama, GDEmbedding, GDLlava, and LlmDB nodes, their properties, and functions. These nodes are part of the Godot LLM plugin, allowing developers to integrate large language model capabilities into their Godot projects.

## Table of Contents

1. [GDLlama Node](#gdllama-node)
2. [GDEmbedding Node](#gdembedding-node)
3. [GDLlava Node](#gdllava-node)
4. [LlmDB Node](#llmdb-node)

## GDLlama Node

The GDLlama node provides text generation capabilities using a large language model.

### Properties

- `model_path` (String): Path to the GGUF model file.
- `interactive` (bool): Enable interactive mode for continuous conversation.
- `reverse_prompt` (String): Prompt to stop generation and wait for user input.
- `input_prefix` (String): Text to prepend before each user input.
- `input_suffix` (String): Text to append after each user input.
- `should_output_prompt` (bool): Whether to include the prompt in the output.
- `should_output_special` (bool): Whether to output special tokens.
- `context_size` (int): Number of tokens the model can process at a time.
- `n_predict` (int): Number of tokens to generate (-1 for infinite).
- `n_keep` (int): Number of initial tokens to keep in context.
- `temperature` (float): Randomness of generated text (higher = more random).
- `penalty_repeat` (float): Penalty for repeated sequences.
- `penalty_last_n` (int): Consider last N tokens for repetition penalty.
- `penalize_nl` (bool): Whether to penalize newline tokens.
- `top_k` (int): Consider only top K tokens for sampling.
- `top_p` (float): Consider tokens within this cumulative probability.
- `min_p` (float): Minimum probability threshold for token consideration.
- `n_threads` (int): Number of CPU threads to use.
- `n_gpu_layer` (int): Number of layers to offload to GPU.
- `main_gpu` (int): Main GPU for computation.
- `split_mode` (int, enum): How to distribute computation across GPUs.
- `escape` (bool): Process escape characters in input.
- `n_batch` (int): Maximum number of prompt tokens per batch.
- `n_ubatch` (int): Maximum number of generated tokens per batch.

### Functions

- `generate_text(prompt: String, grammar: String, json: String) -> String`: Generate text based on the prompt, with optional grammar or JSON schema constraints.
- `generate_text_simple(prompt: String) -> String`: Generate text based on the prompt without constraints.
- `generate_text_grammar(prompt: String, grammar: String) -> String`: Generate text based on the prompt with grammar constraints.
- `generate_text_json(prompt: String, json: String) -> String`: Generate text based on the prompt with JSON schema constraints.
- `run_generate_text(prompt: String, grammar: String = "", json: String = "") -> Error`: Run text generation in the background.
- `is_running() -> bool`: Check if text generation is currently running.
- `is_waiting_input() -> bool`: Check if the model is waiting for user input.
- `stop_generate_text()`: Stop the current text generation process.
- `input_text(input: String)`: Provide input text during interactive mode.

### Signals

- `generate_text_updated(new_text: String)`: Emitted when new text is generated.
- `input_wait_started()`: Emitted when the model starts waiting for user input.
- `generate_text_finished(text: String)`: Emitted when text generation is completed.

## GDEmbedding Node

The GDEmbedding node provides text embedding capabilities.

### Properties

- `model_path` (String): Path to the GGUF embedding model file.
- `n_threads` (int): Number of CPU threads to use.
- `n_gpu_layer` (int): Number of layers to offload to GPU.
- `main_gpu` (int): Main GPU for computation.
- `split_mode` (int, enum): How to distribute computation across GPUs.
- `n_batch` (int): Maximum number of tokens per batch.

### Functions

- `compute_embedding(prompt: String) -> PackedFloat32Array`: Compute the embedding vector for the given prompt.
- `run_compute_embedding(prompt: String) -> Error`: Compute embedding in the background.
- `similarity_cos_array(array1: PackedFloat32Array, array2: PackedFloat32Array) -> float`: Compute cosine similarity between two embedding vectors.
- `similarity_cos_string(s1: String, s2: String) -> float`: Compute cosine similarity between embeddings of two strings.
- `run_similarity_cos_string(s1: String, s2: String) -> Error`: Compute string similarity in the background.
- `is_running() -> bool`: Check if embedding computation is currently running.
- `get_n_embd() -> int`: Get the size of the embedding vector.

### Signals

- `compute_embedding_finished(embedding: PackedFloat32Array)`: Emitted when embedding computation is finished.
- `similarity_cos_string_finished(similarity: float)`: Emitted when string similarity computation is finished.

## GDLlava Node

The GDLlava node provides multimodal (text and image) generation capabilities.

### Properties

- `model_path` (String): Path to the GGUF model file.
- `mmproj_path` (String): Path to the mmproj GGUF file.
- `context_size` (int): Number of tokens the model can process at a time.
- `n_predict` (int): Number of tokens to generate.
- `temperature` (float): Randomness of generated text.
- `n_threads` (int): Number of CPU threads to use.
- `n_gpu_layer` (int): Number of layers to offload to GPU.
- `main_gpu` (int): Main GPU for computation.
- `split_mode` (int, enum): How to distribute computation across GPUs.
- `escape` (bool): Process escape characters in input.
- `n_batch` (int): Maximum number of tokens per batch.

### Functions

- `generate_text_base64(prompt: String, image_base64: String) -> String`: Generate text based on prompt and base64-encoded image.
- `run_generate_text_base64(prompt: String, image_base64: String) -> Error`: Run text generation with base64 image in the background.
- `generate_text_image(prompt: String, image: Image) -> String`: Generate text based on prompt and Image object.
- `run_generate_text_image(prompt: String, image: Image) -> Error`: Run text generation with Image object in the background.
- `is_running() -> bool`: Check if text generation is currently running.
- `stop_generate_text()`: Stop the current text generation process.

### Signals

- `generate_text_updated(new_text: String)`: Emitted when new text is generated.
- `generate_text_finished(text: String)`: Emitted when text generation is completed.

## LlmDB Node

The LlmDB node provides vector database functionality for storing and retrieving text embeddings.

### Properties

- `meta` (Array[LlmDBMetaData]): Metadata structure for stored text.
- `db_dir` (String): Directory for the database file.
- `db_file` (String): Name of the database file.
- `table_name` (String): Name of the main table in the database.
- `embedding_size` (int): Size of embedding vectors.
- `absolute_separators` (PackedStringArray): Separators for initial text splitting.
- `chunk_separators` (PackedStringArray): Separators for fine-grained text splitting.
- `chunk_size` (int): Maximum size of text chunks.
- `chunk_overlap` (int): Overlap between adjacent text chunks.

### Functions

- `calibrate_embedding_size()`: Set embedding size based on the current model.
- `open_db()`: Open or create the database.
- `close_db()`: Close the database connection.
- `execute(statement: String)`: Execute an SQL statement.
- `create_llm_tables()`: Create necessary tables in the database.
- `drop_table(p_table_name: String)`: Drop a specific table.
- `drop_llm_tables(p_table_name: String)`: Drop all related tables.
- `has_table(p_table_name: String) -> bool`: Check if a table exists.
- `is_table_valid(p_table_name: String) -> bool`: Check if a table has valid metadata.
- `store_meta(meta_dict: Dictionary)`: Store metadata for text.
- `has_id(id: String, p_table_name: String) -> bool`: Check if an ID exists in the table.
- `split_text(text: String) -> PackedStringArray`: Split text into chunks.
- `store_text_by_id(id: String, text: String)`: Store text with a given ID.
- `run_store_text_by_id(id: String, text: String) -> Error`: Store text by ID in the background.
- `store_text_by_meta(meta_dict: Dictionary, text: String)`: Store text with metadata.
- `run_store_text_by_meta(meta_dict: Dictionary, text: String) -> Error`: Store text with metadata in the background.
- `retrieve_similar_texts(text: String, where: String, n_results: int) -> PackedStringArray`: Retrieve similar texts.
- `run_retrieve_similar_texts(text: String, where: String, n_results: int) -> Error`: Retrieve similar texts in the background.

### Signals

- `retrieve_similar_texts_finished(array: PackedStringArray)`: Emitted when similar text retrieval is finished.
- `store_text_finished()`: Emitted when text storage is completed.