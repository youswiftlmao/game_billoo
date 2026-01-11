extends Node2D

var triggered := false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if triggered:
		return

	if body.name == "player":
		triggered = true

		$AnimationPlayer.play("PUSHER")

		# Disable collision safely AFTER physics step
		$Area2D/CollisionShape2D2.set_deferred("disabled", true)
