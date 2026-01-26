extends RichTextLabel

@export var level_name: String = ""
@export var fade_in := 1.0
@export var hold := 1.0
@export var fade_out := 1.0

func _ready():
	modulate.a = 0.0  # start invisible

	# Auto-detect level name if not set
	if level_name == "":
		level_name = get_tree().current_scene.name

	# Show only once per level
	if LevelState.shown_levels.has(level_name):
		visible = false
		return

	LevelState.shown_levels[level_name] = true

	# DO NOT change text — use whatever is in the editor
	fade_sequence()


func fade_sequence():
	var t = create_tween()

	# Fade in
	t.tween_property(self, "modulate:a", 1.0, fade_in)

	# Hold
	t.tween_interval(hold)

	# Fade out
	t.tween_property(self, "modulate:a", 0.0, fade_out)

	# Hide after fade-out
	t.tween_callback(func(): visible = false)
