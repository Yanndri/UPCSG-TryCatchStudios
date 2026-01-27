extends Node

var Day : int = 1 :
	set(value):
		Day = value
		print("Day Changed: ", Day)
		emit_signal("day_changed", Day)

var chosen_item : String : #If no value selected it should be ""
	set(value):
		if value == "Journal": #This is for the journal interactable
			return
		chosen_item = value
		print("Chosen Item: ", chosen_item)
		emit_signal("item_changed", chosen_item)

var feelings : Dictionary = { #values should be the continuation of "is feeling -blank-"
	"Okay": "Okay so far",
	"Depressed": "Depressed and should be looked after"
}
const max_hunger = 100
var characters : Dictionary = {
	"Character1" : {
		"name": "David",
		"feeling" : feelings["Okay"],
		"hunger" : 100
	},
	"Character2" : {
		"name": "Neil",
		"feeling" : feelings.Okay,
		"hunger" : 100
	},
	"Character3" : {
		"name": "Russel",
		"feeling" : feelings.Okay,
		"hunger" : 100
	},
	"Character4" : {
		"name": "Selena",
		"feeling" : feelings["Okay"],
		"hunger" : 100
	}
}

signal item_changed
signal day_changed
