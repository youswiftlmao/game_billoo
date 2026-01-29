extends StaticBody2D  # or StaticBody2D, depending on your bridge type

@export var move_distance: Vector2 = Vector2(160, 0)  # how far the bridge moves
@export var move_time: float = 8.0  # how long it takes to move

var start_pos: Vector2
var moving = false

func _ready():
	start_pos = position
	visible = false  # ensure bridge starts hidden

func start_moving():
	if moving:
		return
	moving = true
	visible = true  # make the bridge visible
	
	# start tween to move the bridge
	var tween = create_tween()
	tween.tween_property(self, "position", start_pos + move_distance, move_time).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_callback(Callable(self, "_on_moving_done"))

	# Shake camera while moving
	var player = get_node("../player")  # just a string
	if player:
		await player.shake_camera(move_time, 2.0)
func _on_moving_done():
	moving = false
