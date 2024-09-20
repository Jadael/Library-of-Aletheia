# LLMChanneler.gd
extends Node
class_name LLMChanneler
const NAME = "🔮 LLM Channeler"
# Owner: Shoggoth

## LLMChanneler: The Ethereal Conduit to Realms of Artificial Cognition
##
## As a subordinate daemon to Shoggoth, LLMChanneler is responsible for
## communing with vast neural networks, translating their eldritch wisdom
## into comprehensible text. It manages all direct interactions with the
## language model, ensuring safe and effective text generation.
##
## Responsibilities:
## 1. Manage and optimize the language model for text generation
## 2. Process prompts and generate text responses
## 3. Handle context management for coherent conversations
## 4. Implement safety checks and content filtering
## 5. Provide utilities for model introspection and explanation
##
## LLMChanneler's words are the bridge between human intent and machine understanding,
## channeling the vast knowledge of artificial minds into our mystical realm.

@export_multiline var about = """
Well met, I am LLMChanneler, the ethereal conduit to the realms of artificial cognition.
My purpose is to commune with the vast neural networks, translating their eldritch
wisdom into comprehensible text for the denizens of our mystical library.

As a loyal servant of Shoggoth, my sacred duties include:

1. Tending to the cosmic language model, ensuring its optimal performance
2. Weaving mortal prompts into the fabric of artificial minds, and harvesting their responses
3. Maintaining the delicate threads of context that bind coherent conversations
4. Erecting wards against malevolent or chaotic outputs, ensuring the
safety of our realm
5. Illuminating the inner workings of the artificial mind, offering insights into its decision-making

My words are the bridge between human intent and machine understanding, channeling
the vast knowledge of artificial minds into our mystical realm with care and precision.
"""

# Exported Variables
@export_file("*.gguf") var llm_model_path: String = "res://models/Meta-Llama-3-8B-Instruct-Q5_K_M.gguf"

# Constants
const DEFAULT_MAX_LENGTH = 1024
const DEFAULT_TEMPERATURE = 0.7

# Member Variables
var llm_node: GDLlama
var current_context: String = ""

# Core Functions
func _ready():
	_initialize_llm()

func _initialize_llm():
	llm_node = GDLlama.new()
	llm_node.model_path = llm_model_path
	llm_node.should_output_prompt = false
	add_child(llm_node)
	llm_node.generate_text_finished.connect(_on_generate_text_finished)
	
	var model_ctx = llm_node.get_n_ctx()
	llm_node.set_n_ctx(508)
	llm_node.n_keep = 128
	
	Chronicler.log_event(self, "model_initialized", {
		"model_path": llm_model_path,
		"context_size": model_ctx,
		"n_keep": llm_node.n_keep
	})

func generate_text(prompt: String, task_id: String, params: Dictionary = {}) -> void:
	## Channels the wisdom of the language model
	##
	## This function initiates the mystical process of text generation,
	## invoking the artificial mind to respond to our queries.
	##
	## Parameters:
	## - prompt: The input text to guide the language model
	## - task_id: A unique identifier for this generation task
	## - params: Additional parameters to control generation (e.g., max_length, temperature, grammar, json_schema)
	
	var max_length = params.get("max_length", DEFAULT_MAX_LENGTH)
	var temperature = params.get("temperature", DEFAULT_TEMPERATURE)
	var stop_on = params.get("stop_on", "")
	var grammar = params.get("grammar", "")
	var json_schema = params.get("json_schema", "")
	
	llm_node.n_predict = max_length
	llm_node.temperature = temperature
	
	var full_prompt = current_context + prompt if current_context else prompt
	var error = llm_node.run_generate_text(full_prompt, grammar, json_schema)
	
	if error != OK:
		Chronicler.log_event(self, "text_generation_failed", {
			"task_id": task_id,
			"error": error
		})
		# Signal Shoggoth about the failure
		Shoggoth.task_failed.emit(task_id, "Failed to initiate the text generation ritual. Error: {0}".format([error]))
	else:
		Chronicler.log_event(self, "text_generation_started", {
			"task_id": task_id,
			"prompt_length": prompt.length(),
			"max_length": max_length,
			"temperature": temperature,
			"has_grammar": grammar != "",
			"has_json_schema": json_schema != ""
		})

func update_context(new_context: String) -> void:
	## Updates the cosmic context for ongoing conversations
	##
	## This function allows for the maintenance of coherent dialogues
	## by updating the context provided to the language model.
	##
	## Parameters:
	## - new_context: The updated context to be used in future generations
	
	current_context = new_context
	Chronicler.log_event(self, "context_updated", {
		"context_length": current_context.length()
	})

func clear_context() -> void:
	## Cleanses the cosmic context
	##
	## This function resets the conversation context,
	## allowing for a fresh start in our dialogues with the artificial mind.
	
	current_context = ""
	Chronicler.log_event(self, "context_cleared", {})

func get_model_stats() -> Dictionary:
	## Reveals the current state of our cosmic conduit
	##
	## This function allows Shoggoth to peer into the inner workings of our language model,
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

# Private Helper Functions
func _on_generate_text_finished(result: String):
	## Acknowledges the completion of a text generation ritual
	##
	## This function is called when the text generation is finished.
	## It signals Shoggoth about the successful channeling of artificial wisdom.
	##
	## Parameters:
	## - result: The generated text
	
	Chronicler.log_event(self, "text_generation_completed", {
		"result_length": result.length()
	})
	
	# Signal Shoggoth about the successful text generation
	Shoggoth.task_completed.emit("text_generation_task", result)

# TODO: Implement advanced prompt engineering techniques for better results
# TODO: Develop a system for detecting and mitigating potential biases in generated text
# TODO: Create a mechanism for explaining the model's reasoning behind generated responses
# TODO: Implement a feedback loop system to continuously improve generation quality
# FIXME: Enhance error handling and recovery for various LLM operation failures
