extends UnitState


func enter() -> void:
	unit.animation_player.play("idle")


func on_input(event: InputEvent) -> void:
	if event.is_action("unit_attack"):
		transition_requested.emit(self, UnitState.State.ATTACKING)
	elif (event.is_action("unit_move_up")
	or event.is_action("unit_move_down")
	or event.is_action("unit_move_left")
	or event.is_action("unit_move_right")):
		transition_requested.emit(self, UnitState.State.RUNNING)
