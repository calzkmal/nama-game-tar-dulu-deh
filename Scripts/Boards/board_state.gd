extends RefCounted

class_name BoardState

var width: int
var height: int

var cells: Array = []

func _init(board_width: int, board_height: int):

	width = board_width
	height = board_height

	for y in range(height):

		var row = []

		for x in range(width):
			row.append(null)

		cells.append(row)
