class_name BattleMouseControlStateMachine
extends Node

@export var initial_state: BattleMouseControlState


var current_state: BattleMouseControlState
var states: Dictionary[BattleMouseControlState.State, BattleMouseControlState] = {}



func init(unit_handler: UnitHandler, battle_unit_selection_ui: BattleUnitSelectionUI, mouse_selection_box: MouseSelectionBox) -> void:
	for child in get_children():
		if child is BattleMouseControlState:
			states[child.state] = child
			if (!child.transition_requested.is_connected(_on_transition_requested)):
				child.transition_requested.connect(_on_transition_requested)
			child.unit_handler = unit_handler
			child.battle_unit_selection_ui = battle_unit_selection_ui
			child.mouse_selection_box = mouse_selection_box
		else:
			print_debug("Child of BattleMouseControlStateMachine is not a BattleMouseControlState")

	assert (initial_state, "initial state should be assigned")
	if initial_state:
		initial_state.enter()
		current_state = initial_state


func on_input(event: InputEvent) -> void:
	assert(current_state, "current_state should be not null")
	if current_state:
		current_state.on_input(event)


func _on_transition_requested(from_state: BattleMouseControlState, to_state: BattleMouseControlState.State) -> void:
	assert(from_state == current_state, "only the current_state should be emitting the transition_request signal")
	if from_state != current_state:
		return
	
	var new_state: BattleMouseControlState = states[to_state]
	
	assert (new_state, "new_state should not fail lookup")
	if not new_state:
		#If the state lookup fails, don't transition
		return
	
	assert(current_state, "current_state should be not null")
	if current_state:
		current_state.exit()
	
	new_state.enter()
	current_state = new_state
