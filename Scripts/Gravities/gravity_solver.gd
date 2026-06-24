extends RefCounted

class_name GravitySolver

# Moves all cards downward until no empty
# cells remain beneath them.
#
# Example:
#
# [A]
# [ ]
# [K]
#
# becomes
#
# [ ]
# [A]
# [K]
#
# Board data and visual node positions
# are updated together.

static func apply_gravity(
	board_state: BoardState,
	board_to_screen: Callable
):
	# Shortcut references
	var board = board_state.cells
	var width = board_state.width
	var height = board_state.height
	
	# Process each column independently
	for x in range(width):

		# Start from bottom-up (kecuali last row)
		# so cards can fall into empty spaces
		for y in range(height - 2, -1, -1):
			
			# Skip empty cells
			if board[y][x] == null:
				continue

			var card_data = board[y][x]
			var card_node = card_data["node"]
			
			# Assume current row as landing position
			var target_y = y

			# Search for the lowest empty slot
			# directly beneath this card
			while (
				target_y + 1 < height
				and board[target_y + 1][x] == null
			):
				target_y += 1
			
			# Move card only if it can fall
			if target_y != y:
				
				# Update board data
				board[target_y][x] = card_data
				board[y][x] = null
				
				# Update visual position
				if is_instance_valid(card_node):
					card_node.position = board_to_screen.call(
						Vector2i(x, target_y)
					)
