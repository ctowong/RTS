class_name BaseUnit
extends CharacterBody2D

@export var speed: float = 100.0
@export var unit_name: String = "default_unit_name"

@onready var animation_player: AnimatedSprite2D = %AnimationPlayer
@onready var unit_state_machine: UnitStateMachine = %UnitStateMachine
@onready var debug_state_rect: ColorRect = %DebugStateRect
@onready var debug_state_label: Label = %DebugStateLabel

var target_position: Vector2


func _input(event: InputEvent) -> void:
	unit_state_machine.on_input(event)


func _ready() -> void:
	target_position = global_position
	unit_state_machine.init(self)
	


func _physics_process(_delta: float) -> void:
	unit_state_machine.move_and_slide()


func move_to(position: Vector2):
	target_position = position
	unit_state_machine.recheck_ai()
