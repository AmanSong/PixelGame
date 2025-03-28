class_name State_Idle extends State
@onready var move : State = $"../Move"

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
	return null
