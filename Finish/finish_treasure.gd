extends Area2D
class_name Finish_Treasure

@export var scene: PackedScene
@onready var animated_sprite = $AnimatedSprite2D

func _on_body_entered(body):
	if body != Global.player:
		return
	animated_sprite.play("Open")
	await animated_sprite.animation_finished
	await get_tree().create_timer(0.5).timeout
	# TODO: add finish animation instead of a timer
	SceneSwitcher.switch_packed_scene(scene)
	Global.previous_level = Global.Levels.find_key(scene)
