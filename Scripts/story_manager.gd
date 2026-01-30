extends Node
##This script was added late

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalValues.connect("day_changed", new_day)

func new_day(_day : int):
	daily_values()

func daily_values():
	for key in GlobalValues.characters.keys():
		var character = GlobalValues.characters[key]
		character.hunger -= 20
