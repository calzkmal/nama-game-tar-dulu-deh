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

enum Priority {
	PAIR = 10,
	THREE_KIND = 20,
	STRAIGHT = 30,
	FLUSH = 40,
	FULL_HOUSE = 50,
	# TODO:
	# FOUR_KIND,
	STRAIGHT_FLUSH = 70,
	ROYAL_FLUSH = 80
}

enum Direction {
	HORIZONTAL,
	VERTICAL
}

# Type of poker combination
var type: Type

# Used by ComboResolver.
# Higher value = higher priority.
var priority: int = 0

# Horizontal or Vertical
var direction: Direction

# Board cells involved in this combo
var cells: Array[Vector2i] = []

# Base score before chain multiplier
var base_score: int = 0

# Whether this combo has already been selected
# by the ComboResolver.
var resolved: bool = false

# Chain index where this combo was resolved.
# Assigned by the resolve loop.
var chain: int = 1


# Initiator 
func _init(
	p_type: Type,
	p_priority: int,
	p_direction: Direction,
	p_cells: Array[Vector2i],
	p_base_score: int
):

	type = p_type
	priority = p_priority
	direction = p_direction
	cells = p_cells
	base_score = p_base_score


# Create combination for scoring
static func create(
	p_type: Type,
	p_direction: Direction,
	p_cells: Array[Vector2i]
) -> Combo:

	var priority: int
	var base_score: int

	match p_type:

		Type.PAIR:
			priority = Priority.PAIR
			base_score = 100

		Type.THREE_KIND:
			priority = Priority.THREE_KIND
			base_score = 300

		Type.STRAIGHT:
			priority = Priority.STRAIGHT
			base_score = 500

		Type.FLUSH:
			priority = Priority.FLUSH
			base_score = 600

		Type.FULL_HOUSE:
			priority = Priority.FULL_HOUSE
			base_score = 800
		
		# For later work
		#Type.FOUR_KIND:
			#priority = Priority.FOUR_KIND
			#base_score = 1500
		
		Type.STRAIGHT_FLUSH:
			priority = Priority.STRAIGHT_FLUSH
			base_score = 2000

		Type.ROYAL_FLUSH:
			priority = Priority.ROYAL_FLUSH
			base_score = 3000

	return Combo.new(
		p_type,
		priority,
		p_direction,
		p_cells,
		base_score
	)
	


func contains(cell: Vector2i) -> bool:

	return cell in cells


func _to_string() -> String:

	return "%s (%d cells)" % [
		Type.keys()[type],
		cells.size()
	]


# Calculates the final score after applying
# the chain multiplier.
func get_score(chain_multiplier: int) -> int:

	return base_score * chain_multiplier


func overlaps(other: Combo) -> bool:

	for cell in cells:
		if other.contains(cell):
			return true

	return false
