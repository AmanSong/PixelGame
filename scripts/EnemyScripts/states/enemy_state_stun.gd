class_name EnemyStateStun extends EnemyState

@export var anim_name : String = "Stun"
@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10.0

@export_category("AI")
@export var next_state : EnemyState

var _direction : Vector2
var _animation_finished : bool = false

func _ready():
	pass
	
func init() -> void:
	enemy.enemy_damaged.connect(_on_enemy_damage)
	pass

func enter() -> void:
	enemy.sprite2D.modulate = Color(1, 0.6, 0.6)
	enemy.invunverable = true
	_animation_finished = false
	_direction = enemy.global_position.direction_to(enemy.player.global_position)
	
	enemy.set_direction(_direction)
	enemy.velocity = _direction * -knockback_speed
	enemy.update_animation(anim_name)
	
	enemy.sprite2D.animation_finished.connect(_on_animation_finished)
	pass
	
func exit() -> void:
	enemy.invunverable = false
	enemy.sprite2D.animation_finished.disconnect(_on_animation_finished)
	pass
	
func process(_delta:float) -> EnemyState:
	if _animation_finished == true:
		return next_state
	enemy.velocity -= enemy.velocity * decelerate_speed * _delta
	
	return null

func physics(_delta:float) -> EnemyState:
	return null

func _on_enemy_damage() -> void:
	state_machine.change_state(self)

func _on_animation_finished() -> void:
	enemy.sprite2D.modulate = Color(1,1,1)
	_animation_finished = true
	
