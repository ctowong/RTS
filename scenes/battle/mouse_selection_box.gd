class_name MouseSelectionBox
extends Node2D

const MIN_DISTANCE_TO_SHOW_BOX: float = 100

@onready var selection_box_ui: Panel = %SelectionBoxUI
@onready var selection_collision_shape: CollisionShape2D = %SelectionCollisionShape

var box_start_global_position: Vector2: set = _set_box_start_global_position
var box_end_global_position: Vector2: set = _set_box_end_global_position


func _update_box() -> void:
	global_position = Vector2(
					(box_start_global_position.x + box_end_global_position.x)/2,
					(box_start_global_position.y + box_end_global_position.y)/2
		)

	selection_box_ui.global_position = Vector2(
					min(box_start_global_position.x, box_end_global_position.x),
					min(box_start_global_position.y, box_end_global_position.y)
		)

	var collision_shape: RectangleShape2D = selection_collision_shape.shape
	collision_shape.set_size(abs(box_start_global_position - box_end_global_position)) 
	selection_box_ui.set_size(abs(box_start_global_position - box_end_global_position)) 

	#print("Updating_Box_Start: %s" % [box_start_global_position])
	#print("Updating_Box_End: %s" % [box_end_global_position])
	#print("collision_box_size: %s" % [collision_shape.size])
	#print("collision_box_pos: %s" % [selection_collision_shape.global_position])
	#print("selection_box_size: %s" % [selection_box.size])
	##print("selection_box_pos: %s" % [selection_box.global_position])
	#print("selection_box_vis: %s" % [selection_box.is_visible_in_tree()])


func _set_box_start_global_position(value: Vector2) -> void:
	box_start_global_position = value
	_update_box()
	pass


func _set_box_end_global_position(value: Vector2) -> void:
	box_end_global_position = value
	_update_box()
	pass
