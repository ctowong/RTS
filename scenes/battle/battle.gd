extends Node2D

@onready var unit_name: Label = %UnitName
@onready var base_unit: BaseUnit = $UnitHandler/BaseUnit


func _ready() -> void:
	unit_name.text = base_unit.unit_name
