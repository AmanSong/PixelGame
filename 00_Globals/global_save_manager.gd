extends Node

const SAVE_PATH = "user://"

signal game_loaded
signal game_saved

var current_save : Dictionary = {
	scene_path = "",
	player = {
		health = 1,
		max_health = 1,
		mana = 1,
		max_mana = 1,
		pos_x = 0,
		pos_y = 0
	},
	items = [],
	persistence = [],
	quests = [],
}

func save_game() -> void:
	update_player_data()
	update_scene_path()
	update_item_data()
	
	var file := FileAccess.open(SAVE_PATH + "save.sav", FileAccess.WRITE)
	var save_json = JSON.stringify(current_save)
	file.store_line(save_json)
	game_saved.emit()
	pass
	
func load_game() -> void:
	var file := FileAccess.open(SAVE_PATH + "save.sav", FileAccess.READ)
	var json := JSON.new()
	json.parse(file.get_line())
	var save_dict : Dictionary = json.get_data() as Dictionary
	current_save = save_dict
	
	LevelManager.load_new_level(current_save.scene_path, "", Vector2.ZERO)
	await LevelManager.level_load_started
	
	PlayerManager.set_player_position(Vector2(current_save.player.pos_x, current_save.player.pos_y))
	PlayerManager.set_health(current_save.player.health, current_save.player.max_health)
	PlayerManager.set_mana(current_save.player.mana, current_save.player.max_mana)
	PlayerManager.INVENTORY_DATA.parse_saved_data(current_save.items)
	
	await LevelManager.level_loaded
	
	game_loaded.emit()
	pass

func update_player_data() -> void:
	var p : Player = PlayerManager.player
	current_save.player.health = p.health
	current_save.player.max_health = p.max_health
	current_save.player.mana = p.mana
	current_save.player.max_mana = p.max_mana
	current_save.player.pos_x = p.global_position.x
	current_save.player.pos_y = p.global_position.y

func update_scene_path() -> void:
	var p : String = ""
	for scene in get_tree().root.get_children():
		if scene is Level:
			p = scene.scene_file_path
	current_save.scene_path = p

func update_item_data() -> void:
	current_save.items = PlayerManager.INVENTORY_DATA.get_saved_data()
