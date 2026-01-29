extends Control


signal dfinished
@export_file("*.json") var d_file
var dialogue = []
var currentdialogue_id = 0
var dactive = false

func _ready() -> void:
	$NinePatchRect.visible = false
		
func start():
	if dactive:
		return
	dactive = true
	$NinePatchRect.visible = true
	dialogue = load_dialogue()
	currentdialogue_id = -1
	nextscript()
func load_dialogue():
	var file = FileAccess.open("res://dialouguye/misty dialouge.json", FileAccess.READ)
	var content = JSON.parse_string(file.get_as_text())
	return content
func _input(event: InputEvent) -> void:
	if !dactive:
		return
	if event.is_action_pressed("ui_accept"):
		nextscript()
func nextscript():
	currentdialogue_id += 1
	if currentdialogue_id >= len(dialogue):
		dactive = false
		$NinePatchRect.visible = false
		visible = false
		emit_signal("dfinished")
		return
		
	$NinePatchRect/name.text = dialogue[currentdialogue_id]["name"]
	$NinePatchRect/text.text = dialogue[currentdialogue_id]["text"]
