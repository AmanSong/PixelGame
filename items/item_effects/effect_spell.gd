class_name EffectSpell extends ItemEffect

func use(item_data : ItemData) -> void:
	var added = PlayerManager.SPELL_DATA.add_spell(item_data)
	pass
