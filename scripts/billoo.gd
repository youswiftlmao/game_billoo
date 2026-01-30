extends CharacterBody2D



func _on_talk_area_body_entered(body: Node2D) -> void:
	if body.name.begins_with("player"):
		var fade := get_node("dd/CanvasLayer/FadeRect")
		await fade.fade_out(2.0)
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
