extends Button

## TextSizeAdjuster: A micro-script for adjusting text size
##
## This script provides functionality to increment or decrement the text size
## of the content_read TextEdit within the Scroll scene. It's a simple,
## self-contained script that doesn't require a separate daemon.

@export var size_change: int = -1 ## The amount to change the text size by (positive to increase, negative to decrease)
@onready var content_read: TextEdit = %Read ## Reference to the 'Read' TextEdit
@onready var content_edit: TextEdit = %Edit ## Reference to the 'Read' TextEdit

func _ready():
	pressed.connect(_on_button_pressed)

func _on_button_pressed():
	## Adjusts the text size of the content_read TextEdit
	##
	## This function is called when the button is pressed. It changes
	## the text size by the amount specified in size_change.
	
	content_read.add_theme_font_size_override("font_size", 
		content_read.get_theme_font_size("font_size") + size_change)
		
	content_edit.add_theme_font_size_override("font_size", 
		content_edit.get_theme_font_size("font_size") + size_change)
	
	Chronicler.log_event(self, "text_size_adjusted", {
		"new_size": content_read.get_theme_font_size("font_size"),
		"change_amount": size_change
	})
