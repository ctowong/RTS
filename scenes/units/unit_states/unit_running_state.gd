extends UnitState


func enter() -> void:
	_update_debug_state_info()
	unit.animation_player.play("run")


func on_input(event: InputEvent) -> void:
	if event.is_action("unit_attack"):
		transition_requested.emit(self, UnitState.State.ATTACKING)


func move_and_slide() -> bool:
	var input_direction = Input.get_vector("unit_move_left", "unit_move_right", "unit_move_up", "unit_move_down")
	unit.velocity = input_direction * unit.speed
	if unit.velocity.x < 0:
		unit.animation_player.flip_h = true
	elif unit.velocity.x > 0:
		unit.animation_player.flip_h = false
	
	return unit.move_and_slide()
