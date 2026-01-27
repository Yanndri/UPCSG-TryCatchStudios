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
		"name": "Wilson",
		"feeling" : feelings.Okay,
		"hunger" : 100
	},
	"Character2" : {
		"name": "Wendy",
		"feeling" : feelings.Okay,
		"hunger" : 100
	},
	#"Character3" : {
		#"name": "Russel",
		#"feeling" : feelings.Okay,
		#"hunger" : 100
	#},
	#"Character4" : {
		#"name": "Selena",
		#"feeling" : feelings["Okay"],
		#"hunger" : 100
	#}
}

#when in main view and you are prompt to click, used to determine which type should glow in map.gd
enum click_events{items, journal, rations, door} 
var click_event_type : click_events :
	set(value):
		click_event_type = value
		emit_signal("click_event_type_changed", click_event_type)

signal click_event_type_changed
signal item_changed
signal day_changed
