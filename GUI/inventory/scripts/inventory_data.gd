class_name InventoryData extends Resource

@export var slots : Array[SlotData]

signal inventory_changed

func _init() -> void:
	connect_slots()
	pass
	
func add_item(item: ItemData, count: int = 1) -> bool:
	# if the item already in inventory
	for slot in slots:
		if slot:
			if slot.item_data == item:
				slot.quantity += count
				emit_signal("inventory_changed")
				return true
				
	for i in slots.size():
		if slots[i] == null:
			var new_slot := SlotData.new()
			new_slot.item_data = item
			new_slot.quantity = count
			new_slot.changed.connect(slot_changed)
			slots[i] = new_slot
			emit_signal("inventory_changed")
			return true

	
	print("Inventory full!")
	return false;


func connect_slots() -> void:
	for slot in slots:
		if slot:
			slot.changed.connect(slot_changed)
	pass


func slot_changed() -> void:
	for i in range(slots.size()):
		var slot = slots[i]
		if slot and slot.quantity < 1:
			slot.changed.disconnect(slot_changed)
			slots[i] = null
			
	emit_signal("inventory_changed")
	pass
