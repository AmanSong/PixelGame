class_name ItemData extends Resource

@export_enum("Weapon", "Potion", "SpellBook") var type : String

@export var name : String = ""
@export_multiline var description : String = ""
@export var texture : Texture2D

@export_category("Item use effects")
@export var effects : Array[ItemEffect]

@export_category("Weapon stats")
@export var damage : int
@export var range : float

@export_category("Spell_Scene")
@export var spell_scene : PackedScene

func use() -> bool:
	if effects.size() == 0:
		return false
	
	for effect in effects:
		if type == "SpellBook":
			var was_used = PlayerManager.SPELL_DATA.add_spell(self)
			if was_used == false:
				return false
			
		if effect:
			effect.use(self)
		
	return true
