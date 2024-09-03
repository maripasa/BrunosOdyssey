extends Area2D
class_name NextLevelArea

var _objects_in_contact: Array

@export_category("Objects")
@export var _time_to_skip: Timer

func _on_body_entered(_body: Node2D) -> void:
	if _body is BaseCharacter:
		_body.next_level()
		_time_to_skip.start()


func _on_timer_to_skip_timeout() -> void:
	transition_screen.fade_in("")
