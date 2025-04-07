extends Node2D

@export var manaCost = 1
@export var cool_down : float = 0.5
@onready var animated_sprite_2d = $AnimatedSprite2D

var direction: Vector2

func _ready():
	global_rotation_degrees = rad_to_deg(direction.angle())

func _process(delta):
	animated_sprite_2d.animation_finished.connect(finished)
	animated_sprite_2d.play("FireSlash")
	
	pass

func finished() -> void:
	queue_free()
