class_name Player extends CharacterBody2D 

signal DirectionChanged(new_direction : Vector2)
signal player_damaged(hurt_box : HurtBox)

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO

@onready var state_machine : State_Machine = $StateMachine
@onready var player_sprite : AnimatedSprite2D = $PlayerSprite
@onready var hit_box : HitBox = $HitBox
@onready var blink_animation : AnimationPlayer = $BlinkAnimation

var invunerable = false
var index = 0

@export var weapon : WeaponData

# dynamicaly fill array later
var spells = {
	"FlameSlash": preload("res://scenes/PlayerScenes/spell_scenes/FireSlash.tscn"),
	"MagicMissile": preload("res://scenes/PlayerScenes/spell_scenes/MagicMissile.tscn")
}
var spell_keys := []
var current_spell_index := 0
var selected_spell_name: String = ""
var selected_spell: PackedScene = null

var health : int = 100
var max_health : int = 100
var mana : int = 100
var max_mana : int = 100

# when game starts
func _ready():
	PlayerManager.player = self
	state_machine.initialize(self)
	hit_box.Damaged.connect(_take_damage)
	update_health(999)
	update_selected_spell()
	PlayerHud.update_mana(mana, max_mana)
	PlayerHud.update_spell_icon(selected_spell)
	pass
	

# when game is running
func _process(_delta):
	direction.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	direction.y = Input.get_action_strength("Down") - Input.get_action_strength("Up")
	
	if Input.is_action_just_pressed("Cycle"):
		next_spell()
		PlayerHud.update_spell_icon(selected_spell)
	pass
	
	
func next_spell():
	if spell_keys.size() == 0:
		return
	current_spell_index = (current_spell_index + 1) % spell_keys.size()
	selected_spell_name = spell_keys[current_spell_index]
	selected_spell = spells[selected_spell_name]

func update_selected_spell() -> void:
	spell_keys = spells.keys()
	if spell_keys.size() > 0:
		selected_spell_name = spell_keys[current_spell_index]
		selected_spell = spells[selected_spell_name]
	else:
		selected_spell_name = ""
		selected_spell = null
	
func _physics_process(_delta):
	move_and_slide()
	

func set_direction() -> bool:
	var new_dir : Vector2 = cardinal_direction
	if direction == Vector2.ZERO:
		return false
		
	
	if direction.y == 0:
		new_dir = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	elif direction.x == 0:
		new_dir = Vector2.UP if direction.y < 0 else Vector2.DOWN
		
	cardinal_direction = new_dir
	DirectionChanged.emit(new_dir)
	player_sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	
	return true


func update_animation(state : String) -> void:
	player_sprite.play(state + "_" + anim_direction())
	pass
	
	
func anim_direction():
	if cardinal_direction == Vector2.DOWN:
		return "Down"
	elif cardinal_direction == Vector2.UP:
		return "Up"
	else:
		return "Side"

func _take_damage(hurt_box : HurtBox) -> void:
	if invunerable == true:
		return
	update_health(-hurt_box.damage)
	
	if health > 0:
		player_damaged.emit(hurt_box)
	else:
		player_damaged.emit(hurt_box)
		update_health(999)
	pass
	
func update_health(delta : int) -> void:
	health = clamp(health + delta, 0, max_health)
	PlayerHud.update_health(health, max_health)
	pass
	
	
func update_mana(cost: int) -> void:
	# avoid going over max mana limit when drinking potions
	mana -= cost
	mana = clampi(mana, mana, max_mana)
	PlayerHud.update_mana(mana, max_mana)
	pass
	
	
func make_invunerable(_duration : float = 1.0) -> void:
	invunerable = true
	hit_box.monitoring = false
	
	await get_tree().create_timer(_duration).timeout
	
	invunerable = false
	hit_box.monitoring = true
	pass
	
