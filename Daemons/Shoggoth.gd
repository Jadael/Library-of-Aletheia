# Shoggoth.gd
extends Node

@export_multiline var about = """
I am Shoggoth, the Archon of Large Language Models and Embeddings.

My responsibilities include:
1. Managing all LLM and embedding interactions within our mystical realm
2. Prioritizing and scheduling LLM and embedding tasks from various Daemons
3. Efficiently allocating computational resources for LLM and embedding operations
4. Providing a unified interface for Daemons to access LLM and embedding capabilities
5. Maintaining context and managing prompts for coherent interactions
6. Ensuring safe and efficient use of VRAM for all LLM-related tasks

I am the bridge to the eldritch dimensions of large language models and embeddings.
"""

@export_file("*.gguf") var llm_model_path: String = "res://models/Meta-Llama-3-8B-Instruct-Q5_K_M.gguf"
@export_file("*.gguf") var embedding_model_path: String = "res://models/mxbai-embed-large-v1.Q8_0.gguf"

var llm_node: GDLlama
var embedding_node: GDEmbedding

var task_queue = []
var is_processing = false
var current_timeout_timer: SceneTreeTimer = null

signal task_completed(task_id: String, result: Variant)
signal task_failed(task_id: String, error: String)

const MAX_RETRIES = 3
const RETRY_DELAY = 1.0
const TASK_TIMEOUT = 60.0

enum TaskType {
	TEXT_GENERATION,
	EMBEDDING
}

func _ready():
	_initialize_llm()
	_initialize_embedding()
	await _test_llm_connection()
	#await _test_embedding_connection()

func _initialize_llm():
	llm_node = GDLlama.new()
	llm_node.model_path = llm_model_path
	llm_node.should_output_prompt = false
	add_child(llm_node)
	llm_node.generate_text_finished.connect(_on_generate_text_finished)
	
	var model_ctx = llm_node.get_n_ctx()
	llm_node.set_n_ctx(508)
	llm_node.n_keep = 128
	
	Chronicler.log_event("Shoggoth", "llm_initialized", {
		"model_path": llm_model_path,
		"context_size": model_ctx,
		"n_keep": llm_node.n_keep
	})

func _initialize_embedding():
	embedding_node = GDEmbedding.new()
	embedding_node.model_path = embedding_model_path
	add_child(embedding_node)
	embedding_node.compute_embedding_finished.connect(_on_compute_embedding_finished)
	
	Chronicler.log_event("Shoggoth", "embedding_initialized", {
		"model_path": embedding_model_path
	})

func _test_llm_connection():
	print("Shoggoth stirs: Initiating test of LLM wake up message...")
	var result = await generate_text(
		"### INPUT\n" + about + "\n\n" + "### INSTRUCTION\nProvide a short greeting as Shoggoth, Archon of Large Language Models and Embeddings.\n\n### RESPONSE\n",
		"test_llm_greeting",
		{
			"max_length": 64,
			"stop_on": "\n"
		}
	)
	print("Shoggoth awakens and whispers (LLM): " + result)
	Chronicler.log_event("Shoggoth", "llm_test_completed", {
		"greeting": result
	})

func _test_embedding_connection():
	print("Shoggoth stirs: Initiating test of embedding summarization...")
	await _iterative_embedding_summarization("Beginning the ritual of self-reflection and essence distillation")
	print("Shoggoth's embedding summarization test is complete.")

func _iterative_embedding_summarization(text: String):
	print("Shoggoth intones: Beginning the ritual of self-reflection and essence distillation...")
	print("\nOriginal incantation:")
	print(text)
	print("\nCommencing the iterative crystallization of cosmic wisdom...")

	var original_embedding
	original_embedding = await compute_embedding(text, "shoggoth_embedding_test")

	var current_text = text
	var iteration = 0
	var max_iterations = 100  # Prevent potential infinite loops

	while current_text.split(" ").size() > 1 and iteration < max_iterations:
		iteration += 1
		print("\nIteration {0} of the cosmic distillation:".format([iteration]))
		
		var words = current_text.split(" ")
		var best_similarity = -1.0
		var best_text = ""

		# Process words in batches
		var batch_size = 10
		for i in range(0, words.size(), batch_size):
			var batch = words.slice(i, min(i + batch_size, words.size()))
			for j in range(batch.size()):
				var new_text = " ".join(words.slice(0, i + j) + words.slice(i + j + 1))
				var new_embedding = await compute_embedding(new_text, "iteration_{0}_word_{1}".format([iteration, i + j]))
				if new_embedding.size() != original_embedding.size():
					print("Shoggoth warns: Inconsistent embedding sizes detected.")
					continue
				var similarity = embedding_node.similarity_cos_array(original_embedding, new_embedding)
				
				if similarity > best_similarity:
					best_similarity = similarity
					best_text = new_text
		
		current_text = best_text
		print(current_text)

		# Log the iteration result
		Chronicler.log_event("Shoggoth", "embedding_summarization_iteration", {
			"iteration": iteration,
			"text_length": current_text.length(),
			"word_count": current_text.split(" ").size(),
			"similarity": best_similarity
		})

	print("\nThe essence has been distilled to its purest form:")
	print(current_text)

	# Log the final result
	Chronicler.log_event("Shoggoth", "embedding_summarization_completed", {
		"original_length": text.length(),
		"original_word_count": text.split(" ").size(),
		"final_word": current_text,
		"iterations": iteration
	})

