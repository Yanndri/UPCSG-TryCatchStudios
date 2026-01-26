extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalValues.connect("item_changed", display_chosen_item)
	display_chosen_item("")

func display_chosen_item(chosen_item : String):
	%chosenItem.text = chosen_item
	if chosen_item != "":
		%chosenItem.visible = true
	else:
		%chosenItem.visible = false
