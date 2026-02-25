class_name	UnitStatDetailedUI extends Control

const DAMAGE_TYPE_COLORS: Dictionary[UnitStats.DamageType, Color] = {
	UnitStats.DamageType.NORMAL: Color.DARK_GRAY,
	UnitStats.DamageType.PIERCING: Color.SADDLE_BROWN,
	UnitStats.DamageType.MAGIC: Color.DEEP_SKY_BLUE
}

const ARMOR_TYPE_COLORS: Dictionary[UnitStats.ArmorType, Color] = {
	UnitStats.ArmorType.LIGHT: Color.LIGHT_SKY_BLUE,
	UnitStats.ArmorType.MEDIUM: Color.CORAL,
	UnitStats.ArmorType.HEAVY: Color.DARK_SLATE_GRAY
}

@export var unit_stats: UnitStats: set = _set_unit_stats

@onready var unit_name: Label = %UnitName
@onready var damage_type_color_rect: ColorRect = %DamageTypeColorRect
@onready var damage_type_label: Label = %DamageTypeLabel
@onready var damage_value: Label = %DamageValue
@onready var armor_type_color_rect: ColorRect = %ArmorTypeColorRect
@onready var armor_type_label: Label = %ArmorTypeLabel
@onready var armor_value: Label = %ArmorValue


func _ready():
	pass


func _set_unit_stats(value: UnitStats):
	if (unit_stats != value and unit_stats):
		if (unit_stats.stats_changed.is_connected(_update_ui)):
			unit_stats.stats_changed.disconnect(_update_ui)
	
	if not (value.stats_changed.is_connected(_update_ui)):
		value.stats_changed.connect(_update_ui)
	unit_stats = value
	_update_ui()


func _update_ui():
	if (!is_node_ready()):
		await ready
	
	if (unit_stats):
		unit_name.text = unit_stats.name
		damage_type_color_rect.color = DAMAGE_TYPE_COLORS[unit_stats.damage_type] 
		damage_type_label.text = unit_stats.DamageType.find_key(unit_stats.damage_type)
		damage_value.text = "%.f" % unit_stats.attack_damage
		armor_type_color_rect.color = ARMOR_TYPE_COLORS[unit_stats.armor_type] 
		armor_type_label.text = unit_stats.ArmorType.find_key(unit_stats.armor_type)
		armor_value.text = "%.f" % unit_stats.armor
