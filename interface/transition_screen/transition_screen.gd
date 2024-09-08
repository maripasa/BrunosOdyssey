extends CanvasLayer
class_name TransitionScreen

signal start_level

var scene_path: String

@export_category("Objects")
@export var _animation: AnimationPlayer
@export var _introduction_timer: Timer

func fade_in(next_scene_path: String) -> void:
	scene_path = next_scene_path
	game_data.save_game()
	_animation.play("fade_in")

func _on_animation_animation_finished(_anim_name: String) -> void:
	match _anim_name:
		"fade_in":
			get_tree().change_scene_to_file(scene_path)
			_animation.play("fade_out")

		"fade_out":
			emit_signal("start_level")

func introduction_end(scene_path) -> void:
	get_tree().change_scene_to_file(scene_path)
	_introduction_timer.start()


func _on_introduction_transition_timer_timeout() -> void:
	emit_signal("start_level")
