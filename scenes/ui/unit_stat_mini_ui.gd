class_name UnitStatMiniUI
extends Control

@onready var portrait: TextureRect = %Portrait
@onready var hp_bar: ProgressBar = %HPBar

@export var unit_stat: UnitStats: set = _set_unit_stats


func _set_unit_stats(value: UnitStats):
	if not is_node_ready():
		await ready

	if not value.stats_changed.is_connected(_update_display):
		value.stats_changed.connect(_update_display)
	unit_stat = value
	
	_update_display()


func _update_display() -> void:
	hp_bar.max_value = unit_stat.max_hp
	hp_bar.value = unit_stat.hp
	portrait.texture = unit_stat.portrait
