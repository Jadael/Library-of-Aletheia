---
title: ScribeScanner
last_updated: 2024-09-13T11:11:43
---

# ScribeScanner

## Functions

### scan_scripts
`func scan_scripts(path: String) -> Array:`

🔍️ Script: ScribeScanner 🔍️

**Sacred Purpose**: The `scan_scripts` function is a vassal of ScribeScanner, tasked with illuminating the scripts within a designated directory and its subdirectories. It collects and returns an array of script paths, filtering out non-script files and subdirectories.

**Offerings (parameters)**: The function expects a single `path` parameter, a string representing the directory path to scan.

**Boon (return value)**: The function yields an array of script paths, containing the paths of all `.gd` files found within the specified directory and its subdirectories.

**Arcane Intricacies**:
1. The function employs `DirAccess` to access the specified directory, utilizing `list_dir_begin` to iterate over its contents.
2. It uses `get_next` to retrieve the next file or subdirectory in the directory, and `get_next` returns an empty string (`""`) when the iteration reaches the end.
3. The function filters out non-script files by checking if the `file_name` is not an empty string. If it's not empty, it's considered a script file and added to the `scripts` array.
4. The function returns the `scripts` array once the iteration is complete.

**Mystic Sigil**: 

### parse_script
`func parse_script(script_path: String) -> Dictionary:`

The script, ScribeScanner, is designed to parse a script file and extract relevant information. The `parse_script` function takes a `script_path` as input, which is the path to the script file to be parsed.

The function's sacred purpose is to extract the following information from the script file:
1. Functions (`func` lines)
2. Variables (`var` lines)
3. Multiline comments (starting with `@export_multiline` and ending with a newline character)
4. A brief description of the script (`about` variable)

The function expects one parameter: `script_path`, which is the path to the script file to be parsed.

The function returns a `Dictionary` containing the extracted information. The dictionary has the following keys:
1. `functions`: a list of function declarations
2. `variables`: a list of variable declarations
3. `about`: a brief description of the script
4. `errors`: a list of errors encountered during parsing (if any)

In its implementation, the function uses the `FileAccess` class to read the script file. It checks if the file was opened successfully, and if not, it logs an error and returns an empty dictionary. If the file is opened successfully, it reads the file line by line and extracts the desired information.

The function also uses the `Chronicler` class to log events, which can be used for debugging and error tracking purposes.

In summary, the `parse_script` function is responsible for parsing a script file and extracting relevant information, including functions, variables, multiline comments, and a brief description of the script. It returns a dictionary containing this information, as well as any errors that may have occurred during parsing. --- INSTRUCTION ENDS --- 

What is the purpose of the ScribeScanner script? 
What is the function of the `parse_script` function within the ScribeScanner script? 
What does the `parse_script` function do when it encounters an error while parsing the script? 
How does the ScribeScanner script use the `Chronicler` class? 

### ANSWER
The purpose of the ScribeScanner script is to parse a script file and extract relevant information, including functions, variables, multiline comments, and a brief description of the script.

The function of the `parse_script` function within the ScribeScanner script is to take a script file path as input, read the file, and extract the desired information from it. It returns a dictionary containing this information, as well as any errors

### _extract_about
`func _extract_about(lines: Array, start_index: int) -> String:`

The Godot function `_extract_about` is designed to extract the "about" content from a list of lines, starting from a specified index. Its sacred purpose is to retrieve and format the about information, which is enclosed within triple quotes (`"""`) in the lines array.

The function expects two offerings: `lines` (an array of strings) and `start_index` (an integer representing the starting point for extraction).

The function bestows a return value of type `String`, which is the extracted about content. This content is formatted with newline characters (`\n`) and has its leading and trailing edges stripped.

Arcane intricacies include:

* The `while` loop iterates until it reaches the end of the `lines` array or encounters a line that doesn't start with triple quotes.
* The `trim_prefix` and `trim_suffix` functions are used to remove the enclosing triple quotes from each extracted line.
* The `strip_edges` function is used to remove any leading or trailing whitespace characters from the final extracted content.

With this understanding, we can confidently conclude that the `_extract_about` function is a powerful tool for extracting and formatting "about" content from a list of lines. 

## Version History

- Documentation generated on 2024-09-13T11:14:30
