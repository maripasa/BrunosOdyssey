extends AnimatedSprite2D
class_name CharacterTexture

var _is_on_action: bool = false

@export_category("Objects")
@export var _character: BaseCharacter

func animate(_velocity: Vector2) -> void:
	_verify_direction(_velocity.x)
	
	if _is_on_action:
		return
		
	if not _velocity:
		play("idle")
		return
		
	if _velocity.y:
		if _velocity.y > 0:
			play("falling")
			return
		if _velocity.y < 0:
			play("jump")
			return
			
	if _velocity.x:
		play("run")

func _verify_direction(_direction: float) -> void:
	if _direction > 0:
		flip_h = false
	
	if _direction < 0:
		flip_h = true	
	
func action_animation(_action_name: String) -> void:
	_is_on_action = true
	play(_action_name)

func _on_animation_finished() -> void:
	_character.set_physics_process(true)
	_is_on_action = false 
	
func _on_frame_changed() -> void:
	if animation == "run":
		if frame % 2 != 0:
			global.spawn_effect(
			"res://visual_effects/dust/run_effect.tscn",
			Vector2(-9, 2),
			global_position,
			flip_h)
