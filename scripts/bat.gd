extends CharacterBody2D
var speed = 35
var playerchase = false
var player = null
var  health = 50
var player_inattack_zone = false
var can_take_damage = true

func _physics_process(delta: float) -> void:
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
	if player_inattack_zone and Global.player_current_attack == true:
		if can_take_damage == true:
			$TAKEDAMAGECD.start()
			can_take_damage = false
			health -= 20
			print("bat got slimed = ", health)
			
			# Call the player's shake_camera function
			if player:
				player.shake_camera(0.1, 5.0)  # duration = 0.1s, intensity = 5px

			# Brief freeze + smooth knockback
			var original_chase = playerchase
			playerchase = false  # freeze for knockback

			if health > 0:
				var knockback_distance = 50
				var knockback_time = 0.2
				var elapsed = 0.0
				var direction = 1 if player.position.x < position.x else -1
				while elapsed < knockback_time:
					position.x += direction * knockback_distance * get_process_delta_time() / knockback_time
					await get_tree().process_frame
					elapsed += get_process_delta_time()

				# Resume chasing after knockback
				playerchase = original_chase

			# If dead
			if health <= 0:
				playerchase = false
				can_take_damage = false
				$AnimatedSprite2D.play("death")

				# Freeze briefly for death animation
				await get_tree().create_timer(0.5).timeout

				# Fall smoothly
				var fall_speed = 150
				while position.y < 1000:  # arbitrary off-screen value
					position.y += fall_speed * get_process_delta_time()
					await get_tree().process_frame

				queue_free()

func _on_takedamagecd_timeout() -> void:
	can_take_damage = true
	
