extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


const SPEED = 200.0
const JUMP_VELOCITY = -335.0

var e_inattack_range =  false
var g_inattack_range = false
var HEARTLIST : Array[TextureRect]
var ATTACKED := false

var e_attackCD =  true
var g_attackCD =  true
var HP = 100
var player_alive = true 

var attack_ip = false


var took_damage = false
var can_move = true




	
	
func _physics_process(delta: float) -> void:
	enemy_attack()
	attack()
	updhp()
	# different spikes

	# Collision checking (e.g. if touching spikes)
# Collision checking (e.g. if touching spikes)
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()

		if collider and "tilemapspike" in collider.name:
			HP = 0
			break  # stop checking further collisions this frame

	if HP <= 0 and player_alive:
		player_alive = false
		
		HP = 0
		print("player has been eliminated")

		can_move = false
		attack_ip = true
		animated_sprite.play("death")

		await get_tree().create_timer(2.0).timeout
		get_tree().reload_current_scene()
		return
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	

				
			
			
		

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#gets input direction: -1,0,1
	var direction := Input.get_axis("move_left", "move_right")
	#flips sprite
	if HP >=1:
		if direction > 0:
			animated_sprite.flip_h = false
		elif direction < 0:
			animated_sprite.flip_h = true
		
	#play animation
	if is_on_floor():
		if direction == 0:
			if attack_ip == false:
				animated_sprite.play("default")
		else:
			if attack_ip == false:
				animated_sprite.play("run")
	else:
		if attack_ip == false:
			animated_sprite.play("workingjump")
	
	if can_move == false:
		return
	else:
		if direction:
			velocity.x =direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0 , SPEED)
			
		move_and_slide()
	
	
func player():
	pass
	
func _on_phitbox_body_entered(body: Node2D) -> void:

		if body.has_method("enemy"):
			e_inattack_range = true
		elif body.has_method("ghost"):
			g_inattack_range = true
		
		

		

func _on_phitbox_body_exited(body: Node2D) -> void: 
	if body.has_method("enemy"):
		e_inattack_range =  false
	else:
		if body.has_method("ghost"):
			g_inattack_range = false
		
func enemy_attack():
	if HP >= 1:
		if e_inattack_range and e_attackCD == true:
			HP = HP - 10
			e_attackCD = false
			$AttackCD.start()
			print(HP)
		elif  g_inattack_range and g_attackCD == true:
				HP = HP - 20
				g_attackCD = false
				$AttackCD.start()
				print(HP)
	else:
		return


func _on_attack_cd_timeout() -> void:
	e_attackCD = true
	g_attackCD = true
func attack():
	if Input.is_action_just_pressed("attack"):
		Global.player_current_attack = true
		attack_ip = true
		$AnimatedSprite2D.play("attack")
		$deal_attack_timer.start()
		
		




func _on_deal_attack_timer_timeout() -> void:
	$deal_attack_timer.stop()
	Global.player_current_attack =  false
	attack_ip = false
func shake_camera(duration: float = 0.1, intensity: float = .0) -> void:
	var elapsed = 0.0
	while elapsed < duration:
		var offset = Vector2(randf_range(-intensity, intensity), randf_range(-intensity, intensity))
		$Camera2D.offset = offset
		await get_tree().process_frame
		elapsed += get_process_delta_time()
	$Camera2D.offset = Vector2.ZERO  # reset after shake


	


func _on_regen_timeout() -> void:
	if HP < 100:
		HP = HP  + 20
	if HP > 100:
		HP = 100
	if HP <= 0:
		HP = 0
	
	
func updhp():
	var hpbar = $healtbar
	hpbar.value = HP

	


func _on_hurtbox_body_entered(body: Node2D) -> void:
	print("Hurtbox touched by: ", body.name)
	if body.name.begins_with("spider"):
		HP = 0
		print("player got 1shotted lmao -spdr")
