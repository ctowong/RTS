class_name BattleMouseControlState
extends Node


@warning_ignore("unused_signal")
signal transition_requested(from: BattleMouseControlState, to: State)

enum State {BASE, DRAGGING, HANDLE_SELECTION}

@export var state: State

var unit_handler: UnitHandler
var battle_unit_selection_ui: BattleUnitSelectionUI
var mouse_selection_box: MouseSelectionBox


func enter() -> void:
	pass


func exit() -> void:
	pass


func on_input(_event: InputEvent) -> void:
	pass
