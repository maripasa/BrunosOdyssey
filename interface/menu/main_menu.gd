extends Control
class_name MainMenu

@export_category("Objects")
@export var _animation: AnimationPlayer

func _ready() -> void:
	#transition_screen.start_level.connect(_on_level_start)
	pass

func _on_level_start() -> void:
	_animation.play("start_animation")
