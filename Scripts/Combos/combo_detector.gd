extends RefCounted

class_name ComboDetector

const PairDetector = preload(
	"res://Scripts/Combos/Combinations/pair_detector.gd"
)

# Detectors registry
const DETECTORS = [
	PairDetector,
]


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

	# Combos
	for detector in DETECTORS:
		
		combos.append_array(
			detector.detect(board_state)
		)

	return combos
