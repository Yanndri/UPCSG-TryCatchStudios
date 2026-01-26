class_name JournalEntry
extends Resource

@export var Title : String
@export_multiline var notes : PackedStringArray

var notes_size : int
var note_count : int :
	set(value):
		note_count = value
		print("note_count: ", note_count - 1)

func flip_journal() -> String:
	notes_size = notes.size() #get the amount of notes this journal entry have. Count doesn't start from index 0 btw
	
	var note : String
	note_count += 1
	if note_count <= notes_size:
		note = notes[note_count - 1] #this makes it so note_count always starts at 0 index
	
	return note

func flip_backwards_journal() -> String:
	notes_size = notes.size() #get the amount of notes this journal entry have. Count doesn't start from index 0 btw
	
	var note : String
	note_count -= 1
	if note_count >= 0:
		note = notes[note_count - 1]
	
	return note

func is_first_page() -> bool:
	return note_count - 1 == 0

func is_last_page() -> bool:
	return note_count == notes_size
