class_name UnitStats
extends Resource

signal stats_changed

enum Owner {PLAYER, ENEMY, NEUTRAL}
enum DamageType {NORMAL, PIERCING, MAGIC}
enum ArmorType {LIGHT, MEDIUM, HEAVY}

@export_group("Visuals")
@export var portrait: Texture
@export var visuals: PackedScene
@export_multiline var name: String

@export_group("Gameplay Data")
@export var max_hp: float
@export var attack_damage: float
@export var attack_range: float
@export var damage_type: DamageType
@export var armor: float
@export var armor_type: ArmorType
@export var speed: float
@export var owner: Owner

var hp: float : set = _set_hp


func create_instance() -> UnitStats:
	var instance: UnitStats = self.duplicate()
	instance.hp = max_hp
	return instance


func _set_hp(value: float):
	hp = clamp(value, 0, max_hp)
	stats_changed.emit()

func take_damage(damage: float) -> void:
	if damage <= 0:
		return
	self.hp -= damage
	stats_changed.emit()
