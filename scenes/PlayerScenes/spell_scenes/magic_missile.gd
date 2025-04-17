extends Spell
class_name MagicMissile

@export var speed: float = 100
const SFX = preload("res://assets/audio/magic_missile.mp3")

@onready var audio = $AudioStreamPlayer2D

func _ready():
	cast()

func cast():
	rotate_towards_direction()
	audio.stream = SFX
	audio.pitch_scale = randf_range(2, 3)
	audio.play()

	get_tree().create_timer(self_delete).timeout.connect(queue_free)

func _process(delta):
	velocity = direction * speed
	var collision = move_and_collide(velocity * delta) 
	if collision:
		queue_free()
	move_and_slide()
