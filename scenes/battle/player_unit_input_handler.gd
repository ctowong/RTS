class_name PlayerUnitInputHandler
extends Node2D

const MIN_DISTANCE_TO_START_DRAG: float = 100

var battle_unit_selection_ui: BattleUnitSelectionUI
var unit_handler: UnitHandler : set = _set_unit_handler
var selected_units: Array[BaseUnit] = []
var is_dragging: bool = false
var select_mouse_held_down: bool = false
var select_mouse_held_start_global_position: Vector2


@onready var mouse_selection_box: MouseSelectionBox = %MouseSelectionBox


func _ready() -> void:
	mouse_selection_box.show()


func _input(event: InputEvent) -> void:
	_update_drag_area(event)
	_handle_selection(event)
	_handle_movement(event)


func _update_drag_area(_event: InputEvent):
	if select_mouse_held_down:
		mouse_selection_box.box_start_global_position = select_mouse_held_start_global_position
		var vector_from_start_of_hold: Vector2 = abs(select_mouse_held_start_global_position - get_global_mouse_position())
		if vector_from_start_of_hold.length() >= MIN_DISTANCE_TO_START_DRAG:
			is_dragging = true
	if is_dragging:
		mouse_selection_box.box_end_global_position = get_global_mouse_position()



func _handle_selection(event: InputEvent):
	if event.is_action("battle_action_select"):
		# unselect everything on click
		for child in selected_units:
			child.is_selected = false
		selected_units = []
		
		# single click handling
		if event is InputEventMouseButton:
			if event.is_pressed():
				select_mouse_held_down = true
				select_mouse_held_start_global_position = event.global_position
			elif event.is_released():
				select_mouse_held_down = false
				mouse_selection_box.show()

				# if time is too short, do a single select
				if not is_dragging:
					return
					for child in unit_handler.units:
						if child.in_selection_area(event.global_position):
							selected_units.append(child)
							child.is_selected = true
							
							selected_units.append(child)
							var selected_unit_stats: Array[UnitStats] = []
							selected_unit_stats.append(child.unit_stats)
							battle_unit_selection_ui.unit_stats_list = selected_unit_stats
							# break on first single click
							return
				
				if is_dragging:
					is_dragging = false
					var selected_unit_stats: Array[UnitStats] = []
					#for child in unit_handler.units:
					#	if (
					#		child.global_position.x >= min(get_global_mouse_position().x, select_mouse_held_start_global_position.x)
					#		and child.global_position.x <= max(get_global_mouse_position().x, select_mouse_held_start_global_position.x)
					#		and child.global_position.y >= min(get_global_mouse_position().y, select_mouse_held_start_global_position.y)
					#		and child.global_position.y <= max(get_global_mouse_position().y, select_mouse_held_start_global_position.y)
					#	):
					#		selected_units.append(child)
					#		child.is_selected = true
					#		selected_unit_stats.append(child.unit_stats)
					#selected_unit_stats.sort_custom(sort_units)
					#battle_unit_selection_ui.unit_stats_list = selected_unit_stats
			if selected_units.size() == 0:
				#var temp_unit_stats_list: Array[UnitStats] = []
				#battle_unit_selection_ui.unit_stats_list = temp_unit_stats_list
				pass


func _handle_movement(event: InputEvent):
	if event.is_action("battle_action_command"):
		select_mouse_held_down = false
		for unit in selected_units:
			unit.move_to(get_global_mouse_position())


func single_unit_select(selected_unit: BaseUnit) -> void:
	for unit in selected_units:
		unit.is_selected = false
	selected_units = []
	selected_units.append(selected_unit)
	selected_unit.is_selected = true


func _set_unit_handler(value: UnitHandler) -> void:
	unit_handler = value

func sort_units(a: UnitStats, b: UnitStats) -> bool:
	if a.selection_sort_order <= b.selection_sort_order:
		return true
	elif (a.selection_sort_order == b.selection_sort_order) and (a.name <= b.name):
		return true
	return false
