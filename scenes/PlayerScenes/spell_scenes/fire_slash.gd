extends Node2D

@export var manaCost = 1
@export var cool_down : float = 0.5
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var hurt_box = $HurtBox

var direction: Vector2

func _ready():
	animated_sprite_2d.animation_finished.connect(finished)
	global_rotation_degrees = rad_to_deg(direction.angle())
	hurt_box.monitoring = false

func _process(_delta):
	animated_sprite_2d.play("FireSlash")
	get_tree().create_timer(0.075).timeout
	hurt_box.monitoring = true
	pass

func finished() -> void:
	animated_sprite_2d.animation_finished.disconnect(finished)
	queue_free()
