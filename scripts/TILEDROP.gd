extends TileMap


# Called when the node enters the scene tree for the first time.



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name.begins_with("player"):
		$AnimationPlayer.play("goobsdrop")
