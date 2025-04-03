extends CharacterBody2D

@export var speed: float = 100
@export var self_delete: float = 1.5

var direction: Vector2

func _ready():
	global_rotation_degrees = rad_to_deg(direction.angle())

	# Delete itself after a certain time
	get_tree().create_timer(self_delete).timeout.connect(queue_free)

func _process(delta):
	velocity = direction * speed
	var collision = move_and_collide(velocity * delta) 
	if collision:
		queue_free()
		
	move_and_slide()

	
