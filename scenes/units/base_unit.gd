class_name BaseUnit
extends CharacterBody2D

@export var speed: float = 100.0

@onready var animation_player: AnimatedSprite2D = %AnimationPlayer
@onready var unit_state_machine: UnitStateMachine = %UnitStateMachine
@onready var debug_state_rect: ColorRect = %DebugStateRect
@onready var debug_state_label: Label = %DebugStateLabel


func _input(event: InputEvent) -> void:
	unit_state_machine.on_input(event)


func _ready() -> void:
	unit_state_machine.init(self)


func _physics_process(_delta: float) -> void:
	unit_state_machine.move_and_slide()
