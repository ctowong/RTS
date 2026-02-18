class_name BaseUnit
extends CharacterBody2D

signal unit_selected(which_unit: BaseUnit)

@export var speed: float = 100.0
@export var unit_name: String = "default_unit_name"
@export var collision_shape_radius: float = 20.0

@onready var collision_shape: CollisionShape2D = %CollisionShape
@onready var animation_player: AnimatedSprite2D = %AnimationPlayer
@onready var unit_state_machine: UnitStateMachine = %UnitStateMachine
@onready var debug_state_rect: ColorRect = %DebugStateRect
@onready var debug_state_label: Label = %DebugStateLabel
@onready var selected_square: ColorRect = %SelectedSquare

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
	selected_square.visible = value


func _on_mouse_select_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action("battle_action_select") and event.is_released():
		unit_selected.emit(self)
