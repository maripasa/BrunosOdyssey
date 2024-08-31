extends Control
class_name PauseMenu

@export_category("Objects")
@export var main: Node2D

"""
this is for the level main code

@export_category("Objects")
@export var _pause_menu: PauseMenu

var paused = false

func _process(_delta):
	if Input.is_action_just_pressed("pause")
		_pause_menu()
func _pause_menu() -> :
	if paused:
		_pause_menu.hide()
		Engine.time_scale = 1
	else:
		_pause_menu.show()
		Engine.time_scale = 0
	paused = !paused
"""



func _on_resume_pressed() -> void:
	main.pauseMenu()


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_music_button_toggled(toggled_on: bool) -> void:
	pass
