extends RefCounted

class_name CardFactory

static func create_card() -> Dictionary:
	return preload("res://Scripts/Cards/card.gd").create_random()
