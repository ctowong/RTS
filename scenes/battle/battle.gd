extends Node2D

@onready var unit_name: Label = %UnitName
@onready var unit_handler: UnitHandler = %UnitHandler
@onready var player_unit_input_handler: PlayerUnitInputHandler = %PlayerUnitInputHandler
@onready var battle_unit_selection_ui : BattleUnitSelectionUI = %BattleUnitSelectionUI


func _ready() -> void:
	if not(is_node_ready()):
		await(ready)
	
	var unit_stats_list: Array[UnitStats] = []
	battle_unit_selection_ui.unit_stats_list = []
	player_unit_input_handler.unit_handler = unit_handler
	player_unit_input_handler.battle_unit_selection_ui = battle_unit_selection_ui
	
	_random_debug_function()


func _random_debug_function() -> void:
	var timer: SceneTreeTimer = get_tree().create_timer(2)
	await timer.timeout
	print("been 2 seconds")	
	
