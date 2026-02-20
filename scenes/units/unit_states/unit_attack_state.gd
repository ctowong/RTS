extends UnitState


func enter() -> void:
	_update_debug_state_info()
	if not unit.animation_player.animation_finished.is_connected(_finished_attacking):
		unit.animation_player.animation_finished.connect(_finished_attacking)
	
	unit.animation_player.play("attack1")


func _finished_attacking() -> void:
	transition_requested.emit(self, UnitState.State.IDLE)
