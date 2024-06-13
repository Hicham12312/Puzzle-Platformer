extends Resource
class_name Item

@export var icon: Texture2D
@export var name: String

@export_enum("Weapon", "Consumable", "Ability")
var type = "Weapon"
