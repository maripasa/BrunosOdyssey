extends Node2D
class_name GameData

const SAVE_PATH = "user://game_save.data"

var save: Dictionary = {
	"score": 0,
	"last_map": "",
	"lifes": 0,
	"volume": 0
}

func save_game() -> void:
	var save_game = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var json = JSON.stringify(save)
	save_game.store_line(json)
	
func load_game():
	var save_game = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if save_game == null:
		return {}
		
	var json = JSON.new()
	var json_string = save_game.get_line()
	var parse_result = json.parse(json_string)
	save_game = json.get_data()
