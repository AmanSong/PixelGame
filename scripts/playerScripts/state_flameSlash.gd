class_name State_FlameSlash extends State

var attacking : bool = false

@export var flameSlash_sound : AudioStream 

@onready var move : State = $"../Move"
@onready var idle = $"../Idle"
@onready var player_sprite = $"../../PlayerSprite"
@onready var audio = $"../../Audio/AudioStreamPlayer2D"
@onready var flame_slash_hurt_box = $"../../Interactions/FlameSlash_HurtBox"

func Enter():
	attacking = true
	player.UpdateAnimation("FlameSlash")
	player_sprite.animation_finished.connect( EndAttack )
	
	audio.stream = flameSlash_sound
	audio.pitch_scale = randf_range(2, 3)
	audio.play()
	
	await get_tree().create_timer(0.075).timeout
	flame_slash_hurt_box.monitoring = true 
	pass
	
func Exit():
	player_sprite.animation_finished.disconnect( EndAttack )
	attacking = false
	
	flame_slash_hurt_box.monitoring = false
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
