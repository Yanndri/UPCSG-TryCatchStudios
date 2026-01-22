extends Camera3D

@export var min_zoom := 3
@export var max_zoom := 6
const default_zoom := 4

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("zoom_in"):
		if size > min_zoom:
			size -= 0.2
	if Input.is_action_pressed("zoom_out"):
		if size < max_zoom:
			size += 0.2
	
	%zoom_label.text = "Zoom : " + str(int(size / default_zoom * 100)) + "%"
