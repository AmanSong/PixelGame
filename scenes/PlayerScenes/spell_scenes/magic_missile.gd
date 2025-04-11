extends CharacterBody2D

@export var speed: float = 100
@export var self_delete: float = 1.5
@export var cool_down: float = 1.5
@export var manaCost = 25

const SFX = preload("res://assets/audio/magic_missile.mp3")

@onready var audio = $AudioStreamPlayer2D

var direction: Vector2

func _ready():
	global_rotation_degrees = rad_to_deg(direction.angle())
	
	# Play sound
	audio.stream = SFX
	audio.pitch_scale = randf_range(2, 3)
	audio.play()
	
	# Delete itself after a certain time
	get_tree().create_timer(self_delete).timeout.connect(queue_free)

func _process(delta):
	velocity = direction * speed
	var collision = move_and_collide(velocity * delta) 
	if collision:
		queue_free()
	move_and_slide()
