class_name State extends Node

static var player : Player

func _ready():
	pass

func Enter():
	pass
	
func Exit():
	pass
	
func Process(delta:float) -> State:
	return null

func Physics(delta:float) -> State:
	return null
	
func HandleInput(_event:InputEvent) -> State:
	return null
