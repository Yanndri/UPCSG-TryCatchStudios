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
var note_count : int :
	set(value):
		note_count = value
		print("note_count: ", note_count - 1)

func flip_journal() -> String:
	notes_size = notes.size() #get the amount of notes this journal entry have. Count doesn't start from index 0 btw
	
	var note : String
	note_count += 1
	
	if pick_event and GlobalValues.chosen_item != "": ##This is for pick event
		pick_event = false #Set to false since the pick event is finished
		if GlobalValues.chosen_item == item_needed: #If item chosen is correct
			note = good_pick
		else: #If item chosen is wrong
			note = bad_pick
	elif note_count <= notes_size:
			note = notes[note_count - 1] #this makes it so note_count always starts at 0 index
	
	if is_all_notes_finished(): #check if everything in the journal entry is finished
		note = daily_check(note) #add the daily check notes
	
	print("Journal Entry-> Size: ", notes_size,  "| note_count: ", note_count)
	
	##this replaces the string {item_name} to the item the player chose
	note = note.format({"item_name": GlobalValues.chosen_item}) 
	return note

func flip_backwards_journal() -> String:
	notes_size = notes.size() #get the amount of notes this journal entry have. Count doesn't start from index 0 btw
	
	var note : String
	note_count -= 1
	if note_count >= 0 and note_count <= notes_size:
		note = notes[note_count - 1]
	
	return note

func is_first_page() -> bool:
	return note_count == 1

func is_last_page() -> bool:
	return note_count == notes_size

func is_too_far_page() -> bool: #used to check if it should be next day
	return note_count > notes_size

func is_all_notes_finished() -> bool: #Check if all journal notes are done read
	return note_count >= notes_size and pick_event == false and yes_or_no_event == false

func daily_check(note : String): #This shows after all pages are finished
	note += "\n"
	for key in GlobalValues.characters.keys():
		var character = GlobalValues.characters[key]
		#print(character["name"] + " is feeling " + character["feeling"])
		note += "\n" + character["name"] + " is feeling " + character["feeling"]
	return note
