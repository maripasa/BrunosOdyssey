extends Control
class_name Introduction

@export_category("Objects")
@export var _animation: AnimationPlayer
@export var _space_animation: AnimationPlayer
@export var _godot_intro: VideoStreamPlayer
@export var _vine_background: ColorRect
@export var _developers: Control
@export var _art_designer: Control
@export var _audio_designer: Control

func _ready() -> void:
	transition_screen.start_level.connect(_start_animation)

func _process(delta: float) -> void:
	if Input.is_anything_pressed():
		_space_animation.play("space")
	if Input.is_action_just_pressed("jump"):
		transition_screen.introduction_end("res://interface/menu/main_menu.tscn")

func _start_animation() -> void:
	_animation.play("fade_in")
	_space_animation.play("space")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_in":
		_godot_intro.play()
		_vine_background.hide()

	if anim_name == "show_developers":
		_developers.hide()
		_animation.play("show_audio_designer")
		sound_fx.introduction_music.player("play")

	if anim_name == "show_audio_designer":
		_audio_designer.hide()
		_animation.play("show_art_designer")

	if anim_name == "show_art_designer":
		transition_screen.introduction_end("res://interface/menu/main_menu.tscn") 

func _on_godot_intro_finished() -> void:
	_animation.play("show_developers")
