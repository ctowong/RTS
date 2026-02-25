class_name UnitStats
extends Resource

signal stats_changed

enum Owner {PLAYER, ENEMY, NEUTRAL}
enum DamageType {NORMAL, PIERCING, MAGIC}
enum ArmorType {LIGHT, MEDIUM, HEAVY}

@export_group("Visuals")
@export var portrait: Texture
@export var unit_animation: PackedScene
@export_multiline var name: String

@export_group("Gameplay Data")
@export var max_hp: float: set = _set_max_hp
@export var max_mp: float: set = _set_max_mp
@export var attack_damage: float
@export var attack_range: float
@export var damage_type: DamageType
@export var armor: float
@export var armor_type: ArmorType
@export var speed: float
@export var owner: Owner

var hp: float : set = _set_hp
var mp: float : set = _set_mp




func create_instance() -> UnitStats:
	var instance: UnitStats = self.duplicate()
	instance.hp = max_hp
	instance.mp = max_mp
	return instance


func _set_hp(value: float):
	hp = clamp(value, 0, max_hp)
	stats_changed.emit()


func _set_mp(value: float):
	mp = clamp(value, 0, max_mp)
	stats_changed.emit()


func _set_max_hp(value: float):
	max_hp = value
	stats_changed.emit()
	

func _set_max_mp(value: float):
	max_mp = value
	stats_changed.emit()


func take_damage(damage: float) -> void:
	if damage <= 0:
		return
	self.hp -= damage
	stats_changed.emit()
