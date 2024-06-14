extends Node2D

@onready var collision = $Area2D/CollisionShape2D
@onready var sprite_2d = $Sprite2D
@export var stats: Item

func _ready():
	if stats != null:
		sprite_2d.texture = stats.icon
		if stats.name == Global.items_Dictionary.get("double_jump"):
			return
		if stats.icon.get_image().get_size() >= Vector2i(500,500):
			sprite_2d.scale = Vector2(0.4, 0.4)
			collision.shape.size = Vector2(150, 148)


func _on_player_entered(body):
	if body != Global.player:
		return
	call_deferred("reparent", body.find_child("Weapons"))
	position = body.position
	body.add_item(stats)
	collision.call_deferred("set_disabled", true)
	if Global.items_Dictionary.get("double_jump") == stats.name:
		queue_free()
