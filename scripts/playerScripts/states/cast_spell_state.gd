class_name State_CastSpell extends State

var attacking: bool = false

@onready var move: State = $"../Move"
@onready var idle: State = $"../Idle"
@onready var player_sprite: AnimatedSprite2D = $"../../PlayerSprite"
@onready var audio: AudioStreamPlayer2D = $"../../AudioStreamPlayer2D"

const NO_MP = preload("res://assets/audio/hit_01.wav")

# Registry of spell names to PackedScenes
const SPELLS = {
	"FlameSlash": preload("res://scenes/PlayerScenes/spell_scenes/FireSlash.tscn"),
	"MagicMissile": preload("res://scenes/PlayerScenes/spell_scenes/MagicMissile.tscn")
}
# cool down for spells
var SPELL_COOLDOWNS = {}

func enter():
	attacking = true
	var spell_name = player.selected_spell
	var spell_scene = SPELLS.get(spell_name)
	cast_spell(spell_scene)
	
	
func cast_spell(spell_scene: PackedScene) -> void:
	var spell = spell_scene.instantiate()
	
	if is_spell_on_cooldown(spell.name):
		attacking = false
		print(spell.name, " is still on cooldown.")
		return

	# check if we have enough mana to cast our spell
	if !has_enough_mana(spell):
		attacking = false
		return

	#set our direction (where its facing and where it is to our player)
	spell.direction = player.cardinal_direction
	spell.global_position = player.global_position + (player.cardinal_direction * 10)
	
	# add spell to player scene
	get_parent().add_child(spell)
	
	# set cooldown
	set_spell_cooldown(spell.name, spell.cool_down)
	
	# no longer attacking
	attacking = false

func is_spell_on_cooldown(spell_name: String) -> bool:
	var current_time = Time.get_ticks_msec() / 1000.0  # seconds
	if SPELL_COOLDOWNS.has(spell_name) and SPELL_COOLDOWNS[spell_name] > current_time:
		return true
	return false

func set_spell_cooldown(spell_name: String, cool_down: float) -> void:
	var current_time = Time.get_ticks_msec() / 1000.0
	SPELL_COOLDOWNS[spell_name] = current_time + cool_down
	
	
func has_enough_mana(spell) -> bool:
	var cost = spell.manaCost
	if player.mana - cost < 0:
		audio.stream = NO_MP
		audio.pitch_scale = randf_range(2, 3)
		audio.play()
		return false

	player.update_mana(cost)
	return true


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
