extends Sprite2D


func _on_area_2d_body_entered(_body: Node2D) -> void:
	get_tree().call_deferred("reload_current_scene")
