extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("Coin Collected!")
		# Remove the coin from the game
		queue_free() 
