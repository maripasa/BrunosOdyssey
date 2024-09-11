extends Node2D
class_name BaseLevel

var music: BaseAudio
var paused: bool = false

@export_category("Variables")
@export var _scene_path: String
@export var _level_number: int

@export_category("Objects")
@export var _pause_menu: PauseMenu

func play_music() -> void:
	pass

func _ready() -> void:
	play_music()
	global.current_scene_path = _scene_path
	game_data.save["level"] = _level_number

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		pause_menu()
		
func pause_menu() -> void:
	if paused:
		music.volume_db += 15
		_pause_menu.hide()
		Engine.time_scale = 1
	else:
		music.volume_db -= 15
		_pause_menu.show()
		Engine.time_scale = 0
	paused = !paused
