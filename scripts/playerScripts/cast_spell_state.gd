class_name State_CastSpell extends State

@export var flameSlash_sound: AudioStream 
@export var missile_cooldown: float = 1.5

# generic slash hurtbox (can be re-used for close range attacks)
const SLASH_HURT_BOX = preload("res://components/HurtBox/Slash_HurtBox.tscn")

const MAGIC_MISSILE = preload("res://scenes/PlayerScenes/MagicMissile.tscn")

var attacking: bool = false
var can_cast: bool = true

@onready var move: State = $"../Move"
@onready var idle: State = $"../Idle"
@onready var player_sprite: AnimatedSprite2D = $"../../PlayerSprite"
@onready var audio = $"../../AudioStreamPlayer2D"

const FIRE_WHOOSH = preload("res://assets/audio/Fire_Whoosh.mp3")

func enter():
	attacking = true
	var spell = player.selected_spell  # Assume player has a spell selection system

	if spell == "FlameSlash":
		cast_flame_slash()
	elif spell == "MagicMissile" and can_cast:
		cast_magic_missile()
	else:
		exit()

func cast_flame_slash():
	player.update_animation("FlameSlash")
	player_sprite.animation_finished.connect(end_attack)

	# Play sound
	audio.stream = FIRE_WHOOSH
	audio.pitch_scale = randf_range(2, 3)
	audio.play()

	await get_tree().create_timer(0.075).timeout
	spawn_flame_slash_hurtbox()

func spawn_flame_slash_hurtbox():
	var hurtbox = SLASH_HURT_BOX.instantiate()
	hurtbox.global_position = player.global_position + (player.cardinal_direction * 7)
	hurtbox.global_rotation_degrees = rad_to_deg(player.cardinal_direction.angle())

	get_parent().add_child(hurtbox)
	get_tree().create_timer(0.3).timeout.connect(hurtbox.queue_free)

func cast_magic_missile():
	if !can_cast:
		print("cd")
		return
		
	can_cast = false
	var missile = MAGIC_MISSILE.instantiate()
	missile.direction = player.cardinal_direction
	missile.global_position = player.global_position + (player.cardinal_direction * 10)

	get_parent().add_child(missile)
	
	# End the attack state shortly after firing
	await get_tree().create_timer(0.2).timeout
	attacking = false
	
	get_tree().create_timer(missile_cooldown).timeout.connect(_reset_spell_casting)

func _reset_spell_casting():
	can_cast = true

func exit():
	player_sprite.animation_finished.disconnect(end_attack)
	attacking = false

func process(_delta: float) -> State:
	player.velocity = Vector2.ZERO

	if !attacking:
		return idle if player.direction == Vector2.ZERO else move

	return null

func physics(_delta: float) -> State:
	return null

func handle_input(_event: InputEvent) -> State:
	return null

func end_attack():
	attacking = false
