extends Node2D

const FIRE_WHOOSH = preload("res://assets/audio/Fire_Whoosh.mp3")

@export var manaCost = 10
@export var cool_down : float = 0.5
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var hurt_box = $HurtBox
@onready var audio = $AudioStreamPlayer2D

var direction: Vector2

func _ready():
	animated_sprite_2d.animation_finished.connect(finished)
	animated_sprite_2d.apply_scale(Vector2(1.5,1.5)) 
	hurt_box.apply_scale(Vector2(1.5,1.5))
	global_rotation_degrees = rad_to_deg(direction.angle())
	hurt_box.monitoring = false
	
	# Play sound
	audio.stream = FIRE_WHOOSH
	audio.pitch_scale = randf_range(2, 3)
	audio.play()

func _process(_delta):
	animated_sprite_2d.play("FireSlash")
	get_tree().create_timer(0.075).timeout
	hurt_box.monitoring = true
	pass

func finished() -> void:
	animated_sprite_2d.animation_finished.disconnect(finished)
	queue_free()
