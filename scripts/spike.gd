extends Sprite2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	get_tree().call_deferred("reload_scene")
