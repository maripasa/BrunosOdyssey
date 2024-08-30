extends Area2D
class_name KillArea

var _objects_in_contact: Array

@export_category("Objects")
@export var _time_to_kill: Timer

func _on_body_entered(_body: Node2D) -> void:
	if _body is BaseCharacter:
		_body.disable()


	if _body is BaseEnemy: # or _body is CollectableItem:
		_objects_in_contact.append(_body)
		_time_to_kill.start()


func _on_timer_to_kill_timeout() -> void:
	for _object in _objects_in_contact:
		if _object is BaseEnemy: #or collectable
			_object.queue_free()
