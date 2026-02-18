class_name UnitState
extends Node


@warning_ignore("unused_signal")
signal transition_requested(from: UnitState, to: State)

enum State {IDLE, ATTACKING, RUNNING, CASTING, DEAD}

const DEBUG_STATE_COLOR: Dictionary[UnitState.State, Color] = {
	UnitState.State.IDLE: Color.BLUE,
	UnitState.State.RUNNING: Color.DARK_GREEN,
	UnitState.State.ATTACKING: Color.DARK_RED,
	UnitState.State.CASTING: Color.CYAN,
	UnitState.State.DEAD: Color.CHOCOLATE
}

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


func recheck_ai():
	pass


func _update_debug_state_info() -> void:
	assert(unit, "unit should not be null")
	if unit:
		unit.debug_state_rect.color = DEBUG_STATE_COLOR[state]
		unit.debug_state_label.text = State.find_key(state)
