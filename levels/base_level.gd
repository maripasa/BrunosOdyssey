extends Node2D
class_name BaseLevel

var paused: bool = false

@export_category("Variables")
@export var _scene_path: String
@export_category("Objects")
@export var _pause_menu: PauseMenu

func _ready() -> void:
	global.current_scene_path = _scene_path

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		pause_menu()
		
func pause_menu() -> void:
	if paused:
		_pause_menu.hide()
		Engine.time_scale = 1
	else:
		_pause_menu.show()
		Engine.time_scale = 0
	paused = !paused
