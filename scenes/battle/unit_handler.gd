extends Node2D

@onready var base_unit: BaseUnit = $BaseUnit

var units: Array[BaseUnit] = []

func _ready() -> void:
	for child in get_children():
		if child is BaseUnit:
			units.append(child)


func _input(event: InputEvent) -> void:
	#print(get_global_mouse_position())
	if event.is_action("battle_action_command"):
		for unit in units:
			unit.move_to(get_global_mouse_position())
