extends Node

var chosen_item : String : #If no value selected it should be ""
	set(value):
		chosen_item = value
		print("Chosen Item: ", chosen_item)
		emit_signal("item_changed", chosen_item)

signal item_changed
