class_name BattleUnitSelectionUI
extends Control

@export var unit_stats_list: Array[UnitStats]: set = _set_unit_stats_list

@onready var portrait_background: UnitPortraitStatUI = %PortraitBackground
@onready var multi_unit_select_ui: GridContainer = %MultiUnitSelectUI
@onready var unit_stat_detailed_ui: UnitStatDetailedUI = %UnitStatDetailedUi


func _ready() -> void:
	_update_ui()

func _set_unit_stats_list(value: Array[UnitStats]) -> void:
	unit_stats_list = value
	_update_ui()


func _update_ui() -> void:
	if (not is_node_ready()):
		await ready

	if unit_stats_list.size() == 1:
		portrait_background.unit_stats = unit_stats_list[0]
		multi_unit_select_ui.hide()
		unit_stat_detailed_ui.unit_stats = unit_stats_list[0]
		unit_stat_detailed_ui.show()
