extends CanvasLayer

@onready var text := $Label   # ← this is the correct path now
var fade_time := 1.0
var hold_time := 2.0

func _ready():
	if LevelState.intro_played:
		text.modulate.a = 0.0
		return

	LevelState.intro_played = true
	text.modulate.a = 0.0
	play_intro()


func play_intro():
	fade_in()
	await get_tree().create_timer(hold_time).timeout
	fade_out()


func fade_in():
	var t := 0.0
	while t < fade_time:
		t += get_process_delta_time()
		text.modulate.a = t / fade_time
		await get_tree().process_frame
	text.modulate.a = 1.0


func fade_out():
	var t := 0.0
	while t < fade_time:
		t += get_process_delta_time()
		text.modulate.a = 1.0 - (t / fade_time)
		await get_tree().process_frame
	text.modulate.a = 0.0
