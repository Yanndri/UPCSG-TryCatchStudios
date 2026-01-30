class_name JournalEntry
extends Resource

@export var Title : String
@export var pick_event : bool #Choose item event
@export_enum("Shotgun", "Medkit", "Toolbox", "Bag", "Flashlight") var item_needed : String

@export var yes_or_no_event : bool #Yes or No event
enum yes_or_no_options {NA, Yes, No} 
@export var yes_or_no : yes_or_no_options

enum ration_types {NA, Food, Water} 
@export var reward_ration : ration_types
@export var reward_item : bool

@export_multiline var notes : PackedStringArray
@export_multiline var good_pick : String #For events when they picked correctly
@export_multiline var bad_pick : String #For events when they picked correctly


var notes_size : int
var note_count := 0 :
	set(value):
		note_count = value

var daily_check_finished : bool
var pick_event_finished : bool
var event_done : bool

func _have_event() -> bool: return pick_event or yes_or_no_event
func event_finished() -> bool: return _have_event() and (is_pick_event_finished())

func flip_journal(flip_amount : int) -> String:
	notes_size = notes.size() #get the amount of notes this journal entry have. Count doesn't start from index 0 btw
	
	var note : String
	note_count += flip_amount ##if 1 goes to next page, if -1 goes back page
	
	if pick_event and GlobalValues.chosen_item != "": ##This is for pick event
		pick_event_finished = true #Set to true since the pick event is finished
		if GlobalValues.chosen_item == item_needed: #If item chosen is correct
			note = good_pick
		else: #If item chosen is wrong
			note = bad_pick
			var random_num := randi_range(6, 23)
			note += "\n\nThe " + Durability.break_random_item(random_num) + " Lost it's durability"
	elif note_count >= 0 and note_count <= notes_size:
		note = notes[note_count - 1] #this makes it so note_count always starts at 0 index
	
	if _have_event() and event_done:
		pass
	
	if not _have_event() or event_done:
		if is_after_last_page() and not daily_check_finished: 
			daily_check_finished = true
			note = daily_check(note) #add the daily check notes
		if is_after_last_page() and daily_check_finished: note = time_for_rations(note) #notes to initiate the food 
	elif is_pick_event_finished(): event_done = true
	
	print("Journal Entry-> ", Title, "-> Size: ", notes_size,  "| note_count: ", note_count)
	print("is_first_page(): ", is_first_page(), " is_last_page(): ", is_last_page())
	
	##this replaces the string {item_name} to the item the player chose
	note = note.format({"item_name": GlobalValues.chosen_item}) 
	
	return note

func is_first_page() -> bool: return note_count == 1
func is_last_page() -> bool: return note_count == notes_size
func is_after_last_page() -> bool:  return note_count > notes_size
func is_pick_event_finished() -> bool: return pick_event and pick_event_finished
func is_ration_time() -> bool: return daily_check_finished

func is_all_notes_finished() -> bool: #Check if all journal notes are done read
	return note_count >= notes_size and pick_event == false and yes_or_no_event == false

func daily_check(note : String): #This shows after all pages are finished
	for key in GlobalValues.characters.keys():
		var character = GlobalValues.characters[key]
		note += "\n\n" + character["name"]
		note += CharacterStats.get_feeling_comments(character["sanity"])
		note += character["pronouns"] + "'s "
		note += CharacterStats.get_hunger_comments(character["hunger"])
		note += CharacterStats.get_thirst_comments(character["thirst"]) + "."
	
	return note

func time_for_rations(note : String) -> String:
	note += "\n\nIt's time to ration the food and water, we have plenty of rations so maybe rations may not be a problem. \n\nOne can and one water is good enough for all of us we'll share it the whole day" 
	return note

func reward() -> String:
	var note : String
	
	#match reward_ration:
		
	
	return note
