class_name State_Idle extends State

@onready var move : State = $"../Move"
@onready var flame_slash : State = $"../FlameSlash"
@onready var magic_missile = $"../MagicMissile"

func Enter():
	player.UpdateAnimation("Idle")
	pass
	
func Exit():
	pass
	
func Process(delta:float) -> State:
	if player.direction != Vector2.ZERO:
		return move
		
	player.velocity = Vector2.ZERO
	return null

func Physics(delta:float) -> State:
	return null
	
func HandleInput(_event:InputEvent) -> State:
	if _event.is_action("FlameSlash"):
		return flame_slash
	if _event.is_action("MagicMissile"):
		return magic_missile
		
	return null
