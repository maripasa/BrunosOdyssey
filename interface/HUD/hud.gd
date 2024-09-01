extends CanvasLayer
class_name HUD

@export_category("Variables")
@export var start_time: int

var seconds: int = 0
var stopped: bool = true
var time: float = 0.0

func _ready() -> void:
	transition_screen.start_level.connect(_on_level_start)

func _process(_delta) -> void:
	if stopped:
		return
	time -= _delta
	if time < 0:
		stopped = true
		return
	seconds = int(fmod(time, 600))
	$Seconds.text = "%03d" % seconds

func _on_level_start() -> void:
	stopped = false
	time = start_time
