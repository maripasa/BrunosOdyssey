extends CanvasLayer

@export_category("Objects")
@export var _animation: AnimationPlayer

@export var _score_amount: Label
@export var _save_button: Button
@export var _highscore: Label
@export var _input: LineEdit

var _score: int
var _name: String
var _level: int
@onready var _names: Array = [$Name/Name1, $Name/Name2, $Name/Name3, $Name/Name4]
@onready var _scores: Array = [$Score/Score1, $Score/Score2, $Score/Score3, $Score/Score4]
@onready var _stages: Array = [$Stage/Level1, $Stage/Level2, $Stage/Level3, $Stage/Level4]

func _ready() -> void:
	transition_screen.start_level.connect(_on_level_start)
	_score = game_data.save["score"]
	_level = game_data.save["level"]
	game_data.zero_save()
func _process(_delta: float) -> void:
	pass

func _on_level_start() -> void:
	#SoundFx.interface.play("")
	_animation.play("start_animation")

func _on_name_input_text_changed(new_text: String) -> void:
	if len(new_text) == 3:
		_save_button.disabled = false
		_name = new_text
		return
	_save_button.disabled = true

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
	
	if len(board) > 0:
		if board[0]["score"] > _score:
			_highscore.show()
	else:
		_highscore.show()


func _on_save_score_pressed() -> void:
	_save_button.disabled = true
	_input.editable = false
	game_data.add_entry(_name, _score, _level)
	game_data.save_leaderboard()
	_show_scores()


func _on_animation_animation_finished(anim_name: StringName) -> void:
	_show_scores()
	

func _on_continue_pressed() -> void:
	transition_screen.fade_in("res://interface/menu/main_menu.tscn")
