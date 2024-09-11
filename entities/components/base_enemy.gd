extends CharacterBody2D
class_name BaseEnemy

enum _types {
	STATIC = 0,
	CHASE = 1,
	WANDER = 2
}

var _on_knockback: bool = false
var _player_in_range: BaseCharacter = null
var _on_floor: bool = false
var _gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var _is_alive: bool = true

@export_category("Objects")
@export var _enemy_texture: EnemyTexture
@export var _floor_detection_ray: RayCast2D
@export var _knockback_timer: Timer
@export var _wall_detector: RayCast2D

@export_category("Areas")
@export var _attack_area_collision: CollisionShape2D
@export var _detection_area_collision: CollisionShape2D

@export_category("Variables")
@export var _direction: Vector2 = Vector2(1, 0)
@export var _enemy_type: _types
@export var _move_speed: float = 50.0
@export var _enemy_health: int = 10
@export var _knockback_speed: float = 600
@export var _dead_knockback_timer: float = 0
@export var _hit_knockback_timer: float = 0
@export var _pink_star_enemy: bool = false

func _ready() -> void:
	_update_direction()


func _process(_delta: float) -> void:
	if _on_knockback:
		move_and_slide()

func _physics_process(_delta):
	_vertical_movement(_delta)
	if not _is_alive:
		return

	if is_instance_valid(_player_in_range):
		_attack()
		return

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
		if not _is_alive:
			collision_layer = 2
			collision_mask = 2
			return
			
		if _on_floor == false:
			_enemy_texture.action_animate("land")
			_on_floor = true
			
	else:
		_on_floor = false
		velocity.y += _gravity * _delta

func _wandering() -> void:
	if _floor_detection_ray.is_colliding():
		if _wall_detector.is_colliding():
			_update_direction()
		if _floor_detection_ray.get_collider() is TileMapLayer:
			velocity.x = _direction.x * _move_speed
			return
			
	if is_on_floor():
		_update_direction()
		velocity.x = 0
	
func _update_direction() -> void:
	_direction.x = -_direction.x
	_attack_area_collision.position.x = -_attack_area_collision.position.x
	_detection_area_collision.position.x = -_detection_area_collision.position.x

	if _pink_star_enemy:
		if _direction.x > 0:
			_enemy_texture.flip_h = true
			_floor_detection_ray.position.x = 12
			_wall_detector.target_position.x = 15
		if _direction.x < 0:
			_enemy_texture.flip_h = false
			_floor_detection_ray.position.x = -12
			_wall_detector.target_position.x = -15
	else:
		if _direction.x > 0:
			_enemy_texture.flip_h = false
			_floor_detection_ray.position.x = 12

		if _direction.x < 0:
			_enemy_texture.flip_h = true
			_floor_detection_ray.position.x = -12
		

func _attack() -> void:
	pass
	
func update_health(_damage: int, _entity: BaseCharacter) -> void:
	if _is_alive == false:
		move_and_slide()
		return
		
	_knockback(_entity)
	_enemy_health -= _damage
	if _enemy_health <= 0:
		_knockback_timer.start(_dead_knockback_timer)
		_kill()
		return
		
	_knockback_timer.start(_hit_knockback_timer)
	_enemy_texture.action_animate("hit")

func _knockback(_entity: BaseCharacter) -> void:
	var _knockback_direction: Vector2 = _entity.global_position.direction_to(global_position)
	velocity.x = _knockback_direction.x * _knockback_speed
	velocity.y = -1 * _knockback_speed
	_knockback_timer.start()
	_on_knockback = true
	
func _kill() -> void:
		_enemy_texture.action_animate("dead_hit")
		_is_alive = false

func _on_detection_area_body_entered(_body) -> void:
	if _body is BaseCharacter:
		_player_in_range = _body

func _on_detection_area_body_exited(_body) -> void:
	if _body is BaseCharacter:
		_player_in_range = null

func _on_knockback_timer_timeout() -> void:
	_on_knockback = false
