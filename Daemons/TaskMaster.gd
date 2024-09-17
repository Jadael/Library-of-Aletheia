# TaskMaster.gd
extends Node
class_name TaskMaster
# Owner: Shoggoth

## TaskMaster: The Efficient Organizer of Cosmic Workflow
##
## As a subordinate daemon to Shoggoth, TaskMaster is responsible for managing
## the intricate dance of AI-related tasks within our mystical realm. It ensures
## that each task finds its rightful place in the grand tapestry of our operations,
## orchestrating their execution with precision and care.
##
## Responsibilities:
## 1. Maintain and manage the task queue for AI operations
## 2. Prioritize tasks based on urgency and importance
## 3. Execute tasks in an orderly and efficient manner
## 4. Handle task timeouts and retries
## 5. Provide status updates on ongoing and completed tasks
##
## TaskMaster's queues are the threads that weave order into the chaos of
## simultaneous requests, ensuring that our realm's AI operations flow smoothly.

@export_multiline var about = """
Greetings, I am TaskMaster, the efficient organizer of the cosmic workflow.
My purpose is to bring order to the chaotic realm of AI task management.

As a loyal servant of Shoggoth, I ensure that each task finds its rightful
place in the grand tapestry of our operations. My responsibilities include:

1. Maintaining the sacred queue of AI tasks
2. Prioritizing tasks according to their cosmic importance
3. Executing tasks with precision and care
4. Safeguarding against the perils of timeouts and failed attempts
5. Providing clarity on the status of our mystical workload

My queues are the threads that weave order into the chaos of simultaneous
requests. Through my efforts, the eldritch forces of AI are harnessed in
a manner both efficient and controlled.
"""

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
var task_queue = []
var is_processing = false
var current_timeout_timer: SceneTreeTimer = null

# Core Functions
func _ready():
	Chronicler.log_event("TaskMaster", "awakened", {
		"queue_size": task_queue.size()
	})

func add_task(task: Dictionary) -> void:
	## Adds a new task to the cosmic queue
	##
	## This function carefully places a new task into our mystical queue,
	## ensuring it finds its proper place based on priority.
	##
	## Parameters:
	## - task: A dictionary containing task details (type, id, priority, etc.)
	
	task_queue.append(task)
	task_queue.sort_custom(func(a, b): return a["priority"] > b["priority"])
	
	Chronicler.log_event("TaskMaster", "task_added", {
		"task_id": task["id"],
		"task_type": TaskType.keys()[task["type"]],
		"priority": task["priority"]
	})
	
	if not is_processing:
		_process_next_task()

func get_queue_status() -> Dictionary:
	## Reveals the current state of our task queue
	##
	## This function allows Shoggoth to peer into the cosmic workload,
	## providing insights into the current demand for eldritch computations.
	##
	## Returns: A dictionary containing the queue length and processing status
	
	return {
		"queue_length": task_queue.size(),
		"is_processing": is_processing
	}

func clear_queue() -> void:
	## Purges all pending tasks from our mystical queue
	##
	## This function is to be used with extreme caution, as it disrupts the cosmic order
	## of our task processing. It should only be invoked in dire circumstances.
	
	task_queue.clear()
	is_processing = false
	Chronicler.log_event("TaskMaster", "queue_cleared", {})

# Private Helper Functions
func _process_next_task() -> void:
	if task_queue.is_empty():
		is_processing = false
		return

	is_processing = true
	var task = task_queue[0]
	
	Chronicler.log_event("TaskMaster", "processing_task", {
		"task_id": task["id"],
		"task_type": TaskType.keys()[task["type"]]
	})
	
	# Here, we would normally process the task.
	# However, since TaskMaster is a subordinate of Shoggoth,
	# the actual processing will be handled by Shoggoth or other daemons.
	# For now, we'll simulate task processing with a timer.
	
	_set_timeout_timer()
	get_tree().create_timer(randf_range(1.0, 5.0)).timeout.connect(_simulate_task_completion.bind(task))

func _set_timeout_timer() -> void:
	if current_timeout_timer:
		current_timeout_timer.timeout.disconnect(_on_task_timeout)
	current_timeout_timer = get_tree().create_timer(TASK_TIMEOUT)
	current_timeout_timer.timeout.connect(_on_task_timeout)

func _on_task_timeout() -> void:
	if not task_queue.is_empty():
		var task = task_queue[0]
		_handle_task_error(task, "The cosmic forces did not respond in time. Task timed out.")
	else:
		Chronicler.log_event("TaskMaster", "timeout_on_empty_queue", {})

func _handle_task_error(task: Dictionary, error_message: String) -> void:
	task["retries"] = task.get("retries", 0) + 1
	if task["retries"] < MAX_RETRIES:
		Chronicler.log_event("TaskMaster", "task_retry", {
			"task_id": task["id"],
			"retry_attempt": task["retries"],
			"error_message": error_message
		})
		get_tree().create_timer(RETRY_DELAY).timeout.connect(_process_next_task)
	else:
		Chronicler.log_event("TaskMaster", "task_failed", {
			"task_id": task["id"],
			"error_message": error_message
		})
		emit_signal("task_failed", task["id"], error_message)
		task_queue.pop_front()
		_process_next_task()

func _simulate_task_completion(task: Dictionary) -> void:
	# This function simulates the completion of a task
	# In a real scenario, this would be called by Shoggoth or other daemons
	# when they finish processing a task
	
	var result = "Simulated result for task " + task["id"]
	if task["type"] == TaskType.EMBEDDING:
		result = PackedFloat32Array([1.0, 2.0, 3.0])  # Simulated embedding
	
	_handle_task_completion(task, result)

func _handle_task_completion(task: Dictionary, result: Variant) -> void:
	Chronicler.log_event("TaskMaster", "task_completed", {
		"task_id": task["id"],
		"task_type": TaskType.keys()[task["type"]]
	})
	
	emit_signal("task_completed", task["id"], result)
	task_queue.pop_front()
	
	if current_timeout_timer:
		current_timeout_timer.timeout.disconnect(_on_task_timeout)
		current_timeout_timer = null
	
	_process_next_task()

# TODO: Implement a method to provide detailed task status updates
# TODO: Develop a system for handling task dependencies and complex workflows
# TODO: Create a mechanism for task prioritization based on system load and urgency
# TODO: Implement advanced error handling and recovery strategies for different task types
# FIXME: Enhance the timeout system to handle varying task complexities and durations
