extends CharacterBody2D

func _process(_delta):
	
	var direction = Input.get_vector("Left", "Right","Jump", "Climb")
	velocity = direction * 500
	move_and_slide() 
	
