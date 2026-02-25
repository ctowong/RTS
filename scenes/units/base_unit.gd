class_name BaseUnit
extends CharacterBody2D

@export var collision_shape_radius: float = 20.0
@export var unit_stats: UnitStats: set = _set_unit_stats

@onready var collision_shape: CollisionShape2D = %CollisionShape
@onready var unit_animation: UnitAnimation = %UnitAnimation
@onready var unit_state_machine: UnitStateMachine = %UnitStateMachine
@onready var debug_state_rect: ColorRect = %DebugStateRect
@onready var debug_state_label: Label = %DebugStateLabel
@onready var mouse_select_area: CollisionShape2D = %MouseSelectArea
@onready var visuals: Node2D = $Visuals

var target_position: Vector2
var is_selected: bool : set = _set_selected

func _input(event: InputEvent) -> void:
	unit_state_machine.on_input(event)


func _ready() -> void:
	is_selected = false
	target_position = global_position
	
	var new_collision_shape := CircleShape2D.new()
	new_collision_shape.radius = collision_shape_radius
	collision_shape.shape = new_collision_shape
	
	unit_state_machine.init(self)
	


func _physics_process(_delta: float) -> void:
	unit_state_machine.move_and_slide()


func move_to(new_target_position: Vector2):
	target_position = new_target_position
	unit_state_machine.recheck_ai()


func _set_selected(value: bool) -> void:
	is_selected = value
	
	if(unit_animation):
		if value:
			unit_animation.material = unit_stats.OWNER_OUTLINE_MATERIAL[unit_stats.owner]
		else:
			unit_animation.material = null


func _set_unit_stats(value: UnitStats) -> void:
	if (not is_node_ready()):
		await ready
	unit_stats = value.create_instance()
	
	if not unit_stats.stats_changed.is_connected(_update_stats):
		unit_stats.stats_changed.connect(_update_stats)
	
	var new_unit_animation: UnitAnimation = value.unit_animation.instantiate()
	for child in visuals.get_children():
		if (child is UnitAnimation):
			if (unit_animation):
				unit_animation.queue_free()
	visuals.add_child(new_unit_animation)
	unit_animation = new_unit_animation
	unit_state_machine.init(self)


func _update_stats() -> void:
	pass


func in_selection_area(global_position_value: Vector2) -> bool:
	# subtract half the height of the box since the box is aligned to the bottom of the unit

	var rect_global_position: Vector2 = mouse_select_area.shape.get_rect().position + global_position  - Vector2(0,mouse_select_area.shape.get_rect().size.y/2)
	var rect_global_end: Vector2 = mouse_select_area.shape.get_rect().end + global_position - Vector2(0,mouse_select_area.shape.get_rect().size.y/2)

	var result: bool = (
			 global_position_value.x >= rect_global_position.x
			and global_position_value.x <= rect_global_end.x
			and global_position_value.y >= rect_global_position.y
			and global_position_value.y <= rect_global_end.y
	)
	
	return result
	
