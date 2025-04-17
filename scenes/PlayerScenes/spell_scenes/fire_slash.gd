extends Spell
class_name FireSlash

const FIRE_WHOOSH = preload("res://assets/audio/Fire_Whoosh.mp3")

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var hurt_box = $HurtBox
@onready var audio = $AudioStreamPlayer2D


func _ready():
	cast()

func cast():
	rotate_towards_direction()

	animated_sprite_2d.apply_scale(Vector2(1.5,1.5)) 
	hurt_box.apply_scale(Vector2(1.5,1.5))
	hurt_box.monitoring = false
	
	audio.stream = FIRE_WHOOSH
	audio.pitch_scale = randf_range(2, 3)
	audio.play()

	animated_sprite_2d.play("FireSlash")
	animated_sprite_2d.animation_finished.connect(finished)

	get_tree().create_timer(0.075).timeout.connect(_enable_hurtbox)

func _enable_hurtbox():
	hurt_box.monitoring = true

func finished():
	animated_sprite_2d.animation_finished.disconnect(finished)
	queue_free()
