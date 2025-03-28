class_name State_FlameSlash extends State

var attacking : bool = false

@export var flameSlash_sound : AudioStream 

@onready var move : State = $"../Move"
@onready var idle = $"../Idle"
@onready var player_sprite = $"../../PlayerSprite"
@onready var audio = $"../../Audio/AudioStreamPlayer2D"

func Enter():
	attacking = true
	player.UpdateAnimation("FlameSlash")
	player_sprite.animation_finished.connect( EndAttack )
	
	audio.stream = flameSlash_sound
	audio.pitch_scale = randf_range(2, 3)
	audio.play()
	pass
	
func Exit():
	player_sprite.animation_finished.disconnect( EndAttack )
	attacking = false
	pass
	
func Process(delta:float) -> State:
	player.velocity = Vector2.ZERO
	
	if attacking == false:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return move
			
	return null

func Physics(delta:float) -> State:
	return null
	
	
func HandleInput(_event:InputEvent) -> State:
	return null

func EndAttack(  ) -> void:
	attacking = false
