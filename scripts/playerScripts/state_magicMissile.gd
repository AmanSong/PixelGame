class_name State_MagicMissile extends State
const MAGIC_MISSILE = preload("res://scenes/PlayerScenes/MagicMissile.tscn")

var attacking : bool = false
var can_shoot: bool = true
@export var missile_cooldown: float = 1.5 

@onready var move : State = $"../Move"
@onready var idle = $"../Idle"

func enter():
	if !can_shoot:
		return
		
	attacking = true
	can_shoot = false
	
	var missile = MAGIC_MISSILE.instantiate()
	missile.direction = player.cardinal_direction
	
	# slight offest the missile spawn
	missile.pos = player.position + (player.cardinal_direction * 10)
	get_parent().add_child(missile)

	end_attack()
	get_tree().create_timer(missile_cooldown).timeout.connect(_reset_shooting)
	pass
	
func exit():
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
	
func _reset_shooting() -> void:
	can_shoot = true
