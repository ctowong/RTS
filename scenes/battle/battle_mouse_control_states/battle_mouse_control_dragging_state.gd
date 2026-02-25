extends BattleMouseControlState


func enter() -> void:
	mouse_selection_box.show()


func on_input(event: InputEvent) -> void:
	mouse_selection_box.box_end_global_position = event.global_position
	if event.is_action("battle_action_select"):
		transition_requested.emit(self, BattleMouseControlState.State.HANDLE_SELECTION)
