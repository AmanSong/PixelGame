extends Node

var current_tilemap_bounds : Array[Vector2]
signal TileMapBounds_Changed(bounds : Array[Vector2])

func ChangeTileMap_Bounds(bounds : Array[Vector2]) -> void:
	current_tilemap_bounds = bounds
	TileMapBounds_Changed.emit(bounds)
	
