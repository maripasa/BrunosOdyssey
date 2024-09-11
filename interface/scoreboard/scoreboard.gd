extends CanvasLayer
class_name ScoreBoard

@export_category("Objects")
@export var _animation: AnimationPlayer

var _score: int
var _name: String
var _level: int
@onready var _names: Array = [$Name/Name1, $Name/Name2, $Name/Name3, $Name/Name4]
@onready var _scores: Array = [$Score/Score1, $Score/Score2, $Score/Score3, $Score/Score4]
@onready var _stages: Array = [$Stage/Level1, $Stage/Level2, $Stage/Level3, $Stage/Level4]

func _ready() -> void:
	transition_screen.start_level.connect(_on_level_start)

func _on_level_start() -> void:
	_animation.play("start_animation")

func _show_scores() -> void:
	game_data.load_game()
	var board: Array = game_data.leaderboard
	
	var n: int = 4
	if len(board) < 4:
		n = len(board)
		
	for i in range(n):
		_names[i].text = str(board[i]["name"])
		_scores[i].text = str(board[i]["score"])
		_stages[i].text = str(board[i]["level"])
	
	if n < 4:
		for i in range(len(board), 4):
			_names[i].text = "-"
			_scores[i].text = "-"
			_stages[i].text = "-"
	
func _on_animation_animation_finished(anim_name: StringName) -> void:
	_show_scores()

func _on_continue_pressed() -> void:
	sound_fx.click.player("play")
	transition_screen.fade_in("res://interface/menu/main_menu.tscn")

func _on_continue_mouse_entered():
	sound_fx.hover.player("play")
