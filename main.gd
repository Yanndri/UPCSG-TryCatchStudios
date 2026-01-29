extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalValues.click_event_type = GlobalValues.click_events.NA
	GlobalValues.Day = 1
	
	GlobalValues.connect("day_changed", new_day)
	new_day(1)

func new_day(_day : int):
	GlobalValues.chosen_item = ""
	%Map.glow_journal()
