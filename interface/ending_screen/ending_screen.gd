extends CanvasLayer
class_name MainMenu

@export_category("Objects")
@export var _animation: AnimationPlayer
@export var _score_amount: Label

var _score: int

func _ready() -> void:
	transition_screen.start_level.connect(_on_level_start)
	game_data.save["score"] = _score
	_score = 10000

func _on_level_start() -> void:
	_animation.play("start_animation")


		
