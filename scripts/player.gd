extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0
const COYOTE_TIME = 0.2

var coyote_timer = 0.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	update_coyote_timer(delta)
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		coyote_timer = COYOTE_TIME

	# Handle jump.
	if coyote_timer > 0:
		if Input.is_action_just_pressed("ui_accept"):
			coyote_timer = 0
			velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction == 1:
		animated_sprite_2d.flip_h = false
		velocity.x = direction * SPEED 
	elif direction == -1:
		animated_sprite_2d.flip_h = true
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func update_coyote_timer(delta):
	if not is_on_floor() and coyote_timer > 0:
		coyote_timer -= delta
