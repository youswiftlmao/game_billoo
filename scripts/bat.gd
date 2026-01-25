extends CharacterBody2D
var speed = 45
var playerchase = false
var player = null
var  health = 40
var player_inattack_zone = false
var can_take_damage = true

func _physics_process(delta: float) -> void:
	updhp()
	deal_with_damage()
	
	if playerchase:
		position += (player.position - position)/speed
		
		if(player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = false
		else:
			$AnimatedSprite2D.flip_h = true

func _on_detection_body_entered(body: Node2D) -> void:
	player = body
	playerchase =  true
	


func _on_detection_body_exited(body: Node2D) -> void:
	player = null
	playerchase = false
func enemy():
	pass



func _on_bhitbox_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_inattack_zone = true
	



func _on_bhitbox_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_inattack_zone = false
		
func deal_with_damage():
	# Clamp health and stop damage if dead
	if health <= 0:
		health = 0
		can_take_damage = false

	# Only take damage if player is attacking and bat is allowed to take damage
	if player_inattack_zone and Global.player_current_attack and can_take_damage:
		$TAKEDAMAGECD.start()
		can_take_damage = false
		health -= 20
		print("bat got slimed =", health)

		# Camera shake (only if the player actually has the method)
		if player and player.has_method("shake_camera"):
			player.shake_camera(0.1, 5.0)

		# Pause chasing during knockback
		var was_chasing = playerchase
		playerchase = false

		# Knockback only if still alive
		if health > 0:
			var knockback_distance = 50
			var knockback_time = 0.2
			var elapsed = 0.0
			var direction = 1 if player.position.x < position.x else -1

			while elapsed < knockback_time:
				# Stop immediately if the node is removed from the scene
				if not is_inside_tree():
					return

				position.x += direction * knockback_distance * get_process_delta_time() / knockback_time
				await get_tree().create_timer(0).timeout
				elapsed += get_process_delta_time()

			# Resume chasing after knockback
			playerchase = was_chasing

	# Handle death
	if health <= 0:
		playerchase = false
		can_take_damage = false
		$AnimatedSprite2D.play("death")

		# Give the animation a moment to show
		if is_inside_tree():
			await get_tree().create_timer(0.5).timeout

		# Smooth fall off-screen
		var fall_speed = 150
		while is_inside_tree() and position.y < 1000:
			position.y += fall_speed * get_process_delta_time()
			await get_tree().create_timer(0).timeout

		if is_inside_tree():
			queue_free()
func _on_takedamagecd_timeout() -> void:
	can_take_damage = true
	
func updhp():
	var healthbar = $healthbar
	healthbar.value = health



	
