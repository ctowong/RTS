class_name UnitStateMachine
extends Node

@export var initial_state: UnitState

var current_state: UnitState
var states: Dictionary[UnitState.State, UnitState] = {}


func init(unit: BaseUnit) -> void:
	for child in get_children():
		if child is UnitState:
			states[child.state] = child
			child.transition_requested.connect(_on_transition_requested)
			child.unit = unit
		else:
			print_debug("Child of UnitStateMachine is not a UnitState")

	assert (initial_state, "initial state should be assigned")
	if initial_state:
		initial_state.enter()
		current_state = initial_state


func on_input(event: InputEvent) -> void:
	assert(current_state, "current_state should be not null")
	if current_state:
		current_state.on_input(event)


func _on_transition_requested(from_state: UnitState, to_state: UnitState.State) -> void:
	#This should be an assertion.  Only the current_state should be emitting the transition_request signal. The current_state would emit itself as the "from" CardState and hence, from should always be the same as the current_state tracked in the StateMachine
	assert(from_state == current_state, "only the current_state should be emitting the transition_request signal")
	if from_state != current_state:
		return
	
	var new_state: UnitState = states[to_state]
	
	assert (new_state, "new_state should not fail lookup")
	if not new_state:
		#If the state lookup fails, don't transition
		return
	
	assert(current_state, "current_state should be not null")
	if current_state:
		current_state.exit()
	
	new_state.enter()
	current_state = new_state


func move_and_slide() -> bool:
	assert(current_state, "current_state should be not null")
	if current_state:
		return current_state.move_and_slide()
	else:
		return false
