extends CanvasLayer

@onready var health_bar = $Control/Health_Bar

func _ready():
	pass

func update_health(_hp: int, _max_hp: int) -> void:
	print(_hp)
	health_bar.max_value = _max_hp
	health_bar.value = _hp
	pass
	
func update_max_health(_max_hp: int) -> void:
	health_bar.max_value = _max_hp
	pass
