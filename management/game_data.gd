extends Node2D
class_name GameData

const SAVE_PATH = "user://game_save.data"
const SETTINGS_PATH = "user://settings.data"
const LEADER_BOARD = "user://leaderboard.data"

var leaderboard: Array

var save: Dictionary = {
	"started_game": 0,
	"score": 0,
	"coins": 0,
	"level": 0,
	"lives": 5
}

var empty: Dictionary = {
	"started_game": 0,
	"score": 0,
	"coins": 0,
	"level": 0,
	"lives": 5
}

var settings: Dictionary = {
	"volume": 100
}

func save_game() -> void:
	var save_game = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var json = JSON.stringify(save)
	save_game.store_line(json)
	
func load_game():
	var save_game = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if save_game == null:
		save = empty
		return
		
	var json = JSON.new()
	var json_string = save_game.get_line()
	var parse_result = json.parse(json_string)
	save = json.get_data()
	
func save_settings() -> void:
	var settings_file = FileAccess.open(SETTINGS_PATH, FileAccess.WRITE)
	var json = JSON.stringify(settings_file)
	settings_file.store_line(json)
	
func load_settings():
	var settings_file = FileAccess.open(SETTINGS_PATH, FileAccess.READ)
	if settings_file == null:
		settings["volume"] = 100
		
	var json = JSON.new()
	var json_string = settings_file.get_line()
	var parse_result = json.parse(json_string)
	settings = json.get_data()

func save_leaderboard() -> void:
	var leaderboard_file = FileAccess.open(SETTINGS_PATH, FileAccess.WRITE)
	var json = JSON.stringify(leaderboard_file)
	leaderboard_file.store_line(json)
	
func load_leaderboard() -> void:
	var leaderboard_file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if leaderboard_file == null:
		leaderboard = []
		return
		
	var json = JSON.new()
	var json_string = leaderboard_file.get_line()
	var parse_result = json.parse(json_string)
	leaderboard = json.get_data()
	
func zero_save() -> void:
	save = {
	"score": 0,
	"coins": 0,
	"level": 0,
	"lives": 5
}

func add_entry(name: String, score: int, level: int) -> void:
	var new_entry = {
	"name": name,
	"score": score,
	"level": level
	}
	leaderboard.append(new_entry)
	sort_leaderboard()

func update_entry(name: String, score: int, level: int) -> void:
	var entry_found = false
	for entry in leaderboard:
		if entry["name"] == name:
			entry["score"] = score
			entry["level"] = level
		entry_found = true
		break

	if not entry_found:
		add_entry(name, score, level)
		
func sort_leaderboard() -> void:
	leaderboard.sort_custom(_compare_entries)

func _compare_entries(a: Dictionary, b: Dictionary) -> int:
	if a["score"] > b["score"]:
		return -1
	elif a["score"] < b["score"]:
		return 1
	else:
		if a["level"] > b["level"]:
			return -1
		elif a["level"] < b["level"]:
			return 1
		else:
			return 0
