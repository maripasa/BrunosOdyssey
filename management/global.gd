extends Node
class_name Global

var current_scene_path: String

func spawn_effect(_path: String, _offset: Vector2, _initial_position: Vector2,
_is_flipped: bool) -> void:
	
	var _effect: BaseEffect = load(_path).instantiate()
	
	_effect.flip_h = _is_flipped
	if _is_flipped:
		_offset.x *= -1
	_effect.global_position = _initial_position + _offset
		
	get_tree().root.call_deferred("add_child", _effect)
