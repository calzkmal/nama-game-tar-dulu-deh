extends RefCounted

class_name BoardResolver

static func destroy_pairs(
	board_state: BoardState,
	pairs: Array
):
	var board = board_state.cells
	
	var destroyed = {}

	for pair in pairs:

		var pos1: Vector2i = pair[0]
		var pos2: Vector2i = pair[1]

		destroyed[str(pos1)] = pos1
		destroyed[str(pos2)] = pos2

	for value in destroyed.values():

		var pos: Vector2i = value

		if board[pos.y][pos.x] == null:
			continue

		var card = board[pos.y][pos.x]

		if card.has("node"):
			if is_instance_valid(card["node"]):
				card["node"].queue_free()

		board[pos.y][pos.x] = null
