extends Node2D
class_name SoundFx

@export var main_menu_music: AudioStreamPlayer
@export var level_1_music: AudioStreamPlayer
@export var level_2_music: AudioStreamPlayer

func main_menu() -> void:
	main_menu_music.play()

func level_1() -> void:
	level_1_music.play()

func level_2() -> void:
	level_2_music.play()
