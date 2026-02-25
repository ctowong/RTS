class_name UnitStatMiniUI
extends Control

@onready var portrait: TextureRect = %Portrait
@onready var hp_bar: ProgressBar = %HPBar
@onready var mp_bar: ProgressBar = %MPBar

@export var unit_stat: UnitStats: set = _set_unit_stats


func _set_unit_stats(value: UnitStats):
	if not is_node_ready():
		await ready
	
	if (unit_stat and unit_stat.stats_changed.is_connected(_update_display)):
		unit_stat.stats_changed.disconnect(_update_display)
	
	unit_stat = value
	
	if (value and not value.stats_changed.is_connected(_update_display)):
		value.stats_changed.connect(_update_display)

	_update_display()


func _update_display() -> void:
	if (not unit_stat):
		modulate = Color(0,0,0,0)
		return
	else:
		modulate = Color(1,1,1,1)
	
	hp_bar.max_value = unit_stat.max_hp
	hp_bar.value = unit_stat.hp
	
	if (unit_stat.max_mp == 0):
		mp_bar.modulate = Color(0,0,0,0)
	else:
		mp_bar.modulate = Color(1,1,1,1)
		mp_bar.max_value = unit_stat.max_mp
		mp_bar.value = unit_stat.mp

	portrait.texture = unit_stat.portrait
