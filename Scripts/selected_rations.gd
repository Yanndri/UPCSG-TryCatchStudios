extends MarginContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalValues.connect("item_changed", display_ration)
	
	reset_visibility()

func reset_visibility():
	self.visible = false
	%FoodLabel.visible = false
	%WaterLabel.visible = false

func display_ration(item : String):
	if not GlobalValues.click_event_type == GlobalValues.click_events.rations:
		return

	match item:
		"Food": 
			%FoodLabel.visible = true #the food that was took is now on the table
		"Removed Food": 
			%FoodLabel.visible = false #the food that was took is now on the table
		"Water": 
			%WaterLabel.visible = true #the bottle that was took is now on the table
		"Removed Water":
			%WaterLabel.visible = false #the bottle that was took is now on the table
	
	if %WaterLabel.visible or %FoodLabel.visible:
		self.visible = true
	else:
		self.visible = false

func _on_confirm_rations_pressed() -> void:
	GlobalValues.click_event_type = GlobalValues.click_events.NA
	if %FoodLabel.visible:
		for key in GlobalValues.characters.keys():
			GlobalValues.characters[key]["hunger"] += 20
			print(GlobalValues.characters[key]["name"], " hunger: ", GlobalValues.characters[key]["hunger"])
	if %WaterLabel.visible:
		for key in GlobalValues.characters.keys():
			GlobalValues.characters[key]["thirst"] += 20
			print(GlobalValues.characters[key]["name"], " thirst: ", GlobalValues.characters[key]["thirst"])
	reset_visibility()
	%JournalEntries._on_confirm_rations_pressed()
