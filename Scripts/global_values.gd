extends Node

var food_amount : int :
	set(value):
		food_amount = value
		emit_signal("food_amount_changed", food_amount)

var water_amount : int :
	set(value):
		water_amount = value
		emit_signal("water_amount_changed", water_amount)

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

const max_hunger = 100
var characters : Dictionary = {
	"Character1" : {
		"name": "Wilson",
		"pronouns" : "He",
		"sanity" : 50,
		"hunger" : 70,
		"thirst" : 70
	},
	"Character2" : {
		"name": "Wendy",
		"pronouns" : "She",
		"sanity" : 80,
		"hunger" : 40,
		"thirst" : 40
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

var eat_food : bool #When on ration time and they confirmed to eat food
var drink_water : bool #When on ration time and they confirmed to drink water

#when in main view and you are prompt to click, used to determine which type should glow in map.gd
#either items, journal, rations, door will glow
enum click_events{NA, items, journal, rations, door} 
var click_event_type : click_events = click_events.NA :
	set(value):
		click_event_type = value
		print("click_event_type: ", click_event_type)
		emit_signal("click_event_type_changed", click_event_type)

##SIGNALS
signal food_amount_changed
signal water_amount_changed
signal click_event_type_changed
signal item_changed
signal day_changed
