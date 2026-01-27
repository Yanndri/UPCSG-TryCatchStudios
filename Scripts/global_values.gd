extends Node

var Day : int = 1 :
	set(value):
		Day = value
		print("Day Changed: ", Day)
		emit_signal("day_changed", Day)

var chosen_item : String : #If no value selected it should be ""
	set(value):
		chosen_item = value
		print("Chosen Item: ", chosen_item)
		emit_signal("item_changed", chosen_item)

signal item_changed
signal day_changed
