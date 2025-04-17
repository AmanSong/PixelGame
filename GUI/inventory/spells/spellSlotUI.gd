class_name SpellSlotUI extends Button

var slot_data : SlotData : set = set_slot_data

@onready var texture_rect = $TextureRect

func _ready():
	texture_rect.texture = null
	pressed.connect(remove_spell)

func set_slot_data(value : SlotData) -> void:
	slot_data = value
	if slot_data == null:
		return
	texture_rect.texture = slot_data.item_data.texture

func remove_spell() -> void:
	if slot_data and slot_data.item_data:
		PlayerManager.INVENTORY_DATA.add_item(slot_data.item_data)
		slot_data.quantity = 0
