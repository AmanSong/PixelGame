class_name ItemEffect extends Resource

@export var use_description : String 

# item data is used for weapons and spellbooks
# for potions, simply ignore it
func _use(item_data: ItemData) -> void:
	pass
