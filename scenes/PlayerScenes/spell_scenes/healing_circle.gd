class_name HealingCircle extends Spell

@onready var sprite_2d = $Sprite2D
@onready var collision_shape_2d = $Area2D/CollisionShape2D

var healing = false
var heal_timer := 0.0
var heal_interval := 0.5 # 1 second between heals

func _ready():
	sprite_2d.scale = Vector2.ONE
	cast()
	get_tree().create_timer(self_delete).timeout.connect(queue_free)

func cast():
	pass

func _process(delta):
	if sprite_2d.scale.x < 3.75:
		sprite_2d.scale += Vector2.ONE * 1.5 * delta
	
	if healing:
		heal_timer -= delta
		if heal_timer <= 0:
			PlayerManager.player.update_health(1)
			heal_timer = heal_interval

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		healing = true

func _on_area_2d_body_exited(body):
	if body.name == "Player":
		healing = false
