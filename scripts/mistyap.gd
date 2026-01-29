extends CharacterBody2D  

@onready var dialogue_ui = $dialogue
var player_in_range := false
var player_ref: Node = null

func _input(event):
	if player_in_range and event.is_action_pressed("ui_accept"):
		dialogue_ui.start()


func _on_talk_area_body_entered(body: Node2D) -> void:
	if body.name == "player":
		player_in_range = true
		player_ref = body
		if not dialogue_ui.dfinished.is_connected(body._on_dialog_dfinished):
			dialogue_ui.dfinished.connect(body._on_dialog_dfinished)

func _on_talk_area_body_exited(body: Node2D) -> void:
	if body == player_ref:
		player_in_range = false
		player_ref = null
