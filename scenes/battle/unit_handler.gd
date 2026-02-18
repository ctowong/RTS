extends Node2D

@onready var base_unit: BaseUnit = $BaseUnit

func _input(event: InputEvent) -> void:
	#print(get_global_mouse_position())
	if event.is_action("battle_action_command"):
		base_unit.move_to(get_global_mouse_position())
	
