extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 200.0
const JUMP_VELOCITY = -320.0

var took_damage = false
var can_move = true

func respawn():
	self.visible = false
	can_move = false
	await get_tree().create_timer(0.5).timeout
	self.global_position = Vector2(10,1)
	self.visible = true
	can_move =  true
	await get_tree().create_timer(0.5).timeout
	took_damage = false

	
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	for i in get_slide_collision_count():
		var  collision = get_slide_collision(i)
		
		if collision.get_collider().name == "spiketiles":
			if took_damage == false:
				took_damage = true
				respawn() #respawn the player?
				
			
			
		

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#gets input direction: -1,0,1
	var direction := Input.get_axis("move_left", "move_right")
	#flips sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
	#play animation
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("default")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("workingjump")
	
	if can_move == false:
		return
	else:
		if direction:
			velocity.x =direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0 , SPEED)
			
		move_and_slide()
	
	
