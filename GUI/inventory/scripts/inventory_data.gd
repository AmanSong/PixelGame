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

#gather all items in inventory into an array
func get_saved_data() -> Array:
	var item_save : Array = []
	for i in slots.size():
		item_save.append(item_to_save(slots[i]))
	return item_save
	
func item_to_save(slot : SlotData) -> Dictionary:
	var result = {item = "", quantity = 0}
	if slot != null:
		result.quantity = slot.quantity
		if slot.item_data != null:
			result.item = slot.item_data.resource_path
	return result

func parse_saved_data(savedData: Array) -> void:
	var array_size = slots.size()
	slots.clear()
	slots.resize(array_size)
	for i in savedData.size():
		slots[i] = item_from_save(savedData[i])
	connect_slots()
	
func item_from_save(save_object: Dictionary) -> SlotData:
	if save_object.item == "":
		return null
	var new_slot : SlotData = SlotData.new()
	new_slot.item_data = load(save_object.item)
	new_slot.quantity = int(save_object.quantity)
	
	return new_slot
