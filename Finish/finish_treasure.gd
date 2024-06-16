extends Area2D

@export var scene: PackedScene

func _on_body_entered(body):
	if body != Global.player:
		return
	
	
