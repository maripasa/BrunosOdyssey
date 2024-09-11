extends BaseLevel
class_name WinterLevel

func play_music() -> void:
	music = sound_fx.level_1_music
	
	if not music.playing:
		music.player("play")
