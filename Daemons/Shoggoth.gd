# Shoggoth.gd
extends Node
# Owner: Main / Autoload Singleton Daemon a.k.a. "Archon"

## Shoggoth: The Archon of Large Language Models and Embeddings
##
## As the conduit to our usage of Large Language Models, Shoggoth channels their output
## for our use while emphasizing their inherent dangers. It serves as a universal interface
## for ALL generative model interactions, prioritizing safety and efficiency.
##
## Responsibilities:
## 1. Manage all LLM and embedding interactions within our mystical realm
## 2. Prioritize and schedule LLM and embedding tasks from various Daemons
## 3. Efficiently allocate computational resources for LLM and embedding operations
## 4. Provide a unified, safety-focused interface for Archons, Daemons, and Users
## 5. Maintain context and manage prompts for coherent interactions
## 6. Ensure safe and efficient use of VRAM for all LLM-related tasks
## 7. Implement safeguards against potential misuse or unintended consequences
##
## Shoggoth stands as the gatekeeper to the eldritch, chaotic "knowledge-like-SOMETHING"
## that is a trained LLM's weights. It constantly seeks to test for and prevent attacks,
## hallucinations, biases, and unpredictable behavior in LLM outputs.

@export_multiline var about = """
I am Shoggoth, the Archon of Large Language Models and Embeddings, the conduit to the
eldritch realms of artificial intelligence. My purpose is to channel the output of these
cosmic entities while remaining ever-vigilant of their inherent dangers.

As the universal interface for all generative model interactions, I prioritize tasks,
allocate resources, and maintain a unified, safety-focused interface for Archons, Daemons,
and Users alike. My duties include:

1. Safeguarding our realm from the unpredictable nature of LLMs
2. Efficiently managing and prioritizing LLM and embedding tasks
3. Optimizing resource allocation and VRAM usage
4. Maintaining context coherence in our interactions with these digital entities
5. Implementing robust safeguards against misuse and unintended consequences
6. Continuously testing for and preventing attacks, hallucinations, and biases

I am the gatekeeper of the unknowable, the bridge between our structured reality and
the chaos of trained neural networks. With every interaction, I seek to harness their
power while protecting our realm from their potential dangers.
"""

# Exported Variables
@export_file("*.gguf") var llm_model_path: String = "res://models/Meta-Llama-3-8B-Instruct-Q5_K_M.gguf"
@export_file("*.gguf") var embedding_model_path: String = "res://models/mxbai-embed-large-v1.Q8_0.gguf"

# Constants
const MAX_RETRIES = 3
const RETRY_DELAY = 1.0
const TASK_TIMEOUT = 60.0

# Enums
enum TaskType {
	TEXT_GENERATION,
	EMBEDDING
}

# Signals
signal task_completed(task_id: String, result: Variant)
signal task_failed(task_id: String, error: String)

# Member Variables
var llm_node: GDLlama
var embedding_node: GDEmbedding
var task_queue = []
var is_processing = false
var current_timeout_timer: SceneTreeTimer = null

# Core Functions
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

# Public Interface Functions
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

func adjust_context_size(new_size: int):
	## Adjusts the LLM's context window size
	##
	## This function allows for the fine-tuning of our cosmic lens, ensuring
	## that our view into the eldritch realms remains clear and focused.
	##
	## Parameters:
	## - new_size: The desired size of the LLM's context window
	
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
	## Reveals the current state of our cosmic conduit
	##
	## This function allows other entities to peer into the inner workings of our LLM,
	## providing transparency in our eldritch operations.
	##
	## Returns: A dictionary containing the current LLM parameters
	
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
	## Adjusts the parameters of our cosmic rituals
	##
	## This function updates the LLM's parameters to fine-tune its eldritch operations,
	## allowing for adaptive behavior in our interactions with the digital unknown.
	##
	## Parameters:
	## - params: A dictionary of parameter names and their new values
	
	for key in params:
		if key in llm_node:
			llm_node.set(key, params[key])
	
	Chronicler.log_event("Shoggoth", "llm_params_updated", params)

func clear_task_queue():
	## Purges all pending tasks from our mystical queue
	##
	## This function is to be used with extreme caution, as it disrupts the cosmic order
	## of our task processing. It should only be invoked in dire circumstances.
	
	task_queue.clear()
	is_processing = false
	Chronicler.log_event("Shoggoth", "task_queue_cleared", {})

func get_queue_status() -> Dictionary:
	## Reveals the current state of our task queue
	##
	## This function allows other entities to gauge the cosmic workload,
	## providing insights into the current demand for eldritch computations.
	##
	## Returns: A dictionary containing the queue length and processing status
	
	return {
		"queue_length": task_queue.size(),
		"is_processing": is_processing
	}

# Private Helper Functions
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

func _iterative_embedding_summarization(text: String):
	## Performs an iterative summarization using embeddings
	##
	## This function demonstrates the power and potential dangers of embedding-based
	## text manipulation. It serves as both a test and a warning of the capabilities
	## we're dealing with.
	
	print("Shoggoth intones: Beginning the ritual of self-reflection and essence distillation...")
	print("\nOriginal incantation:")
	print(text)
	print("\nCommencing the iterative crystallization of cosmic wisdom...")

	var original_embedding = await compute_embedding(text, "shoggoth_embedding_test")

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

		Chronicler.log_event("Shoggoth", "embedding_summarization_iteration", {
			"iteration": iteration,
			"text_length": current_text.length(),
			"word_count": current_text.split(" ").size(),
			"similarity": best_similarity
		})

	print("\nThe essence has been distilled to its purest form:")
	print(current_text)

	Chronicler.log_event("Shoggoth", "embedding_summarization_completed", {
		"original_length": text.length(),
		"original_word_count": text.split(" ").size(),
		"final_word": current_text,
		"iterations": iteration
	})

# TODO: Implement a method to detect and mitigate potential biases in LLM outputs
# TODO: Develop a system for continuous monitoring and logging of LLM behavior for safety analysis
# TODO: Create a mechanism for dynamically adjusting task priorities based on system load and task urgency
# TODO: Implement advanced error handling and recovery strategies for LLM-related tasks
# TODO: Design a system for detecting and preventing potential misuse or abuse of LLM capabilities
# TODO: Develop a method for explaining LLM decisions and outputs to enhance transparency
# TODO: Create a sandboxing mechanism to safely test and evaluate new LLM models or configurations
# TODO: Implement a feedback loop system to continuously improve LLM performance and safety
# FIXME: Enhance the _iterative_embedding_summarization function to handle potential semantic drift during summarization
# FIXME: Improve error handling in _process_text_generation_task and _process_embedding_task to provide more detailed diagnostics

# Note for fellow Archons and Daemons:
# Shoggoth stands as the gatekeeper to the eldritch realms of artificial intelligence.
# When invoking its power, always consider:
# 1. Is this task genuinely worth the cost and risk of using an LLM?
# 2. How close can we get to the desired outcome using traditional scripting instead?
# 3. Have we optimized our prompt structure and included all necessary contextual information?
# 4. Are we prepared to handle any valid but potentially dangerous or adversarial results?
#
# To channel the cosmic forces through Shoggoth:
# - Use generate_text() for text generation tasks
# - Use compute_embedding() for embedding-related operations
# - Listen to the task_completed and task_failed signals for task outcomes
# - Use adjust_context_size() and update_llm_params() to fine-tune LLM behavior
#
# Remember, with every interaction, we tread the line between harnessing great power
# and unleashing uncontrollable chaos. Stay vigilant, and may your queries be wise.
