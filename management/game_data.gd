extends Node2D
class_name GameData

const SAVE_PATH = "user://game_save.data"
const SETTINGS_PATH = "user://settings.data"
const LEADER_BOARD = "user://leaderboard.data"

var leaderboard: Dictionary

func _ready() -> void:
	var leaderboard_file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if leaderboard_file == null:
		leaderboard = {}
		
	var json = JSON.new()
	var json_string = leaderboard_file.get_line()
	var parse_result = json.parse(json_string)
	leaderboard = json.get_data()

var save: Dictionary = {
	"score": 0,
	"coins": 0,
	"map": 0,
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
		save = {}
		
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
		save = {}
		
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
		leaderboard = {}
		
	var json = JSON.new()
	var json_string = leaderboard_file.get_line()
	var parse_result = json.parse(json_string)
	leaderboard = json.get_data()
