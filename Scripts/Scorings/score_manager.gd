extends RefCounted

class_name ScoreManager


static func calculate(
	combos: Array[Combo],
	chain: int
) -> ScoreResult:

	var result := ScoreResult.new()
	
	for combo in combos:
		
		var entry := ScoreEntry.new()
		
		entry.combo = combo
		entry.base_score = combo.base_score
		entry.multiplier = chain
		entry.total_score = combo.get_score(chain)
		
		result.total +=	 entry.total_score
		result.entries.append(entry)

	return result
