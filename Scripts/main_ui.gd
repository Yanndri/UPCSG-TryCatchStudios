extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%PickAnItemLabel.visible = false 
	%ChooseRations.visible = false

	GlobalValues.connect("item_changed", display_chosen_item)
	display_chosen_item("")

func display_chosen_item(chosen_item : String):
	%chosenItem.text = chosen_item
	if chosen_item != "":
		%UseItem.visible = true
	else:
		%UseItem.visible = false

#When OK is pressed after choosing an item
func _on_okay_button_pressed() -> void: 
	print("GlobalValues.chosen_item: ", GlobalValues.chosen_item)
	if not (GlobalValues.chosen_item == "Food" or GlobalValues.chosen_item == "Water"):
		%CameraManager.journal_view()
