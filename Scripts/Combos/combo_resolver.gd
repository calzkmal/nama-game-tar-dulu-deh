extends RefCounted

class_name ComboResolver


# Resolves overlapping combos.
#
# Higher priority combos are selected first.
# Horizontal wins when priorities are equal.
#
# Returns only the combos that should be executed.
static func resolve(
	combos: Array[Combo]
) -> Array[Combo]:

	var resolved: Array[Combo] = []

	# Cells that are already occupied
	# by accepted combos.
	var locked := {}

	# Highest priority first.
	# Horizontal before Vertical.
	combos.sort_custom(_compare_priority)

	for combo in combos:

		var blocked := false

		for cell in combo.cells:

			if locked.has(cell):
				blocked = true
				break

		if blocked:
			continue

		resolved.append(combo)

		for cell in combo.cells:
			locked[cell] = true

	return resolved


static func _compare_priority(
	a: Combo,
	b: Combo
) -> bool:

	if a.priority != b.priority:
		return a.priority > b.priority

	if a.direction != b.direction:

		return (
			a.direction
			==
			Combo.Direction.HORIZONTAL
		)

	return false
