extends CanvasLayer
class_name HUD

@export_category("Variables")
@export var start_time: int

@export_category("Objects")
@export var _coins_label: Label
@export var _lives_label: Label
@export var score_label: Label
@export var seconds_label: Label
@export var _hearts_label: TextureProgressBar

var seconds: int = 0
var stopped: bool = true
var time: float = 0.0
signal timer_end

func _ready() -> void:
	transition_screen.start_level.connect(_on_level_start)
	
func _process(_delta) -> void:
	if stopped:
		return
	if time <= 0:
		stopped = true
		emit_signal("timer_end")
		return
	time -= _delta
	seconds = int(fmod(time, 600))
	seconds_label.text = "%d" % seconds

func _on_level_start() -> void:
	stopped = false
	time = start_time

func update_stats(lives: int, hearts: int, coins: int, score: int):
	_lives_label.text = "x%d" % lives
	_coins_label.text = str(coins)
	score_label.text = str(score)
	_hearts_label.value = hearts
