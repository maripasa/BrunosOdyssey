extends CollectableComponent
class_name CollectableCoin

func _consume(_body: BaseCharacter) -> void:
	game_data.save["coins"] += 1
	game_data.save["score"] += 20
