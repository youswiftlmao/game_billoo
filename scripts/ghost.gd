extends CharacterBody2D

var speed = 40
var playerchase = false
var player = null
var health = 60
var player_in_attack_zone = false
var cantakedmg = true
var dead = false

func _physics_process(delta: float) -> void:
	updhp()
	deal_with_damage()

	if playerchase and player != null:
		position += (player.position - position) / speed
		$AnimatedSprite2D.play("run")

		if player != null and (player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = false
		else:
			$AnimatedSprite2D.flip_h = true
	elif health > 0:
		$AnimatedSprite2D.play("idle")
	else:
		$AnimatedSprite2D.play("death")

func _on_detection_zone_body_entered(body: Node2D) -> void:
	player = body
	playerchase = true

func _on_detection_zone_body_exited(body: Node2D) -> void:
	player = null
	playerchase = false

func ghost():
	pass

func _on_ghitbox_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_attack_zone = true

func _on_ghitbox_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_attack_zone = false

func deal_with_damage():
	if health <= 0:
		cantakedmg = false

	if player == null:
		return

	if player_in_attack_zone and Global.player_current_attack == true:
		if cantakedmg == true:
			health -= 20
			$TAKEDAMAGECD.start()
			cantakedmg = false
			print("ghost owie,", health)

			if player != null:
				player.shake_camera(0.1, 5.0)

			var original_chase = playerchase
			playerchase = false

			if health > 0:
				var knockback_distance = 50
				var knockback_time = 0.2
				var elapsed = 0.0
				var direction = 1

				if player != null:
					direction = 1 if player.position.x < position.x else -1

				while elapsed < knockback_time:
					position.x += direction * knockback_distance * get_process_delta_time() / knockback_time
					await get_tree().process_frame
					elapsed += get_process_delta_time()

				playerchase = original_chase

			if health <= 0:
				playerchase = false
				cantakedmg = false
				await get_tree().create_timer(0.5).timeout

				var fall_speed = 150
				while position.y < 1000:
					position.y += fall_speed * get_process_delta_time()
					await Engine.get_main_loop().process_frame

				queue_free()

func _on_takedamagecd_timeout() -> void:
	cantakedmg = true

func updhp():
	var healthbar = $healthbar
	healthbar.value = health
