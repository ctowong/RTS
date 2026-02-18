extends UnitState

const MIN_MOVEMENT_POS_DELTA = 5 # don't move if pixel difference less than this amountfunc enter() -> void:


func enter() -> void:
	_update_debug_state_info()
	unit.animation_player.play("run")


func on_input(event: InputEvent) -> void:
	if event.is_action("unit_attack"):
		transition_requested.emit(self, UnitState.State.ATTACKING)


func move_and_slide() -> bool:
	var vector_to_target = unit.target_position - unit.global_position

	# If distance is too small, do not move
	if vector_to_target.length() < MIN_MOVEMENT_POS_DELTA:
		unit.velocity = Vector2(0.0, 0.0)
		transition_requested.emit(self, State.IDLE)
		return false
	
	unit.velocity = vector_to_target.normalized() * unit.speed
	if unit.velocity.x < 0:
		unit.animation_player.flip_h = true
	elif unit.velocity.x > 0:
		unit.animation_player.flip_h = false
	return unit.move_and_slide()
