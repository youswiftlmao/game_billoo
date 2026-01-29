extends Area2D

@export var point_a = Vector2(540, -47)

var busy := false

func _on_body_entered(body: Node2D) -> void:
	if busy:
		return
	if body.name == "player":
		busy = true
		await teleport(body)
		busy = false

func teleport(player):
	var fade = player.get_node("Camera2D/CanvasLayer/FadeRect")

	# fade out
	fade.fade_out(0.5)
	await get_tree().create_timer(0.5).timeout

	# move player
	player.global_position = point_a

	# fade in
	fade.fade_in(0.5)

	# prevent instant re-trigger
	await get_tree().create_timer(0.5).timeout
