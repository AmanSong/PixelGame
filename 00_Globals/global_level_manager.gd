extends Node

signal TileMapBounds_Changed(bounds : Array[Vector2])
signal level_load_started
signal level_loaded

var current_tilemap_bounds : Array[Vector2]
var target_transition: String
var position_offest: Vector2
var is_transitioning = false

func _ready():
	await get_tree().process_frame
	level_loaded.emit()


func ChangeTileMap_Bounds(bounds : Array[Vector2]) -> void:
	current_tilemap_bounds = bounds
	TileMapBounds_Changed.emit(bounds)
	
func load_new_level(
		level_path: String,
		_target_transition: String,
		_position_offset: Vector2
) -> void:
	is_transitioning = true
	get_tree().paused = true
	target_transition = _target_transition
	position_offest = _position_offset
	
	await SceneTransition.fade_out()
	
	level_load_started.emit()
	get_tree().change_scene_to_file(level_path)
	
	await SceneTransition.fade_in()
	
	get_tree().paused = false
	
	await get_tree().process_frame
	is_transitioning = false
	level_loaded.emit()
	pass
