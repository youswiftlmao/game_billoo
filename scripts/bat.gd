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
		if  can_take_damage == true:
			$TAKEDAMAGECD.start()
			can_take_damage = false
			health = health - 20
			print("bat got slimed = ", health)
			if health <= 0:
				self.queue_free()


func _on_takedamagecd_timeout() -> void:
	can_take_damage = true
	
