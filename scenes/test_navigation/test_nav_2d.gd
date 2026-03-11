extends CharacterBody2D

var movement_speed: float = 200.0
var movement_target_position: Vector2 = Vector2(60.0,20.0)

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var arrow: RayCast2D = $Arrow

func _ready() -> void:
	# These values need to be adjusted for the actor's speed
	# and the navigation layout.
	navigation_agent.path_desired_distance = 20
	navigation_agent.target_desired_distance = 10



	# Make sure to not await during _ready.
	actor_setup.call_deferred()

func _input(event: InputEvent) -> void:
	if event.is_action("battle_action_command"):
		set_movement_target(get_global_mouse_position())



func actor_setup() -> void:
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame

	# Now that the navigation map is no longer empty, set the movement target.
	set_movement_target(movement_target_position)

func set_movement_target(movement_target: Vector2) -> void:
	navigation_agent.target_position = movement_target

func _physics_process(_delta: float) -> void:
	if navigation_agent.is_navigation_finished():
		print("finished")
		return

	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()

	print("%s ,%s, %s" % [next_path_position, position, velocity])
	print(navigation_agent.is_target_reachable())
	velocity = current_agent_position.direction_to(next_path_position).limit_length() * movement_speed
	arrow.target_position = velocity
	move_and_slide()
