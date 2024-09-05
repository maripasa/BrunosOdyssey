extends Control
class_name EndingScreen

@export_category("Objects")
@export var _animation: AnimationPlayer

func _ready() -> void:
	transition_screen.start_level.connect(_on_level_start)

func _on_level_start() -> void:
	_animation.play("start_animation")


func _on_new_game_pressed() -> void:
	transition_screen.fade_in("res://levels/level1.tscn")


func _on_continue_pressed() -> void:
	pass # Replace with function body.


func _on_score_board_pressed() -> void:
	pass # Replace with function body.


func _on_credits_pressed() -> void:
	pass # Replace with function body.


func _on_quit_pressed() -> void:
	get_tree().quit()
