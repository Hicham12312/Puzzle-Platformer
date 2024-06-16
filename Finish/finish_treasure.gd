extends Area2D

signal On_finish

@export var scene: PackedScene
@onready var animated_sprite = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer

func _on_body_entered(body):
	if body != Global.player:
		return
	On_finish.emit()
	$AnimationPlayer.play("ZoomCameraToFinish")
	animated_sprite.play("Open")
	await animated_sprite.animation_finished and animation_player.animation_finished
	await get_tree().create_timer(0.5).timeout
	# TODO: add finish animation instead of a timer
	SceneSwitcher.switch_packed_scene(scene)
