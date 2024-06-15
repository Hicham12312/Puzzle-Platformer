extends Button


@onready var progress_bar = $TextureProgressBar
@onready var timer = $Timer
@onready var time = $Time

@export var stats: Item = null:
	set(value):
		stats = value
		
		if value != null:
			icon = value.icon
		else:
			icon = null

func _ready():
	progress_bar.max_value = timer.wait_time
	set_process(false)
	set_process_input(false)

@warning_ignore("unused_parameter")
func _process(delta):
	time.text = "%3.1f" % timer.time_left
	progress_bar.value = timer.time_left


func _input(event):
	if event.is_action_pressed("use_item"):
		use_item()

func use_item():
	if stats == null:
		return
	var ItemsClass = Global.Items.new() as Global.Items
	if stats.name == ItemsClass.AbilitysClass.double_jump:
		Global.player.MAX_JUMPS = 2
		print_debug("you can double jump")
		timer.start()
		disabled = true
		set_process(true)
	elif stats.name == ItemsClass.AbilitysClass.star:
		pass


func _on_pressed():
	use_item()
	get_parent().current_index = get_index()
	Global.player.find_child("Weapons")._on_index(get_index())



func _on_double_jump_timer_timeout():
	disabled = false
	time.text = ""
	set_process(false)
	Global.player.MAX_JUMPS = 1
	stats = null
