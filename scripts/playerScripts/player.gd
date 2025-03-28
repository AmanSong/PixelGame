class_name Player extends CharacterBody2D 

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO

@onready var state_machine : State_Machine = $StateMachine
@onready var player_sprite = $PlayerSprite

# when game stats
func _ready():
	state_machine.Initialize(self)
	pass
	

# when game is running
func _process(delta):
	direction.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	direction.y = Input.get_action_strength("Down") - Input.get_action_strength("Up")
	pass
	
	
func _physics_process(delta):
	move_and_slide()
	

func SetDirection() -> bool:
	var new_dir : Vector2 = cardinal_direction
	if direction == Vector2.ZERO:
		return false
		
	
	if direction.y == 0:
		new_dir = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	elif direction.x == 0:
		new_dir = Vector2.UP if direction.y < 0 else Vector2.DOWN
		
	cardinal_direction = new_dir
	player_sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	
	return true


func UpdateAnimation(state : String) -> void:
	player_sprite.play(state + "_" + AnimDirection())
	pass
	
	
func AnimDirection():
	if cardinal_direction == Vector2.DOWN:
		return "Down"
	elif cardinal_direction == Vector2.UP:
		return "Up"
	else:
		return "Side"
