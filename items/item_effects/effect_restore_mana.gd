class_name EffectRestoreMana extends ItemEffect

@export var restore_amount : int = 1
@export var audio : AudioStream

func use() -> void:
	# since mana cost is positive, we apply negative to restore mana
	PlayerManager.player.update_mana(-restore_amount)
	Inventory.play_audio(audio)
