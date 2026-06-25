extends RefCounted

class_name Combo

enum Type {
	PAIR,
	THREE_KIND,
	STRAIGHT,
	FLUSH,
	FULL_HOUSE,
	# TODO:
	# FOUR_KIND,
	STRAIGHT_FLUSH,
	ROYAL_FLUSH
}

enum Direction {
	HORIZONTAL,
	VERTICAL
}

var type: Type
var priority: int
var direction: Direction
var cells: Array[Vector2i]
var score: int
