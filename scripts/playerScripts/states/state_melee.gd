class_name State_Melee extends State

@onready var move : State = $"../Move"
@onready var idle = $"../Idle"
@onready var weapon_sprite = $"../../WeaponSprite"

var attacking : bool = false

func enter() -> void:
	attacking = true

	var weapon = player.weapon
	var damage = weapon.damage
	var range = weapon.range
	var sprite_texture = weapon.texture
	print("Texture is null? ", weapon.texture == null)
	# Show the weapon
	weapon_sprite.texture = sprite_texture
	weapon_sprite.visible = true

	# Optionally: animate rotation or scale to simulate a swing
	# You can also use Tween for smoother animation
	weapon_sprite.rotation_degrees = -90
	var tween = create_tween()
	tween.tween_property(weapon_sprite, "rotation_degrees", 90, 0.2).set_trans(Tween.TRANS_QUAD)

	# Hide and reset after attack
	await get_tree().create_timer(0.025).timeout
	weapon_sprite.visible = false
	weapon_sprite.rotation_degrees = 0
	
	attacking = false

func exit() -> void:
	attacking = false
	weapon_sprite.visible = false
	weapon_sprite.rotation_degrees = 0
	
func process(_delta:float) -> State:
	player.velocity = Vector2.ZERO
	if !attacking:
		return idle if player.direction == Vector2.ZERO else move
	return null

func physics(_delta:float) -> State:
	return null
	
func handle_input(_event:InputEvent) -> State:
	return null
