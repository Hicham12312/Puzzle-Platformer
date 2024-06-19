extends Node

var current_scene = null

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	print_debug(current_scene)

func switch_scene(res_path):
	call_deferred("_deferred_switch_scene", res_path)

func _deferred_switch_scene(res_path):
	current_scene.free()
	var s = load(res_path) as PackedScene
	current_scene = s.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene


func switch_packed_scene(packed_scene: PackedScene):
	call_deferred("_deferred_switch_packed_scene", packed_scene)

func _deferred_switch_packed_scene(packed_scene: PackedScene):
	current_scene.free()
	current_scene = packed_scene.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene








