extends Control

@export var journal_entries : Array[JournalEntry]

var current_journal_entry : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_journal_entry = "Day 1"
	find_journal_entry(current_journal_entry)

func find_journal_entry(title : String):
	for journal_entry in journal_entries:
		if journal_entry.Title == title:
			%Day.visible = journal_entry.is_first_page() #Only visible if the first note of the journal entry
			
			var note : String = journal_entry.flip_journal() #Get the note from the journal
			%Body.text = note #set the note as the text body

func _on_next_page_pressed() -> void:
	%JournalAnimations.play("flip") #Animation only, the animation also changes transparency of text label
	await get_tree().create_timer(0.5).timeout
	find_journal_entry(current_journal_entry)
