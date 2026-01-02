extends AnimatedSprite2D




var triggered := false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if triggered:
		return
	if body.name == "player":
		triggered = true

		var fade = body.get_node_or_null("Camera2D/CanvasLayer/FadeRect")
		if fade:
			fade.fade_out(1.0)

		await get_tree().create_timer(1.0).timeout
		get_tree().change_scene_to_file("res://scenes/lvl_3.tscn")
