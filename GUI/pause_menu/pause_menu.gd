extends CanvasLayer

@onready var button_load = $Control/VBoxContainer/Button_Load
@onready var button_save = $Control/VBoxContainer/Button_Save

var is_paused : bool = false

func _ready():
	hide_pause_menu()
	button_save.pressed.connect(_on_save_pressed)
	button_load.pressed.connect(_on_load_pressed)
	pass
	
func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("Pause"):
		if is_paused == false:
			show_pause_menu()
		else:
			hide_pause_menu()
		get_viewport().set_input_as_handled()

func show_pause_menu() -> void:
	if LevelManager.is_transitioning == true:
		return
	get_tree().paused = true
	visible = true
	is_paused = true
	# to hide inventory 
	Inventory.layer = 1
	button_save.grab_focus()

func hide_pause_menu() -> void:
	get_tree().paused = false
	visible = false
	is_paused = false
	Inventory.layer = 2

func _on_save_pressed() -> void:
	if is_paused == false:
		return
	SaveManager.save_game()
	hide_pause_menu()
	pass
	
func _on_load_pressed() -> void:
	if is_paused == false:
		return
	SaveManager.load_game()
	await LevelManager.level_load_started
	hide_pause_menu()
	pass
