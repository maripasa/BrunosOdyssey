extends BaseLevel
class_name SummerLevel

func play_music() -> void:
	music = sound_fx.level_2_music
	
	if not music.playing:
		music.player("play")
