extends Node2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var door_collision: CollisionShape2D = $StaticBody2D/CollisionShape2D
@onready var trigger: Area2D = $TriggerArea

const REQUIRED_COINS = 5

var is_open := false
var player_inside := false
var player_ref = null

func _ready():
	anim.play("closed")
	trigger.body_entered.connect(_on_body_entered)
	trigger.body_exited.connect(_on_body_exited)

func _process(_delta):
	if player_inside and not is_open and player_ref:
		if player_ref.coins >= REQUIRED_COINS:
			open_door()

func _on_body_entered(body):
	if body.name == "player":
		player_inside = true
		player_ref = body

func _on_body_exited(body):
	if body.name == "player":
		player_inside = false
		player_ref = null

func open_door():
	is_open = true
	anim.play("open")
	door_collision.disabled = true
