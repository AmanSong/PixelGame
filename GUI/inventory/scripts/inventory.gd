extends CanvasLayer

var inventory_opened = false
signal opened
signal closed

@onready var item_description = $Control/ItemDescription

func _ready():
	close_inventory()
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_focus_next") and inventory_opened:
		print("Hi")
		return
	# Handle other input events...

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Inventory"):
		if inventory_opened == true:
			close_inventory()
		else:
			open_inventory()
	
func open_inventory() -> void:
	inventory_opened = true
	visible = true
	opened.emit()

func close_inventory() -> void:
	inventory_opened = false
	visible = false
	closed.emit()

func update_item_description(new_text: String) -> void:
	item_description.text = new_text
