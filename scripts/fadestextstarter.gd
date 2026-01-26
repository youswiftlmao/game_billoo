extends CanvasLayer

@onready var text_root: CanvasItem = $IntroText
var fade_time := 1.0
var hold_time := 2.0

var intro_played := false   # ← put it HERE, not in a global script

func _ready():
	await get_tree().process_frame  # important on level change
	text_root.modulate.a = 0.0
	play_intro()

func play_intro():
	fade_in()
	await get_tree().create_timer(hold_time).timeout
	fade_out()

func fade_in():
	var t := 0.0
	while t < fade_time:
		t += get_process_delta_time()
		text_root.modulate.a = t / fade_time
		await get_tree().process_frame
	text_root.modulate.a = 1.0

func fade_out():
	var t := 0.0
	while t < fade_time:
		t += get_process_delta_time()
		text_root.modulate.a = 1.0 - (t / fade_time)
		await get_tree().process_frame
	text_root.modulate.a = 0.0
