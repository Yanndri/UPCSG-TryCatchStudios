extends Node

var food_amount : int :
	set(value):
		food_amount = value
		emit_signal("food_amount_changed", food_amount)

var food_ate : bool
var water_drank : bool

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

var item_durability : Dictionary = {
	"Medkit" : 100,
	"Toolbox" : 100,
	"Bag" : 100,
	"Shotgun" : 100,
	"Flashligt" : 100
}

const max_hunger = 100
var characters : Dictionary = {
	"Character1" : {
		"name": "Wilson",
		"pronouns" : "He",
		"sanity" : 69,
		"hunger" : 120,
		"thirst" : 90
	},
	"Character2" : {
		"name": "Wendy",
		"pronouns" : "She",
		"sanity" : 100,
		"hunger" : 90,
		"thirst" : 120
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
var cube_accepted : bool :
	set(value):
		cube_accepted = value
		emit_signal("cube_changed", cube_accepted)

var cube_finished : bool

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
signal cube_changed
