extends Node2D

@onready var unit_name: Label = %UnitName
@onready var unit_handler: UnitHandler = %UnitHandler
@onready var player_unit_input_handler: PlayerUnitInputHandler = %PlayerUnitInputHandler
@onready var battle_unit_selection_ui : BattleUnitSelectionUI = %BattleUnitSelectionUI

@onready var base_unit: BaseUnit = $UnitHandler/BaseUnit
@onready var base_unit_2: BaseUnit = $UnitHandler/BaseUnit2

func _ready() -> void:
	if not(is_node_ready()):
		await(ready)

	player_unit_input_handler.unit_handler = unit_handler
	player_unit_input_handler.battle_unit_selection_ui = battle_unit_selection_ui
