class_name State_Move extends State

@export var Move_Speed : float = 75.0
@onready var idle : State = $"../Idle"
@onready var cast_spell = $"../CastSpell"
@onready var melee = $"../Melee"

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
	if _event.is_action("CastSpell"):
		return cast_spell
	if _event.is_action("Melee"):
		return melee
	if _event.is_action("Interact"):
		PlayerManager.interact_pressed.emit()
	return null
