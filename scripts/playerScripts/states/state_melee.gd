class_name State_Melee extends State

@onready var move : State = $"../Move"
@onready var idle = $"../Idle"
@onready var weapon_sprite = $"../../WeaponSprite"
@onready var audio = $"../../AudioStreamPlayer2D"

var attacking : bool = false
var swing_hurtbox : HurtBox
var weapon : WeaponData

const SWORD_SOUND = preload("res://assets/audio/sword_sound.mp3")

func enter() -> void:
	# get our currently equipped weapon and load its texture onto the sprit
	# and get the hurtbox to attack
	weapon = player.weapon
	weapon_sprite.texture = weapon.texture
	swing_hurtbox = weapon_sprite.get_child(0)
	
	weapon_sprite.rotation_degrees = 30
	swing_weapon()

func swing_weapon() -> void:
	weapon_sprite.visible = true
	swing_hurtbox.monitoring = true
	swing_hurtbox.global_position = player.global_position + (player.cardinal_direction * 10)
	weapon_sprite.global_position = player.global_position + (player.cardinal_direction * 7)
	
	var rotate_way = 180
	match player.cardinal_direction:
		Vector2.LEFT:
			weapon_sprite.flip_h = true
			weapon_sprite.flip_v = false
			weapon_sprite.rotation_degrees = -45
			rotate_way = -260
		Vector2.RIGHT:
			weapon_sprite.flip_h = false
			weapon_sprite.flip_v = false
			weapon_sprite.rotation_degrees = 45
			rotate_way = 260
		Vector2.UP:
			weapon_sprite.flip_v = true
			weapon_sprite.flip_h = false
			weapon_sprite.rotation_degrees = 60
			rotate_way = 260
		Vector2.DOWN:
			weapon_sprite.flip_v = false
			weapon_sprite.flip_h = false
			weapon_sprite.rotation_degrees = -60
			rotate_way = -260
	
	audio.stream = SWORD_SOUND
	#audio.pitch_scale = randf_range(1,2)
	audio.play()
	
	var tween = create_tween()
	tween.tween_property(weapon_sprite, "rotation_degrees", rotate_way, 0.3).set_trans(Tween.TRANS_QUAD)

	await tween.finished
	swing_hurtbox.monitoring = false
	weapon_sprite.visible = false
	attacking = false
	pass

func exit() -> void:
	attacking = false
	
func process(_delta:float) -> State:
	player.velocity = Vector2.ZERO
	if !attacking:
		return idle if player.direction == Vector2.ZERO else move
	return null

func physics(_delta:float) -> State:
	return null
	
func handle_input(_event:InputEvent) -> State:
	return null
