extends Node

const PLAYER = preload("res://scenes/PlayerScenes/player.tscn")
const INVENTORY_DATA : InventoryData = preload("res://GUI/inventory/player_inventory.tres")
const SPELL_DATA : SpellsData = preload("res://GUI/inventory/spells/spell_slots.tres")

signal interact_pressed

var player : Player
var player_spawned : bool = false

func _ready():
	add_player_instance()
	await get_tree().create_timer(0.2).timeout
	player_spawned = true

func add_player_instance() -> void:
	player = PLAYER.instantiate()
	add_child(player)
	pass
	
func set_health(hp: int, max_hp: int) -> void:
	player.max_health = max_hp
	player.health = hp
	player.update_health(0)

func set_mana(mp: int, max_mp: int) -> void:
	player.max_mana = max_mp
	player.mana = mp
	player.update_mana(0)

func set_player_position(_new_pos : Vector2) -> void:
	player.global_position = _new_pos
	pass
	
func set_as_parent(_p : Node2D) -> void:
	if player.get_parent():
		player.get_parent().remove_child(player)
	_p.add_child(player)
	
func unparent_player(_p : Node2D) -> void:
	_p.remove_child(player)

func get_weapon_slot() -> WeaponEquipped:
	return Inventory.get_node("Control/Weapon/WeaponSlot") as WeaponEquipped
