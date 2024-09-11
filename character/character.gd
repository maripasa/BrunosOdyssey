extends CharacterBody2D
class_name BaseCharacter

@export_category("Stats")
@export var score: int = 0
@export var coins: int = 0
@export var level: int = 1
@export var lives: int = 5
@export var hearts: int = 5

var _jump_count: int = 0
var _on_knockback: bool = false
var _is_alive: bool = true
var _on_floor: bool
var _is_falling: bool
var _next_level: bool = false

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export_category("Variables")
@export var _speed: float = 200.0
@export var _jump_velocity: float = -300.0
@export var _high_fall_threshold: float = 100.0
@export var _knockback_speed: int = 200

@export_category("Objects")
@export var _character_texture: CharacterTexture
@export var _knockback_timer: Timer
@export var _character_camera: Camera2D
@export var hud: HUD

func disable() -> void:
	_is_alive = false
	velocity.x = 0
	_character_camera.limit_bottom = int(global_position.y) + int(360.0/2.0)
	
	lives -= 1
	game_data.save["score"] = score
	game_data.save["coins"] = coins
	game_data.save["level"] = level
	game_data.save["lives"] = lives
	if lives <= 0:
		transition_screen.fade_in("res://interface/ending_screen/ending_screen.tscn")
		return
	transition_screen.fade_in(global.current_scene_path)
	
func _ready() -> void:
	hud.timer_end.connect(disable)
	score = game_data.save["score"]
	coins = game_data.save["coins"]
	lives = game_data.save["lives"]
	hud.update_stats(lives, hearts, coins, score)

func _process(_delta: float) -> void:
	if _on_knockback:
		move_and_slide()
	if not _next_level:
		hud.update_stats(lives, hearts, coins, score)

func _physics_process(_delta: float) -> void:
	game_data.save["score"] = score
	game_data.save["coins"] = coins
	game_data.save["lives"] = lives
	_vertical_movement(_delta)
	
	if not _is_alive or _on_knockback:
		move_and_slide()
		return
	if _next_level:
		velocity.x = 1 * _speed
		move_and_slide()
		return
		
	_horizontal_movement(_delta)
	move_and_slide()
	
	_character_texture.animate(velocity)
	
func _vertical_movement(_delta: float) -> void:
	if is_on_floor():
		if not _is_alive:
			velocity.x = 0
			collision_layer = 3
			collision_mask = 3
			return
		if _is_falling:
			_is_falling = false
				
		if not _on_floor:
			_on_floor = true
		_jump_count = 0
	# Add the gravity.
	if not is_on_floor():
		_on_floor = false
		velocity.y += gravity * _delta
		
	if velocity.y < 0:
		_is_falling = false
	if velocity.y > 0 and not _is_falling:
		_is_falling = true
		
	if Input.is_action_just_pressed("jump") and _jump_count < 2 and _is_alive:
		if _jump_count == 1:
			global.spawn_effect(
				"res://visual_effects/cloud_poof/fall_effect.tscn",
				Vector2(0, 16),
				global_position,
				false)
		_jump_count += 1
		velocity.y = _jump_velocity

func _horizontal_movement(_delta: float) -> void:
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * _speed
		return	
	velocity.x = move_toward(velocity.x, 0, _speed)

func update_health(_value: int, _entity) -> void:
	_knockback(_entity)
	_knockback_timer.start()
	hearts -= _value
	
	if hearts <= 0:
		_is_alive = false
		_character_texture.action_animation("dead_hit")
		
		lives -= 1
		
		game_data.save["score"] = score
		game_data.save["coins"] = coins
		game_data.save["level"] = level
		game_data.save["lives"] = lives
		
		if lives <= 0:
			transition_screen.fade_in("res://interface/ending_screen/ending_screen.tscn")
			return

		transition_screen.fade_in(global.current_scene_path)
		return
	
	hud.update_stats(lives, hearts, coins, score)
	_character_texture.action_animation("hit")
	
func _knockback(_entity: BaseEnemy) -> void:
	var _knockback_direction: Vector2 = _entity.global_position.direction_to(global_position)
	velocity.x = _knockback_direction.x * _knockback_speed
	velocity.y = -1 * _knockback_speed
	_on_knockback = true

func _on_knockback_timer_timeout() -> void:
	_on_knockback = false

func is_player_alive() -> bool:
	return _is_alive
	
func collect_coin() -> void:
	coins += 1
	score += 20
	
func next_level():
	_next_level = true
	hud.stopped = true
