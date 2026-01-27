extends Node

@export var cameras : Array[Camera3D]

func switch_camera(camera_index : int):
	for camera in cameras:
		if camera != cameras[camera_index]:
			camera.current = false
	cameras[camera_index].current = true

func main_view() -> void:
	switch_camera(0)
	%JournalEntries.visible = false
	
	%MainUI.visible = true

func journal_view():
	switch_camera(1)
	%JournalEntries.visible = true
	%Map.disable_tweens() #This stops the glowing
	%Map.disable_journal_texture() #To stop the very white texture render
	
	%MainUI.visible = false

#When journal is clicked
func _on_interactable_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			journal_view()
			%Map.disable_monitoring_areas() #so the mouse doesn't detect the area3d of the journal
