extends RefCounted

class_name ComboDetector

const PairDetector = preload(
	"res://Scripts/Combos/pair_detector.gd"
)

# Future detectors
# const TripleDetector = preload(...)
# const StraightDetector = preload(...)
# const FlushDetector = preload(...)


# Detects every possible combo on the board.
#
# Every detector contributes Combo objects
# to a single collection.
#
# The returned array is NOT resolved yet.
# Conflict resolution is handled separately
# by ComboResolver.
static func detect_all(
	board_state: BoardState
) -> Array:

	var combos: Array[Combo] = []

	# Pair
	combos.append_array(
		PairDetector.detect(board_state)
	)

	# Future combinations
	#
	# combos.append_array(
	#     TripleDetector.detect(board_state)
	# )
	#
	# combos.append_array(
	#     StraightDetector.detect(board_state)
	# )

	return combos
