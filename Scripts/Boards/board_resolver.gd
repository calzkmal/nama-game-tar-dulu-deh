extends RefCounted

class_name BoardResolver

static func destroy_combos(
	board_state: BoardState,
	combos: Array
):
	var board = board_state.cells
	
	var destroyed = {}

	for combo in combos:

		for cell in combo.cells:
			destroyed[str(cell)] = cell

	for value in destroyed.values():

		var pos: Vector2i = value

		if board[pos.y][pos.x] == null:
			continue

		var card = board[pos.y][pos.x]

		if card.has("node"):
			if is_instance_valid(card["node"]):
				card["node"].queue_free()

		board[pos.y][pos.x] = null
