extends CanvasLayer

@onready var health_bar = $Control/Health_Bar
@onready var mana_bar = $Control/Mana_Bar
@onready var spell_sprite = $Control/Control/TextureRect/SpellSprite

@onready var mana_label = $Control/Mana_Bar/Mana_label
@onready var health_label = $Control/Health_Bar/Health_label

func _ready():
	pass
	
func update_health(_hp: int, _max_hp: int) -> void:
	health_bar.max_value = _max_hp
	health_bar.value = _hp
	health_label.text = str(_hp)
	pass
	
func update_max_health(_max_hp: int) -> void:
	health_bar.max_value = _max_hp
	pass

func update_mana(_mp: int, _max_mp: int) -> void:
	mana_bar.max_value = _max_mp
	mana_bar.value = _mp
	mana_label.text = str(_mp)
	pass


var spell_texture_cache := {}
func update_spell_icon(spell_scene: PackedScene) -> void:
	if !spell_scene:
		return

	var scene_path = spell_scene.resource_path
	if spell_texture_cache.has(scene_path):
		spell_sprite.texture = spell_texture_cache[scene_path]
		return

	var spell_instance = spell_scene.instantiate()
	var sprite = spell_instance.get_node_or_null("Sprite2D")  # Adjust if needed
	if sprite:
		spell_texture_cache[scene_path] = sprite.texture
		spell_sprite.texture = sprite.texture
	else:
		printerr("Sprite2D node not found in spell scene: ", scene_path)
