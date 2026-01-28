extends RichTextLabel

# Number of flash cycles
const CYCLES := 3
# Duration of each fade (in seconds)
const FADE_TIME := 0.2

func _ready():
	flash_out(CYCLES)

func flash_out(times: int) -> void:
	for i in range(times):
		# Fade in
		await tween_alpha(1.0, FADE_TIME)
		# Fade out
		await tween_alpha(0.0, FADE_TIME)
	# Ensure fully invisible at the end
	modulate.a = 0.0

# Helper function for fading alpha
func tween_alpha(target_alpha: float, duration: float) -> void:
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", target_alpha, duration)
	await tween.finished
