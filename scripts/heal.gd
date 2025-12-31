extends Area2D
func _ready():
	body_entered.connect(_on_area_2d_body_entered)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		queue_free()
