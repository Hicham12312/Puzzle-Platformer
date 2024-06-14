extends Node2D
class_name AbstractItem


@onready var collision = $Area2D/CollisionShape2D
@onready var sprite_2d = $Sprite2D
@export var stats: Item

func _ready():
	if stats != null:
		sprite_2d.texture = stats.icon


func _on_player_entered(body):
	if body != Global.player:
		return
	call_deferred("reparent", body.find_child("Weapons"))
	position = body.position
	body.add_item(stats)
	collision.call_deferred("set_disabled", true)
