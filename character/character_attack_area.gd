extends Area2D
class_name CharacterAttackArea

@export_category("Variables")
@export var _attack_damage: int = 1
@export var _character: BaseCharacter

func _on_body_entered(_body) -> void:
	if _body is BaseEnemy:
		_body.update_health(_attack_damage, _character)
		_character.velocity.y = _character._jump_velocity
		_character._jump_count += 1
		
