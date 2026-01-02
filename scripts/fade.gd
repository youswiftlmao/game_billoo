extends ColorRect


func fade_out(duration := 1.0):
	visible = true
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, duration)

func fade_in(duration := 1.0):
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, duration)
