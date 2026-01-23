extends ParallaxLayer


@export var cloud_speed: float = -5.0
@export var loop_time: float = 300.0

var elapsed_time: float = 0.0
var start_offset_x: float

func _ready() -> void:
	start_offset_x = motion_offset.x

func _process(delta: float) -> void:
	elapsed_time += delta
	motion_offset.x += cloud_speed * delta

	if elapsed_time >= loop_time:
		elapsed_time = 0.0
		motion_offset.x = start_offset_x
