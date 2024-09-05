extends CanvasLayer
class_name PauseMenu

@export_category("Objects")
@export var main: BaseLevel

func _on_resume_pressed() -> void:
	main.pause_menu()


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_music_button_toggled(toggled_on: bool) -> void:
	pass
