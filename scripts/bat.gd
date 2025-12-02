extends CharacterBody2D
var speed = 35
var playerchase = false
var player = null
func _physics_process(delta: float) -> void:
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
