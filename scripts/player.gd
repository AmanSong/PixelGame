extends CharacterBody2D 

var SPEED = 100
var DAMAGE = 10
var is_attacking = false
var basic_cooldown = false
var attack_offset = 20

@onready var animation = $AnimatedSprite2D
var direction = "Front_Idle"

func _ready():
	animation.animation_finished.connect(_animation_finished)

func _physics_process(delta):
	if Input.is_action_just_pressed("Slash") and basic_cooldown == false:
		player_attacking()
	elif is_attacking == false:
		player_movement(delta)

func player_attacking():
	is_attacking = true
	basic_cooldown = true
	
	# Adjust attack box position based on facing direction
	match direction:
		"Front_Idle":
			$Attack_Box.position = Vector2(0, attack_offset)  # Down
			animation.play("Attack_Down")

		"Right_Idle":
			$Attack_Box.position = Vector2(attack_offset, 0)  # Right
			animation.play("Attack_Side")

		"Left_Idle":
			$Attack_Box.position = Vector2(-attack_offset, 0)  # Left
			$AnimatedSprite2D.flip_h = true
			animation.play("Attack_Side")

		"Back_Idle":
			$Attack_Box.position = Vector2(0, -attack_offset)  # Up
			animation.play("Attack_Up")
	
	# Get all bodies overlapping with Attack_Box
	var enemies_in_range = $Attack_Box.get_overlapping_bodies()
	for enemy in enemies_in_range:
		if enemy.has_node("Health") and enemy != self:  # Check if the enemy has a Health node
			var health = enemy.get_node("Health")
			health.damage_taken(DAMAGE)  # Deal damage
	

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
	$Attack_CD.start()

func _on_attack_cd_timeout():
	basic_cooldown = false
