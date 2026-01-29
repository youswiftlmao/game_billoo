extends Node2D

var move := false
var player_inside := false
var player: Node = null
var shake_active := false
const  speed := 200

func _ready() -> void:
	$DRAGON.play("default")
	$"lower jaw".hide()
	$"upper jaw".hide()
	
	player = get_tree().get_root().find_child("player", true, false) 
func _physics_process(delta: float) -> void:
	if move:
		position.x += speed * delta	
func _on_area_2d_body_entered(body: Node2D) -> void:

	if body.name == "player":
		player_inside = true


		$DRAGON.hide()

		$"lower jaw".show()
		$"upper jaw".show()


		var lower_anim = $"lower jaw/AnimationPlayer"
		var upper_anim = $"upper jaw/AnimationPlayer"

		lower_anim.stop()
		lower_anim.seek(0, true)

		upper_anim.stop()
		upper_anim.seek(0, true)

		lower_anim.play("jaw")
		upper_anim.play("upper jaw")


		call_deferred("shake_loop")
		call_deferred("loop_jaws")


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "player":
		player_inside = false


func loop_jaws() -> void:
	while player_inside:
		await $"lower jaw/AnimationPlayer".animation_finished
		await $"upper jaw/AnimationPlayer".animation_finished

		$"lower jaw/AnimationPlayer".play("jaw")
		$"upper jaw/AnimationPlayer".play("upper jaw")
	
	reset_dragon()


func shake_loop() -> void:
	if shake_active:
		return

	shake_active = true

	await get_tree().create_timer(1).timeout

	while player_inside:
		if player:
			player.shake_camera(0.1, 3.0)
		await get_tree().create_timer(1).timeout


	if player:
		player.shake_camera(0.1, 3.0)

	shake_active = false

func reset_dragon() -> void:
	$DRAGON.show()
	$"lower jaw".hide()
	$"upper jaw".hide()
	$DRAGON.play("default")
	


func _on_playerdetector_body_entered(body: Node2D) -> void:
	if body.name == "player":
		move = true
		


func _on_playerdetector_body_exited(body: Node2D) -> void:
	if body.name == "player":
		return
