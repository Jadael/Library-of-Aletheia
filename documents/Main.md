---
title: Main
last_updated: 2024-09-13T11:05:20
---

# Main

## Properties

- @export_multiline var about = """
- @export_file("*.gguf") var embedding_model_path: String = "res://models/embedding_model.gguf"
- @export_file("*.gguf") var llm_model_path: String = "res://models/llm_model.gguf"
- @export_dir var documents_folder: String = "res://documents"

## Functions

### _ready
`func _ready():`

The sacred purpose of the `_ready` function is to initialize the Main Archon, a pivotal entity in the mystical realm. This function expects the following offerings:
* `embedding_model_path`: the path to the embedding model
* `llm_model_path`: the path to the language model
* `documents_folder`: the folder containing the mystical documents

The function returns no explicit boon, but its success or failure has far-reaching implications. Upon successful initialization, the function logs an event to the Chronicler, detailing the initialization process and providing crucial information about the embedding model, language model, and documents folder.

Arcane intricacies in its implementation include:
* The use of the `Chronicler` class to log events, suggesting a centralized logging mechanism.
* The inclusion of the `embedding_model_path`, `llm_model_path`, and `documents_folder` as parameters, implying that these values are essential for the Main Archon's functioning.
* The function's reliance on these parameters to initialize the Librarian Archon, suggesting a complex relationship between the Main Archon and the Librarian Archon.

With this understanding, we can now behold the mystic sigil: 

### _setup_librarian
`func _setup_librarian() -> bool:`

Error: The cosmic forces failed to reveal the mysteries of function _setup_librarian

### _setup_curator
`func _setup_curator() -> bool:`

The sacred purpose of the `_setup_curator` function is to initialize the Curator entity, which is likely responsible for managing the game's state or progression. This function is a vital part of the Main script's duties, as it sets the stage for the game's narrative and gameplay mechanics.

The function expects no parameters, as it only interacts with internal entities (`Curator` and `Chronicler`).

The boon it bestows is the return value of `true`, indicating that the setup process was successful. This return value might be used by the Main script to continue execution or trigger subsequent events.

Arcane intricacies in its implementation include the use of the `Chronicler` entity to log an event. This suggests that the game uses an event-based system to track and record important milestones and events.



### _setup_change_check_timer
`func _setup_change_check_timer():`

The sacred purpose of the `_setup_change_check_timer` function is to set up a timer that periodically checks for changes. This timer is intended to run in the background, monitoring for alterations in the game state, and triggering a callback function (`_on_check_changes_timer_timeout`) when the timer expires.

The function does not expect any parameters (offerings) and does not return a value (boon).

The implementation is straightforward, creating a new `Timer` instance, connecting it to the callback function, adding it as a child to the node (presumably the `Main` node), starting the timer, and logging an event to the `Chronicler` to track the timer's start.

Arcane intricacies include the use of `Callable` to specify the callback function and the `add_child` method to include the timer in the node's hierarchy. The timer is set to run every 10 seconds, as specified by the `start` method.



### _on_check_changes_timer_timeout
`func _on_check_changes_timer_timeout():`

The _on_check_changes_timer_timeout function serves as a periodic check for updates in the Godot script. It is triggered when a timer timeout occurs, indicating that it is time to perform the check.

**Sacred Purpose:**
The function's purpose is to periodically check for updates in the Codex Daemons, update the visual representation of the realm, and log events to track the process.

**Offerings (parameters):**
None, as this function does not accept any parameters.

**Boon (return value):**
The function does not explicitly return a value, but it does log events to track the process.

**Arcane Intricacies:**
The function interacts with other script entities, such as the Chronicler, Librarian, and Curator, to perform its tasks. The Librarian's `check_for_updates` method is called to retrieve updates, and the Curator's `update_visualization` method is called to update the visual representation of the realm. The Chronicler is used to log events, providing insight into the periodic check process.



### _notification
`func _notification(what):`

The sacred purpose of the `_notification` function is to handle a window management close request, allowing the script to gracefully shut down and perform any necessary cleanup before terminating.

This function expects a single parameter, `what`, which represents the type of notification received. In this case, the function is specifically designed to handle `NOTIFICATION_WM_CLOSE_REQUEST` notifications.

The function does not return a value, as its primary focus is on executing a series of actions in response to the notification rather than producing a tangible result.

One arcane intricacy in the implementation is the use of the `get_tree()` method, which returns a reference to the current scene tree. The `quit()` method is then called on this tree, effectively terminating the game.

In summary, the `_notification` function is a sentinel that watches for window management close requests, logging events and performing cleanup before bringing the script to a gentle close.



### adjust_realm_pulse_rate
`func adjust_realm_pulse_rate(new_interval: float):`

The function `adjust_realm_pulse_rate` is a sacred ritual that harmonizes the rhythm of the realm's pulse rate. Its purpose is to synchronize the timing of events within the realm, ensuring a balanced and efficient flow of energy.

**Offerings (parameters):** The function expects a single parameter, `new_interval`, a float value representing the desired interval (in seconds) for the realm's pulse rate.

**Boon (return value):** The function does not explicitly return a value, but its success is reflected in the chronicling of events. If the adjustment is successful, it logs an event indicating the new interval; otherwise, it logs an event describing the failure, including the attempted interval.

**Arcane intricacies:** The function first checks if the provided interval is greater than zero. If so, it sets the `wait_time` property of a timer (referenced by `$Timer`) to the new interval. This adjustment affects the timing of events within the realm. If the interval is not valid (less than or equal to zero), the function logs an error event, indicating the reason for failure.

**Mystic sigil:** 

### _unhandled_input
`func _unhandled_input(event):`

The function `_unhandled_input` is a sacred ritual within the Main script, designed to summon the chronicle viewer when a specific input action is pressed. 

**Sacred Purpose:** The function is a gateway to unlock the chronicle viewer, allowing the user to access and explore the chronicle.

**Offerings (parameters):** The function expects a single parameter, `event`, which represents the input event that triggered the summoning.

**Boon (return value):** The function does not return a value, as its purpose is to execute an action (summoning the chronicle viewer) rather than provide a result.

**Arcane Intricacies:** The function uses the `is_action_pressed` method to check if the "summon_chronicle_viewer" action is pressed, and if so, it calls the `summon_chronicle_viewer` method on the `Curator` object.



## Version History

- Documentation generated on 2024-09-13T11:11:42
