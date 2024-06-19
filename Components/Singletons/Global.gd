extends Node

var grappling_hook = "res://Resources/items/Grappling_Hook.tres"

class Items:
	var weaponsClass = Weapons.new() as Weapons
	var AbilitysClass = Abilitys.new() as Abilitys
	var ConsumableClass = Consumable.new() as Consumable
	class Weapons:
		var grappling_hook = "GrapplingHook"
	
	class Abilitys:
		var double_jump = "DoubleJump"
		var star = "Star"
	
	class Consumable:
		pass

var player: CharacterBody2D

var is_reloading_scene: bool

enum Levels {
	noLevel,
	Level01,
	Level02,
	level_test
}

var previous_level = Levels.noLevel
