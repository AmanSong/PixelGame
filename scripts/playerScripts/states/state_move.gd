class_name State_Move extends State

@export var Move_Speed : float = 100.0
@onready var idle : State = $"../Idle"
@onready var magic_missile = $"../MagicMissile"
@onready var cast_spell = $"../CastSpell"

func enter():
	player.update_animation("Move")
	pass
	
func exit():
	pass
	
func process(_delta:float) -> State:
	if player.direction == Vector2.ZERO:
		return idle
	
	player.velocity = player.direction * Move_Speed
	if player.set_direction():
		player.update_animation("Move")
		
	return null

func Physics(_delta:float) -> State:
	return null
	
func handle_input(_event:InputEvent) -> State:
	if _event.is_action("FlameSlash"):
		return cast_spell
		
	return null
