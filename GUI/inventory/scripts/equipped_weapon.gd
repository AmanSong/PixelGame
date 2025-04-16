class_name WeaponEquipped extends Button

@export var set_weapon : ItemData
@onready var texture_rect = $TextureRect

func _ready() -> void:
	await _wait_for_player()

	if set_weapon != null:
		equip_weapon(set_weapon)

	pressed.connect(_on_button_pressed)

func _wait_for_player() -> void:
	while PlayerManager.player == null:
		await get_tree().process_frame

func _on_button_pressed() -> void:
	# Just unequip if already equipped
	if set_weapon != null:
		unequip_weapon()

func equip_weapon(weapon_data: ItemData) -> void:
	# If a weapon is already equipped, unequip it first
	if set_weapon != null:
		unequip_weapon()

	set_weapon = weapon_data
	texture_rect.texture = weapon_data.texture
	PlayerManager.player.weapon = weapon_data

func unequip_weapon() -> void:
	if set_weapon == null:
		return

	texture_rect.texture = null

	# Add the unequipped weapon back to inventory
	if PlayerManager.INVENTORY_DATA.add_item(set_weapon):
		PlayerManager.player.weapon = null
		set_weapon = null
