class_name Health extends Node

@export var max_health: int = 100
var health: int

func _ready():
	health = max_health  # Initialize health properly

	# Use instance-based signals instead of global connections
	if get_parent().name == "Player":
		Signals.PLAYER_DAMAGED.connect(damage_taken)
	elif get_parent().name == "Slime":
		Signals.ENEMY_DAMAGED.connect(damage_taken)

func damage_taken(damage: int):
	health -= damage
	print(get_parent().name, " took damage! Current health: ", health)

	if health <= 0:
		health_depleted()

func max_health_changed(hp: int):
	max_health = hp

func health_depleted():
	print(get_parent().name, " died!")
	get_parent().queue_free()  # Remove the character itself instead of just health node
