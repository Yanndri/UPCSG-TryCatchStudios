class_name JournalEntry
extends Resource

@export var Title : String
@export_multiline var notes : PackedStringArray

var notes_size : int
var note_count : int = 0

func flip_journal() -> String:
	notes_size = notes.size() #get the amount of notes this journal entry have. Count doesn't start from index 0 btw
	
	var note : String
	if note_count <= notes_size - 1:
		note = notes[note_count]
		note_count += 1
	
	return note

func is_first_page() -> bool:
	return note_count == 0
