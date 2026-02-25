class_name UnitPortraitStatUI
extends Control

@export var unit_stats: UnitStats: set = _set_unit_stats

@onready var hp_bar_bottom: NinePatchRect = %HPBarBottom
@onready var mp_bar_bottom: NinePatchRect = %MPBarBottom
@onready var hp_bar: TextureProgressBar = %HPBar
@onready var mp_bar: TextureProgressBar = %MPBar
@onready var hp_label: Label = %HPLabel
@onready var mp_label: Label = %MPLabel
@onready var unit_portrait: TextureRect = %UnitPortrait


func _set_unit_stats(value: UnitStats) -> void:
	if not is_node_ready():
		await ready

	if (unit_stats != value and unit_stats):
		if(unit_stats.stats_changed.is_connected(_update_ui)):
			unit_stats.stats_changed.disconnect(_update_ui)
	
	if (value and not value.stats_changed.is_connected(_update_ui)):
		unit_stats = value
		unit_stats.stats_changed.connect(_update_ui)
	
	print("%s %s %s" % [unit_stats.name, unit_stats.mp, mp_bar.value])
	_update_ui()


func _update_ui() -> void:
	assert(unit_stats, "unitstats should be populated")	
	
	if (unit_stats.max_mp == 0):
		mp_bar_bottom.modulate = Color(0,0,0,0)
	else:
		mp_bar_bottom.modulate = Color(1,1,1,1)

	unit_portrait.texture = unit_stats.portrait
	hp_bar.max_value = unit_stats.max_hp
	hp_bar.value = unit_stats.hp
	hp_label.text = "%.f/%.f" % [unit_stats.hp, unit_stats.max_hp]
	mp_bar.max_value = unit_stats.max_mp
	mp_bar.value = unit_stats.mp
	mp_label.text = "%.f/%.f" % [unit_stats.mp, unit_stats.max_mp]
