class_name EffectHeal extends ItemEffect

@export var heal_amount : int = 1
@export var audio : AudioStream

func use(item_data: ItemData) -> void:
	PlayerManager.player.update_health(heal_amount)
	Inventory.play_audio(audio)
