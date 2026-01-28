extends Node3D

@export var items_theme : StandardMaterial3D
@export var rations_theme : StandardMaterial3D
@export var journal_theme : StandardMaterial3D
@export var door_theme : StandardMaterial3D

var items_tween : Tween
var rations_tween : Tween
var journal_tween : Tween
var door_tween : Tween

func _input(_event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_1):
		glow_items()
	if Input.is_key_pressed(KEY_2):
		glow_journal()
	if Input.is_key_pressed(KEY_3):
		glow_rations()
	if Input.is_key_pressed(KEY_4):
		glow_door()

func _ready() -> void:
	GlobalValues.connect("click_event_type_changed", toggle_glowing_types) #when the clicking types(journal, rations, items, or door) changes, also change which will glow
	glow_journal()

func glow_items():
	items_tween =create_tween()
	glow(items_tween, items_theme) #now turn on this specific tween
	
	disable_monitoring_areas() #disable all interactables
	toggle_monitoring(true, "item") #enable this interactable

func glow_journal():
	journal_theme.render_priority = 0 #When -1 the theme will not render, 0 is default
	journal_tween =create_tween()
	glow(journal_tween, journal_theme) #now turn on this specific tween
	
	disable_monitoring_areas() #disable all interactables
	toggle_monitoring(true, "journal") #enable this interactable

##Used by camera_manager when on journal view
func disable_journal_texture(): journal_theme.render_priority = -1 #this makes it so the theme doesnt render

func glow_rations():
	rations_tween =create_tween()
	glow(rations_tween, rations_theme) #now turn on this specific tween
	
	disable_monitoring_areas() #disable all interactables
	toggle_monitoring(true, "ration") #enable this interactable
	toggle_monitoring(true, "journal") #enable this interactable

func glow_door():
	door_tween =create_tween()
	glow(door_tween, door_theme) #now turn on this specific tween
	
	disable_monitoring_areas() #disable all interactables

func glow(tween : Tween, theme : StandardMaterial3D):
	disable_tweens() #First disable the running tweens 
	theme.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	
	tween.set_loops()
	tween.tween_property(theme, "albedo_color:g", 0.9, 0.5)\
	.set_trans(Tween.TRANS_SINE)\
	.set_ease(Tween.EASE_IN_OUT)
	#the '\' allows for newline, so that it's more readable
	
	tween.tween_property(theme, "albedo_color:g", 0.4, 0.5)\
	.set_trans(Tween.TRANS_SINE)\
	.set_ease(Tween.EASE_IN_OUT)

func disable_tweens():
	if items_tween != null and items_tween.get_loops_left() == -1: stop_glow(items_tween, items_theme)
	if rations_tween != null and rations_tween.get_loops_left() == -1: stop_glow(rations_tween, rations_theme)
	if journal_tween != null and journal_tween.get_loops_left() == -1: stop_glow(journal_tween, journal_theme)
	if door_tween != null and door_tween.get_loops_left() == -1: stop_glow(door_tween, door_theme)

func stop_glow(tween : Tween, theme : StandardMaterial3D):
	tween.kill() #Terminate tween
	tween = null #make sure to erase the instance
	
	theme.shading_mode = BaseMaterial3D.SHADING_MODE_PER_PIXEL
	theme.albedo_color.g = 1

func toggle_monitoring(is_working : bool, group_name : String):
	for node in get_tree().get_nodes_in_group(group_name):
		if node is Area3D:
			node.input_ray_pickable = is_working #disabling monitoring and monitorable doesnt work on mouse inputs

func disable_monitoring_areas(): #so when hovering, the mouse isn't getting picked up
	toggle_monitoring(false, "item")
	toggle_monitoring(false, "ration")
	toggle_monitoring(false, "journal")

func toggle_glowing_types(click_event : int) -> void:
	if click_event == GlobalValues.click_events.items: glow_items()
	if click_event == GlobalValues.click_events.rations: glow_rations()
	if click_event == GlobalValues.click_events.NA: make_everything_clickable_but_no_glow()

func make_everything_clickable_but_no_glow():
	toggle_monitoring(true, "item")
	toggle_monitoring(true, "ration")
	toggle_monitoring(true, "journal")
