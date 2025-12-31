extends ColorRect

func flash():
	visible = true
	modulate.a = 0.12  # starting alpha

	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 0.25)
	tween.finished.connect(Callable(self, "_on_tween_finished"))

func _on_tween_finished():
	visible = false
