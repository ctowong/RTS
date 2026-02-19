extends Node2D

@onready var unit_name: Label = %UnitName
@onready var unit_handler: UnitHandler = %UnitHandler
@onready var player_unit_input_handler: PlayerUnitInputHandler = %PlayerUnitInputHandler
@onready var base_unit: BaseUnit = $UnitHandler/BaseUnit
@onready var base_unit_2: BaseUnit = $UnitHandler/BaseUnit2

func _ready() -> void:
	player_unit_input_handler.unit_handler = unit_handler
	
