extends AudioStreamPlayer
class_name BaseAudio

@export var animation: AnimationPlayer

func player(command: String) -> void:
	match command:
		"play":
			play()
		"stop":
			stop()

func fade_out() -> void:
	animation.play("fade_out")
	stop()
