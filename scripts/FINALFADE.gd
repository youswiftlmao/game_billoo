extends ColorRect


# Called when the node enters the scene tree for the first time.
func fade_out(duration: float = 2.0) -> void:
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, duration)
	await tween.finished
