extends CharacterBody2D

@export var speed = 100
var pos : Vector2
var direction : Vector2

var self_delete : float = 1.5

func _ready():
	global_position = pos
	global_rotation_degrees = rad_to_deg(direction.angle())
	
	# delete itself after a certain time
	get_tree().create_timer(self_delete).timeout.connect(delete)

func _process(delta):
	velocity = direction * speed
	
	var collision = move_and_collide(velocity * delta) 
	if collision:  
		delete()
		
	move_and_slide()

func delete() -> void:
	self.queue_free()
	
