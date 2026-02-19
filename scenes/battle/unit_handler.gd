class_name UnitHandler
extends Node2D

var units: Array[BaseUnit] = []

func _ready() -> void:
	for child in get_children():
		if child is BaseUnit:
			add_unit(child) 


func add_unit(unit: BaseUnit) -> void:
	units.append(unit)
