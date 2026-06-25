extends Node2D

@onready var sprite = $Sprite2D

var rank = ""
var suit = ""

static func create_random() -> Dictionary:

	var suits = ["Clubs", "Diamonds", "Hearts", "Spades"]

	# TODO: Add 'J', 'Q', 'K', 'A' once Eileen's finished
	var ranks = [
		"2", "3", "4", "5",
		"6", "7", "8", "9", "10"
		]

	var suit = suits.pick_random()
	var rank = ranks.pick_random()

	return {
		"rank": rank,
		"suit": suit,
		"texture":
			"res://Assets/PNG/Cards/card%s%s.png"
			% [suit, rank]
	}

func setup(card_data):

	rank = card_data["rank"]
	suit = card_data["suit"]

	sprite.texture = load(card_data["texture"])
