extends TileMap

const REQUIRED_FLOWERS = 5
const MOVE_DISTANCE = 112.0

var moved := false

func _process(_delta):
	if moved:
		return

	# Search the player in the current scene
	var player = get_tree().current_scene.get_node("player")
	if player and player.flowers >= REQUIRED_FLOWERS:
		position.y -= MOVE_DISTANCE
		moved = true
		print("TileMap moved up ", MOVE_DISTANCE, " pixels!")
