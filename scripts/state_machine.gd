class_name State_Machine extends Node

var states : Array[ State ]
var prev_state : State
var current_state : State

func _ready():
	process_mode = Node.PROCESS_MODE_DISABLED
	pass
	
	
func _process(delta):
	change_state( current_state.process(delta) )
	pass
	
	
func _physics_process(delta):
	change_state( current_state.physics(delta) )
	pass
	
	
func _unhandled_input(event):
	change_state(current_state.handle_input(event))
	pass
	
	
func initialize( _player : Player ) -> void:
	states = []
	
	for child in get_children():
		if child is State:
			states.append(child)
			
	if states.size() == 0:
		return
	
	states[0].player = _player
	states[0].state_machine = self
	
	for state in states:
		state.init()
		
	change_state( states[0] )
	process_mode = Node.PROCESS_MODE_INHERIT
		
	
func change_state(new_state : State) -> void:
	if new_state == null || current_state == new_state:
		return
	
	if current_state:
		current_state.exit()
	
	prev_state = current_state
	current_state = new_state
	current_state.enter()