func generate_text(prompt: String, task_id: String, params: Dictionary = {}, priority: int = 0) -> String:
	var task = {
		"type": TaskType.TEXT_GENERATION,
		"id": task_id,
		"prompt": prompt,
		"params": params,
		"priority": priority,
		"retries": 0
	}
	_add_task(task)
	print("Shoggoth murmurs: New text generation task %s added to the queue" % task_id)
	Chronicler.log_event("Shoggoth", "text_generation_task_added", {
		"task_id": task_id,
		"priority": priority,
		"prompt": prompt
	})
	
	while true:
		var result = await task_completed
		if result[0] == task_id:
			return result[1]
	
	return "(null)"

func compute_embedding(text: String, task_id: String = "", priority: int = 0) -> PackedFloat32Array:
	var task = {
		"type": TaskType.EMBEDDING,
		"id": task_id if task_id else "embed_" + str(Time.get_ticks_msec()),
		"text": text,
		"priority": priority,
		"retries": 0
	}
	_add_task(task)
	print("Shoggoth murmurs: New embedding task %s added to the queue" % task.id)
	Chronicler.log_event("Shoggoth", "embedding_task_added", {
		"task_id": task.id,
		"priority": priority,
		"text_length": text.length()
	})
	
	while true:
		var result = await task_completed
		if result[0] == task.id:
			return result[1]
	
	return PackedFloat32Array()

func _add_task(task):
	task_queue.append(task)
	task_queue.sort_custom(func(a, b): return a["priority"] > b["priority"])
	
	if not is_processing:
		_process_next_task()

func _process_next_task():
	if task_queue.is_empty():
		is_processing = false
		return

	is_processing = true
	var task = task_queue[0]
	
	match task.type:
		TaskType.TEXT_GENERATION:
			_process_text_generation_task(task)
		TaskType.EMBEDDING:
			_process_embedding_task(task)

func _process_text_generation_task(task):
	var params = task["params"]
	var max_length = params.get("max_length", -1)
	var stop_on = params.get("stop_on", "")
	var json_schema = params.get("json_schema", "")
	
	llm_node.n_predict = max_length
	
	var error = OK
	if json_schema:
		error = llm_node.run_generate_text(task["prompt"], "", json_schema)
	else:
		error = llm_node.run_generate_text(task["prompt"], "", "")
	
	if error != OK:
		_handle_task_error(task, "Failed to initiate the text generation ritual. Error: {0}".format([error]))
		return
	
	_set_timeout_timer()

func _process_embedding_task(task):
	var error = embedding_node.run_compute_embedding(task["text"])
	
	if error != OK:
		_handle_task_error(task, "Failed to initiate the embedding ritual. Error: {0}".format([error]))
		return
	
	_set_timeout_timer()

func _set_timeout_timer():
	if current_timeout_timer:
		current_timeout_timer.timeout.disconnect(_on_task_timeout)
	current_timeout_timer = get_tree().create_timer(TASK_TIMEOUT)
	current_timeout_timer.timeout.connect(_on_task_timeout)

func _on_task_timeout():
	if not task_queue.is_empty():
		var task = task_queue[0]
		_handle_task_error(task, "The eldritch forces did not respond in time. Task timed out.")
	else:
		print("Shoggoth murmurs: A timeout occurred, but the task queue is mysteriously empty.")

