extends Node3D

@export var menu_scene : PackedScene

func _ready() -> void:
	await get_tree().create_timer(3).timeout
	await %Lamp.flicker()
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_packed(menu_scene)
