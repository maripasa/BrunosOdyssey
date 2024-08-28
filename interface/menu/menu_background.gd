extends ParallaxBackground
class_name MenuBackground

@onready var _foreground: Array = [
	$SmallerMountains, $SmallerMountains2, $Foreground, $Foreground2
]

var _speed_values: Array[float] = [
	8.0, 8.0, 16.0, 16.0
]

func _physics_process(_delta: float) -> void:
	var _i: int = 0
	for item in _foreground:
		item.motion_offset.x -= _speed_values[_i] * _delta
		_i += 1
