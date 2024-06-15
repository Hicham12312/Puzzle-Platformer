extends Node2D
class_name AbstractItem


@onready var collision = $Area2D/CollisionShape2D as CollisionShape2D
@onready var sprite_2d = $Sprite2D as Sprite2D
@export var stats: Item



func _ready():
	if stats != null:
		sprite_2d.texture = stats.icon
		
		if stats.icon.get_size() == Vector2(32, 32):
			sprite_2d.scale = Vector2(6, 6)
		elif stats.icon.get_size() == Vector2(500, 500):
			sprite_2d.scale = Vector2(0.5, 0.5)

func _on_player_entered(body):
	if body != Global.player:
		return
	call_deferred("reparent", body.find_child("Weapons"))
	position = body.position
	body.add_item(stats)
	collision.call_deferred("set_disabled", true)
	show()
	queue_free()
