extends CharacterBody2D

var speed = 25
var chase_player = false
var player = null

func _physics_process(delta):
	if chase_player:
		if position.distance_to(player.position) > 10:

			if (player.position.x > position.x):
				$AnimatedSprite2D.flip_h=true
			else:
				$AnimatedSprite2D.flip_h=false
				
			position += (player.position - position).normalized() * speed * delta
			move_and_slide()

func _on_detect_area_body_entered(body):
	player = body
	chase_player = true

func _on_detect_area_body_exited(body):
	player = null
	chase_player = false
