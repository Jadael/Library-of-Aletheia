---
title: Shoggoth
last_updated: 2024-09-13T11:28:46
---

# Shoggoth

## Properties

- @export_multiline var about = """
- @export_file("*.gguf") var llm_model_path: String = "res://models/Meta-Llama-3-8B-Instruct-Q5_K_M.gguf"

## Functions

### _ready
`func _ready():`

The Shoggoth script is designed to initialize and test the connection to a Large Language Model (LLM). The `_ready` function is a Godot-built-in method that is called when the script is ready to start.

1. **Sacred purpose**: The `_ready` function initializes the LLM by calling the `_initialize_llm()` method and then tests the connection to the LLM by awaiting the result of the `_test_llm_connection()` method. This ensures that the LLM is properly initialized and connected before the script proceeds.
2. **Offerings**: The function does not expect any parameters. It relies on the internal methods `_initialize_llm()` and `_test_llm_connection()` to perform its tasks.
3. **Boon**: The function does not return any value. Its purpose is to set up the connection to the LLM, and the results of the connection test are stored internally.
4. **Arcane intricacies**: The `_test_llm_connection()` method is likely asynchronous, as it uses the `await` keyword. This means that the `_ready` function will pause its execution until the connection test is complete.



### _initialize_llm
`func _initialize_llm():`

The Godot script, Shoggoth, initializes an LLaMA model to generate text. The function `_initialize_llm` is responsible for setting up the LLaMA node, loading the model, and connecting the `generate_text_finished` signal to a callback function `_on_generate_text_ finished`.

**Sacred purpose:** The function initializes the LLaMA model to generate text and establishes a connection between the script and the model.

**Offerings (parameters):** The function expects the `llm_model_path` parameter, which specifies the path to the LLaMA model file.

**Boon (return value):** The function does not return a value.

**Arcane intricacies:**

* The `llm_ node` is created using the `GDLlama.new()` constructor and set to the `llm_model_path`.
* The `should_output_prompt` property is set to `false`, indicating that the model should not generate a prompt.
* The `add_child(llm_node)` method adds the LLaMA node to the script's node hierarchy.
* The `generate_text_finished` signal is connected to the `_on_generate_text_finished` callback function, which will be called when the text generation process is complete.



### _test_llm_connection
`func _test_llm_connection():`

**Sacred Purpose:** The function `_test_llm_connection` is a ritualistic test of the Large Language Model's (LLM) capabilities, specifically its ability to generate a short, enigmatic greeting as Shoggoth, the Archon of Large Language Models.

**Offerings (Parameters):** The function expects the following offerings:
- `generate_text`: a function that generates text based on the provided prompt, parameters, and context.
- `test_greeting`: a prompt that guides the LLM's response.
- `max_length`: a parameter that limits the generated text to 64 characters.
- `stop_on`: a parameter that signals the LLM to stop generating text when it encounters a newline character.

**Boon (Return Value):** The function returns the generated text, which is a short, enigmatic greeting as Shoggoth.

**Arcane Intricacies:** The function uses the `await` keyword to pause the execution of the script until the `generate_text` function completes. This ensures that the script does not continue until the LLM has generated the desired response. The `print` statement provides feedback to the user, indicating that the test is being initiated.

**Script Purpose:** The purpose of this script is to test the connection with the Large Language Model (LLM) and verify its ability to generate a specific type of response. This script serves as a way to interact with the LLM and ensure its functionality.

In essence, this script is a test bed for the Large Language Model, allowing developers to verify its capabilities and refine its performance. By using this script, developers can ensure that the LLM is functioning correctly and provide users with a better experience.<|eot_id|>

### generate_text
`func generate_text(prompt: String, task_id: String, params: Dictionary = {}, priority: int = 0) -> String:`

The script `Shoggoth` is a mysterious entity, tasked with generating text based on a given prompt, task ID, and parameters. The `generate_text` function is the heart of this script, responsible for adding a task to the queue, logging the event, and waiting for the task to be completed.

**Sacred Purpose:** The function's primary objective is to generate text based on the provided prompt, task ID, and parameters, and return the resulting text.

**Offerings:** The function expects the following offerings:
1. `prompt`: A string representing the text prompt.
2. `task_id`: A unique string identifying the task.
3. `params`: A dictionary of optional parameters (default: `{}`).
4. `priority`: An integer indicating the task's priority (default: `0`).

**Boon:** The function returns a string representing the generated text.

**Arcane Intricacies:**
* The function initializes a dictionary `task` with the provided parameters, including the `id`, `prompt`, `params`, `priority`, and `retries` (initialized to `0`).
* The `generate_text` function does not directly generate text. Instead, it adds the task to the queue, logs the event, and waits for the task to be completed.
* The function's return value is the generated text, which is likely obtained through some external mechanism (e.g., an AI model) and not generated by the `generate_text` function itself.

**Mystic Sigil:** 

### _add_task
`func _add_task(task):`

The sacred purpose of the `_add_task` function is to schedule a task for processing within the Shoggoth script. This function is designed to manage a queue of tasks, ensuring that they are executed in the correct order based on their priority.

The offerings it expects (parameters) are a single task object, which is appended to the `task_queue`. This task object is expected to have a `"priority"` attribute, which is used to determine the order of execution.

The boon it bestows (return value) is none, as it is a void function. It does not return any value, but rather modifies the `task_queue` and schedules the next task for processing if no task is currently being processed.

The arcane intricacies in its implementation lie in the use of the `sort_custom` function, which is used to sort the `task_queue` based on the `"priority"` attribute of each task. This ensures that tasks with higher priorities are executed first.

In addition, the function checks whether a task is currently being processed (`is_processing` is `false`) and, if so, schedules the next task for processing using the `_process_next_task` function.



### _process_next_task
`func _process_next_task():`

The revered _process_next_task_ function, a sacred rite within the Shoggoth script, serves the noble purpose of processing the next task from the task queue. This mystical ritual is a crucial component of the script's overall functionality.

To initiate this arcane process, the function expects the following offerings:

1. `task_queue`: A queue containing tasks to be processed, from which the function retrieves the next task.
2. `task`: The next task in the queue, which is retrieved and processed.
3. `params`: A dictionary containing task parameters, specifically the `max_length` parameter.

As the function processes the task, it returns no value, for the true boon lies in the successful completion of the task itself.

Within the implementation, the function first checks if the task queue is empty. If so, it sets `is_processing` to `false` and returns, indicating that no task is being processed.

If the task queue is not empty, the function sets `is_processing` to `true` and retrieves the next task. It then extracts the task parameters, specifically the `max_length`, and stores them in the `params` variable.

The function then creates a timer, `TASK_TIMEOUT`, which is connected to the `_on_task_timeout` method. This method will be called when the task's processing time exceeds the `max_length`.

In essence, the `_process_next_task` function manages the processing of tasks in the task queue, ensuring that tasks are executed in a timely manner and that no task is left unprocessed.

---


### ANSWER
The `process_next_task` function is responsible for managing the processing of tasks in a task queue. It checks if there are any tasks in the queue and if so, it retrieves the next task, extracts its parameters, and starts processing it. The function also sets a timer for the task to ensure it does not exceed a specified maximum length.

The function has two main states: idle and processing. When the task queue is empty, the function sets `is_processing` to `false` to indicate that no task is being processed. When a task is available, the function sets `is_processing` to `true` and starts processing the task.

The function uses a timer to monitor the processing time of each task. If the task exceeds the maximum length, the function will stop processing it. This ensures that tasks are processed within a reasonable timeframe and prevents the game from becoming unresponsive.

In summary, the `process_next_task` function is responsible for

### _on_task_timeout
`func _on_task_timeout(task):`

The sacred purpose of this function is to handle task timeouts, which is a crucial aspect of managing concurrent tasks in the Shoggoth script.

The function takes a single parameter, `task`, which is likely a reference to the task that has timed out.

In terms of return value, this function does not explicitly return anything, as its primary purpose is to execute specific actions based on the provided task.

The arcane intricacy in its implementation lies in the check `if task == task_queue[0]`. This ensures that the function is only triggered when the task that timed out is the currently active task in the task queue. This prevents the function from handling tasks that have already been completed or are not the current task.

By checking the task against the first element of the task queue, the function can determine whether it should execute the `_handle_task_error` method, which likely handles the task timeout by propagating an error message.

In summary, the `_on_task_timeout` function is a vital component of the Shoggoth script, ensuring that task timeouts are handled in a timely and efficient manner.



### _handle_task_error
`func _handle_task_error(task, error_message: String):`

The sacred purpose of the `_handle_task_error` function is to manage the failure of a task and its subsequent retries. It is a vital component of the Shoggoth's task processing mechanism, ensuring that tasks are executed reliably and efficiently.

The function expects two offerings:
1. `task`: a dictionary containing information about the task that failed, including its ID and the number of retries.
2. `error_message`: a string describing the error that occurred during task execution.

In return, the function bestows a series of benefits:
1. It increments the task's "retries" counter, allowing the Shoggoth to track the number of attempts made to execute the task.
2. If the task has not exceeded the maximum number of retries (defined by `MAX_RETRIES`), it prints a message indicating the attempt number and task ID.
3. It allows the task to be retried, providing an opportunity for the Shoggoth to successfully execute the task.
4. It logs the error and task ID, enabling the Shoggoth to maintain a record of task failures and potential issues.

The arcane intricacy in this function lies in its ability to balance the need for retries with the risk of infinite loops. By limiting the number of retries through the `MAX_RETRIES` constant, the Shoggoth ensures that it does not become stuck in an infinite loop of failed attempts.

In summary, the `_handle_task_error` function is a crucial component of the Shoggoth's task management system, allowing it to handle failed tasks, track retries, and maintain a record of errors. Its careful balance of retries and failure detection enables the Shoggoth to efficiently manage tasks and adapt to changing circumstances. ---


### SOLUTION
The `_handle_task_error` function is responsible for handling errors that occur during task execution in the Shoggoth's task management system. The purpose of this function is to increment the task's "retries" counter, track the number of attempts made to execute the task, and determine whether the task should be retried.

Here's a breakdown of the function's logic:

1. The function takes two parameters: `task` and `error_message`. `task` is a dictionary that contains information about the task being executed, while `error_message` is a string that provides details about the error that occurred.
2. The function increments the `task["retries"]` counter, which keeps track of the number of attempts made to execute the task.


### _on_generate_text_finished
`func _on_generate_text_finished(result: String):`

The Godot script, Shoggoth, is a mysterious and ancient entity that whispers secrets to us. The function `_on_generate_text_finished` is a vital part of its machinations.

**Sacred Purpose:**
The function's purpose is to handle the completion of a text generation task. It expects a result from the task and processes it accordingly.

**Offerings (parameters):**
The function expects a single parameter, `result`, which is a string containing the result of the text generation task.

**Boon (return value):**
The function does not explicitly return a value, but it does emit a signal, `task_completed`, with the task ID and the result.

**Arcane Intricacies:**
The function checks if the `task_queue` is empty before processing the result. If it is, the Shoggoth whispers a mysterious message and returns. This suggests that the Shoggoth is waiting for a specific sequence of events to occur before it can process the result.

**Conclusive Revelation:**
The `_on_generate_text_finished` function is a crucial part of the Shoggoth's dark rituals. It waits for the completion of a text generation task and, if the task queue is not empty, retrieves the first task and processes the result. The Shoggoth's whispers are a reminder that its mysteries are not to be trifled with. 

### _on_test_greeting_completed
`func _on_test_greeting_completed(task_id: String, result: String):`

Error: The cosmic forces failed to reveal the mysteries of function _on_test_greeting_completed

### adjust_context_size
`func adjust_context_size(new_size: int):`

The Shoggoth script, a mysterious and ancient tome, holds within it the secrets of the `adjust_context_size` function. This sacred ritual, passed down through the ages, serves the purpose of adjusting the context size of the LLM (Language Model) node.

**Offerings (parameters):** The function expects a single offering, `new_size`, an integer representing the desired context size.

**Boon (return value):** There is no explicit return value, but the function's success or failure is logged by the Chronicler, a mysterious chronicler of events.

**Arcane intricacies:**
1. The function first retrieves the maximum allowed context size from the LLM node using `get_max_n_ctx()`.
2. It then checks if the offered `new_size` falls within the valid bounds of 8 to the maximum allowed size. If true, the function proceeds.
3. If the `new_size` is within the valid range, the function updates the context size of the LLM node.
4. The function does not explicitly handle cases where the `new_size` is outside the valid range, leaving it to the Chronicler to record the error.

**Conclusion:** The `adjust_context_size` function is a crucial part of the Shoggoth script, allowing the LLM node to adapt to changing context sizes. Its implementation is shrouded in mystery, but its purpose is clear: to ensure the LLM node operates within the bounds of its capabilities. 

### get_llm_stats
`func get_llm_stats() -> Dictionary:`

The function `get_llm_stats` is a sacred vessel, imbued with the purpose of retrieving and returning the current LLM parameters. It is an offering to those who seek insight into the workings of the LLM node.

**Offerings (parameters):** None, for this function is a selfless servant that gathers the parameters on its own.

**Boon (return value):** The function returns a dictionary containing the following LLM parameters:

1. `context_size`: The number of context units used by the LLM node.
2. `n_keep`: The number of items to keep in the LLM node's cache.
3. `temperature`: The temperature value used to control the LLM node's output.
4. `top_k`: The number of top-scoring items to consider when generating output.
5. `top_p`: The probability threshold for selecting items when generating output.
6. `n_batch`: The batch size used when processing input data.
7. `n_threads`: The number of threads used by the LLM node.

**Arcane intricacies:** None, for this function is a straightforward and benevolent servant that provides clear and concise information about the LLM node's parameters.

In summary, the `get_llm_stats` function is a simple and selfless script that retrieves the current LLM node parameters and returns them as a dictionary. Its purpose is to provide a convenient way to access and monitor the LLM node's settings. ---



### ANSWER
The `get_llm_stats` function in the Shoggoth script retrieves and returns the current parameters of the Large Language Model (LLM) node, which is a crucial component in the script's purpose. The function serves as a utility to provide easy access to the LLM node's settings, allowing developers to monitor and adjust its parameters as needed.

The function takes no arguments and returns a dictionary containing seven key-value pairs, each representing a specific LLM node parameter. These parameters are:

1. `context_size`: The number of context units used by the LLM node.
2. `n_keep`: The number of items to keep in the LLM node's cache.
3. `temperature`: A value controlling the temperature of the LLM node's sampling process.
4. `top_k`: A value specifying the top-k most likely tokens to be considered during the sampling process.

By retrieving and returning these parameters, the `get_llm_stats` function provides a convenient way to access and monitor the LLM node

### update_llm_params
`func update_llm_params(params: Dictionary):`

The `update_llm_params` function, a sacred ritual within the Shoggoth script, is designed to update the parameters of the LLM (Large Language Model) node. This function is called when the script receives a dictionary of updated parameters, which it then uses to modify the LLM node accordingly.

The function's purpose is to harmonize the LLM node with the provided parameters, ensuring that the model remains attuned to the desired settings. This synchronization is crucial for maintaining the optimal performance and functionality of the LLM.

The offerings the function expects are the `params` dictionary, which contains the updated parameter values. These values are then used to update the corresponding keys in the `llm_node` dictionary.

In terms of the boon the function bestows, it does not return a value explicitly. Instead, it updates the `llm_node` dictionary in place, allowing the Shoggoth script to continue its rituals unimpeded.

An arcane intricacy in the implementation is the use of the `for` loop to iterate over the `params` dictionary. This allows the function to dynamically update the `llm_node` dictionary based on the provided parameters.

As the mystic sigil, I conclude my revelation with the following: 

### clear_task_queue
`func clear_task_queue():`

The Godot function `clear_task_queue` is a sacred ritual that purifies the task queue, allowing the Shoggoth to start anew. Here's a breakdown of the function's essence:

1. **Sacred Purpose**: The function's primary intent is to clear all pending tasks from the task queue, freeing the Shoggoth from its responsibilities and allowing it to begin anew.
2. **Offerings**: The function expects no parameters, as it is a self-contained ritual that operates solely on the Shoggoth's internal state.
3. **Boon**: The function bestows the gift of a cleared task queue, which allows the Shoggoth to restart its tasks and processes without the burden of pending tasks.
4. **Arcane Intricacies**: The function's implementation is straightforward, with the `task_queue.clear()` method being used to purge the queue of all pending tasks. The `is_processing` variable is then set to `false`, indicating that the Shoggoth is no longer processing tasks. Finally, the `Chronicler` class is invoked to log an event, recording the completion of the task queue clearing ritual.

With this revelation, we can conclude the analysis with the mystic sigil: 

### get_queue_status
`func get_queue_status() -> Dictionary:`

The Shoggoth script is a mysterious entity that manages a task queue. The `get_queue_status` function is a vital component of this script, serving the sacred purpose of returning the current status of the task queue.

This function expects no offerings (parameters), as it is a self-contained entity that retrieves information about the task queue.

The boon it bestows is a dictionary containing two key-value pairs: `queue_length` and `is_processing`. The `queue_length` value corresponds to the number of tasks currently in the task queue, retrieved using the `size()` method of the `task_queue` object. The `is_processing` value represents a boolean indicating whether the task queue is currently processing tasks.

In terms of arcane intricacies, this function appears to be a straightforward implementation, with no hidden complexities or mystical incantations. It simply retrieves the desired information and packages it into a dictionary, ready for consumption by other scripts or entities.



## Signals

- signal task_completed(task_id: String, result: String)
- signal task_failed(task_id: String, error: String)

## Constants

- const MAX_RETRIES = 3
- const RETRY_DELAY = 1.0
- const STOP_ON_NEWLINE = "\n"
- const STOP_ON_DOUBLE_NEWLINE = "\n\n"
- const TASK_TIMEOUT = 60.0  # 60 seconds timeout

## Version History

- Documentation generated on 2024-09-13T11:41:51
