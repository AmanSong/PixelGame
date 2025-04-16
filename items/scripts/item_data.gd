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

func use() -> bool:
	if effects.size() == 0:
		return false
	
	for effect in effects:
		if effect:
			effect.use(self)
		
	return true
