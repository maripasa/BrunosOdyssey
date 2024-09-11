extends BaseLevel
class_name WinterLevel

func _ready() -> void:
	music = sound_fx.level_1_music
	
	if not sound_fx.level_1_music.playing:
		sound_fx.level_1_music.player("play")
