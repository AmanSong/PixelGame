class_name EffectWeapon extends ItemEffect

func use(item_data : ItemData) -> void:
	PlayerManager.get_weapon_slot().equip_weapon(item_data)
	pass
