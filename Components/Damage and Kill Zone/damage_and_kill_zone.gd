extends Area2D

@export_enum("Damage_zone", "Kill_zone") var type_of_zone

func _on_body_entered(body: Node2D) -> void:
	if body is Player and type_of_zone == 0:
		body.take_damage(5)
	elif body is Player and type_of_zone == 1:
		get_tree().call_deferred("reload_current_scene")
		Global.is_reloading_scene = true
		print_rich("[color=red] you died [/color]")
	elif "CollisionObject2D" not in body:
		print_rich("[color=red] This is not collidable [/color]")
		return
