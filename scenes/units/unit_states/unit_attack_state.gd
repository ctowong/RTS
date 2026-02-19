extends UnitState


func enter() -> void:
	_update_debug_state_info()
	if not unit.animation_player.animation_finished.is_connected(_finished_attacking):
		unit.animation_player.animation_finished.connect(_finished_attacking)
	
	unit.animation_player.play("attack1")


func _finished_attacking() -> void:
	var input_direction = Input.get_vector("unit_move_left", "unit_move_right", "unit_move_up", "unit_move_down")
	if input_direction.abs().x > 0 or input_direction.abs().y > 0:
		transition_requested.emit(self, UnitState.State.RUNNING)
	else:
		transition_requested.emit(self, UnitState.State.IDLE)
