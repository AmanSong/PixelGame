@tool
class_name Chest extends Node2D

@export var item_data : ItemData : set = _set_item_data
@export var quantity : int = 1 : set = _set_quantity

@onready var items_sprite = $itemsSprite
@onready var interact_area = $Area2D
@onready var animation_player = $AnimationPlayer
@onready var label = $itemsSprite/Label
@onready var save_helper: SaveHandler = $SaveHelper

var is_opened = false

func _ready():
	_update_label()
	_update_texture()
	if Engine.is_editor_hint():
		return
	
	interact_area.area_entered.connect(_on_area_entered)
	interact_area.area_exited.connect(_on_area_exit)
	save_helper.data_loaded.connect(set_chest_state)
	set_chest_state()
	pass

func _set_item_data(value: ItemData) -> void:
	item_data = value
	_update_texture()
	pass
	
func _set_quantity(value: int) -> void:
	quantity = value
	_update_label()
	pass

func _on_area_entered(_a : Area2D) -> void:
	PlayerManager.interact_pressed.connect(_player_interact)
	pass
	
func _player_interact() -> void:
	if is_opened:
		return
	is_opened = true
	save_helper.set_value()
	animation_player.play("opened_chest")
	if item_data and quantity > 0:
		PlayerManager.INVENTORY_DATA.add_item(item_data, quantity)
	else:
		printerr("No items in chest!")
		push_error("No items in chest! Chest Name: ", name)
	pass
	
func _on_area_exit(_a : Area2D) -> void:
	PlayerManager.interact_pressed.disconnect(_player_interact)
	pass

func _update_texture() -> void:
	if item_data and items_sprite:
		items_sprite.texture = item_data.texture
		
	pass
	
func _update_label() -> void:
	if label:
		if quantity <= 1:
			label.text = ""
		else:
			label.text = "x" + str(quantity)
	pass

func set_chest_state() -> void:
	is_opened = save_helper.value
	if is_opened:
		animation_player.play("opened")
	else:
		animation_player.play("closed")
		
