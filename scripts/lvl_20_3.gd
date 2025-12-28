extends AnimatedSprite2D


var triggered := false  # prevent multiple triggers

func _on_area_2d_body_entered(body: Node2D) -> void:
	if triggered:
		return
	if body.has_method("player"):
		triggered = true
		# Use a short timer to delay the level change
		var timer = Timer.new()
		timer.wait_time = 1.0  # 1 second delay
		timer.one_shot = true
		add_child(timer)
		timer.start()
		timer.connect("timeout", Callable(self, "_change_level"))

func _change_level() -> void:
	get_tree().change_scene_to_file("res://scenes/lvl_3.tscn")
