extends BaseLevel
class_name SummerLevel

func _ready() -> void:
	music = sound_fx.level_2_music
	
	if not music.playing:
		music.player("play")