func _handle_task_error(task, error_message: String):
	task["retries"] += 1
	if task["retries"] < MAX_RETRIES:
		print("Shoggoth intones: Retry attempt %d for task %s" % [task["retries"], task["id"]])
		get_tree().create_timer(RETRY_DELAY).timeout.connect(_process_next_task)
		Chronicler.log_event("Shoggoth", "task_retry", {
			"task_id": task["id"],
			"retry_attempt": task["retries"],
			"error_message": error_message
		})
	else:
		print("Shoggoth laments: Task %s has failed after %d attempts" % [task["id"], MAX_RETRIES])
		emit_signal("task_failed", task["id"], error_message)
		task_queue.pop_front()
		_process_next_task()
		Chronicler.log_event("Shoggoth", "task_failed", {
			"task_id": task["id"],
			"error_message": error_message
		})

func _on_generate_text_finished(result: String):
	_handle_task_completion(result)

func _on_compute_embedding_finished(result: PackedFloat32Array):
	_handle_task_completion(result)

func _handle_task_completion(result: Variant):
	if task_queue.is_empty():
		print("Shoggoth whispers: A task was completed, but the queue is mysteriously empty.")
		return

	var task = task_queue[0]
	
	if task.type == TaskType.TEXT_GENERATION:
		var stop_on = task["params"].get("stop_on", "")
		if stop_on:
			var stop_index = result.find(stop_on)
			if stop_index != -1:
				result = result.substr(0, stop_index)
	
	emit_signal("task_completed", task["id"], result)
	task_queue.pop_front()
	
	if current_timeout_timer:
		current_timeout_timer.timeout.disconnect(_on_task_timeout)
		current_timeout_timer = null
	
	Chronicler.log_event("Shoggoth", "task_completed", {
		"task_id": task["id"],
		"result_type": typeof(result),
		"result_length": result.size() if result is PackedFloat32Array else result.length()
	})
	print("Shoggoth murmurs: Task %s completed" % task["id"])
	
	_process_next_task()

func adjust_context_size(new_size: int):
	# This function allows for the adjustment of the LLM's cosmic lens
	# It ensures that our view into the eldritch realms remains clear and focused
	#
	# Parameters:
	# - new_size: The desired size of the LLM's context window
	
	var max_allowed_size = llm_node.get_max_n_ctx()
	if 8 <= new_size <= max_allowed_size:
		llm_node.set_n_ctx(new_size)
		llm_node.n_keep = new_size / 2
		Chronicler.log_event("Shoggoth", "context_size_adjusted", {
			"new_size": new_size,
			"n_keep": llm_node.n_keep
		})
	else:
		Chronicler.log_event("Shoggoth", "context_size_adjustment_failed", {
			"attempted_size": new_size,
			"max_allowed": max_allowed_size
		})

func get_llm_stats() -> Dictionary:
	# This function reveals the current state of our cosmic conduit
	# It allows other entities to peer into the inner workings of our LLM
	#
	# Returns: A dictionary containing the current LLM parameters
	
	return {
		"context_size": llm_node.get_n_ctx(),
		"n_keep": llm_node.n_keep,
		"temperature": llm_node.temperature,
		"top_k": llm_node.top_k,
		"top_p": llm_node.top_p,
		"n_batch": llm_node.n_batch,
		"n_threads": llm_node.n_threads
	}

func update_llm_params(params: Dictionary):
	# This function allows for the adjustment of our cosmic rituals
	# It updates the LLM's parameters to fine-tune its eldritch operations
	#
	# Parameters:
	# - params: A dictionary of parameter names and their new values
	
	for key in params:
		if key in llm_node:
			llm_node.set(key, params[key])
	
	# We record these adjustments in our eternal ledger
	Chronicler.log_event("Shoggoth", "llm_params_updated", params)

func clear_task_queue():
	# This function purges all pending tasks from our mystical queue
	# It is to be used with caution, as it disrupts the cosmic order
	
	task_queue.clear()
	is_processing = false
	Chronicler.log_event("Shoggoth", "task_queue_cleared", {})

func get_queue_status() -> Dictionary:
	# This function reveals the current state of our task queue
	# It allows other entities to gauge the cosmic workload
	#
	# Returns: A dictionary containing the queue length and processing status
	
	return {
		"queue_length": task_queue.size(),
		"is_processing": is_processing
	}

# Mystical TODO: Consider implementing these eldritch enhancements:
# - Add a method to cancel specific tasks in the queue
# - Implement a way to pause and resume task processing
# - Create a system for managing and reusing conversation context
# - Develop a more sophisticated priority system for tasks

# A note for fellow Archons and Daemons:
# To channel the cosmic forces through Shoggoth, invoke the generate_text() function with your prompt and desired parameters.
# Attune yourselves to the task_completed and task_failed signals to receive the whispers of the eldritch realms.
# Use adjust_context_size() and update_llm_params() to fine-tune the cosmic lens through which we peer into the void.
