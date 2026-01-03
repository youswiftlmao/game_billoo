extends ColorRect

func flash(
	fade_in_time: float = 0.15,
	hold_time: float = 0.2,
	fade_out_time: float = 0.4,
	max_alpha: float = 0.18
) -> void:
	visible = true
	modulate.a = 0.0  # start fully transparent

	var tween := create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)

	# Fade in
	tween.tween_property(self, "modulate:a", max_alpha, fade_in_time)

	# Hold at max alpha
	tween.tween_interval(hold_time)

	# Fade out
	tween.tween_property(self, "modulate:a", 0.0, fade_out_time)

	tween.finished.connect(_on_tween_finished)


func _on_tween_finished() -> void:
	visible = false
