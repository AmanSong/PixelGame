extends CharacterBody2D

var SPEED = 100
var HEALTH = 100
var is_attacking = false

@onready var animation = $AnimatedSprite2D
var direction = "Front_Idle"

func _ready():
	Signals.connect("attack_player", damage_taken)
	animation.animation_finished.connect(_animation_finished)

func _physics_process(delta):
	if Input.is_action_just_pressed("Slash"):
		player_attacking()
	elif is_attacking == false:
		player_movement(delta)

		
func player_attacking():
	is_attacking = true
	
	if direction == "Front_Idle":
		animation.play("Attack_Down")
		
	if direction == "Right_Idle":
		animation.play("Attack_Side")
		
	if direction == "Left_Idle":
		$AnimatedSprite2D.flip_h = true
		animation.play("Attack_Side")

	if direction == "Back_Idle":
		animation.play("Attack_Up")

func player_movement(delta):
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = input_direction * SPEED
	$AnimatedSprite2D.flip_h = false
	
	if input_direction:
		pass
	else:
		animation.play(direction)
		
	if Input.is_action_pressed("Right"):
		animation.play("Move_Right")
		direction = "Right_Idle"
		
	if Input.is_action_pressed("Left"):
		animation.play("Move_Left")
		direction = "Left_Idle"
		
	if Input.is_action_pressed("Up"):
		animation.play("Move_Up")
		direction = "Back_Idle"
		
	if Input.is_action_pressed("Down"):
		animation.play("Move_Down")
		direction = "Front_Idle"
		
	move_and_slide()

func _animation_finished():
	is_attacking = false

# take damage from enemies
func damage_taken(damage):
	HEALTH -= damage
	
func _on_player_hitbox_body_entered(body):
	pass

func _on_player_hitbox_body_exited(body):
	pass
