extends RefCounted

class_name PairDetector

# Finds all adjacent cards with matching ranks.
#
# Only checks:
# - Right neighbor
# - Bottom neighbor
#
# Avoids detecting the same pair twice.
#
# Example:
#
# A A
#
# Detected once:
# (0,0) <-> (1,0)
#
# Not twice.

static func detect(
	board_state: BoardState
) -> Array:
	
	# Shortcut references
	var board = board_state.cells
	var width = board_state.width
	var height = board_state.height
	
	var combos: Array[Combo] = []

	for y in range(height):

		for x in range(width):

			var card = board[y][x]
			
			# Skip empty cells
			if card == null:
				continue

			var pos = Vector2i(x, y)
			
			# Only check right and down
			# to avoid duplicate pair detection
			var directions = [
				Vector2i.RIGHT,
				Vector2i.DOWN
			]

			for dir in directions:

				var check_pos = pos + dir
				
				# Ignore positions outside board bounds
				if check_pos.x >= width:
					continue

				if check_pos.y >= height:
					continue

				var other = board[
					check_pos.y
				][
					check_pos.x
				]
				
				# Ignore empty neighbors
				if other == null:
					continue
				
				# Match found
				if card["rank"] == other["rank"]:

					var combo := Combo.new()

					combo.type = Combo.Type.PAIR
					combo.priority = 1
					combo.score = 100
					combo.cells = [
						pos,
						check_pos
					]

					if dir == Vector2i.RIGHT:
						combo.direction = Combo.Direction.HORIZONTAL
					else:
						combo.direction = Combo.Direction.VERTICAL

					combos.append(combo)

	return combos
