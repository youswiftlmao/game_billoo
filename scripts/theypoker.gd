extends Node2D




@export var delay := 1
@export var animation_name := "spike_out"

func _ready():
	await get_tree().create_timer(delay).timeout
	$AnimationPlayer.play("OWIOWI")
