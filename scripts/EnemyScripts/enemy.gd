class_name Enemy extends CharacterBody2D

signal direction_changed(new_direction : Vector2)
signal enemy_damaged()

const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP] 

@export var hp : int = 50

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
var player : Player
var invunverable : bool = false

@onready var sprite2D = $AnimatedSprite2D
#@onready var hit_box : HitBox = $HitBox
@onready var state_machine : EnemyStateMachine = $EnemyStateMachine

func _ready():
	state_machine.initialize(self)
	player = PlayerManager.player
	pass
	
func _process(_delta):
	pass

func _physics_process(_delta):
	move_and_slide()

func set_direction(_new_direction : Vector2) -> bool:
	direction = _new_direction
	if direction == Vector2.ZERO:
		return false
	
	var direction_id : int = int( round (
		(direction + cardinal_direction * 0.1).angle()
		/ TAU * DIR_4.size()
	))
	
	var new_dir = DIR_4[direction_id]
	if new_dir == cardinal_direction:
		return false
		
	cardinal_direction = new_dir
	direction_changed.emit(new_dir)
	sprite2D.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	
	return true

func update_animation(state : String) -> void:
	sprite2D.play(state + "_" + anim_direction())
	pass
	
func anim_direction() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "Down"
	elif cardinal_direction == Vector2.UP:
		return "Up"
	else:
		return "Side"
