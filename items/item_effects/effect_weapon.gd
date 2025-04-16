class_name EffectWeapon extends ItemEffect

func use(item_data : ItemData) -> void:
	Inventory.get_node("Control/Weapon/WeaponSlot").equip_weapon(item_data)
	pass
