extends RefCounted

class_name BoardResolver


# Removes every card contained in the
# resolved combo list.
#
# Does not perform any combo detection.
# Does not apply gravity.
static func destroy_combos(
	board_state: BoardState,
	combos: Array[Combo]
):

	var board = board_state.cells

	var destroyed := {}

	# Collect every unique cell
	for combo in combos:

		for cell in combo.cells:
			destroyed[str(cell)] = cell

	# Destroy collected cells
	for value in destroyed.values():

		var pos: Vector2i = value

		if board[pos.y][pos.x] == null:
			continue

		var card = board[pos.y][pos.x]

		if card.has("node"):

			var node = card["node"]

			if is_instance_valid(node):
				node.queue_free()

		board[pos.y][pos.x] = null
