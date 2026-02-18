extends UnitState

const MIN_MOVEMENT_POS_DELTA = 20 # don't move if pixel difference less than this amount


func enter() -> void:
	_update_debug_state_info()
	unit.animation_player.play("idle")
	
	# make sure unit does not move when re-entering idle
	unit.target_position = unit.global_position


func on_input(event: InputEvent) -> void:
	if event.is_action("unit_attack"):
		transition_requested.emit(self, UnitState.State.ATTACKING)
	elif abs(unit.global_position - unit.target_position).length() > MIN_MOVEMENT_POS_DELTA:
		transition_requested.emit(self, UnitState.State.RUNNING)


func recheck_ai():
	if abs(unit.global_position - unit.target_position).length() > MIN_MOVEMENT_POS_DELTA:
		transition_requested.emit(self, UnitState.State.RUNNING)
