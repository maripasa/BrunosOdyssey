extends CharacterBody2D
class_name BaseCharacter

var _jump_count: int = 0
var _fall_distance: float = 0
var _fall_start_y: float = 0.0

var _on_floor: bool
var _is_falling: bool

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export_category("Variables")
@export var _speed: float = 200.0
@export var _jump_velocity: float = -300.0
@export var _high_fall_threshold: float = 100.0

@export_category("Objects")
@export var _character_texture: CharacterTexture

@onready var fall_timer: Timer = $FallTimer

func _physics_process(_delta: float) -> void:
	_vertical_movement(_delta)
	_horizontal_movement(_delta)
	move_and_slide()
	
	_character_texture.animate(velocity)
	
	
func _vertical_movement(_delta: float) -> void:
	if is_on_floor():
		if _is_falling:
			_is_falling = false
			_fall_distance = abs(global_position.y - _fall_start_y)
			print(_fall_distance)
			if _fall_distance > _high_fall_threshold:
				_character_texture.action_animation("duck")
				global.spawn_effect(
					"res://visual_effects/cloud_poof/fall_effect.tscn",
					Vector2(0, 16),
					global_position,
					false)
				set_physics_process(false)
				
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
		_fall_start_y = global_position.y
		_is_falling = true
		
	# Handle jump.
	if Input.is_action_just_pressed("jump") and _jump_count < 2:
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

