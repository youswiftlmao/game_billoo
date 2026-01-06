extends Node2D

var player_inside := false
var player: Node = null

func _ready() -> void:
	$DRAGON.play("default")
	$"lower jaw".hide()
	$"upper jaw".hide()

	player = get_tree().get_root().find_child("player", true, false)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		player_inside = true

		$DRAGON.hide()
		$"lower jaw".show()
		$"upper jaw".show()

		# RESET animations to frame 0
		var lower_anim = $"lower jaw/Sprite2D2/AnimationPlayer"
		var upper_anim = $"upper jaw/Sprite2D3/AnimationPlayer"

		lower_anim.stop()
		lower_anim.seek(0, true)

		upper_anim.stop()
		upper_anim.seek(0, true)

		# Play cleanly from the start
		lower_anim.play("jaw")
		upper_anim.play("upper jaw")

		# Start shake + loop
		call_deferred("shake_loop")
		loop_jaws()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "player":
		player_inside = false


func loop_jaws() -> void:
	while player_inside:
		await $"lower jaw/Sprite2D2/AnimationPlayer".animation_finished
		await $"upper jaw/Sprite2D3/AnimationPlayer".animation_finished

		$"lower jaw/Sprite2D2/AnimationPlayer".play("jaw")
		$"upper jaw/Sprite2D3/AnimationPlayer".play("upper jaw")

	reset_dragon()


func shake_loop() -> void:
	await get_tree().create_timer(1).timeout

	while player_inside:
		if player:
			player.shake_camera(0.1, 3.0)
		await get_tree().create_timer(1).timeout


func reset_dragon() -> void:
	$DRAGON.show()
	$"lower jaw".hide()
	$"upper jaw".hide()
	$DRAGON.play("default")
