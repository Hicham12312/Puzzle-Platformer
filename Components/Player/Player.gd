extends CharacterBody2D
class_name Player

var SPEED = 1200
const JUMP_POWER = 4000

const ACC = 50
const FRICTION = 80
const GRAVITY = 200

var MAX_JUMPS = 1
var current_jumps = 1

var Alive: bool = true
var can_be_damaged: bool = true

var health := 100.0

@onready var label = $UI/Label
@onready var hot_bar = $UI/HotBar
@onready var sprite_2d = $Sprite2D

@warning_ignore("unused_parameter")
func _physics_process(delta):
	Global.player = self
	var input_dir: Vector2 = input()
	
	if input_dir != Vector2.ZERO:
		accelerate(input_dir)
		# play animation
	else:
		add_friction()
		# play animation
	player_mouvement()
	jump()
	label.text = "velocity: " + str(velocity)

# function to get the input
func input() -> Vector2:
	var input_dir = Vector2.ZERO
	
	input_dir.x = Input.get_axis("move_left", "move_right")
	input_dir = input_dir.normalized()
	return input_dir

# function to accelerate
func accelerate(direction):
	velocity = velocity.move_toward(SPEED * direction, ACC)

# function to add friction
func add_friction():
	velocity = velocity.move_toward(Vector2.ZERO, FRICTION)

func player_mouvement():
	move_and_slide()
# Jump
func jump():
	if Input.is_action_just_pressed("jump"):
		if current_jumps < MAX_JUMPS:
			velocity.y = -JUMP_POWER
			current_jumps += 1
		elif current_jumps >= MAX_JUMPS and is_on_floor():
			velocity.y = -JUMP_POWER
			current_jumps += 1
	elif Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= 0.5
	else:
		velocity.y += GRAVITY
	
	if is_on_floor():
		current_jumps = 1

func take_damage(Damage: int):
	health -= Damage
	if health <= 0:
		get_tree().paused = true
		print_rich("[color=red][b]you are dead[/b][/color]")

func add_item(stats):
	if !Alive:
		return
	hot_bar.add_item(stats)

