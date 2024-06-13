extends Sprite2D

@onready var collision = $Area2D/CollisionShape2D

@export var stats: Item


func _ready():
	if stats != null:
		texture = stats.icon


func _on_player_entered(body):
	call_deferred("reparent", body.find_child("Weapons"))
