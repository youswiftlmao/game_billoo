extends StaticBody2D

@onready var col: CollisionShape2D = $CollisionShape2D
@onready var sprite: Sprite2D = $Sprite2D

var triggered: bool = false
var player_inside: bool = false

func _ready() -> void:
	col.disabled = true
	sprite.visible = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		player_inside = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "player":
		player_inside = false


func _physics_process(delta: float) -> void:
	if triggered or not player_inside:
		return

	var player := get_tree().get_root().find_child("player", true, false)
	if not player:
		return

	# Only trigger if the player is inside AND moving upward
	if player.velocity.y < 0.0:
		triggered = true
		col.disabled = false
		sprite.visible = true
