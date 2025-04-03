class_name State_FlameSlash extends State

var attacking : bool = false

@export var flameSlash_sound : AudioStream 

@onready var move : State = $"../Move"
@onready var idle = $"../Idle"
@onready var player_sprite = $"../../PlayerSprite"
@onready var audio = $"../../Audio/AudioStreamPlayer2D"

const FLAME_SLASH_HURTBOX = preload("res://scenes/PlayerScenes/FlameSlash_HurtBox.tscn")
#@onready var flame_slash_hurt_box = $"../../Interactions/FlameSlash_HurtBox"

func enter():
	attacking = true
	player.update_animation("FlameSlash")
	player_sprite.animation_finished.connect( end_attack )
	
	audio.stream = flameSlash_sound
	audio.pitch_scale = randf_range(2, 3)
	audio.play()
	
	await get_tree().create_timer(0.075).timeout
	#flame_slash_hurt_box.monitoring = true 
	spawn_hurtbox()
	pass
	
func spawn_hurtbox():
	var hurtbox = FLAME_SLASH_HURTBOX.instantiate()

	# Offset hurtbox forward based on player's direction
	var offset_distance = 7  # Adjust based on sword length
	hurtbox.global_position = player.global_position + (player.cardinal_direction * offset_distance)

	# Rotate hurtbox based on direction
	hurtbox.global_rotation_degrees = rad_to_deg(player.cardinal_direction.angle())

	get_parent().add_child(hurtbox)

	# Auto-delete hurtbox after attack duration
	get_tree().create_timer(0.3).timeout.connect(hurtbox.queue_free)
	
	
func exit():
	player_sprite.animation_finished.disconnect( end_attack )
	attacking = false
	pass
	
func process(_delta:float) -> State:
	player.velocity = Vector2.ZERO
	
	if attacking == false:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return move
			
	return null

func physics(_delta:float) -> State:
	return null
	
func handle_input(_event:InputEvent) -> State:
	return null

func end_attack(  ) -> void:
	attacking = false
