extends Node
##This script was added late

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalValues.connect("day_changed", new_day)

func new_day(_day : int):
	daily_values()
	add_food_and_water()

func add_food_and_water():
	for key in GlobalValues.characters.keys():
		var character = GlobalValues.characters[key]
		if GlobalValues.food_ate: 
			character.hunger += 35
		if GlobalValues.water_drank: 
			character.thirst += 35


func daily_values():
	for key in GlobalValues.characters.keys():
		var character = GlobalValues.characters[key]
		character.hunger -= 20
		GlobalValues.food_ate = false
		GlobalValues.water_drank = false
