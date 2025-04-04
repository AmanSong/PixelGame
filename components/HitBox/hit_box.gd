class_name HitBox extends Area2D # TAKING DAMAGE

signal Damaged(hurt_box: HurtBox)

func _ready():
	pass
	
func _process(_delta):
	pass
	
func TakeDamage(hurt_box: HurtBox) -> void:
	Damaged.emit(hurt_box)
