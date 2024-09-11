extends Control
class_name EndingScreen

@export_category("Objects")
@export var _animation: AnimationPlayer
@export var _continue: Button
@export var _continue_shadow: Label

func _ready() -> void:
	if not sound_fx.introduction_music.playing:
		if not sound_fx.interface_music.playing:
			sound_fx.interface_music.player("play")
	transition_screen.start_level.connect(_on_level_start)
	game_data.load_game()
	if game_data.save["started_game"] != 0:
		_continue.disabled = false
		_continue_shadow.show()

func _on_level_start() -> void:
	_animation.play("start_animation")
	game_data.load_game()
	if game_data.save["started_game"] != 0:
		_continue.disabled = false
		_continue_shadow.show()

func _on_new_game_pressed() -> void:
	game_data.zero_save()
	game_data.save["started_game"] = 1
	game_data.save_game()
	sound_fx.introduction_music.player("stop")
	sound_fx.interface_music.player("stop")
	transition_screen.fade_in("res://levels/level1.tscn")

func _on_continue_pressed() -> void:
	if sound_fx.interface_music.playing:
		sound_fx.interface_music.fade_out()
	else:
		sound_fx.introduction_music.fade_out()
	transition_screen.fade_in("res://levels/level%d.tscn" % game_data.save["level"])

func _on_score_board_pressed() -> void:
	sound_fx.click.player("play")
	transition_screen.fade_in("res://interface/scoreboard/scoreboard.tscn")
	
func _on_quit_pressed() -> void:
	sound_fx.click.player("play")
	get_tree().quit()

func _on_new_game_mouse_entered():
	sound_fx.hover.player("play")


func _on_continue_mouse_entered():
	sound_fx.hover.player("play")


func _on_score_board_mouse_entered():
	sound_fx.hover.player("play")

func _on_quit_mouse_entered():
	sound_fx.hover.player("play")
