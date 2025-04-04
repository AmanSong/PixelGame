class_name Chest extends Node2D

func _ready():
	$HitBox.Damaged.connect(TakeDamage)
	pass
	
func TakeDamage(hurt_box : HurtBox) -> void:
	# break and maybe drop an item
	queue_free()
	pass
