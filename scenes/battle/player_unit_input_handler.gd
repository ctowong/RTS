class_name PlayerUnitInputHandler
extends Node2D

var selected_units: Array[BaseUnit] = []

func _input(event: InputEvent) -> void:
	_handle_selection(event)
	_handle_movement(event)


func _handle_selection(_event: InputEvent):
	#var _new_selected_units: Array[BaseUnit] = []
	pass

func _handle_movement(event: InputEvent):
	if event.is_action("battle_action_command"):
		for unit in selected_units:
			unit.move_to(get_global_mouse_position())


func single_unit_select(selected_unit: BaseUnit) -> void:
	for unit in selected_units:
		unit.is_selected = false
	selected_units = []
	selected_units.append(selected_unit)
	selected_unit.is_selected = true
