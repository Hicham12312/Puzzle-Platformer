extends Sprite2D

@onready var collision = $Area2D/CollisionShape2D

@export var stats: Item

func _ready():
	if stats != null:
		texture = stats.icon


func _on_player_entered(body):
	call_deferred("reparent", body.find_child("Weapons"))
	position = body.position
	body.add_item(stats)
	collision.call_deferred("set_disabled", true)
	if Global.items_Dictionary.get("double_jump") == stats.name:
		queue_free()
