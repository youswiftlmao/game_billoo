extends Control

signal dialogue_finished

@export_file("*.json") var d_file  # assign your JSON in the inspector
var dialogue := []
var current_id := -1
var active := false

func _ready():
	$NinePatchRect.visible = false
	set_process_input(true)
	focus_mode = FocusMode.FOCUS_ALL
	print("[DEBUG] Dialogue UI ready, file assigned:", d_file)

func start():
	if active:
		return
	active = true
	$NinePatchRect.visible = true
	grab_focus()
	dialogue = load_dialogue()
	current_id = -1
	next_line()

func load_dialogue() -> Array:
	if not d_file:
		push_error("[ERROR] No JSON file assigned!")
		return []
	
	var file = FileAccess.open(d_file, FileAccess.READ)
	if file == null:
		push_error("[ERROR] Failed to open JSON file: " + d_file)
		return []
	
	var content = file.get_as_text()
	file.close()
	
	# Godot 4 JSON parsing
	var parse_result = JSON.parse_string(content)  # returns Dictionary with 'result' and 'error'
	if parse_result.error != OK:
		push_error("[ERROR] Failed to parse JSON: " + str(parse_result.error_string))
		return []
	
	var dialogue_data = parse_result.result
	print("[DEBUG] Dialogue lines loaded:", dialogue_data.size())
	return dialogue_data


func _input(event):
	if not active:
		return
	if event.is_action_pressed("ui_accept"):  # Q key
		next_line()

func next_line():
	current_id += 1
	if current_id >= dialogue.size():
		active = false
		$NinePatchRect.visible = false
		print("[DEBUG] Dialogue ended")
		emit_signal("dialogue_finished")
		return
	$NinePatchRect/name.text = dialogue[current_id]["name"]
	$NinePatchRect/text.text = dialogue[current_id]["text"]
	print("[DEBUG] Showing line:", current_id, dialogue[current_id]["text"])
