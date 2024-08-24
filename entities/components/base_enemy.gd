extends CharacterBody2D
class_name BaseEnemy

enum _types {
	STATIC = 0,
	CHASE = 1,
	WANDER = 2
}

@export_category("Objetos")
@export var _enemy_texture: EnemyTexture
@export var _floor_detection_ray: RayCast2D

@export_category("Variables")
@export var _enemy_type: _types
@export var _move_speed: float = 50.0

var _direction: Vector2 = Vector2.ZERO
var _on_floor: bool = false
var _gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	_direction = [Vector2(-1, 0), Vector2(1, 0)].pick_random()
	
func _physics_process(_delta):
	_vertical_movement(_delta)
	match _enemy_type:
		_types.STATIC:
			pass
		_types.CHASE:
			pass
		_types.WANDER:
			_wandering()
	move_and_slide()
	
	_enemy_texture.animate(velocity)

func _vertical_movement(_delta: float) -> void:
	if is_on_floor():
		if _on_floor == false:
			_enemy_texture.action_animate("land")
			_on_floor = true
	if not is_on_floor():
		_on_floor = false
		velocity.y += _gravity * _delta

func _wandering() -> void:
	if _floor_detection_ray.is_colliding():
		if _floor_detection_ray.get_collider() != TileMap:
			velocity.x = _direction.x * _move_speed
			return
	_update_direction()


func _update_direction() -> void:
	_direction.x = -_direction.x
	if _direction.x > 0:
		_enemy_texture.flip_h = false
		_floor_detection_ray.position.x = 12
	if _direction.x < 0:
		_enemy_texture.flip_h = true
		_floor_detection_ray.position.x = -12
	
