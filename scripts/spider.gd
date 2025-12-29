

extends CharacterBody2D

var SPEED := 10.0
var facing_left := false
var can_flip := true

func _physics_process(delta):
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Move
	velocity.x = SPEED
	move_and_slide()

	# Edge detection
	if is_on_floor() and not $RayCast2D.is_colliding() and can_flip:
		flip()
		can_flip = false

	# Reset flip lock when ground is detected again
	if $RayCast2D.is_colliding():
		can_flip = true

func flip():
	facing_left = !facing_left

	# Reverse direction
	SPEED = -SPEED

	# Flip sprite
	scale.x = -scale.x

	# Flip RayCast forward direction
	$RayCast2D.target_position.x *= -1
