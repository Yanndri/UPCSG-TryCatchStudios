extends Node3D

@export var main_scene : PackedScene

func _ready() -> void:
	%Lamp._ready_light()
	await get_tree().create_timer(3).timeout
	await %Lamp.flicker(16)
	%center_label.text = "Presents"
	await %Lamp.flicker(8)
	%center_label.text = "Dark Choices"
	await %Lamp.flicker(32)
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_packed(main_scene)
