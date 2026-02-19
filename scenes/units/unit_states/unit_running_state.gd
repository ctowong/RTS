extends UnitState

const MIN_MOVEMENT_POS_DELTA: float = 5.0 # don't move if pixel difference less than this amountfunc enter() -> void:
const MAX_STALLED_MOVEMENT_TIME_SEC: float = 0.5 # Stop moving if position is minimally changing over this time period

var stalled_movement_time: float = 0.0
var is_stalled: bool = false
var last_position: Vector2

func enter() -> void:
	_update_debug_state_info()
	stalled_movement_time = 0.0
	unit.animation_player.play("run")
	last_position = unit.global_position


func on_input(event: InputEvent) -> void:
	if event.is_action("unit_attack"):
		transition_requested.emit(self, UnitState.State.ATTACKING)


func move_and_slide() -> bool:
	_update_stall_time()

	if is_stalled:
		if stalled_movement_time > MAX_STALLED_MOVEMENT_TIME_SEC:
			_return_to_idle()
			return false

	last_position = unit.global_position
	
	
	var vector_to_target = unit.target_position - unit.global_position

	# If distance is too small, do not move
	if vector_to_target.length() < MIN_MOVEMENT_POS_DELTA:
		_return_to_idle()
		return false
	
	unit.velocity = vector_to_target.normalized() * unit.speed
	if unit.velocity.x < 0:
		unit.animation_player.flip_h = true
	elif unit.velocity.x > 0:
		unit.animation_player.flip_h = false
	
	return unit.move_and_slide()
	

func _return_to_idle():
	unit.velocity = Vector2(0.0, 0.0)
	transition_requested.emit(self, State.IDLE)

func _update_stall_time() -> void:
	# if unit moved less than max velocity after the last tick, start the stalled movement timer
	var amount_moved_since_last_delta: float = abs(last_position - unit.global_position).length()
	# If unit moves less than half the expected speed in a given delta, assume unit is stalled
	if  amount_moved_since_last_delta < unit.speed / 2 * get_physics_process_delta_time():
		# if the unit is not currently stalled, restart the timer
		if not is_stalled:
			is_stalled = true
			stalled_movement_time = 0
		stalled_movement_time += get_physics_process_delta_time()
	else:
		is_stalled = false
