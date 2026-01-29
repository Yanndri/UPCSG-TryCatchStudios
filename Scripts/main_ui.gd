extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%PickAnItemLabel.visible = false 

	GlobalValues.connect("item_changed", display_chosen_item)
	GlobalValues.connect("click_event_type_changed", display_confirm_button)
	display_chosen_item("")

func display_chosen_item(chosen_item : String):
	if GlobalValues.click_event_type == GlobalValues.click_events.rations: #Don't want to display items when it's ration time
		return
		
	%chosenItem.text = chosen_item
	if chosen_item != "":
		%UseItem.visible = true
	else:
		%UseItem.visible = false

func display_confirm_button(click_event : int):
	if click_event == GlobalValues.click_events.rations or click_event == GlobalValues.click_events.NA : #In Rations mode get rid of okay button
		%OkayButton.visible = false
	else:
		%OkayButton.visible = true

#When OK is pressed after choosing an item
func _on_okay_button_pressed() -> void: 
	print("GlobalValues.chosen_item: ", GlobalValues.chosen_item)
	if not (GlobalValues.chosen_item == "Food" or GlobalValues.chosen_item == "Water"):
		%CameraManager.journal_view()
