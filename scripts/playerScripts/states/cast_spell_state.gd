class_name State_CastSpell extends State

@export var flameSlash_sound: AudioStream 
@export var missile_cooldown: float = 1.5
@export var Damage : float

# generic slash hurtbox (can be re-used for close range attacks)
const MAGIC_MISSILE = preload("res://scenes/PlayerScenes/spell_scenes/MagicMissile.tscn")
const FIRE_SLASH = preload("res://scenes/PlayerScenes/spell_scenes/FireSlash.tscn")

var attacking: bool = false
var can_cast: bool = true

@onready var slash_hurt_box = $"../../Slash_HurtBox"
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
		attacking = false
		exit()

func cast_flame_slash():
	if !can_cast:
		attacking = false
		return
		
	var fireSlash = FIRE_SLASH.instantiate()
	if manaCost(fireSlash.manaCost) == false:
		attacking = false
		return
		
	can_cast = false
		
	# Play sound
	audio.stream = FIRE_WHOOSH
	audio.pitch_scale = randf_range(2, 3)
	audio.play()

	fireSlash.direction = player.cardinal_direction
	fireSlash.global_position = player.global_position + (player.cardinal_direction * 10)
	
	get_parent().add_child(fireSlash)
	
	await get_tree().create_timer(0.2).timeout
	attacking = false
	
	get_tree().create_timer(fireSlash.cool_down).timeout.connect(_reset_spell_casting)


func cast_magic_missile():
	if !can_cast:
		attacking = false
		return

	var missile = MAGIC_MISSILE.instantiate()
	if manaCost(missile.manaCost) == false:
		attacking = false
		return
	
	can_cast = false
	missile.direction = player.cardinal_direction
	missile.global_position = player.global_position + (player.cardinal_direction * 10)

	get_parent().add_child(missile)
	
	# End the attack state shortly after firing
	await get_tree().create_timer(0.2).timeout
	attacking = false
	
	get_tree().create_timer(missile.cool_down).timeout.connect(_reset_spell_casting)

func manaCost(cost: int) -> bool:
	if player.mana - cost < 0:
		return false
		
	player.update_mana(cost)
	return true

func _reset_spell_casting():
	can_cast = true

func exit():
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
