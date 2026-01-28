extends Area3D

@export var item_name : String
enum category{items, journal, rations, door}
@export var item_type : category #To identify what category of item this is, to use GlobalValues click_event_types

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Auto connects >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	self.connect("input_event", _on_area_3d_input_event) 
	self.connect("mouse_entered", _on_area_3d_mouse_entered)
	self.connect("mouse_exited", _on_area_3d_mouse_exited)
	
	GlobalValues.connect("item_changed", _toggle_input_ray_pickable)

func _toggle_input_ray_pickable(item : String): #Check if item is already pressed if so disable input so it can't be clicked twice
	if GlobalValues.click_event_type == item_type: #Only change input rays when the current click event is the same category
		#print("click_event_type: ", GlobalValues.click_event_type, " item_type: ", item_type, " GlobalValues.chosen_item: ", GlobalValues.chosen_item, " item_name: ", item_name)
		if item == item_name:
			self.input_ray_pickable = false
		else:
			self.input_ray_pickable = true

func _on_area_3d_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			GlobalValues.chosen_item = item_name

func _on_area_3d_mouse_entered() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_area_3d_mouse_exited() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
