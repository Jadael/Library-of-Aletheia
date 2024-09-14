@tool
extends EditorPlugin

var oracle_console

func _enter_tree():
	oracle_console = preload("res://addons/oracle_console/OracleConsole.tscn").instantiate()
	add_control_to_dock(DOCK_SLOT_RIGHT_BL, oracle_console)

func _exit_tree():
	remove_control_from_docks(oracle_console)
	oracle_console.free()
