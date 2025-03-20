extends CharacterBody2D

const SPEED = 100.0
var direction = "none"

func _physics_process(delta):
	player_movement(delta)

func player_movement(delta):
	if Input.is_action_pressed("Right"):
		velocity.x = SPEED
		velocity.y = 0
		direction = "right"
		play_animation(1)
	elif Input.is_action_pressed("Left"):
		velocity.x = -SPEED
		velocity.y = 0
		direction = "left"
		play_animation(1)
	elif Input.is_action_pressed("Up"):
		velocity.x = 0
		velocity.y = -SPEED
		direction = "up"
		play_animation(1)
	elif Input.is_action_pressed("Down"):
		velocity.x = 0
		velocity.y = SPEED
		direction = "down"
		play_animation(1)
	else:
		play_animation(0)
		velocity.x = 0
		velocity.y = 0

	
	move_and_slide()

func play_animation(movement):
	var dir = direction
	var animation = $AnimatedSprite2D
	
	if dir == "right":
		if movement == 1:
			animation.play("Move_Right")
		elif movement == 0:
			animation.play("Right_Idle")
	if dir == "left":
		if movement == 1:
			animation.play("Move_Left")
		elif movement == 0:
			animation.play("Left_Idle")
	if dir == "up":
		if movement == 1:
			animation.play("Move_Up")
		elif movement == 0:
			animation.play("Back_Idle")
	if dir == "down":
		if movement == 1:
			animation.play("Move_Down")
		elif movement == 0:
			animation.play("Front_Idle")
