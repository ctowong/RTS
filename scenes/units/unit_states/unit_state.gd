class_name UnitState
extends Node


@warning_ignore("unused_signal")
signal transition_requested(from: UnitState, to: State)

# TO DO Add CASTING and DEAD states
enum State {IDLE, ATTACKING, RUNNING, CASTING, DEAD}

@export var state: State

var unit: BaseUnit


func enter() -> void:
	pass


func exit() -> void:
	pass


func on_input(_event: InputEvent) -> void:
	pass


func move_and_slide() -> bool:
	return false
