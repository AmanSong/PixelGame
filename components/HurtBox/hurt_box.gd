class_name HurtBox extends Area2D # ATTACKING 

@export var damage: int = 10

func _ready():
	area_entered.connect(AreaEntered)
	pass

func _process(_delta):
	pass
	
	
func AreaEntered( area: Area2D ) -> void:
	if area is HitBox:
		area.TakeDamage(self)
	pass
