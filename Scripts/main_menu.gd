extends Node

@export var game_scene : PackedScene

func _on_play_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			play_game()
			

func play_game():
	get_tree().current_scene.play_game()
	#root.play_game()
	#get_tree().change_scene_to_packed(game_scene)
	
