class_name State_Idle extends State

@onready var move : State = $"../Move"
@onready var flame_slash : State = $"../FlameSlash"
@onready var magic_missile = $"../MagicMissile"
@onready var cast_spell = $"../CastSpell"

func enter() -> void:
	player.update_animation("Idle")
	pass
	
func exit() -> void:
	pass
	
func process(_delta:float) -> State:
	if player.direction != Vector2.ZERO:
		return move
		
	player.velocity = Vector2.ZERO
	return null

func physics(_delta:float) -> State:
	return null
	
func handle_input(_event:InputEvent) -> State:
	if _event.is_action("FlameSlash"):
		return cast_spell
		
	return null
