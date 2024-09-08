extends Area2D
class_name NextLevelArea

var _objects_in_contact: Array

@export_category("Objects")
@export var _character: BaseCharacter
@export var _between_screen: BetweenScreen

func _on_body_entered(_body: Node2D) -> void:
	if _body is BaseCharacter:
		_body.next_level()
		_between_screen.start()

func next_level() -> void:
	transition_screen.fade_in("res://levels/level%s.tscn" % str(_character.level + 1))
