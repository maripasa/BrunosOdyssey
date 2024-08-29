extends Area2D
class_name KillArea

func _on_body_entered(_body: Node2D) -> void:
	if _body is BaseCharacter:
		_body.queue_free()
		
	if _body is BaseEnemy:
		_body.queue_free()
