class_name HurtBox extends Area2D # ATTACKING 

@export var damage: int = 10
@export var box_scale: float = 1.0
@onready var hurtbox_shape = $CollisionShape2D

func _ready():
	area_entered.connect(AreaEntered)
	hurtbox_shape.scale = Vector2(box_scale, box_scale)
	pass

func configure(damage_val: int, scale_val: float) -> void:
	damage = damage_val
	box_scale = scale_val
	hurtbox_shape.scale = Vector2.ONE  # Reset before reapplying
	hurtbox_shape.scale *= box_scale
	
func _process(_delta):
	pass
	
func AreaEntered( area: Area2D ) -> void:
	if area is HitBox:
		area.TakeDamage(self)
	pass
