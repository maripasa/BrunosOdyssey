extends CanvasLayer
class_name BetweenScreen

@export_category("Objects")
@export var _animation: AnimationPlayer
@export var _time_score_label: Label
@export var _time: Label
@export var _character: BaseCharacter
@export var _next_level_area: NextLevelArea

# Constants
var _total_time: float = 5.0  # Total time for countdown in seconds

# Variables
var _initial_score: int = 0
var _current_hud_score: float = 0.0

var _initial_time_score: int = 0.0
var _current_time_score: float = 0.0
var _start_transfer: bool = false
var _score_decrement_per_second: float = 0.0
var step: float = 0.0

func _process(_delta: float) -> void:
	if not _start_transfer:
		return
	
	step = _score_decrement_per_second / (_delta * 3600)
	
	_current_hud_score += step
	_current_time_score -= step
	
	if _current_time_score <= 0:
		_character.hud.update_stats(_character.lives, _character.hearts,
		_character.coins, _initial_score + _initial_time_score)
		_time_score_label.text = str(0)
		_next_level_area.next_level()
		sound_fx.interface_music.player("stop")
		return
		
	# Add the text to the HUD
	_character.hud.update_stats(_character.lives, _character.hearts,
	_character.coins, int(_current_hud_score))
	
	# remove from time_scored
	_time_score_label.text = str(int(_current_time_score))
	
func start() -> void:
	_time.text = _character.hud.seconds_label.text
	
	_initial_score = int(_character.hud.score_label.text)  # Save the initial score
	_current_hud_score = _initial_score
	
	_initial_time_score = _character.hud.seconds * 50 # Set the countdown score to the initial score
	_current_time_score = _initial_time_score
	
	_score_decrement_per_second = _initial_time_score / _total_time  # Calculate the score decrement rate per second
	
	_time_score_label.text = str(_initial_time_score)
	
	_character.score += _initial_time_score
	
	sound_fx.interface_music.player("play")
	_animation.play("start_animation")
	

func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "start_animation":
		_start_transfer = true
