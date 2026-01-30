extends Node2D





func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/game.tscn")


func _on_tut_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/tut.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
	
