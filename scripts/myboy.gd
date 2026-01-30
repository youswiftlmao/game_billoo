extends CharacterBody2D




func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name.begins_with("player"):
		# Play fade animation
		$Blasck.visible = true
		$Blasck/AnimationPlayer.play("fade")
		
		# Wait 2 seconds
		await get_tree().create_timer(3.0).timeout
		
		
		# Change scene
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
