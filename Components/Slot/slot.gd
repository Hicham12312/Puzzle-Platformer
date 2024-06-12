extends Button

@onready var player = get_tree().current_scene.find_child("Player")

@export var stats: Item = null:
	set(value):
		stats = value
		
		if value != null:
			icon = value.icon
		else:
			icon = null


func use_item():
	if stats == null:
		return
