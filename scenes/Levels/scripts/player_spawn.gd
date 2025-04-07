extends Node

func _ready() -> void:
	self.visible = false
	
	if PlayerManager.player_spawned == false:
		PlayerManager.set_player_position(self.global_position)
		PlayerManager.player_spawned = true
	
