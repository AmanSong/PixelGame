class_name HitBox extends Area2D

signal Damaged(damage: int)

func _ready():
	pass
	
func _process(_delta):
	pass
	

func TakeDamage(damage: int) -> void:
	print("Damage taken:", damage)
	Damaged.emit(damage)
