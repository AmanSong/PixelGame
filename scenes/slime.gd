extends CharacterBody2D

var speed = 25
var chase_player = false
var attack = false
var attack_cd = false
var player = null

var HEALTH = 50

func _ready():
	Signals.connect("player_attacks", damage_taken)

func _physics_process(delta):
	on_aggro(delta)
	attack_player()

func on_aggro(delta):
	if chase_player:
		if position.distance_to(player.position) > 10:

			if((player.position.y + 15) > position.y):
				$AnimatedSprite2D.play("Slime_Idle")
			else:
				$AnimatedSprite2D.play("Move_Up")
				
			position += (player.position - position).normalized() * speed * delta
			move_and_slide()
	else:
		pass

func _on_detect_area_body_entered(body):
	player = body
	chase_player = true

func _on_detect_area_body_exited(body):
	player = null
	chase_player = false

# take damage from player
func damage_taken(damage):
	HEALTH -= damage
	if(HEALTH <= 0):
		self.queue_free()
	
# if player enters slime hitbox, attack them
func _on_hit_box_body_entered(body):
	if body.name == "Player":
		attack = true
func _on_hit_box_body_exited(body):
	if body.name == "Player":
		attack = false

# send signal to attack
func attack_player():
	if attack == true and attack_cd == false:
		Signals.emit_signal("attack_player", 10)
		attack_cd = true
		$Attack_CD.start()

# no longer on cd
func _on_attack_cd_timeout():
	attack_cd = false
