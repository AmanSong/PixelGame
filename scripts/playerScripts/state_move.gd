class_name State_Move extends State

@export var Move_Speed : float = 100.0
@onready var idle : State = $"../Idle"
@onready var flame_slash : State = $"../FlameSlash"

func Enter():
	player.UpdateAnimation("Move")
	pass
	
func Exit():
	pass
	
func Process(delta:float) -> State:
	if player.direction == Vector2.ZERO:
		return idle
	
	player.velocity = player.direction * Move_Speed
	if player.SetDirection():
		player.UpdateAnimation("Move")
		
	return null

func Physics(delta:float) -> State:
	return null
	
func HandleInput(_event:InputEvent) -> State:
	if _event.is_action("FlameSlash"):
		return flame_slash
		
	return null
