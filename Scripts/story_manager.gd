extends Node
##This script was added late

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalValues.connect("day_changed", new_day)

func new_day(_day : int):
	daily_values()
	add_food_and_water()
	check_stats()

func check_stats():
	for key in GlobalValues.characters.keys():
		var character = GlobalValues.characters[key]
		print("hunger: ", character["hunger"] <= 0)
		print("thirst: ", character["thirst"] <= 0)
		print("sanity: ", character["sanity"] <= 0)
		if character["hunger"] <= 0:
			%Why.text = character["name"] + " starved"
			%GameOver.visible = true
		if character["thirst"] <= 0:
			%Why.text = character["name"] + " lost due to thirst"
			%GameOver.visible = true
		if character["sanity"] <= 0:
			%Why.text = character["name"] + " have lost sanity and has begone berserk"
			%GameOver.visible = true

func add_food_and_water():
	for key in GlobalValues.characters.keys():
		var character = GlobalValues.characters[key]
		if GlobalValues.food_ate: 
			if character.hunger < 120:
				character.hunger += 50
		if GlobalValues.water_drank: 
			if character.thirst < 120:
				character.thirst += 50


func daily_values():
	for key in GlobalValues.characters.keys():
		var character = GlobalValues.characters[key]
		#print(character["name"], " : ", character.hunger)
		character.hunger -= 20
		character.thirst -= 20
		#print(character["name"], " : ", character.hunger)
		GlobalValues.food_ate = false
		GlobalValues.water_drank = false
