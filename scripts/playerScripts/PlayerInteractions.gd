class_name PlayerInteractions extends Node2D

@onready var player = $".."

func _ready():
	player.DirectionChanged.connect(UpdateDirection)
	pass
	
func UpdateDirection( new_direction : Vector2 ) -> void:
	rotation
	match new_direction:
		Vector2.DOWN:
			rotation_degrees = 0
		Vector2.UP:
			rotation_degrees = 180
		Vector2.LEFT:
			rotation_degrees = 90
		Vector2.RIGHT:
			rotation_degrees = -90
		_:
			rotation_degrees = 0
	pass
