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
	timer.wait_time = 10

func _physics_process(delta):
	if !Global.player.Alive:
		set_process_input(false)
		set_pressed_no_signal(false)
		Global.player.sprite_2d.material.set_shader_parameter("strength", 0)

func _input(event):
	if event.is_action_pressed("use_item"):
		use_item()

func use_item():
	if stats == null or !Global.player.Alive:
		return
	var ItemsClass = Global.Items.new() as Global.Items
	if stats.name == ItemsClass.AbilitysClass.double_jump:
		timer.wait_time = 5
		progress_bar.max_value = timer.wait_time
		Global.player.MAX_JUMPS = 2
		timer.start()
		disabled = true
		set_process(true)
	elif stats.name == ItemsClass.AbilitysClass.star:
		timer.wait_time = 10
		progress_bar.max_value = timer.wait_time
		Global.player.sprite_2d.material.set_shader_parameter("strength", 0.5)
		Music.stream = load("res://Music/Star_Music.mp3")
		Music.play()
		timer.start()
		disabled = true
		set_process(true)


func _on_pressed():
	use_item()
	get_parent().current_index = get_index()
	Global.player.find_child("Weapons")._on_index(get_index())



func _on_timer_timeout():
	var ItemsClass = Global.Items.new()
	disabled = false
	time.text = ""
	set_process(false)
	if stats.name == ItemsClass.AbilitysClass.double_jump:
		Global.player.MAX_JUMPS = 1
	elif stats.name == ItemsClass.AbilitysClass.star:
		Global.player.sprite_2d.material.set_shader_parameter("strength", 0)
		var music_time = Music.get_playback_position()
		Music.stream = load("res://Music/Worldmap Theme.mp3")
		Music.play(music_time)
	stats = null
