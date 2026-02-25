extends BattleMouseControlState


func enter() -> void:
	mouse_selection_box.hide()


func on_input(event: InputEvent) -> void:
	if event.is_action("battle_action_select"):
		if event is InputEventMouseButton:
			if event.is_pressed():
				mouse_selection_box.box_start_global_position = event.global_position
				transition_requested.emit(self, BattleMouseControlState.State.DRAGGING)
				
	
