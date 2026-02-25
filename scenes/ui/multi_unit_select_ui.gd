class_name MultiUnitSelectUI
extends Control

const UNIT_STAT_MINI_UI = preload("uid://4s4elaw7pkcb")
const MAX_UNIT_SELECTION_COUNT = 12 # 

@export var unit_stats_list: Array[UnitStats]: set = _update_unit_stats_list

@onready var unit_grid: GridContainer = %UnitGrid

var mini_unit_stat_ui_list: Array[UnitStatMiniUI] = []


func _ready() -> void:
	for child in unit_grid.get_children():
		if child is UnitStatMiniUI:
			child.queue_free()

	for i in range(1, MAX_UNIT_SELECTION_COUNT):
		var temp_mini_unit_stat_ui: UnitStatMiniUI = UNIT_STAT_MINI_UI.instantiate()
		unit_grid.add_child(temp_mini_unit_stat_ui)
		temp_mini_unit_stat_ui.unit_stat = null
		mini_unit_stat_ui_list.append(temp_mini_unit_stat_ui)


func _update_unit_stats_list(value: Array[UnitStats]) -> void:
	if (not is_node_ready()):
		await ready

	assert(value.size() <= MAX_UNIT_SELECTION_COUNT, "Supporting max %s unit selection" % MAX_UNIT_SELECTION_COUNT)
	
	for child in mini_unit_stat_ui_list:
		child.unit_stat = null
	
	unit_stats_list = value

	var i = 0
	for child in unit_stats_list:
		mini_unit_stat_ui_list[i].unit_stat = child
		i += 1
		
		if i > MAX_UNIT_SELECTION_COUNT:
			break
