extends Node2D

# Board setup
const CELL_WIDTH = 56
const CELL_HEIGHT = 74
const BOARD_OFFSET = Vector2(40, 120)

const WIDTH = 5
const HEIGHT = 9

const BoardState = preload(
	"res://Scripts/Boards/board_state.gd"
)

const CardFactory = preload(
	"res://Scripts/Cards/card_factory.gd"
)

const CardMatcher = preload(
	"res://Scripts/Cards/card_matcher.gd"
)

const GravitySolver = preload(
	"res://Scripts/Gravities/gravity_solver.gd"
)

const BoardResolver = preload(
	"res://Scripts/Boards/board_resolver.gd"
)

const ComboDetector = preload(
	"res://Scripts/Combos/combo_detector.gd"
)

var board_state: BoardState

var active_pos = Vector2i(4, 0)

var fall_timer = 0.0
var fall_interval = 1.0

var active_card_node
var active_card_data = {}

@onready var CardScene = preload("res://Scenes/card.tscn")


func _ready():

	board_state = BoardState.new(
		WIDTH,
		HEIGHT
	)
	
	spawn_card()


func _process(delta):

	# LEFT
	if Input.is_action_just_pressed("ui_left"):
		if can_move(Vector2i(-1, 0)):
			active_pos.x -= 1

	# RIGHT
	if Input.is_action_just_pressed("ui_right"):
		if can_move(Vector2i(1, 0)):
			active_pos.x += 1

	# DOWN
	if Input.is_action_just_pressed("ui_down"):
		if can_move(Vector2i(0, 1)):
			active_pos.y += 1
		else:
			lock_card()

	# Gravity
	fall_timer += delta

	if fall_timer >= fall_interval:

		fall_timer = 0

		if can_move(Vector2i(0, 1)):
			active_pos.y += 1
		else:
			lock_card()

	# Update visual
	if active_card_node:
		active_card_node.position = board_to_screen(active_pos)


func spawn_card():

	active_card_data = CardFactory.create_card()

	active_pos = Vector2i(WIDTH / 2, 0)

	active_card_node = CardScene.instantiate()

	add_child(active_card_node)

	active_card_node.setup(active_card_data)

	active_card_node.position = board_to_screen(active_pos)

	print(
		active_card_data["rank"],
		" of ",
		active_card_data["suit"]
	)


func board_to_screen(pos: Vector2i) -> Vector2:

	return BOARD_OFFSET + Vector2(
		pos.x * CELL_WIDTH,
		pos.y * CELL_HEIGHT
	)


func can_move(offset: Vector2i) -> bool:

	var new_pos = active_pos + offset

	if new_pos.x < 0:
		return false

	if new_pos.x >= WIDTH:
		return false

	if new_pos.y >= HEIGHT:
		return false

	if board_state.cells[new_pos.y][new_pos.x] != null:
		return false

	return true


func lock_card():

	if active_pos.y < 0 or active_pos.y >= HEIGHT:
		return

	if active_pos.x < 0 or active_pos.x >= WIDTH:
		return

	board_state.cells[
	active_pos.y
		][
			active_pos.x
		] = {
			"rank": active_card_data["rank"],
			"suit": active_card_data["suit"],
			"node": active_card_node
		}

	resolve_board()
	spawn_card()


func resolve_board():

	var chain = 0

	while true:

		var combos = ComboDetector.detect_all(
			board_state
		)

		if combos.is_empty():
			break

		chain += 1

		print("CHAIN x", chain)

		BoardResolver.destroy_pairs(
			board_state,
			combos
		)

		GravitySolver.apply_gravity(
			board_state,
			board_to_screen
		)
