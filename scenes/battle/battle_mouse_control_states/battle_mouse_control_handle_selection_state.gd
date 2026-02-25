extends BattleMouseControlState


func enter() -> void:
	mouse_selection_box.hide()


func on_input(event: InputEvent) -> void:
	transition_requested.emit(self, BattleMouseControlState.State.BASE)
