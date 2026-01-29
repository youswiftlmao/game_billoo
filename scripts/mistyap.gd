extends CharacterBody2D  

@onready var dialogue_ui = $dialogue
var player_in_range := false


func _input(event):
	if player_in_range and event.is_action_pressed("ui_accept"):
		dialogue_ui.start()

func _on_talk_area_body_entered(body: Node2D) -> void:
	if body.name == "player":
		player_in_range = true

func _on_talk_area_body_exited(body: Node2D) -> void:
	if body.name == "player":
		player_in_range = false
