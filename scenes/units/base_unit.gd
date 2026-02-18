extends CharacterBody2D

@export var speed: float = 100.0

@onready var sprite: AnimatedSprite2D = %Sprite
var is_attacking: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("unit_attack"):
		_trigger_attack_animation()
	
# gets the user keyboard input for testing
func get_keyboard_input() -> void:
	var input_direction = Input.get_vector("unit_move_left", "unit_move_right", "unit_move_up", "unit_move_down")
	velocity = input_direction * speed


func _physics_process(delta: float) -> void:
	get_keyboard_input()
	
	if !is_attacking:
		if velocity.abs().x > 0 or velocity.abs().y > 0:
			sprite.play("run")
		else:
			sprite.play("idle")
		
		if velocity.x < 0:
			sprite.flip_h = true
		elif velocity.x > 0:
			sprite.flip_h = false
		
		move_and_slide()


func _trigger_attack_animation() -> void:
	is_attacking = true
	sprite.play("attack1")
	print("attacking!")
	sprite.animation_finished.connect(func (): is_attacking = false)
	pass
