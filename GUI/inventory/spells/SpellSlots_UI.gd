class_name SpellSlotsUI extends Control

const SPELL_SLOT = preload("res://GUI/inventory/spells/Spell_slot.tscn")
@export var data : SpellsData

func _ready():
	Inventory.opened.connect(_update_spellslots)
	clear_inventory()
	data.spellslots_changed.connect(_update_spellslots)
	pass
	
func clear_inventory() -> void:
	for child in get_children():
		child.queue_free()
		
func _update_spellslots(i : int = 0) -> void:
	clear_inventory()
	for slot in data.slots:
		var new_slot = SPELL_SLOT.instantiate()
		add_child(new_slot)
		new_slot.slot_data = slot
