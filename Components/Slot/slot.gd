extends Button

@export var stats: Item = null:
	set(value):
		stats = value
		
		if value != null:
			icon = value.icon
		else:
			icon = null

func _ready():
	set_process_input(false)

func _input(event):
	if event.is_action_pressed("use_item"):
		use_item()

func use_item():
	if stats == null:
		return
	if stats.name == Global.items_Dictionary.get("double_jump"):
		Global.player.MAX_JUMPS = 2
		print_debug("you can double jump")
