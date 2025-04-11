class_name InventoryUI extends Control

const INVENTORY_SLOT = preload("res://GUI/inventory/inventory_slot.tscn")
var focus_index : int = 0
@export var data : InventoryData

func _ready():
	Inventory.opened.connect(_update_inventory)
	Inventory.closed.connect(clear_inventory)
	clear_inventory()
	data.inventory_changed.connect(_update_inventory)
	pass
	
func clear_inventory() -> void:
	for child in get_children():
		child.queue_free()
		

func _update_inventory(i : int = 0) -> void:
	clear_inventory()
	for slot in data.slots:
		var new_slot = INVENTORY_SLOT.instantiate()
		add_child(new_slot)
		new_slot.slot_data = slot
		new_slot.focus_entered.connect(item_focused)
		
	await get_tree().process_frame
	if get_child_count() > 0 and i < get_child_count():
		get_child(i).grab_focus()
	
	
func item_focused() -> void:
	for i in get_child_count():
		if get_child(i).has_focus():
			focus_index = i
			break
	pass
