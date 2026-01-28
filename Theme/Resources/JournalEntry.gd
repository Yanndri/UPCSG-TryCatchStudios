class_name JournalEntry
extends Resource

@export var Title : String
@export var pick_event : bool #Choose item event
@export var yes_or_no_event : bool #Yes or No event

@export_enum("Shotgun", "Medkit", "Toolbox", "Bag")
var item_needed : String

@export_multiline var notes : PackedStringArray
@export_multiline var good_pick : String #For events when they picked correctly
@export_multiline var bad_pick : String #For events when they picked correctly

var notes_size : int
var note_count := 0 :
	set(value):
		note_count = value

func flip_journal(flip_amount : int) -> String:
	notes_size = notes.size() #get the amount of notes this journal entry have. Count doesn't start from index 0 btw
	
	var note : String
	note_count += flip_amount ##if 1 goes to next page, if -1 goes back page
	
	if pick_event and GlobalValues.chosen_item != "": ##This is for pick event
		pick_event = false #Set to false since the pick event is finished
		if GlobalValues.chosen_item == item_needed: #If item chosen is correct
			note = good_pick
		else: #If item chosen is wrong
			note = bad_pick
	elif note_count >= 0 and note_count <= notes_size:
		note = notes[note_count - 1] #this makes it so note_count always starts at 0 index
	
	if is_last_page(): note = daily_check(note) #add the daily check notes
	if is_after_last_page(): note = time_for_rations(note) #notes to initiate the food 
	
	print("Journal Entry-> ", Title, "-> Size: ", notes_size,  "| note_count: ", note_count)
	print("is_first_page(): ", is_first_page(), " is_last_page(): ", is_last_page())
	
	##this replaces the string {item_name} to the item the player chose
	note = note.format({"item_name": GlobalValues.chosen_item}) 
	return note

func is_first_page() -> bool: return note_count == 1
func is_last_page() -> bool: return note_count == notes_size
func is_after_last_page() -> bool:  return note_count > notes_size

func is_all_notes_finished() -> bool: #Check if all journal notes are done read
	return note_count >= notes_size and pick_event == false and yes_or_no_event == false

func daily_check(note : String): #This shows after all pages are finished
	note += "\n"
	for key in GlobalValues.characters.keys():
		var character = GlobalValues.characters[key]
		#print(character["name"] + " is feeling " + character["feeling"])
		note += "\n" + character["name"] + " is feeling " + character["feeling"] + ". "
		note += calculate_hunger(character)
		note += calculate_thirst(character)
	
	return note

func calculate_hunger(character : Dictionary) -> String:
	var hunger = character["hunger"]
	var hunger_note : String
	if hunger < 50:
		hunger_note = character["name"] + " could use a little food"
	elif hunger >= 90:
		hunger_note = character["name"] + " is a little full right now"
	return hunger_note

func calculate_thirst(character : Dictionary) -> String:
	var thirst = character["thirst"]
	var thirst_note : String
	if thirst < 50:
		thirst_note = character["name"] + " could use a few bits of water"
	elif thirst >= 90:
		thirst_note = character["name"] + " is over hydrated"
	return thirst_note

func time_for_rations(note : String) -> String:
	note += "\nIt's time to ration the food and water, we have plenty of rations so maybe rations may not be a problem. \n\nOne can and one water is good enough for all of us we'll share it the whole day" 
	return note
