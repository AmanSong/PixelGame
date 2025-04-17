class_name Spell
extends CharacterBody2D

@export var manaCost: int = 0
@export var cool_down: float = 1.0
@export var self_delete: float = 1.5  # Optional, not used in all spells

var direction: Vector2 = Vector2.ZERO

func cast():
	# Override in child classes
	pass

func rotate_towards_direction():
	if direction != Vector2.ZERO:
		global_rotation_degrees = rad_to_deg(direction.angle())
