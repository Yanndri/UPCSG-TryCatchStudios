extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.connect("input_event", _on_area_3d_input_event)
	self.connect("mouse_entered", _on_area_3d_mouse_entered)
	self.connect("mouse_exited", _on_area_3d_mouse_exited)

func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			#get_parent().stop_glow()
			if %IntroCamera.current:
				%MainCamera.current = true
			set_deferred("monitoring", false) #doesnt work??

func _on_area_3d_mouse_entered() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_area_3d_mouse_exited() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
